// الكلمات المستخدمة في الألعاب
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


import '../../../settings/setting_2.dart';
import '../Correction/Correction_2.dart';
import '../Difficult_translation/Difficult_translation_2.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_2.dart';
import '../Guess/Guess_2.dart';
import '../Listening/Listening_2.dart';
import '../Matching/Matching_2.dart';
import '../Memory/Memory_2.dart';
import '../Translation/Translation_2.dart';
import '../the order of letters/the order of letters_2.dart';

final List<List<List<String>>> allWords = [
  [
    ['this', 'هذا'],
    ['an', 'أ'],
    ['by', 'بواسطة'],
    ['not', 'ليس'],
    ['but', 'لكن'],
  ],
  [
    ['at', 'في'],
    ['from', 'من'],
    ['I', 'أنا'],
    ['they', 'هم'],
    ['more', 'أكثر'],
  ],
  [
    ['will', 'سوف'],
    ['if', 'إذا'],
    ['some', 'بعض'],
    ['there', 'هناك'],
    ['what', 'ماذا'],
  ],
  [
    ['about', 'حول'],
    ['which', 'التي'],
    ['when', 'متى'],
    ['one', 'واحد'],
    ['their', 'لهم'],
  ],
];





class HomeGame2 extends StatefulWidget {
  @override
  _HomeGame2State createState() => _HomeGame2State();
}

class _HomeGame2State extends State<HomeGame2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E);



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return FadeTransition(
      opacity: _animation,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // خلفية سوداء
      appBar: AppBar(
        title: Text("وَحَارِبْ لِحُلْمٍ مَا يَزَالُ عَالِقًا بَيْنَ النَّجَاحِ أَوْ أَنْ يَبُوءَ بِالفَشَلِ.", style: TextStyle(fontSize:18, color: Colors.white)),
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
              _buildButton('${AppLocale.S80.getString(context)}', () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translation2()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd2()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage2()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage2()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage2()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage2()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame2()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame2()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame2()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

















class SpeechPage2 extends StatefulWidget {
  @override
  _SpeechPage2State createState() => _SpeechPage2State();
}

class _SpeechPage2State extends State<SpeechPage2> with SingleTickerProviderStateMixin {
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
