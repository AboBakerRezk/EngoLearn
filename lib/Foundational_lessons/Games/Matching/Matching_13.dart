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



class QuickMatchGame13 extends StatefulWidget {
  @override
  _QuickMatchGame13State createState() => _QuickMatchGame13State();
}

class _QuickMatchGame13State extends State<QuickMatchGame13> {
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

  List<String> englishWords = [];
  List<String> arabicWords = [];
  Map<String, bool> matchedPairs = {};
  int score = 0;
  int totalWords = 6; // عدد الكلمات العشوائية التي نريد عرضها
  bool gameFinished = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      // اختيار عدد عشوائي من الكلمات من allWords
      var random = Random();
      List<List<String>> selectedPairs = [];

      // دمج جميع الكلمات في قائمة واحدة واختيار 5 منها بشكل عشوائي
      var flatList = allWords.expand((pairList) => pairList).toList();
      while (selectedPairs.length < totalWords) {
        var randomPair = flatList[random.nextInt(flatList.length)];
        if (!selectedPairs.contains(randomPair)) {
          selectedPairs.add(randomPair);
        }
      }

      // فصل الكلمات الإنجليزية والعربية
      englishWords = selectedPairs.map((pair) => pair[0]).toList();
      arabicWords = selectedPairs.map((pair) => pair[1]).toList();
      englishWords.shuffle();
      arabicWords.shuffle();
      matchedPairs = {};
      score = 0;
      gameFinished = false;
    });
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

  // دالة للتعامل مع نهاية السحب
  void onDragEnd(String englishWord, String arabicWord) {
    setState(() {
      for (var wordList in allWords) {
        for (var pair in wordList) {
          if (pair[0] == englishWord && pair[1] == arabicWord) {
            matchedPairs[englishWord] = true;
            score += 10;


            return;
          }
        }
      }
    });
    setState(() {
      // تحديث مستويات التقدم بناءً على النقاط الجديدة
      if (gamePoints < 500) {
        gamePoints += (score * 0.50).toInt();
        if (gamePoints > 500) gamePoints = 500; // الحد الأقصى
      }
      if (bottleFillLevel < 6000) {
        bottleFillLevel += (score * 0.50).toInt();
        if (bottleFillLevel > 6000) bottleFillLevel = 6000; // الحد الأقصى
      }
      if (matchedPairs.length == totalWords) {
        gameFinished = true;
      }
    });
    saveProgressDataToPreferences();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              SizedBox(height: 20),
              Row(
                children: [
                  // الكلمات الإنجليزية التي يمكن سحبها
                  Expanded(
                    child: Column(
                      children: englishWords.map((englishWord) {
                        return Draggable<String>(
                          data: englishWord,
                          child: Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(16),
                            color: matchedPairs[englishWord] == true
                                ? Colors.green
                                : Colors.blue[200],
                            child: Text(
                              englishWord,
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                          feedback: Material(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              color: Colors.blue[200],
                              child: Text(
                                englishWord,
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          childWhenDragging: Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(16),
                            color: Colors.grey,
                            child: Text(
                              englishWord,
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(width: 20),
                  // الكلمات العربية
                  Expanded(
                    child: Column(
                      children: arabicWords.map((arabicWord) {
                        return DragTarget<String>(
                          onAccept: (englishWord) {
                            onDragEnd(englishWord, arabicWord);
                          },
                          builder: (context, candidateData, rejectedData) {
                            return Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(16),
                              color: Colors.orange[200],
                              child: Text(
                                arabicWord,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // عرض النقاط
              Text(
                '${AppLocale.S87.getString(context)}: $score',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              if (gameFinished)
                ElevatedButton(
                  onPressed: startGame,
                  child: Text(' ${AppLocale.S99.getString(context)}'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


