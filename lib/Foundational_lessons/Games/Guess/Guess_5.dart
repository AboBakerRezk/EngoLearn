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
  {'word': 'the', 'translation': 'ال', 'image': '🔤'}, // أحرف الأبجدية
  {'word': 'of', 'translation': 'من', 'image': '🔗'}, // رابط أو سلسلة
  {'word': 'and', 'translation': 'و', 'image': '➕'}, // علامة الجمع
  {'word': 'to', 'translation': 'إلى', 'image': '➡️'}, // سهم يشير إلى الأمام
  {'word': 'a', 'translation': 'أ', 'image': '🅰️'}, // حرف A كبير
  {'word': 'in', 'translation': 'في', 'image': '📥'}, // صندوق الوارد
  {'word': 'is', 'translation': 'هو', 'image': '❓'}, // علامة استفهام
  {'word': 'you', 'translation': 'أنت', 'image': '👤'}, // أيقونة شخصية
  {'word': 'are', 'translation': 'تكون', 'image': '✅'}, // علامة صح
  {'word': 'for', 'translation': 'لـ', 'image': '🎁'}, // هدية
  {'word': 'that', 'translation': 'أن', 'image': '⚖️'}, // ميزان العدل
  {'word': 'or', 'translation': 'أو', 'image': '🔀'}, // علامة التبديل
  {'word': 'it', 'translation': 'هو', 'image': '💡'}, // مصباح
  {'word': 'as', 'translation': 'مثل', 'image': '🔗'}, // رابط أو سلسلة
  {'word': 'be', 'translation': 'يكون', 'image': '🌟'}, // نجمة
  {'word': 'on', 'translation': 'على', 'image': '🔛'}, // رمز "ON"
  {'word': 'your', 'translation': 'لك', 'image': '🧑‍🦰'}, // شخصية بشعر أحمر
  {'word': 'with', 'translation': 'مع', 'image': '🤝'}, // مصافحة
  {'word': 'can', 'translation': 'يستطيع', 'image': '🛠️'}, // أدوات
  {'word': 'have', 'translation': 'لديك', 'image': '📦'}, // صندوق

  // المجموعة الثانية
  {'word': 'this', 'translation': 'هذا', 'image': '👆'}, // يد تشير إلى الشيء
  {'word': 'an', 'translation': 'أ', 'image': '🅰️'}, // حرف A كبير
  {'word': 'by', 'translation': 'بواسطة', 'image': '✍️'}, // كتابة بواسطة يد
  {'word': 'not', 'translation': 'ليس', 'image': '🚫'}, // علامة منع
  {'word': 'but', 'translation': 'لكن', 'image': '⚖️'}, // ميزان للتعبير عن التناقض

  // المجموعة الثالثة
  {'word': 'at', 'translation': 'في', 'image': '📍'}, // دبوس لتحديد المكان
  {'word': 'from', 'translation': 'من', 'image': '➡️'}, // سهم يشير للخروج
  {'word': 'I', 'translation': 'أنا', 'image': '👤'}, // أيقونة شخصية
  {'word': 'they', 'translation': 'هم', 'image': '👥'}, // شخصين
  {'word': 'more', 'translation': 'أكثر', 'image': '➕'}, // علامة زائد

  // المجموعة الرابعة
  {'word': 'will', 'translation': 'سوف', 'image': '⏳'}, // ساعة رملية تشير للمستقبل
  {'word': 'if', 'translation': 'إذا', 'image': '❓'}, // علامة استفهام
  {'word': 'some', 'translation': 'بعض', 'image': '📊'}, // رسم بياني
  {'word': 'there', 'translation': 'هناك', 'image': '📍'}, // دبوس موقع
  {'word': 'what', 'translation': 'ماذا', 'image': '❔'}, // علامة استفهام بيضاء

  // المجموعة الخامسة
  {'word': 'about', 'translation': 'حول', 'image': '🔄'}, // سهم دائري
  {'word': 'which', 'translation': 'التي', 'image': '❓'}, // علامة استفهام
  {'word': 'when', 'translation': 'متى', 'image': '⏰'}, // ساعة
  {'word': 'one', 'translation': 'واحد', 'image': '1️⃣'}, // الرقم واحد
  {'word': 'their', 'translation': 'لهم', 'image': '🧑‍🤝‍🧑'}, // شخصين للدلالة على الملكية

  // المجموعة السادسة
  {'word': 'all', 'translation': 'الكل', 'image': '💯'}, // كامل أو كل شيء
  {'word': 'also', 'translation': 'أيضاً', 'image': '➕'}, // إضافة أو أيضاً
  {'word': 'how', 'translation': 'كيف', 'image': '❓'}, // سؤال كيف
  {'word': 'many', 'translation': 'كثير', 'image': '🔢'}, // عدد كبير
  {'word': 'do', 'translation': 'افعل', 'image': '✔️'}, // فعل أو تنفيذ

  // المجموعة السابعة
  {'word': 'has', 'translation': 'لديه', 'image': '🛠️'}, // امتلاك أو أدوات
  {'word': 'most', 'translation': 'معظم', 'image': '🔝'}, // الأكثر
  {'word': 'people', 'translation': 'الناس', 'image': '👥'}, // الناس أو مجموعة
  {'word': 'other', 'translation': 'آخر', 'image': '🆚'}, // آخر أو مقارنة
  {'word': 'time', 'translation': 'وقت', 'image': '⏰'}, // الوقت

  // المجموعة الثامنة
  {'word': 'so', 'translation': 'لذلك', 'image': '➡️'}, // نتيجة أو اتجاه
  {'word': 'was', 'translation': 'كان', 'image': '🕰️'}, // الماضي أو الزمن
  {'word': 'we', 'translation': 'نحن', 'image': '👫'}, // نحن أو مجموعة
  {'word': 'these', 'translation': 'هؤلاء', 'image': '👀'}, // هؤلاء أو أشياء معينة
  {'word': 'may', 'translation': 'قد', 'image': '🌟'}, // إمكانية أو قدرة

  // المجموعة التاسعة
  {'word': 'like', 'translation': 'مثل', 'image': '❤️'}, // حب أو شبيهة
  {'word': 'use', 'translation': 'يستخدم', 'image': '🔧'}, // استخدام أو أدوات
  {'word': 'into', 'translation': 'إلى', 'image': '🔜'}, // اتجاه أو دخول
  {'word': 'than', 'translation': 'من', 'image': '➖'}, // مقارنة
  {'word': 'up', 'translation': 'أعلى', 'image': '⬆️'}, // أعلى أو اتجاه أعلى

  // المجموعة العاشرة
  {'word': 'good', 'translation': 'جيد', 'image': '👍'}, // إبهام لأعلى
  {'word': 'water', 'translation': 'ماء', 'image': '💧'}, // قطرة ماء
  {'word': 'been', 'translation': 'كان', 'image': '🕰️'}, // ساعة تشير للماضي
  {'word': 'need', 'translation': 'يحتاج', 'image': '🛠️'}, // أدوات
  {'word': 'should', 'translation': 'ينبغي', 'image': '✔️'}, // علامة صح

  {'word': 'very', 'translation': 'جداً', 'image': '🔥'}, // نار للدلالة على الشدة
  {'word': 'any', 'translation': 'أي', 'image': '❓'}, // علامة استفهام
  {'word': 'history', 'translation': 'تاريخ', 'image': '📜'}, // مخطوطة تاريخية
  {'word': 'often', 'translation': 'غالباً', 'image': '⏰'}, // ساعة
  {'word': 'way', 'translation': 'طريق', 'image': '🛤️'}, // سكة حديد

  {'word': 'well', 'translation': 'حسناً', 'image': '💧'}, // قطرة ماء للدلالة على الصحة
  {'word': 'art', 'translation': 'فن', 'image': '🎨'}, // لوحة فنية
  {'word': 'know', 'translation': 'يعرف', 'image': '🧠'}, // دماغ للدلالة على المعرفة
  {'word': 'were', 'translation': 'كانوا', 'image': '👥'}, // شخصين
  {'word': 'then', 'translation': 'ثم', 'image': '⏩'}, // سهم سريع

  {'word': 'my', 'translation': 'لي', 'image': '👤'}, // أيقونة شخصية
  {'word': 'first', 'translation': 'أول', 'image': '1️⃣'}, // الرقم واحد
  {'word': 'would', 'translation': 'سوف', 'image': '🔮'}, // كرة بلورية للدلالة على المستقبل
  {'word': 'money', 'translation': 'مال', 'image': '💰'}, // كيس المال
  {'word': 'each', 'translation': 'كل', 'image': '🔁'}, // سهم متكرر للدلالة على الكل
];




// الصفحة الرابعه: لعبة  خمن


class MatchWordToImagePage5 extends StatefulWidget {
  @override
  _MatchWordToImagePage5State createState() => _MatchWordToImagePage5State();
}

class _MatchWordToImagePage5State extends State<MatchWordToImagePage5>
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

