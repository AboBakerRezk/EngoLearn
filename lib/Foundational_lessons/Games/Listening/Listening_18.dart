import 'dart:async';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../settings/setting_2.dart';

final List<List<List<String>>> allWords = [
  [
    ['instead', 'بدلاً'],
    ['least', 'الأقل'],
    ['natural', 'طبيعي'],
    ['physical', 'بدني'],
    ['piece', 'قطعة'],
  ],
  [
    ['show', 'يظهر'],
    ['society', 'مجتمع'],
    ['try', 'محاولة'],
    ['check', 'تحقق'],
    ['choose', 'اختر'],
  ],
  [
    ['develop', 'طور'],
    ['second', 'ثاني'],
    ['useful', 'مفيد'],
    ['web', 'شبكة'],
    ['activity', 'نشاط'],
  ],
  [
    ['boss', 'رئيس'],
    ['short', 'قصير'],
    ['story', 'قصة'],
    ['call', 'مكالمة'],
    ['industry', 'صناعة'],
  ],
];






class ListeningGame18 extends StatefulWidget {
  @override
  _ListeningGame18State createState() => _ListeningGame18State();
}

class _ListeningGame18State extends State<ListeningGame18>
    with SingleTickerProviderStateMixin {
  int _currentWordIndex = 0;
  int currentPage = 0;
  int score = 0;
  int pressCount = 0; // متغير لتعقب عدد مرات الضغط
  late AnimationController _controller;
  late Animation<double> _animation;
  final Color primaryColor = Color(0xFF13194E);
  FlutterTts flutterTts = FlutterTts();
  String userInput = '';
  bool isCorrect = false;
  bool isGameStarted = false;

  // Variables for SharedPreferences data
  double grammarPoints = 0;
  double lessonPoints = 0;
  double studyHoursPoints = 0;
  double listeningPoints = 0;
  double speakingPoints = 0;
  double readingPoints = 0;
  double writingPoints = 0;
  double exercisePoints = 0;
  double sentenceFormationPoints = 0;
  double gamePoints = 0; // Initialized to 900 as per your code

  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int bottleFillLevel = 0;

  // Example variables for totalScore calculation
  // Ensure these are defined or remove if not needed
  int _pronounScore = 0;
  int _verbScore = 0;
  int totalScore = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    _generateRandomWord();

    // Initialize SharedPreferences data
    _loadStatisticsData();
    loadSavedProgressData();

    // Example usage of increasePoints
    increasePoints('games', 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    flutterTts.stop();
    super.dispose();
  }

  List<List<String>> getWords() {
    // دمج جميع الكلمات من كل الصفحات في قائمة واحدة
    List<List<String>> mergedWords = [];
    for (var page in allWords) {
      mergedWords.addAll(page);
    }
    return mergedWords;
  }

  List<int> _usedWords = []; // لتتبع الكلمات التي تم استخدامها

  void _generateRandomWord() {
    setState(() {
      Random random = Random();
      List<List<String>> allAvailableWords = getWords(); // الحصول على جميع الكلمات

      // التحقق إذا تم استخدام جميع الكلمات
      if (_usedWords.length == allAvailableWords.length) {
        _usedWords.clear(); // إعادة ضبط الكلمات المستخدمة عندما نمر على كل الكلمات
      }

      // التأكد من اختيار كلمة جديدة
      do {
        _currentWordIndex = random.nextInt(allAvailableWords.length);
      } while (_usedWords.contains(_currentWordIndex));

      _usedWords.add(_currentWordIndex); // إضافة الكلمة المختارة إلى قائمة الكلمات المستخدمة
      userInput = '';
      isCorrect = false;
      isGameStarted = true;
      pressCount = 0; // إعادة تعيين عدد الضغطات عند الانتقال إلى كلمة جديدة
    });
  }

  Future<void> _speakWord(String word) async {
    double speechRate;

    // تعيين سرعة الكلام بناءً على عدد مرات الضغط
    if (pressCount == 0) {
      speechRate = 1.0; // سرعة طبيعية
    } else if (pressCount == 1) {
      speechRate = 0.75; // أبطأ
    } else {
      speechRate = 0.5; // أكثر بطئًا
    }

    await flutterTts.setSpeechRate(speechRate); // تعيين سرعة الكلام
    await flutterTts.speak(word); // التحدث بالكلمة

    // تحديث عدد الضغطات
    setState(() {
      pressCount = (pressCount + 1) % 3; // العودة إلى السرعة الطبيعية بعد 3 ضغطات
    });
  }

  void _checkAnswer() {
    String correctWord = getWords()[_currentWordIndex][0];
    setState(() {
      if (userInput.trim().toLowerCase() == correctWord.toLowerCase()) {
        isCorrect = true;
        score += 10;
        increasePoints('games', 10); // مثال على زيادة النقاط
        _generateRandomWord();
      } else {
        isCorrect = false;
        score -= 5;
        increasePoints('games', -5); // مثال على تقليل النقاط
      }
    });
    saveStatisticsData(); // حفظ النقاط بعد التحقق من الإجابة
  }

  Widget _buildInputField() {
    return FadeTransition(
      opacity: _animation,
      child: TextField(
        onChanged: (value) {
          userInput = value;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'اكتب الكلمة هنا...',
        ),
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
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
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String correctWord = getWords()[_currentWordIndex][0];
    String translatedWord = getWords()[_currentWordIndex][1];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'لعبة الاستماع',
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
                'الكلمة بالعربية:',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                translatedWord,
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              SizedBox(height: 30),
              _buildButton('استمع للكلمة', () => _speakWord(correctWord)),
              SizedBox(height: 30),
              _buildInputField(),
              SizedBox(height: 20),
              _buildButton('تحقق', _checkAnswer),
              SizedBox(height: 20),
              if (isCorrect)
                Text(
                  'إجابة صحيحة!',
                  style: TextStyle(fontSize: 26, color: Colors.green),
                )
              else if (userInput.isNotEmpty)
                Text(
                  'إجابة خاطئة، حاول مجددًا.',
                  style: TextStyle(fontSize: 26, color: Colors.red),
                ),
              SizedBox(height: 30),
              Text(
                'النقاط: $score',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 20),
              _buildButton('كلمة أخرى', _generateRandomWord),
            ],
          ),
        ),
      ),
    );
  }


  // دالة لتحميل بيانات النقاط المختلفة من SharedPreferences
  Future<void> _loadStatisticsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      grammarPoints = prefs.getDouble('grammarPoints') ?? 0;
      lessonPoints = prefs.getDouble('lessonPoints') ?? 0;
      studyHoursPoints = prefs.getDouble('studyHoursPoints') ?? 0;
      listeningPoints = prefs.getDouble('listeningPoints') ?? 0;
      speakingPoints = prefs.getDouble('speakingPoints') ?? 0;
      readingPoints = prefs.getDouble('readingPoints') ?? 0;
      writingPoints = prefs.getDouble('writingPoints') ?? 0;
      exercisePoints = prefs.getDouble('exercisePoints') ?? 0;
      sentenceFormationPoints =
          prefs.getDouble('sentenceFormationPoints') ?? 0;
      gamePoints = prefs.getDouble('gamePoints') ?? 0;
    });
  }

  // دالة لتحميل بيانات مستويات التقدم من SharedPreferences
  Future<void> loadSavedProgressData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      readingProgressLevel = prefs.getInt('progressReading') ?? 0;
      listeningProgressLevel = prefs.getInt('progressListening') ?? 0;
      writingProgressLevel = prefs.getInt('progressWriting') ?? 0;
      grammarProgressLevel = prefs.getInt('progressGrammar') ?? 0;
      bottleFillLevel = prefs.getInt('bottleLevel') ?? 0;
    });
  }

  // دالة لحفظ بيانات مستويات التقدم إلى SharedPreferences
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('progressReading', readingProgressLevel);
    await prefs.setInt('progressListening', listeningProgressLevel);
    await prefs.setInt('progressWriting', writingProgressLevel);
    await prefs.setInt('progressGrammar', grammarProgressLevel);
    await prefs.setInt('bottleLevel', bottleFillLevel);
  }

  // دالة لحفظ بيانات النقاط المختلفة إلى SharedPreferences
  Future<void> saveStatisticsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('grammarPoints', grammarPoints);
    await prefs.setDouble('lessonPoints', lessonPoints);
    await prefs.setDouble('studyHoursPoints', studyHoursPoints);
    await prefs.setDouble('listeningPoints', listeningPoints);
    await prefs.setDouble('speakingPoints', speakingPoints);
    await prefs.setDouble('readingPoints', readingPoints);
    await prefs.setDouble('writingPoints', writingPoints);
    await prefs.setDouble('exercisePoints', exercisePoints);
    await prefs.setDouble(
        'sentenceFormationPoints', sentenceFormationPoints);
    await prefs.setDouble('gamePoints', gamePoints);
  }

  // دالة لزيادة النقاط في فئة معينة
  void increasePoints(String category, double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      switch (category) {
        case 'grammar':
          grammarPoints += amount;
          prefs.setDouble('grammarPoints', grammarPoints);
          break;
        case 'lessons':
          lessonPoints += amount;
          prefs.setDouble('lessonPoints', lessonPoints);
          break;
        case 'studyHours':
          studyHoursPoints += amount;
          prefs.setDouble('studyHoursPoints', studyHoursPoints);
          break;
        case 'listening':
          listeningPoints += amount;
          prefs.setDouble('listeningPoints', listeningPoints);
          break;
        case 'speaking':
          speakingPoints += amount;
          prefs.setDouble('speakingPoints', speakingPoints);
          break;
        case 'reading':
          readingPoints += amount;
          prefs.setDouble('readingPoints', readingPoints);
          break;
        case 'writing':
          writingPoints += amount;
          prefs.setDouble('writingPoints', writingPoints);
          break;
        case 'exercises':
          exercisePoints += amount;
          prefs.setDouble('exercisePoints', exercisePoints);
          break;
        case 'sentenceFormation':
          sentenceFormationPoints += amount;
          prefs.setDouble(
              'sentenceFormationPoints', sentenceFormationPoints);
          break;
        case 'games':
          gamePoints += amount;
          prefs.setDouble('gamePoints', gamePoints);
          break;
        default:
        // Handle unknown categories if necessary
          break;
      }
    });
  }

}

