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
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'data', 'translation': 'بيانات', 'image': '📊'}, // رسم بياني للدلالة على "بيانات"
  {'word': 'feel', 'translation': 'يشعر', 'image': '😊'}, // وجه مبتسم للدلالة على "يشعر"
  {'word': 'high', 'translation': 'مرتفع', 'image': '🏔️'}, // جبل للدلالة على "مرتفع"
  {'word': 'off', 'translation': 'إيقاف', 'image': '🔌'}, // قابس كهرباء للدلالة على "إيقاف"
  {'word': 'point', 'translation': 'نقطة', 'image': '📍'}, // دبوس للدلالة على "نقطة"

  // المجموعة الثانية
  {'word': 'type', 'translation': 'نوع', 'image': '🔤'}, // أحرف أبجدية للدلالة على "نوع"
  {'word': 'whether', 'translation': 'سواء', 'image': '🤔'}, // وجه يفكر للدلالة على الخيارات
  {'word': 'food', 'translation': 'طعام', 'image': '🍽️'}, // طبق طعام للدلالة على "طعام"
  {'word': 'understanding', 'translation': 'فهم', 'image': '🧠'}, // دماغ للدلالة على "فهم"
  {'word': 'here', 'translation': 'هنا', 'image': '📍'}, // دبوس موقع للدلالة على "هنا"

  // المجموعة الثالثة
  {'word': 'home', 'translation': 'الصفحة الرئيسية', 'image': '🏡'}, // منزل للدلالة على "الصفحة الرئيسية"
  {'word': 'certain', 'translation': 'مؤكد', 'image': '✔️'}, // علامة صح للدلالة على "مؤكد"
  {'word': 'economy', 'translation': 'اقتصاد', 'image': '💰'}, // كيس نقود للدلالة على "اقتصاد"
  {'word': 'little', 'translation': 'قليل', 'image': '🔹'}, // ماسة صغيرة للدلالة على "قليل"
  {'word': 'theory', 'translation': 'نظرية', 'image': '📖'}, // كتاب للدلالة على "نظرية"

  // المجموعة الرابعة
  {'word': 'tonight', 'translation': 'هذه الليلة', 'image': '🌙'}, // قمر للدلالة على "هذه الليلة"
  {'word': 'law', 'translation': 'قانون', 'image': '⚖️'}, // ميزان للدلالة على "قانون"
  {'word': 'put', 'translation': 'وضع', 'image': '📥'}, // صندوق واد للدلالة على "وضع"
  {'word': 'under', 'translation': 'تحت', 'image': '⬇️'}, // سهم يشير لأسفل للدلالة على "تحت"
  {'word': 'value', 'translation': 'قيمة', 'image': '💎'}, // ماسة للدلالة على "قيمة"
];




// الصفحة الرابعه: لعبة  خمن


class MatchWordToImagePage12 extends StatefulWidget {
  @override
  _MatchWordToImagePage12State createState() => _MatchWordToImagePage12State();
}

class _MatchWordToImagePage12State extends State<MatchWordToImagePage12>
    with SingleTickerProviderStateMixin {
  int score = 0;
  int currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E); // اللون الأساسي

  // Statistics Points
  double grammarPoints = 0;
  double lessonPoints = 0;
  double studyHoursPoints = 0;
  double listeningPoints = 0;
  double speakingPoints = 0;
  double readingPoints = 0;
  double writingPoints = 0;
  double exercisePoints = 0;
  double sentenceFormationPoints = 0;
  double gamePoints = 0;

  // Progress Levels
  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int bottleFillLevel = 0;

  // Additional Scores
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
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    // Load saved data
    _loadStatisticsData();
    loadSavedProgressData();
    increasePoints('games', 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // دالة لاختيار كلمة وصورتها الصحيحة
  Map<String, String> getCurrentWordAndImage() {
    if (currentIndex < allWords2.length) {
      return allWords2[currentIndex];
    } else {
      // إعادة التدوير إلى أول كلمة بعد نهاية القائمة
      currentIndex = 0;
      return allWords2[currentIndex];
    }
  }

  // دالة لتحديد خيارات الكلمات
  List<String> getWordOptions(String correctWord) {
    List<String> options = allWords2.map((e) => e['word']!).toList();
    options.remove(correctWord); // إزالة الكلمة الصحيحة من الخيارات
    options.shuffle(); // خلط الكلمات

    // اختيار أول خيارين بعد الخلط
    List<String> selectedOptions = options.take(2).toList();

    // إضافة الكلمة الصحيحة وإعادة الخلط
    selectedOptions.add(correctWord);
    selectedOptions.shuffle();

    return selectedOptions;
  }

  void checkAnswer(String selectedOption, String correctWord) {
    setState(() {
      if (selectedOption == correctWord) {
        score += 10;
        increasePoints('games', 10);
      } else {
        score -= 5;
        increasePoints('games', -5);
      }

      // الانتقال إلى الكلمة التالية
      currentIndex = (currentIndex + 1) % allWords2.length; // إعادة التدوير
    });
  }

  void resetGame() {
    setState(() {
      score = 0;
      currentIndex = 0;
      totalScore = 0;
    });
  }

  Widget _buildButton(String option, String correctWord) {
    return FadeTransition(
      opacity: _animation,
      child: ElevatedButton(
        onPressed: () {
          checkAnswer(option, correctWord); // تأكد من تمرير correctWord الصحيح
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

  @override
  Widget build(BuildContext context) {
    Map<String, String> currentWordAndImage = getCurrentWordAndImage();
    String correctWord = currentWordAndImage['word']!;
    String image = currentWordAndImage['image']!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '${AppLocale.S101.getString(context)}',
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
                '${AppLocale.S102.getString(context)}',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              // عرض الصورة المرتبطة بالكلمة
              Text(
                image,
                style: TextStyle(fontSize: 100, color: Colors.white),
              ),
              SizedBox(height: 30),
              // عرض خيارات الكلمات
              ...getWordOptions(correctWord).map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _buildButton(option, correctWord), // تمرير correctWord هنا
                );
              }).toList(),
              SizedBox(height: 30),
              Text(
                '${AppLocale.S103.getString(context)}: $score',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
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

  // دالة لزيادة النقاط بناءً على الفئة
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
      }
    });
  }

  // إضافات أخرى
  void updateTotalScore() {
    setState(() {
      totalScore = _pronounScore + _verbScore;
    });
  }

  void increaseSectionPoints(String section, int points) {
    if (section == 'games') {
      setState(() {
        totalScore += points;
      });
    }
  }
}

