import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningPage extends StatefulWidget {
  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  PageController _controller = PageController();
  bool _isCompleted = false;

  // نقاط المستخدم المختلفة
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

  // مستويات التقدم
  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int bottleFillLevel = 0;

  // تمارين الضمائر
  List<String> pronounQuestions = [
    '___ goes to school.',
    '___ eats the apple.',
    '___ play football.',
    '___ likes reading.',
    '___ are in the garden.',
    '___ is an engineer.',
    '___ study English.',
    '___ are hardworking students.',
    '___ are in the classroom now.',
    '___ is a doctor.'
  ];

  // خيارات الضمائر
  List<List<String>> pronounOptions = [
    ['He', 'Car', 'Apple'],            // He هو الضمير الصحيح
    ['Book', 'Dog', 'She'],            // She هو الضمير الصحيح
    ['They', 'House', 'Chair'],        // They هو الضمير الصحيح
    ['Computer', 'Tree', 'He'],        // He هو الضمير الصحيح
    ['Water', 'They', 'Light'],        // They هو الضمير الصحيح
    ['Phone', 'Ball', 'She'],          // She هو الضمير الصحيح
    ['They', 'Table', 'Door'],         // They هو الضمير الصحيح
    ['Cloud', 'They', 'Pen'],          // They هو الضمير الصحيح
    ['Road', 'Window', 'We'],          // We هو الضمير الصحيح
    ['He', 'Shoe', 'Bread']            // He هو الضمير الصحيح
  ];

  // الإجابات الصحيحة للضمائر
  List<int> pronounAnswers = [0, 2, 0, 2, 1, 2, 0, 1, 2, 0];

  // تمارين الأفعال
  List<String> verbQuestions = [
    'I ___ an apple.',
    'She ___ to school.',
    'We ___ football.',
    'He ___ the book.',
    'They ___ the homework.',
    'You ___ English.',
    'They ___ in the restaurant.',
    'She ___ tennis.',
    'I ___ to work.',
    'We ___ tea.'
  ];

  // خيارات الأفعال (خيار صحيح وخيارين خاطئين)
  List<List<String>> verbOptions = [
    ['eat', 'consumes', 'book'],          // eat هو الفعل الصحيح
    ['attends', 'go', 'home'],            // attend هو الفعل الصحيح
    ['plays', 'kick', 'ball'],            // plays هو الفعل الصحيح
    ['reads', 'peruse', 'study'],         // reads هو الفعل الصحيح
    ['complete', 'do', 'pen'],            // do هو الفعل الصحيح
    ['speak', 'study', 'teacher'],        // study هو الفعل الصحيح
    ['dine', 'eat', 'kitchen'],           // eat هو الفعل الصحيح
    ['plays', 'participates', 'dance'],    // plays هو الفعل الصحيح
    ['travel', 'go', 'car'],              // go هو الفعل الصحيح
    ['brew', 'drink', 'water']            // drink هو الفعل الصحيح
  ];

  // الإجابات الصحيحة للأفعال
  List<int> verbAnswers = [0, 1, 0, 0, 1, 1, 1, 0, 1, 1];

  // متغيرات لحفظ إجابات المستخدم
  List<int> _selectedPronounOptions = List.filled(10, -1);
  List<String> _feedbackPronouns = List.filled(10, '');

  List<int> _selectedVerbOptions = List.filled(10, -1);
  List<String> _feedbackVerbs = List.filled(10, '');

  int _pronounScore = 0;
  int _verbScore = 0;

  @override
  void initState() {
    super.initState();
    _loadStatisticsData();
    loadSavedProgressData(); // تحميل البيانات المحفوظة عند بدء الصفحة
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
      sentenceFormationPoints = prefs.getDouble('sentenceFormationPoints') ?? 0;
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
    await prefs.setDouble('sentenceFormationPoints', sentenceFormationPoints);
    await prefs.setDouble('gamePoints', gamePoints);
  }
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
    });
  }

  // دالة لزيادة نقاط القواعد بناءً على مجموع نقاط الضمائر والأفعال
  void updateGrammarPointsBasedOnScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      int totalScore = _pronounScore + _verbScore;

      void increasePoints(String section, int points) {
        if (section == 'grammar') {
          totalScore += points;
        }
      }
      increasePoints('grammar', 0); // مثال على زيادة 500 نقطة في قسم القواعد

      // حساب مجموع نقاط الضمائر والأفعال

      // زيادة نقاط القواعد بمقدار مجموع نقاط الضمائر والأفعال
      grammarPoints += totalScore;

      // تحديث مستويات التقدم بناءً على النقاط الجديدة
      if (grammarProgressLevel < 500) {
        grammarProgressLevel += (totalScore * 0.50).toInt();
        if (grammarProgressLevel > 500) grammarProgressLevel = 500; // الحد الأقصى
      }
      if (bottleFillLevel < 6000) {
        bottleFillLevel += (totalScore * 0.50).toInt();
        if (bottleFillLevel > 6000) bottleFillLevel = 6000; // الحد الأقصى
      }
     //t print(totalScore); // 22500

    });

    // حفظ النقاط والمستويات المحدثة
    await prefs.setDouble('grammarPoints', grammarPoints);
    await saveProgressDataToPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الضمائر والأفعال', style: TextStyle(fontFamily: 'Cartoon')),
        backgroundColor: Colors.blue.shade900, // لون أزرق داكن
      ),
      backgroundColor: Colors.blue.shade100, // لون الخلفية الأزرق الفاتح
      body: PageView(
        controller: _controller,
        children: [
          // الصفحة الأولى: شرح الضمائر
      SingleChildScrollView(
      child:Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.blue.shade700, size: 50),
                ).animate().scale(duration: Duration(milliseconds: 600)),
                SizedBox(height: 20),
                Text(
                  'الضمائر الشخصية',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
                ).animate().fadeIn(duration: Duration(milliseconds: 600)),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child:Text(
                    'الضمائر هي كلمات نستخدمها بدلاً من الأسماء لتجنب تكرار الأسماء في الجمل ولجعل الكلام أكثر سلاسة ووضوحًا.\n\n'
                        '🔹 I (أنا): نستخدمه عندما نتحدث عن أنفسنا.\n'
                        'مثال: "I am a student." - "أنا طالب."\n\n'
                        '🔹 You (أنت/أنتِ): نستخدمه عند مخاطبة شخص آخر بشكل مباشر.\n'
                        'مثال: "You are my friend." - "أنت صديقي."\n\n'
                        '🔹 He (هو): نستخدمه عند التحدث عن شخص ذكر غير متحدث.\n'
                        'مثال: "He is playing soccer." - "هو يلعب كرة القدم."\n\n'
                        '🔹 She (هي)*: نستخدمه عند التحدث عن شخص أنثى غير متحدثة.\n'
                        'مثال: "She is reading a book." - "هي تقرأ كتابًا."\n\n'
                        '🔹 It (هو/هي لغير العاقل): نستخدمه عند التحدث عن شيء أو حيوان غير عاقل.\n'
                        'مثال: "It is raining." - "إنها تمطر."\n\n'
                        '🔹 We (نحن): نستخدمه عند التحدث عن مجموعة تشمل المتحدث.\n'
                        'مثال: "We are going to the park." - "نحن ذاهبون إلى الحديقة."\n\n'
                        '🔹 They (هم/هن): نستخدمه عند التحدث عن مجموعة لا تشمل المتحدث.\n'
                        'مثال: "They are studying." - "هم يدرسون."\n\n'
                        'هذه الضمائر تساعدنا على جعل الكلام أكثر تنوعًا وتجنب تكرار الأسماء بشكل ممل، وتأتي بشكل دائم كبديل مباشر عن الاسم المراد الإشارة إليه.',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),

                ).animate().slide(duration: Duration(milliseconds: 500)),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  },
                  child: Text('التالي: تمارين الضمائر', style: TextStyle(color: Colors.white)),
                ),
             ],
            ),
      )),
          // الصفحة الثانية: تمارين الضمائر
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تمارين الضمائر',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
                ).animate().fadeIn(duration: Duration(milliseconds: 600)),
                Expanded(
                  child: ListView.builder(
                    itemCount: pronounQuestions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              pronounQuestions[index],
                              style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Cartoon'),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(pronounOptions[index].length, (i) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: _selectedPronounOptions[index] == i
                                        ? (i == pronounAnswers[index] ? Colors.green : Colors.red)
                                        : Colors.blue.shade900,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectedPronounOptions[index] = i;
                                      if (i == pronounAnswers[index]) {
                                        _feedbackPronouns[index] = 'إجابة صحيحة!';
                                      } else {
                                        _feedbackPronouns[index] = 'إجابة خاطئة، حاول مرة أخرى.';
                                      }
                                    });
                                  },
                                  child: Text(pronounOptions[index][i], style: TextStyle(fontSize: 18, fontFamily: 'Cartoon')),
                                );
                              }),
                            ),
                            Text(
                              _feedbackPronouns[index],
                              style: TextStyle(
                                fontSize: 18,
                                color: _feedbackPronouns[index].contains('صحيحة') ? Colors.green : Colors.red,
                                fontFamily: 'Cartoon',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  },
                  child: Text('التالي: شرح الأفعال', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          // الصفحة الثالثة: شرح الأفعال
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.directions_run, color: Colors.blue.shade700, size: 50),
                ).animate().scale(duration: Duration(milliseconds: 600)),
                SizedBox(height: 20),
                Text(
                  'الأفعال الأساسية',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
                ).animate().fadeIn(duration: Duration(milliseconds: 600)),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Text(
                    'الأفعال هي كلمات تُستخدم للتعبير عن حدوث الأفعال:\n'
                        'مثال: eat (يأكل)، go (يذهب)، play (يلعب)، read (يقرأ)، write (يكتب)',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ).animate().slide(duration: Duration(milliseconds: 500)),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  },
                  child: Text('التالي: تمارين الأفعال', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          // الصفحة الرابعة: تمارين الأفعال
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تمارين الأفعال',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
                ).animate().fadeIn(duration: Duration(milliseconds: 600)),
                Expanded(
                  child: ListView.builder(
                    itemCount: verbQuestions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              verbQuestions[index],
                              style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Cartoon'),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(verbOptions[index].length, (i) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: _selectedVerbOptions[index] == i
                                        ? (i == verbAnswers[index] ? Colors.green : Colors.red)
                                        : Colors.blue.shade900,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectedVerbOptions[index] = i;
                                      if (i == verbAnswers[index]) {
                                        _feedbackVerbs[index] = 'إجابة صحيحة!';
                                      } else {
                                        _feedbackVerbs[index] = 'إجابة خاطئة، حاول مرة أخرى.';
                                      }
                                    });
                                  },
                                  child: Text(verbOptions[index][i], style: TextStyle(fontSize: 18, fontFamily: 'Cartoon')),
                                );
                              }),
                            ),
                            Text(
                              _feedbackVerbs[index],
                              style: TextStyle(
                                fontSize: 18,
                                color: _feedbackVerbs[index].contains('صحيحة') ? Colors.green : Colors.red,
                                fontFamily: 'Cartoon',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  },
                  child: Text('التالي: عرض النتائج', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          // الصفحة الخامسة: عرض النتائج
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'النتائج',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
                ).animate().fadeIn(duration: Duration(milliseconds: 600)),
                SizedBox(height: 20),
                Text(
                  'نقاط الضمائر: $_pronounScore / ${pronounQuestions.length}',
                  style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Cartoon'),
                ),
                SizedBox(height: 10),
                Text(
                  'نقاط الأفعال: $_verbScore / ${verbQuestions.length}',
                  style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Cartoon'),
                ),
                SizedBox(height: 10),
                // Text(
                //   'نقاط القواعد: $grammarPoints',
                //   style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Cartoon'),
                // ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    // حفظ النقاط قبل الخروج
                    await saveStatisticsData();
                    await saveProgressDataToPreferences();
                    Navigator.pop(context);
                  },
                  child: Text('خروج', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],

        onPageChanged: (index) {
          if (index == 2) {
            // حساب نقاط تمارين الضمائر عند الانتقال إلى الصفحة الثالثة (شرح الأفعال)
            _pronounScore = 0;
            for (int i = 0; i < pronounQuestions.length; i++) {
              if (_selectedPronounOptions[i] == pronounAnswers[i]) {
                _pronounScore++;
              }
            }
          } else if (index == 4) {
            // حساب نقاط تمارين الأفعال عند الانتقال إلى الصفحة الخامسة (عرض النتائج)
            _verbScore = 0;
            for (int i = 0; i < verbQuestions.length; i++) {
              if (_selectedVerbOptions[i] == verbAnswers[i]) {
                _verbScore++;
              }
            }

            // تحديث نقاط القواعد بناءً على مجموع نقاط الضمائر والأفعال
            updateGrammarPointsBasedOnScores();

            setState(() {
              _isCompleted = true;
            });
          }
        },

      ),
    );
  }
}




