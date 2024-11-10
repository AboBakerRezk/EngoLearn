

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mushaf25/settings/setting_2.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../Robot_chat.dart';
import 'Foundational_lessons/Explanation_of_words/Explanation_of_words_6.dart';
import 'main.dart';

// تعريف فئة الرسالة
class Message {
  final String text;
  final DateTime timestamp;
  final bool isUser;

  Message(this.text, this.timestamp, {this.isUser = false});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'isUser': isUser,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      map['text'],
      DateTime.parse(map['timestamp']),
      isUser: map['isUser'],
    );
  }
}

// تعريف فئة صفحة الدردشة
class ChatPage {
  String name;
  List<Message> messages;

  ChatPage({required this.name, required this.messages});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'messages': messages.map((msg) => msg.toMap()).toList(),
    };
  }

  factory ChatPage.fromMap(Map<String, dynamic> map) {
    return ChatPage(
      name: map['name'],
      messages: List<Message>.from(
          map['messages']?.map((msg) => Message.fromMap(msg)) ?? []),
    );
  }
}

// تعريف فئة خدمة واجهة برمجة التطبيقات
class ApiService {
  // استبدلها بمفتاح API الخاص بك
  String _apiKey = 'AIzaSyALhb262a99kq0E_swAqyz9bJSPCmHSQv4';

  Future<String> getTextResponse(String message) async {
    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$_apiKey');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'contents': [
        {
          'parts': [
            {
              'text': message,
            },
          ],
        },
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final generatedText =
        data?['candidates']?[0]?['content']?['parts']?[0]?['text'];
        return generatedText ?? 'لم يتم العثور على نص الرد';
      } else {
        return 'خطأ في توليد الرد: ${response.statusCode}';
      }
    } catch (e) {
      return 'خطأ في توليد الرد: $e';
    }
  }
}








class VoiceChatPage extends StatefulWidget {
  @override
  _VoiceChatPageState createState() => _VoiceChatPageState();
}

class _VoiceChatPageState extends State<VoiceChatPage>
    with SingleTickerProviderStateMixin {
  final ApiService _apiService = ApiService();
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _isListening = false;
  bool _isSpeaking = false;
  String _userVoice = '';
  ChatPage _chatPage = ChatPage(name: "الدردشة الصوتية", messages: []);

  final List<String> _languages = ['ar-SA', 'en-US'];
  final List<String> _genders = ['Male', 'Female'];
  String _selectedLanguage = 'ar-SA';
  String _selectedGender = 'Male';
  List<dynamic> _availableVoices = [];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initTts2();
    _loadPreferences2();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  Future<void> _initTts2() async {
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    _availableVoices = await _flutterTts.getVoices;
  }

  Future<void> _loadPreferences2() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('selectedLanguage') ?? 'ar-SA';
      _selectedGender = prefs.getString('selectedGender') ?? 'Male';
    });
  }

  Future<void> _savePreferences2() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', _selectedLanguage);
    await prefs.setString('selectedGender', _selectedGender);
  }

  Future<void> _speak2(String text) async {
    setState(() => _isSpeaking = true);

    // التأكد من توقف الصوت قبل البدء بتشغيل صوت جديد
    await _flutterTts.stop();
    await _flutterTts.setLanguage(_selectedLanguage);

    String? voiceName;
    for (var voice in _availableVoices) {
      if (voice['locale'] == _selectedLanguage &&
          ((_selectedGender == 'Male' && voice['name'].toLowerCase().contains('male')) ||
              (_selectedGender == 'Female' && voice['name'].toLowerCase().contains('female')))) {
        voiceName = voice['name'];
        break;
      }
    }

    if (voiceName != null) {
      await _flutterTts.setVoice({'name': voiceName, 'locale': _selectedLanguage});
    }

    // تشغيل الكلام
    await _flutterTts.speak(text);

    // تعيين المعالج ليتم تعيين _isSpeaking إلى false عند انتهاء الكلام
    _flutterTts.setCompletionHandler(() => setState(() => _isSpeaking = false));
  }

// وظيفة الاستماع
  Future<void> _listen2() async {
    bool available = await _speech.initialize(
      onStatus: (val) {
        if (val == 'notListening') {
          setState(() {
            _isListening = false;
            _animationController.stop();
          });
        }
      },
      onError: (val) {
        setState(() {
          _isListening = false;
          _animationController.stop();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء الاستماع')),
        );
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
        _animationController.repeat(reverse: true);
      });
      _speech.listen(
        localeId: _selectedLanguage,
        onResult: (val) {
          setState(() {
            _userVoice = val.recognizedWords;
          });
        },
      );
    } else {
      setState(() => _isListening = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('التعرف على الصوت غير متاح حالياً')),
      );
    }
  }

// وظيفة التوقف
  Future<void> _stopListening2() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
      _animationController.stop();
    });
    _sendMessage2(_userVoice);  // إرسال الرسالة المستمعة
  }



  Future<void> _sendMessage2(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = Message(text, DateTime.now(), isUser: true);
    setState(() {
      _chatPage.messages.add(userMessage);
    });

    final processingMessage = Message('جاري المعالجة...', DateTime.now(), isUser: false);
    setState(() {
      _chatPage.messages.add(processingMessage);
    });

    try {
      final botResponse = await _apiService.getTextResponse(text);
      setState(() => _chatPage.messages.remove(processingMessage));
      final botMessage = Message(botResponse, DateTime.now(), isUser: false);
      setState(() => _chatPage.messages.add(botMessage));
      await _speak2(botResponse);
    } catch (e) {
      setState(() => _chatPage.messages.remove(processingMessage));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في الاتصال بـ API')),
      );
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _speech.stop();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الدردشة الصوتية مع رفيق'),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: _showLanguageSelection,
            tooltip: 'اختر اللغة',
          ),

        ],
      ),
      body:
         Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(16),
                itemCount: _chatPage.messages.length,
                itemBuilder: (context, index) {
                  final message = _chatPage.messages.reversed.toList()[index];
                  return _buildMessage(message);
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: _isListening ? _stopListening2 : _listen2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_isListening || _isSpeaking)
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Container(
                            width: 100 + (_animationController.value * 20),
                            height: 100 + (_animationController.value * 20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.withOpacity(0.5),
                            ),
                          );
                        },
                      ),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        _isListening ? Icons.stop : Icons.mic,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),

    );
  }

  void _showLanguageSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('اختر اللغة'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLanguageOption('ar-SA', 'العربية'),
              _buildLanguageOption('en-US', 'الإنجليزية'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String languageCode, String languageName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = languageCode;
          _savePreferences2();
        });
        Navigator.of(context).pop();
      },
      child: Column(
        children: [
          Icon(Icons.flag, size: 50, color: _selectedLanguage == languageCode ? Colors.blue : Colors.grey),
          SizedBox(height: 8),
          Text(languageName),
        ],
      ),
    );
  }



  Widget _buildMessage(Message message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.blue[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message.text,
                textAlign: message.isUser ? TextAlign.right : TextAlign.left,
              ),
            ),
            SizedBox(height: 4),
            Text(
              _formatTimestamp2(message.timestamp),
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp2(DateTime timestamp) {
    return "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}";
  }
}




