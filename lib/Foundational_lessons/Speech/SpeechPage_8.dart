
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


import 'package:flutter/material.dart';

final List<List<List<String>>> allWords = [
  [
    ['had', 'كان'],
    ['hi', 'مرحبا'],
    ['right', 'حق'],
    ['still', 'ما زال'],
    ['system', 'نظام'],
  ],
  [
    ['after', 'بعد'],
    ['computer', 'حاسوب'],
    ['best', 'الأفضل'],
    ['must', 'يجب'],
    ['her', 'لها'],
  ],
  [
    ['life', 'حياة'],
    ['since', 'منذ'],
    ['could', 'استطاع'],
    ['does', 'يفعل'],
    ['now', 'الآن'],
  ],
  [
    ['during', 'أثناء'],
    ['learn', 'تعلم'],
    ['around', 'حول'],
    ['usually', 'عادة'],
    ['form', 'شكل'],
  ],
];

class SpeechPage8 extends StatefulWidget {
  @override
  _SpeechPage8State createState() => _SpeechPage8State();
}

class _SpeechPage8State extends State<SpeechPage8> with SingleTickerProviderStateMixin {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isListening = false;
  String _spokenText = "";
  String _targetText = "";
  int _currentWordIndex = 0;
  int currentPage = 0;
  int score = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E);


  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    _targetText = allWords[currentPage][_currentWordIndex][0]; // تعيين الكلمة الأولى
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _spokenText = val.recognizedWords;
              _isListening = false;
              _checkResult();
            });
          },
          localeId: 'en_US', // Ensure you are using the correct parameter name
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _checkResult() {
    String spoken = _spokenText.toLowerCase().trim();
    String target = _targetText.toLowerCase().trim();

    // إزالة المسافات الزائدة
    spoken = spoken.replaceAll(RegExp(r'\s+'), ' ');

    // تقسيم النص المنطوق إلى كلمات
    List<String> spokenWords = spoken.split(' ');

    // التحقق إذا كانت جميع الكلمات هي نفس الكلمة المستهدفة
    bool allWordsMatch = spokenWords.every((word) => word == target);

    if (allWordsMatch) {
      setState(() {
        score += 10;
      });
    } else {
      setState(() {
        score -= 5;
      });
    }
  }

  // الانتقال إلى الكلمة التالية
  void _nextWord() {
    setState(() {
      if (_currentWordIndex < allWords[currentPage].length - 1) {
        _currentWordIndex++;
      } else {
        _currentWordIndex = 0;
        if (currentPage < allWords.length - 1) {
          currentPage++;
        } else {
          currentPage = 0; // إعادة التعيين إذا انتهت القائمة
        }
      }
      _targetText = allWords[currentPage][_currentWordIndex][0]; // تحديث الكلمة التالية
    });
  }

  void _speakText() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(_targetText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'التحدث',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, primaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              Text(
                'قل الكلمة التالية:',
                style: TextStyle(fontSize: 26, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                _targetText, // الكلمة المطلوبة
                style: TextStyle(fontSize: 32, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              FadeTransition(
                opacity: _animation,
                child: ElevatedButton(
                  onPressed: _listen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    _isListening ? 'التحدث...' : 'ابدأ التحدث',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              FadeTransition(
                opacity: _animation,
                child: ElevatedButton(
                  onPressed: _speakText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    'استمع إلى الكلمة',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              FadeTransition(
                opacity: _animation,
                child: ElevatedButton(
                  onPressed: _nextWord, // الانتقال إلى الكلمة التالية
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    'الكلمة التالية',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'الكلام المنطوق:',
                style: TextStyle(fontSize: 26, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                _spokenText,
                style: TextStyle(fontSize: 32, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                'النقاط: $score',
                style: TextStyle(fontSize: 26, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
