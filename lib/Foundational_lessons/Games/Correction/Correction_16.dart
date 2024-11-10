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
    ['line', 'خط'],
    ['product', 'منتج'],
    ['care', 'رعاية'],
    ['group', 'مجموعة'],
    ['idea', 'فكرة'],
  ],
  [
    ['risk', 'خطر'],
    ['several', 'عدة'],
    ['someone', 'شخص ما'],
    ['temperature', 'درجة الحرارة'],
    ['united', 'متحد'],
  ],
  [
    ['word', 'كلمة'],
    ['fat', 'دهون'],
    ['force', 'قوة'],
    ['key', 'مفتاح'],
    ['light', 'ضوء'],
  ],
  [
    ['simply', 'ببساطة'],
    ['today', 'اليوم'],
    ['training', 'تدريب'],
    ['until', 'حتى'],
    ['major', 'رائد'],
  ],
];
class WordShootingGame16 extends StatefulWidget {
  @override
  _WordShootingGame16State createState() => _WordShootingGame16State();
}

class _WordShootingGame16State extends State<WordShootingGame16> {
  // Points Variables
  double grammarPoints = 0;
  double lessonPoints = 0;
  double studyHoursPoints = 0;
  double listeningPoints = 0;
  double speakingPoints = 0;
  double readingPoints = 0;
  double writingPoints = 0;
  double exercisePoints = 0;
  double sentenceFormationPoints = 0;
  double gamePoints = 0; // Initialized to 900 as per _loadStatisticsData

  // Progress Variables
  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int bottleFillLevel = 0;

  // Total Score
  double totalScore = 0;

  // Increase Points Function
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
      // Update Total Score
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

  // Load Statistics Data
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

  // Load Progress Data
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

