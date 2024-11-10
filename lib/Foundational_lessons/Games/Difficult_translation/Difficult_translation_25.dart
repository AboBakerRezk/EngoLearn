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
    ['live', 'يعيش'],
    ['nothing', 'لا شيء'],
    ['period', 'فترة'],
    ['physics', 'فيزياء'],
    ['plan', 'خطة'],
  ],
  [
    ['store', 'متجر'],
    ['tax', 'ضريبة'],
    ['analysis', 'تحليل'],
    ['cold', 'بارد'],
    ['commercial', 'تجاري'],
  ],
  [
    ['directly', 'مباشرة'],
    ['full', 'ممتلئ'],
    ['involved', 'متورط'],
    ['itself', 'ذاته'],
    ['low', 'منخفض'],
  ],
  [
    ['old', 'قديم'],
    ['policy', 'سياسة'],
    ['political', 'سياسي'],
    ['purchase', 'شراء'],
    ['series', 'سلسلة'],
  ],
];


class translationd25 extends StatefulWidget {
  @override
  _translationd25State createState() => _translationd25State();
}

class _translationd25State extends State<translationd25>
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
  int _currentWordIndex = 0;
  int currentPage = 0;
  int score = 0;
  int streak = 0;
  int timeElapsed = 0; // وقت اللعب بدون حدود
  List<String> sessions = []; // قائمة لحفظ الجلسات
  Timer? timer;
  late SharedPreferences prefs;

  // متحكم الرسوم المتحركة
  late AnimationController _controller;
  late Animation<double> _animation;
  final Color primaryColor = Color(0xFF13194E);

  @override
  void initState() {
    super.initState();
    _initPrefs(); // تهيئة SharedPreferences
    startTimer();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    _loadStatisticsData(); // تحميل بيانات النقاط
    loadSavedProgressData(); // تحميل بيانات التقدم
  }

  // تهيئة SharedPreferences وجلب الجلسات المحفوظة
  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      sessions = prefs.getStringList('sessions') ?? []; // جلب الجلسات أو تعيين قائمة فارغة
    });
  }

  // بدء المؤقت لزيادة الوقت المنقضي
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeElapsed++; // زيادة الوقت بدون حدود
      });
    });
  }

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



  List<List<String>> getWords() {
    return allWords[currentPage];
  }

  List<String> getWordOptions(String correctWord) {
    List<String> options = [...getWords().map((e) => e[0])];
    options.shuffle();
    return [correctWord, options[0], options[1]]..shuffle();
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
      sentenceFormationPoints = prefs.getDouble('sentenceFormationPoints') ?? 0;
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

  // التحقق من الإجابة وتحديث النقاط
  void checkAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        score += 10;
        increasePoints('games', 10); // زيادة النقاط في الفئة 'games'
        streak++;
        if (streak % 5 == 0) {
          score += 20;
          increasePoints('games', 20); // زيادة إضافية عند تحقيق ستريك
        }
      } else {
        score -= 5;
        increasePoints('games', -5); // خصم النقاط في الفئة 'games'
        streak = 0;
      }

      // تحديث السؤال
      if (_currentWordIndex < getWords().length - 1) {
        _currentWordIndex++;
      } else {
        _currentWordIndex = 0;
        if (currentPage < allWords.length - 1) {
          currentPage++;
        } else {
          currentPage = 0; // إعادة التدوير
        }
      }

      // حفظ الجلسة بعد كل إجابة صحيحة أو خاطئة
      _saveSession(score);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> words = getWords();
    String correctWord = words[_currentWordIndex][0];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'لعبة اختيار الكلمة الصحيحة', // يمكنك تعديل النص حسب الحاجة
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
                'اختر الكلمة الصحيحة:', // يمكنك تعديل النص حسب الحاجة
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                words[_currentWordIndex][1],
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                'الوقت المنقضي: $timeElapsed ثواني', // عرض الوقت المنقضي
                style: TextStyle(fontSize: 24, color: Colors.red),
              ),
              SizedBox(height: 30),
              ...getWordOptions(correctWord).map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: FadeTransition(
                    opacity: _animation,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      onPressed: () {
                        checkAnswer(option == correctWord);
                      },
                      child: Text(
                        option,
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }).toList(),
              SizedBox(height: 30),
              Text(
                'النتيجة: $score', // عرض النتيجة الحالية
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              // SizedBox(height: 20),
              // Text(
              //   'مجموع اللعبة: $gamePoints',
              //   style: TextStyle(fontSize: 20, color: Colors.white),
              // ),
              //   SizedBox(height: 10),
              //   Text(
              //     'مجموع النقاط الإجمالي: $totalScore',
              //     style: TextStyle(fontSize: 20, color: Colors.white),
              //   ),
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