/////////////////////////////////////

class PronounsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الضمائر الشخصية', style: TextStyle(fontFamily: 'Cartoon')),
        backgroundColor: Colors.blue.shade900, // لون أزرق داكن
      ),
      backgroundColor: Colors.blue.shade100, // لون الخلفية الأزرق الفاتح
      body: SingleChildScrollView( // إضافة ScrollView للتأكد من قابلية التمرير
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blue.shade700, size: 50),
              ).animate().scale(duration: 600.ms),
              SizedBox(height: 20),
              Text(
                'الضمائر الشخصية',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
              ).animate().fadeIn(duration: 600.ms),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الضمائر الشخصية هي كلمات نستخدمها بدلاً من الأسماء لتسهيل الحديث وتجنب التكرار.',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'إليك قائمة بالضمائر الشخصية باللغة الإنجليزية وترجمتها إلى العربية:\n'
                          '1. I (أنا)\n'
                          '2. You (أنت/أنتِ)\n'
                          '3. He (هو)\n'
                          '4. She (هي)\n'
                          '5. It (هو/هي لغير العاقل)\n'
                          '6. We (نحن)\n'
                          '7. They (هم/هن)',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'هذه الضمائر تستخدم لتحديد أو الإشارة إلى الأشخاص أو الأشياء التي نتحدث عنها. '
                          'نستخدم الضمائر بشكل أساسي كبديل للأسماء لتبسيط الجمل وتحسين وضوحها.',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ).animate().slide(duration: 500.ms),
              SizedBox(height: 20),
              Text(
                'أمثلة:\n',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              ).animate().fadeIn(duration: 600.ms),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _exampleCard(
                    'I am a student. (أنا طالب)',
                    'في هذه الجملة، "I" تعني "أنا"، وتستخدم للإشارة إلى المتحدث نفسه.',
                  ),
                  _exampleCard(
                    'You are a teacher. (أنت مدرس)',
                    '“You” تعني “أنت”، وتستخدم للإشارة إلى الشخص الذي نتحدث معه.',
                  ),
                  _exampleCard(
                    'He is my friend. (هو صديقي)',
                    '“He” تعني “هو”، وتستخدم للإشارة إلى شخص ذكر.',
                  ),
                  _exampleCard(
                    'She is very kind. (هي لطيفة جداً)',
                    '“She” تعني “هي”، وتستخدم للإشارة إلى شخص أنثى.',
                  ),
                  _exampleCard(
                    'It is raining. (إنه ممطر)',
                    '“It” تعني “هو/هي” لغير العاقل، وتستخدم للإشارة إلى الأحوال الجوية أو الأشياء غير العاقل.',
                  ),
                  _exampleCard(
                    'We are going to the park. (نحن ذاهبون إلى الحديقة)',
                    '“We” تعني “نحن”، وتستخدم للإشارة إلى مجموعة تشمل المتحدث.',
                  ),
                  _exampleCard(
                    'They are playing football. (هم يلعبون كرة القدم)',
                    '“They” تعني “هم/هن”، وتستخدم للإشارة إلى مجموعة من الأشخاص.',
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child:           ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearningPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF13194E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text('Next', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _exampleCard(String sentence, String explanation) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sentence,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              explanation,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