  // Save Progress Data
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('progressReading', readingProgressLevel);
    await prefs.setInt('progressListening', listeningProgressLevel);
    await prefs.setInt('progressWriting', writingProgressLevel);
    await prefs.setInt('progressGrammar', grammarProgressLevel);
    await prefs.setInt('bottleLevel', bottleFillLevel);
  }

  // Save Statistics Data
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

  // Initialize Points and Progress Data
  @override
  void initState() {
    super.initState();
    _loadStatisticsData();
    loadSavedProgressData();
    startGame();
  }

  // Game Variables
  Random random = Random();
  List<_Word> words = [];
  int score = 0;
  String currentTranslation = '';
  String currentCorrectWord = ''; // الكلمة الإنجليزية الصحيحة الحالية
  bool gameRunning = true;
  Timer? spawnTimer;
  Timer? moveTimer;
  String difficulty = 'سهل'; // مستوى الصعوبة الافتراضي
  double wordSpeed = 2; // سرعة الكلمة الافتراضية
  int wordsSinceLastCorrect = 0; // تتبع عدد الكلمات منذ آخر كلمة صحيحة



  void startGame() {
    adjustDifficultySettings();
    spawnTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (gameRunning) {
        spawnWord();
      }
    });

    moveTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (gameRunning) {
        moveWords();
      }
    });

    nextTranslation();
  }

  void adjustDifficultySettings() {
    // تحديد سرعة الكلمات بناءً على مستوى الصعوبة
    if (difficulty == 'سهل') {
      wordSpeed = 2;
    } else if (difficulty == 'متوسط') {
      wordSpeed = 4;
    } else if (difficulty == 'صعب') {
      wordSpeed = 6;
    }
  }

  void spawnWord() {
    setState(() {
      if (wordsSinceLastCorrect >= 5) {
        // يجب ظهور الكلمة الصحيحة الآن
        double startY = random.nextDouble() *
            (MediaQuery.of(context).size.height / 2 - 50);
        words.add(_Word(
          word: currentCorrectWord,
          positionX: 0,
          positionY: startY,
        ));
        wordsSinceLastCorrect = 0; // إعادة التتبع
      } else {
        // فرصة معينة لظهور الكلمة الصحيحة
        double chance = 0.2; // 20% فرصة لظهور الكلمة الصحيحة
        if (random.nextDouble() < chance) {
          // ظهور الكلمة الصحيحة
          double startY = random.nextDouble() *
              (MediaQuery.of(context).size.height / 2 - 50);
          words.add(_Word(
            word: currentCorrectWord,
            positionX: 0,
            positionY: startY,
          ));
          wordsSinceLastCorrect = 0; // إعادة التتبع
        } else {
          // ظهور كلمة خاطئة
          String englishWord;
          String arabicWord;
          // التأكد من أن الكلمة الخاطئة ليست هي الكلمة الصحيحة
          do {
            int groupIndex = random.nextInt(allWords.length);
            int wordIndex = random.nextInt(allWords[groupIndex].length);
            englishWord = allWords[groupIndex][wordIndex][0];
            arabicWord = allWords[groupIndex][wordIndex][1];
          } while (englishWord == currentCorrectWord);

          double startY = random.nextDouble() *
              (MediaQuery.of(context).size.height / 2 - 50);
          words.add(_Word(
            word: englishWord,
            positionX: 0,
            positionY: startY,
          ));
          wordsSinceLastCorrect += 1; // زيادة العداد
        }
      }
    });
  }

  void nextTranslation() {
    int groupIndex = random.nextInt(allWords.length);
    int wordIndex = random.nextInt(allWords[groupIndex].length);
    setState(() {
      currentTranslation = allWords[groupIndex][wordIndex][1]; // الترجمة العربية
      currentCorrectWord = allWords[groupIndex][wordIndex][0]; // الكلمة الإنجليزية الصحيحة
    });
  }

  void removeWord(_Word word) {
    setState(() {
      words.remove(word);
    });
  }

  void checkWord(_Word word) {
    if (word.word == currentCorrectWord) {
      setState(() {
        score += 10;
        increasePoints('games', 10); // زيادة النقاط في الفئة 'games'
        removeWord(word);
        nextTranslation(); // الانتقال إلى الترجمة التالية
      });
    } else {
      setState(() {
        score -= 5; // خسارة نقاط إذا اختار الكلمة الخاطئة
        increasePoints('games', -5); // خصم النقاط في الفئة 'games'
        removeWord(word);
      });
    }
  }

  void moveWords() {
    setState(() {
      for (int i = words.length - 1; i >= 0; i--) {
        words[i].positionX += wordSpeed; // تحريك الكلمات بناءً على مستوى الصعوبة

        if (words[i].positionX > MediaQuery.of(context).size.width / 2 - 50) {
          words.removeAt(i); // إزالة الكلمة إذا خرجت عن الشاشة
          // يمكنك إضافة منطق خسارة اللعبة إذا رغبت في ذلك
        }
      }
    });
  }

  void changeDifficulty(String newDifficulty) {
    setState(() {
      difficulty = newDifficulty;
      adjustDifficultySettings();
    });
  }

  @override
  void dispose() {
    spawnTimer?.cancel();
    moveTimer?.cancel();
    saveStatisticsData(); // حفظ البيانات عند خروج اللعبة
    saveProgressDataToPreferences();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double halfWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        iconTheme: IconThemeData(
          color: Colors.white, // تغيير لون الأيقونات بما في ذلك النقاط الثلاث إلى الأبيض
        ),
        title: Text(
          'لعبة إطلاق الكلمات',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
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
          PopupMenuButton<String>(
            color: Colors.white,
            onSelected: changeDifficulty,
            itemBuilder: (BuildContext context) {
              return {'سهل', 'متوسط', 'صعب'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // النصف الأيسر: الترجمة العربية الثابتة
          Container(
            width: halfWidth,
            color: Colors.blue[50],
            child: Center(
              child: Text(
                currentTranslation,
                style: TextStyle(fontSize: 32, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // النصف الأيمن: الكلمات الإنجليزية المتحركة
          Container(
            width: halfWidth,
            color: Colors.white,
            child: Stack(
              children: [
                // عرض نقاط اللعبة الحالية
                Positioned(
                  top: 10,
                  right: 10,
                  child: Text(
                    'النقاط: $score',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                // عرض مجموع النقاط الإجمالي داخل اللعبة
                Positioned(
                  top: 40,
                  right: 10,
                  child: Text(
                    'مجموع اللعبة: $gamePoints',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                // عرض الكلمات المتحركة
                ...words.map((word) {
                  return Positioned(
                    top: word.positionY,
                    left: word.positionX,
                    child: GestureDetector(
                      onTap: () {
                        checkWord(word);
                      },
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: Colors.blue[400],
                        child: Text(
                          word.word,
                          style:
                          TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Word {
  String word;
  double positionX;
  double positionY;

  _Word({
    required this.word,
    required this.positionX,
    required this.positionY,
  });
}
