import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  final String _baseUrl = "http://127.0.0.1:8000";

  Future<Map<String, dynamic>> chatWithBot(String message) async {
    final url = Uri.parse("$_baseUrl/chat");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"message": message}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to connect to the API");
    }
  }
}

class TranslationScreen extends StatefulWidget {
  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _messages = [];
  String _selectedLanguage = "ar";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? messagesJson = prefs.getString('messages');
    if (messagesJson != null) {
      List<dynamic> messagesList = json.decode(messagesJson);
      setState(() {
        _messages = messagesList.cast<Map<String, dynamic>>();
      });
    }
  }

  Future<void> _saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String messagesJson = json.encode(_messages);
    await prefs.setString('messages', messagesJson);
  }

  Future<void> sendMessageToBot(String message) async {
    setState(() {
      _isLoading = true; // بدء التحميل
    });

    try {
      final data = await APIService().chatWithBot(message);
      setState(() {
        _messages.add({'text': message, 'isUser': true});
        _messages.add({'text': data['response'], 'isUser': false});
      });
      await _saveMessages();
    } catch (e) {
      setState(() {
        _messages.add({'text': message, 'isUser': true});
        _messages.add({'text': "حدث خطأ أثناء الاتصال بـ API.", 'isUser': false});
      });
      await _saveMessages();
    } finally {
      setState(() {
        _isLoading = false; // انتهاء التحميل
      });
    }
  }

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == "ar" ? "en" : "ar";
    });
  }

  void _clearMessages() {
    setState(() {
      _messages.clear();
    });
    _saveMessages(); // حفظ الحالة الجديدة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: _toggleLanguage,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _clearMessages, // مسح الرسائل
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(child: Text("لا توجد رسائل بعد."))
                : ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['isUser'];
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message['text'] ?? '',
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading) // عرض مؤشر التحميل
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: _selectedLanguage == "ar" ? 'أدخل رسالتك هنا...' : 'Enter your message...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      sendMessageToBot(text);
                      _controller.clear();
                    }
                  },
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}







