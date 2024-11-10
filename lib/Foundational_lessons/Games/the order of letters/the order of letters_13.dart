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
    ['always', 'دائماً'],
    ['body', 'جسم'],
    ['common', 'شائع'],
    ['market', 'سوق'],
    ['set', 'جلس'],
  ],
  [
    ['bird', 'طائر'],
    ['guide', 'مرشد'],
    ['provide', 'تزود'],
    ['change', 'تغيير'],
    ['interest', 'فائدة'],
  ],
  [
    ['literature', 'أدب'],
    ['sometimes', 'أحياناً'],
    ['problem', 'مشكلة'],
    ['say', 'يقول'],
    ['next', 'التالي'],
  ],
  [
    ['create', 'ينشئ'],
    ['simple', 'بسيط'],
    ['software', 'برمجيات'],
    ['state', 'حالة'],
    ['together', 'سوياً'],
  ],
];






// الصفحة الخامسه: لعبة رتب الكلمة


class RearrangeLettersPage13 extends StatefulWidget {
  @override
  _RearrangeLettersPage13State createState() => _RearrangeLettersPage13State();
}

class _RearrangeLettersPage13State extends State<RearrangeLettersPage13>
    with SingleTickerProviderStateMixin {
  int score = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _textController = TextEditingController();
  String feedbackMessage = ''; // رسالة المستخدم
  final Color primaryColor = Color(0xFF13194E); // اللون الأساسي

  // الكلمات والمرادفات
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

  late int outerIndex;
  late int innerIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    // اختيار كلمة عشوائية عند البداية
    _chooseRandomWord();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _chooseRandomWord() {
    // اختيار قائمة عشوائية داخلية ثم اختيار كلمة عشوائية من هذه القائمة
    outerIndex = Random().nextInt(allWords.length);
    innerIndex = Random().nextInt(allWords[outerIndex].length);
  }

  String shuffledWord(String word) {
    List<String> letters = word.split('')..shuffle();
    return letters.join();
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
  void checkAnswer(String input, String correctWord) {
    setState(() {
      if (input.trim() == correctWord) {
        score += 10;

        // تحديث مستويات التقدم بناءً على النقاط الجديدة
        if (gamePoints < 500) {
          gamePoints += (score * 0.50).toInt();
          if (gamePoints > 500) gamePoints = 500; // الحد الأقصى
        }
        if (bottleFillLevel < 6000) {
          bottleFillLevel += (score * 0.50).toInt();
          if (bottleFillLevel > 6000) bottleFillLevel = 6000; // الحد الأقصى
        }


        saveProgressDataToPreferences();
        feedbackMessage = '${AppLocale.S106.getString(context)}';
      } else {
        score -= 5;
        feedbackMessage = '${AppLocale.S107.getString(context)}';
      }

      // اختيار كلمة جديدة عشوائياً
      _chooseRandomWord();
      _textController.clear(); // مسح النص بعد الإجابة
      _controller.reset(); // إعادة تعيين الأنيميشن
      _controller.forward();
    });
  }

  Widget _buildTextField(String shuffled) {
    return FadeTransition(
      opacity: _animation,
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '${AppLocale.S105.getString(context)}',
        ),
        onSubmitted: (input) {
          checkAnswer(input, allWords[outerIndex][innerIndex][0]);
        },
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String correctWord = allWords[outerIndex][innerIndex][0]; // الكلمة الصحيحة
    String shuffled = shuffledWord(correctWord);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '${AppLocale.S108.getString(context)}',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: primaryColor,
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
                '${AppLocale.S109.getString(context)}',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                shuffled,
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
              SizedBox(height: 30),
              _buildTextField(shuffled),
              SizedBox(height: 20),
              Text(
                '${AppLocale.S103.getString(context)}: $score',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                feedbackMessage,
                style: TextStyle(
                    fontSize: 22, color: feedbackMessage == '${AppLocale.S106.getString(context)}'
                    ? Colors.green : Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}// الصفحة السادسة: لعبة اختيار الكلمة

