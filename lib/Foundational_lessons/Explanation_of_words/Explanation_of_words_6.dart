import 'dart:convert';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;

// افتراض أن لديك ملف APIService للتفاعل مع واجهة برمجة التطبيقات
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

// نموذج الرسالة
class Message {
  final String text;
  final DateTime timestamp;
  final bool isUser;

  Message(this.text, this.timestamp, {required this.isUser});
}




class VoiceChatPage3 extends StatefulWidget {
  @override
  _VoiceChatPage3State createState() => _VoiceChatPage3State();
}

class _VoiceChatPage3State extends State<VoiceChatPage3> {
  final ApiService _apiService = ApiService();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _isListening = false;
  String _userVoice = '';
  List<Message> _messages = [];
  String _selectedLanguage = 'العربية';
  final List<String> _languageOptions = ['العربية', 'English'];

  @override
  void initState() {
    super.initState();
    langdetect.initLangDetect(); // Initialize the language detector once
  }

  Future<void> _listen2() async {
    String localeId = _selectedLanguage == 'العربية' ? 'ar-SA' : 'en-US';
    bool available = await _speech.initialize(
      onStatus: (val) {
        if (val == 'notListening') {
          setState(() {
            _isListening = false;
          });
        }
      },
      onError: (val) {
        setState(() {
          _isListening = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error while listening')),
        );
      },
    );

    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        localeId: localeId,
        onResult: (val) {
          setState(() {
            _userVoice = val.recognizedWords;
          });
        },
      );
    } else {
      setState(() => _isListening = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Voice recognition not available')),
      );
    }
  }

  Future<void> _stopListening2() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
    });
    _detectLanguageAndSendMessage2(_userVoice); // Detect language before sending message
  }

  Future<void> _detectLanguageAndSendMessage2(String text) async {
    if (text.trim().isEmpty) {
      print('لا يمكن إرسال رسالة فارغة.');
      return;
    }

    String detectedLang;
    try {
      // كشف اللغة باستخدام مكتبة langdetect
      detectedLang = await langdetect.detect(text);
      print('تم كشف اللغة: $detectedLang');
    } catch (e) {
      print('حدث خطأ أثناء كشف اللغة: $e');
      detectedLang = 'unknown';
    }

    // تعيين اللغة المختارة إذا كانت عربية أو إنجليزية فقط
    setState(() {
      if (detectedLang == 'ar') {
        _selectedLanguage = 'العربية';
      } else if (detectedLang == 'en') {
        _selectedLanguage = 'English';
      } else {
        print('اللغة غير مدعومة، سيتم التعامل كنص إنجليزي افتراضيًا.');
        _selectedLanguage = 'English'; // افتراضيًا للغة غير مدعومة
      }
    });

    // تحسين النص وتحليله
    String optimizedText = _optimizeText2(text);
    String sentiment = await _analyzeSentiment2(text);
    bool containsInappropriateContent = _checkForInappropriateContent2(text);

    // إرسال الرسالة إذا كانت المحتوى مناسب
    if (containsInappropriateContent) {
      print('المحتوى غير ملائم للإرسال.');
      return;
    }

    // تسجيل البيانات
    _logMessageData2(text, detectedLang, sentiment);

    // إرسال الرسالة بعد التحليل
    await _sendMessage(optimizedText, sentiment: sentiment);
  }

// دالة لتحسين النص
  String _optimizeText2(String text) {
    List<String> words = text.split(' ');
    Set<String> uniqueWords = Set.from(words);
    return uniqueWords.join(' ');
  }

// دالة لتحليل المشاعر
  Future<String> _analyzeSentiment2(String text) async {
    if (text.contains(RegExp(r'\b(جميل|رائع|ممتاز|مميز|happy|excellent|great)\b'))) {
      return 'إيجابي';
    } else if (text.contains(RegExp(r'\b(سيء|رديء|حزين|مزعج|sad|bad|annoying)\b'))) {
      return 'سلبي';
    }
    return 'محايد';
  }

// دالة للتحقق من الكلمات المسيئة
  bool _checkForInappropriateContent2(String text) {
    List<String> inappropriateWords = ['كلمة1', 'كلمة2', 'badword1', 'badword2'];
    return inappropriateWords.any((word) => text.contains(word));
  }

// دالة لتسجيل بيانات الرسالة
  void _logMessageData2(String text, String detectedLang, String sentiment) {
    print('تسجيل الرسالة:');
    print('النص: $text');
    print('اللغة: $detectedLang');
    print('المشاعر: $sentiment');
  }


  Future<void> _sendMessage(String text, {required String sentiment}) async {
    if (text.trim().isEmpty) return;

    final userMessage = Message(text, DateTime.now(), isUser: true);
    setState(() {
      _messages.add(userMessage);
    });

    final processingMessage = Message('Processing...', DateTime.now(), isUser: false);
    setState(() {
      _messages.add(processingMessage);
    });

    try {
      final botResponse = await _apiService.getTextResponse(text);
      setState(() {
        _messages.remove(processingMessage);
      });

      final botMessage = Message(botResponse, DateTime.now(), isUser: false);
      setState(() {
        _messages.add(botMessage);
      });
    } catch (e) {
      setState(() {
        _messages.remove(processingMessage);
      });

      final errorMessage = Message('Error getting response. Try again.', DateTime.now(), isUser: false);
      setState(() {
        _messages.add(errorMessage);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('API connection failed')),
      );
    }
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
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
              _formatTimestamp(message.timestamp),
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Chat with Bot'),
        actions: [
          DropdownButton<String>(
            value: _selectedLanguage,
            items: _languageOptions
                .map((lang) => DropdownMenuItem(
              child: Text(lang),
              value: lang,
            ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedLanguage = value;
                });
              }
            },
            underline: Container(),
            dropdownColor: Colors.blue,
            icon: Icon(
              Icons.language,
              color: Colors.white,
            ),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Directionality(
        textDirection: _selectedLanguage == 'العربية' ? TextDirection.rtl : TextDirection.ltr,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[_messages.length - 1 - index];
                  return _buildMessage(message);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      if (_isListening) {
                        _stopListening2();
                      } else {
                        _listen2();
                      }
                    },
                    child: Icon(_isListening ? Icons.stop : Icons.mic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



