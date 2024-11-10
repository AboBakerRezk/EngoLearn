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
    ['over', 'على'],
    ['world', 'العالم'],
    ['information', 'معلومات'],
    ['map', 'خريطة'],
    ['find', 'جد'],
  ],
  [
    ['where', 'أين'],
    ['much', 'كثير'],
    ['take', 'خذ'],
    ['two', 'اثنان'],
    ['want', 'تريد'],
  ],
  [
    ['important', 'مهم'],
    ['family', 'أسرة'],
    ['those', 'أولئك'],
    ['example', 'مثال'],
    ['while', 'بينما'],
  ],
  [
    ['he', 'هو'],
    ['look', 'ينظر'],
    ['government', 'حكومة'],
    ['before', 'قبل'],
    ['help', 'مساعدة'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
// ملف منفصل لإدارة الكلمات والصور (مثلاً: words_data.dart)



class MemoryGamePage6 extends StatefulWidget {
  @override
  _MemoryGamePage6State createState() => _MemoryGamePage6State();
}

class _MemoryGamePage6State extends State<MemoryGamePage6>
    with SingleTickerProviderStateMixin {
  List<Map<String, String>> wordPairs = [];
  List<String> shuffledWords = [];
  List<bool> flipped = [];
  int? firstIndex;
  int? secondIndex;
  int score = 0;
  String difficulty = 'سهل'; // مستوى الصعوبة الافتراضي
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

    // تحويل البيانات إلى شكل زوج من الكلمات
    for (var group in allWords) {
      for (var pair in group) {
        wordPairs.add({'english': pair[0], 'arabic': pair[1]});
      }
    }

    resetGame();
  }

  void resetGame() {
    shuffledWords = [];
    flipped = [];
    firstIndex = null;
    secondIndex = null;
    score = 0;

    // خلط أزواج الكلمات قبل الاختيار
    wordPairs.shuffle();

    // تحديد عدد الأزواج بناءً على مستوى الصعوبة
    int pairsCount = getPairsCountByDifficulty();

    // اختيار الأزواج المناسبة بعد الخلط
    List<Map<String, String>> selectedPairs = wordPairs.take(pairsCount).toList();

    for (var pair in selectedPairs) {
      shuffledWords.add(pair['english']!);
      shuffledWords.add(pair['arabic']!);
    }

    shuffledWords.shuffle(); // خلط الكلمات بعد إضافتها
    flipped = List<bool>.filled(shuffledWords.length, false);
  }

  int getPairsCountByDifficulty() {
    switch (difficulty) {
      case 'سهل':
        return 5; // 5 أزواج
      case 'متوسط':
        return 10; // 10 أزواج
      case 'صعب':
        return 15; // 15 زوجاً
      default:
        return 5;
    }
  }

  void flipCard(int index) {
    setState(() {
      flipped[index] = true;

      if (firstIndex == null) {
        firstIndex = index;
      } else if (secondIndex == null) {
        secondIndex = index;

        Timer(Duration(seconds: 1), () {
          checkMatch();
        });
      }
    });
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

  void checkMatch() {
    if (firstIndex != null && secondIndex != null) {
      String firstWord = shuffledWords[firstIndex!];
      String secondWord = shuffledWords[secondIndex!];

      bool isMatch = false;

      for (var pair in wordPairs) {
        if ((firstWord == pair['english'] && secondWord == pair['arabic']) ||
            (firstWord == pair['arabic'] && secondWord == pair['english'])) {
          isMatch = true;
          break;
        }
      }

      setState(() {
        if (!isMatch) {
          flipped[firstIndex!] = false;
          flipped[secondIndex!] = false;
        } else {
          score += 10;
        }

        // تحقق إذا انتهى اللاعب من جميع البطاقات
        if (flipped.every((isFlipped) => isFlipped)) {
          // إعادة مزج البطاقات والبدء من جديد
          resetGame();
        }

        firstIndex = null;
        secondIndex = null;
      });
    }
  }

  void selectDifficulty(String selectedDifficulty) {
    setState(() {
      difficulty = selectedDifficulty;
      resetGame(); // إعادة ضبط اللعبة بناءً على مستوى الصعوبة
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('لعبة الذاكرة - مطابقة الكلمات',style: TextStyle(color: Colors.white),),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white, // تغيير لون الأيقونات بما في ذلك النقاط الثلاث إلى الأبيض
        ),
        actions: [
          PopupMenuButton<String>(

            onSelected: selectDifficulty,
            color: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem(

                value: 'سهل',
                child: Text('${AppLocale.S111.getString(context)}'),
              ),
              PopupMenuItem(
                value: 'متوسط',
                child: Text('${AppLocale.S112.getString(context)}'),
              ),
              PopupMenuItem(
                value: 'صعب',
                child: Text('${AppLocale.S113.getString(context)}'),
              ),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: shuffledWords.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (!flipped[index] && firstIndex != index && secondIndex == null) {
                        flipCard(index);
                      }
                    },
                    child: FadeTransition(
                      opacity: _animation,
                      child: Card(
                        color: flipped[index] ? Colors.blue[200] : primaryColor,
                        child: Center(
                          child: Text(
                            flipped[index] ? shuffledWords[index] : '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                '${AppLocale.S96.getString(context)}: $score',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: resetGame,
                child: Text('${AppLocale.S99.getString(context)}'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
