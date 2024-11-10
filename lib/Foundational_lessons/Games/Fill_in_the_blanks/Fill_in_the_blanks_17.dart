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
    ['name', 'اسم'],
    ['personal', 'شخصي'],
    ['school', 'مدرسة'],
    ['top', 'أعلى'],
    ['current', 'حالي'],
  ],
  [
    ['generally', 'عموماً'],
    ['historical', 'تاريخي'],
    ['investment', 'استثمار'],
    ['left', 'يسار'],
    ['national', 'وطني'],
  ],
  [
    ['amount', 'كمية'],
    ['level', 'مستوى'],
    ['order', 'طلب'],
    ['practice', 'ممارسة'],
    ['research', 'بحث'],
  ],
  [
    ['sense', 'إحساس'],
    ['service', 'خدمة'],
    ['area', 'منطقة'],
    ['cut', 'قطع'],
    ['hot', 'حار'],
  ],
];



// الصفحة الثانية: لعبة ملء الفراغات


class FillInTheBlanksPage17 extends StatefulWidget {
  @override
  _FillInTheBlanksPage17State createState() => _FillInTheBlanksPage17State();
}

class _FillInTheBlanksPage17State extends State<FillInTheBlanksPage17>
    with SingleTickerProviderStateMixin {
  // نقاط مختلفة
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

  // مجموع النقاط
  double totalScore = 0;

  // مستويات التقدم
  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int bottleFillLevel = 0;

  // الدرجات والوقت والجلسات
  int score = 0;
  int level = 1;
  int correctAnswersInLevel = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E);


  // الجملة الحالية والكلمة الصحيحة
  String currentSentence = '';
  String correctWord = '';

  // SharedPreferences
  late SharedPreferences prefs;
  List<String> sessions = [];

  // مؤقت لزيادة الوقت المنقضي
  Timer? timer;
  int timeElapsed = 0; // وقت اللعب بدون حدود

  @override
  void initState() {
    super.initState();
    _initPrefs(); // تهيئة SharedPreferences
    _loadStatisticsData(); // تحميل بيانات النقاط
    loadSavedProgressData(); // تحميل بيانات التقدم
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    generateSentence(); // توليد الجملة الأولى
  }

  // تهيئة SharedPreferences وجلب الجلسات المحفوظة
  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      sessions = prefs.getStringList('sessions') ?? []; // جلب الجلسات أو تعيين قائمة فارغة
    });
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
          prefs.setDouble('sentenceFormationPoints', sentenceFormationPoints);
          break;
        case 'games':
          gamePoints += amount;
          prefs.setDouble('gamePoints', gamePoints);
          break;
      }
      // تحديث مجموع النقاط
      totalScore = grammarPoints +
          lessonPoints +
          studyHoursPoints +
          listeningPoints +
          speakingPoints +
          readingPoints +
          writingPoints +
          exercisePoints +
          sentenceFormationPoints +
          gamePoints;
      prefs.setDouble('totalScore', totalScore);
    });
  }

  // تحميل بيانات النقاط من SharedPreferences
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
      totalScore = prefs.getDouble('totalScore') ??
          (grammarPoints +
              lessonPoints +
              studyHoursPoints +
              listeningPoints +
              speakingPoints +
              readingPoints +
              writingPoints +
              exercisePoints +
              sentenceFormationPoints +
              gamePoints);
    });
  }

  // تحميل بيانات مستويات التقدم من SharedPreferences
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

  // حفظ بيانات مستويات التقدم إلى SharedPreferences
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('progressReading', readingProgressLevel);
    await prefs.setInt('progressListening', listeningProgressLevel);
    await prefs.setInt('progressWriting', writingProgressLevel);
    await prefs.setInt('progressGrammar', grammarProgressLevel);
    await prefs.setInt('bottleLevel', bottleFillLevel);
  }

  // حفظ بيانات النقاط المختلفة إلى SharedPreferences
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
    await prefs.setDouble('sentenceFormationPoints', sentenceFormationPoints);
    await prefs.setDouble('gamePoints', gamePoints);
    await prefs.setDouble('totalScore', totalScore);
  }

  // قائمة الجلسات
  List<String> sessionsList = [];



  // إضافة الجلسة إلى القائمة وحفظها باستخدام SharedPreferences
  Future<void> _saveSession(int finalScore) async {
    String session = 'Score: $finalScore, Time: $timeElapsed seconds';
    sessions.add(session);
    await prefs.setStringList('sessions', sessions);
  }

  // عرض الجلسات المحفوظة في Dialog
  void showSessionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Previous Sessions'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sessions[index]),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  // دالة لتوليد جملة عشوائية باستخدام كلمات من allWords
  void generateSentence() {
    Random random = Random();

    if (allWords.length < 4) {
      // تأكد من أن هناك فئات كافية للكلمات
      return;
    }

    // اختيار كلمات عشوائية من قائمة allWords
    List<String> subject = allWords[0][random.nextInt(allWords[0].length)];
    List<String> verb = allWords[1][random.nextInt(allWords[1].length)];
    List<String> preposition =
    allWords[2][random.nextInt(allWords[2].length)];

    // بناء الجملة
    String sentence = '${subject[0]} _____ ${preposition[0]}.';
    String correctWordLocal = verb[0];

    setState(() {
      currentSentence = sentence;
      correctWord = correctWordLocal;
    });
  }

  // دالة لتوليد خيارات عشوائية للكلمات
  List<String> getWordOptions(String correctWord) {
    List<String> options = [];
    for (var list in allWords) {
      options.addAll(list.map((e) => e[0]));
    }
    options.remove(correctWord); // إزالة الكلمة الصحيحة من الخيارات
    options.shuffle(); // خلط الكلمات
    return [correctWord, options[0], options[1]]..shuffle();
  }

  // دالة للتحقق من الإجابة الصحيحة وتحديث النقاط
  void checkAnswer(String option, bool isCorrect) {
    setState(() {
      if (isCorrect) {
        score += 10;
        increasePoints('games', 10); // زيادة النقاط في الفئة 'games'
        correctAnswersInLevel++;
        if (correctAnswersInLevel % 5 == 0) {
          level++;
          score += 20;
          increasePoints('games', 20); // زيادة إضافية عند تحقيق ستريك
          correctAnswersInLevel = 0;
        }
      } else {
        score -= 5;
        increasePoints('games', -5); // خصم النقاط في الفئة 'games'
        correctAnswersInLevel = 0;
      }

      // حفظ الجلسة بعد كل إجابة صحيحة أو خاطئة
      _saveSession(score);

      // التبديل إلى الجملة التالية دون حدود
      generateSentence();
    });
  }

  // عرض مربع حوار انتهاء اللعبة (تم إزالته لجعل اللعبة لا نهائية)
  /*
  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('انتهت اللعبة'),
          content: Text('النتيجة: $score\nالمستوى: $level'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetGame(); // إعادة تعيين اللعبة
              },
              child: Text('إعادة تشغيل'),
            ),
          ],
        );
      },
    );
  }
  */

  // إعادة تعيين اللعبة (يمكنك الاحتفاظ بهذه الدالة إذا رغبت في إعادة تعيين اللعبة يدويًا)
  void resetGame() {
    setState(() {
      score = 0;
      level = 1;
      correctAnswersInLevel = 0;
      timeElapsed = 0;
      generateSentence();
    });
  }

  // بناء الزر مع الرسوم المتحركة
  Widget _buildButton(String option, bool isCorrect) {
    return FadeTransition(
      opacity: _animation,
      child: ElevatedButton(
        onPressed: () {
          checkAnswer(option, option == correctWord);
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
    // التأكد من وجود جملة حالية
    if (currentSentence.isEmpty) {
      generateSentence();
    }

    String sentence = currentSentence;
    String correctWordLocal = correctWord;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'لعبة ملء الفراغات', // يمكنك تعديل النص حسب الحاجة
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        actions: [
          // عرض الجلسات السابقة
          IconButton(
            icon: Icon(Icons.history),
            onPressed: showSessionsDialog,
          ),
          // عرض مجموع النقاط الإجمالي في شريط التطبيق
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'المجموع: $totalScore',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
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
                'اختر الكلمة الصحيحة:',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                sentence,
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              SizedBox(height: 30),
              ...getWordOptions(correctWordLocal).map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _buildButton(option, option == correctWordLocal),
                );
              }).toList(),
              SizedBox(height: 30),
              Text(
                'النتيجة: $score',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel(); // إيقاف المؤقت عند الخروج من الصفحة
    _controller.dispose();
    saveStatisticsData(); // حفظ بيانات النقاط
    saveProgressDataToPreferences(); // حفظ بيانات التقدم
    super.dispose();
  }
}

