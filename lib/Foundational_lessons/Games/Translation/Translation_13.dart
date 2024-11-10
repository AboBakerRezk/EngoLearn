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
    ['the', 'ال'],
    ['of', 'من'],
    ['and', 'و'],
    ['to', 'إلى'],
    ['a', 'أ'],
  ],
  [
    ['in', 'في'],
    ['is', 'هو'],
    ['you', 'أنت'],
    ['are', 'تكون'],
    ['for', 'لـ'],
  ],
  [
    ['that', 'أن'],
    ['or', 'أو'],
    ['it', 'هو'],
    ['as', 'مثل'],
    ['be', 'يكون'],
  ],
  [
    ['on', 'على'],
    ['your', 'لك'],
    ['with', 'مع'],
    ['can', 'يستطيع'],
    ['have', 'لديك'],
  ],
];


class translation13 extends StatefulWidget {
  @override
  _translation13State createState() => _translation13State();
}

class _translation13State extends State<translation13>
    with SingleTickerProviderStateMixin {
  int _currentWordIndex = 0;
  int currentPage = 0;
  int score = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
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

  List<List<String>> getWords() {
    // تسترجع قائمة الكلمات لكل صفحة
    return allWords[currentPage];
  }

  List<String> getWordOptions(String correctWord) {
    // تنشئ الخيارات وتخلطها
    List<String> options = [...getWords().map((e) => e[0])];
    options.shuffle();
    return [correctWord, options[0], options[1]]..shuffle();
  }

  void checkAnswer(bool isCorrect) {
    // تتحقق من الإجابة وتحدث النقاط والصفحة الحالية
    setState(() {
      if (isCorrect) {
        score += 10;
      } else {
        score -= 5;
      }

      if (_currentWordIndex < getWords().length - 1) {
        _currentWordIndex++;
      } else {
        _currentWordIndex = 0;
        if (currentPage < allWords.length - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }
      }
      score =  _currentWordIndex + currentPage ;
      // تحديث مستويات التقدم بناءً على النقاط الجديدة
      if (gamePoints < 500) {
        gamePoints += (score * 0.50).toInt();
        if (gamePoints > 500) gamePoints = 500; // الحد الأقصى
      }
      if (bottleFillLevel < 6000) {
        bottleFillLevel += (score * 0.50).toInt();
        if (bottleFillLevel > 6000) bottleFillLevel = 6000; // الحد الأقصى
      }
    });
    saveProgressDataToPreferences();

  }

  Widget _buildButton(String option, bool isCorrect) {
    return FadeTransition(
      opacity: _animation,
      child: ElevatedButton(
        onPressed: () {
          checkAnswer(isCorrect);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        child: Text(
          option,
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
// دالة لتحميل بيانات النقاط المختلفة من SharedPreferences
// Load saved data
  Future<void> loadSavedProgressData() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    setState(() {
      readingProgressLevel = sharedPreferencesInstance.getInt('readingProgressLevel') ?? 0;
      bottleFillLevel = sharedPreferencesInstance.getInt('bottleFillLevel') ?? 0;
      gamePoints = sharedPreferencesInstance.getDouble('gamePoints') ?? 0.0;
    });
  }

// Save data
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    await sharedPreferencesInstance.setInt('readingProgressLevel', readingProgressLevel);
    await sharedPreferencesInstance.setInt('bottleFillLevel', bottleFillLevel);
    await sharedPreferencesInstance.setDouble('gamePoints', gamePoints);
  }


  // دالة لزيادة النقاط بناءً على الفئة
  void increasePointsByCategory(String category, double amount) async {
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

  // دالة لزيادة النقاط في قسم الألعاب
  void increasePoints(String section, int points) {
    if (section == 'games') {
      setState(() {
        score += points;

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    List<List<String>> words = getWords();
    String correctWord = words[_currentWordIndex][0];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '${AppLocale.S88.getString(context)}',
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
                '${AppLocale.S89.getString(context)}:',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                words[_currentWordIndex][1],
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              SizedBox(height: 30),
              ...getWordOptions(correctWord).map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _buildButton(option, option == correctWord),
                );
              }).toList(),
              SizedBox(height: 30),
              Text(
                '${AppLocale.S87.getString(context)}: $score',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

