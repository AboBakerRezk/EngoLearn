import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mushaf25/Foundational_lessons/Grammar/rules_1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LearningPage2 extends StatefulWidget {
  @override
  _LearningPage2State createState() => _LearningPage2State();
}

class _LearningPage2State extends State<LearningPage2> {
  PageController _controller = PageController();
  int _orderScore = 0;
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

  // تمارين ترتيب الكلمات
  List<String> wordOrderQuestions = [
    'eat I apple an',
    'goes she school to',
    'play we football',
    'reads he book the',
    'write they homework the',
    'study you English',
    'eat they restaurant the in',
    'plays she tennis',
    'go I work to',
    'drink we tea'
  ];

  // خيارات ترتيب الكلمات
  List<List<String>> wordOrderOptions = [
    ['I eat an apple', 'Eat I an apple', 'An apple I eat'],
    ['She goes to school', 'To school she goes', 'Goes she to school'],
    ['We play football', 'Play we football', 'Football we play'],
    ['He reads the book', 'Reads he the book', 'The book he reads'],
    ['They write the homework', 'Write they the homework', 'The homework they write'],
    ['You study English', 'Study you English', 'English you study'],
    ['They eat in the restaurant', 'In the restaurant they eat', 'Eat they in the restaurant'],
    ['She plays tennis', 'Plays she tennis', 'Tennis she plays'],
    ['I go to work', 'Go I to work', 'To work I go'],
    ['We drink tea', 'Drink we tea', 'Tea we drink'],
  ];

  // الإجابات الصحيحة
  List<int> wordOrderAnswers = [0, 0, 0, 0, 0, 0, 1, 0, 0, 0];

  // متغيرات لحفظ إجابات المستخدم
  List<int> _selectedOptions = List.filled(10, -1);
  List<String> _feedbackMessages = List.filled(10, '');

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

  // دالة لزيادة نقاط القواعد بناءً على مجموع النقاط
  void updateGrammarPointsBasedOnScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      int totalScore = _orderScore;
      void increasePoints(String section, int points) {
        if (section == 'grammar') {
          totalScore += points;
        }
      }
      increasePoints('grammar', 0); // مثال على زيادة 500 نقطة في قسم القواعد

      // زيادة نقاط القواعد بمقدار مجموع النقاط
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
    });

    // حفظ النقاط والمستويات المحدثة
    await prefs.setDouble('grammarPoints', grammarPoints);
    await saveProgressDataToPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ترتيب الكلمات', style: TextStyle(fontFamily: 'Cartoon')),
        backgroundColor: Colors.blue.shade900, // لون أزرق داكن
      ),
      backgroundColor: Colors.blue.shade100, // لون الخلفية الأزرق الفاتح
      body: PageView(
        controller: _controller,
        children: [
          // الصفحة الأولى: شرح ترتيب الكلمات
      SingleChildScrollView(
      child:Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.sort_by_alpha, color: Colors.blue.shade700, size: 50),
                ).animate().scale(duration: 600.ms),
                SizedBox(height: 20),
                Text(
                  'ترتيب الكلمات في الجملة',
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
                  child: Text(
                    'في اللغة الإنجليزية، الترتيب الشائع للجملة هو:\n'
                        'الفاعل + الفعل + المفعول به\n\n'
                        '🔹 الفاعل (Subject): هو الشخص أو الشيء الذي يقوم بالفعل. مثلاً:\n'
                        '   - في الجملة "I eat an apple"، "I" هو الفاعل لأنه الشخص الذي يقوم بفعل الأكل.\n'
                        '🔹 الفعل (Verb): هو الحدث أو الحركة التي يقوم بها الفاعل. الفعل يوضح ما الذي يحدث في الجملة.\n'
                        '   - في المثال "I eat an apple"، "eat" هو الفعل، حيث يصف النشاط الذي يقوم به الفاعل.\n'
                        '🔹 المفعول به (Object): هو الشيء أو الشخص الذي يتأثر بالفعل. يساعد في إكمال معنى الجملة.\n'
                        '   - في الجملة "I eat an apple"، "an apple" هو المفعول به، لأنه هو الشيء الذي يتأثر بفعل الأكل.\n\n'
                        'مثال بسيط:\n'
                        'I eat an apple (أنا آكل تفاحة)\n\n'
                        'أمثلة إضافية:\n'
                        '1. She reads a book - هي تقرأ كتابًا.\n'
                        '   - هنا "She" هو الفاعل، "reads" هو الفعل، و"book" هو المفعول به.\n'
                        '2. They play football - هم يلعبون كرة القدم.\n'
                        '   - "They" هو الفاعل، "play" هو الفعل، و"football" هو المفعول به.\n'
                        '3. We drink water - نحن نشرب الماء.\n'
                        '   - "We" هو الفاعل، "drink" هو الفعل، و"water" هو المفعول به.\n'
                        '4. He writes a letter - هو يكتب رسالة.\n'
                        '   - "He" هو الفاعل، "writes" هو الفعل، و"letter" هو المفعول به.\n'
                        '5. You watch TV - أنت تشاهد التلفاز.\n'
                        '   - "You" هو الفاعل، "watch" هو الفعل، و"TV" هو المفعول به.\n\n'
                        'يُعتبر هذا الترتيب من القواعد الأساسية التي تجعل الجمل في اللغة الإنجليزية واضحة وسهلة الفهم. '
                        'من المهم أن نفهم كيفية استخدام هذا الترتيب لإنشاء جمل صحيحة ومفهومة.',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),


                ).animate().slide(duration: 500.ms),
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
                  child: Text('التالي: تمارين ترتيب الكلمات', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
      )),
          // الصفحة الثانية: تمارين ترتيب الكلمات
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تمارين ترتيب الكلمات',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
                ).animate().fadeIn(duration: 600.ms),
                Expanded(
                  child: ListView.builder(
                    itemCount: wordOrderQuestions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              wordOrderQuestions[index],
                              style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Cartoon'),
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: List.generate(wordOrderOptions[index].length, (i) {
                                bool isSelected = _selectedOptions[index] == i;
                                bool isCorrect = wordOrderAnswers[index] == i;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: isSelected
                                          ? (isCorrect ? Colors.green : Colors.red)
                                          : Colors.blue.shade900,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _selectedOptions[index] = i;

                                        if (i == wordOrderAnswers[index]) {
                                          _feedbackMessages[index] = 'إجابة صحيحة!';
                                        } else {
                                          _feedbackMessages[index] = 'إجابة خاطئة، حاول مرة أخرى.';
                                        }
                                      });
                                    },
                                    child: Text(wordOrderOptions[index][i], style: TextStyle(fontSize: 18, fontFamily: 'Cartoon')),
                                  ),
                                );
                              }),
                            ),
                            Text(
                              _feedbackMessages[index],
                              style: TextStyle(
                                fontSize: 18,
                                color: _feedbackMessages[index].contains('صحيحة') ? Colors.green : Colors.red,
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
          // الصفحة الثالثة: عرض النتائج
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'النتائج',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
                ).animate().fadeIn(duration: 600.ms),
                SizedBox(height: 20),
                Text(
                  'نقاطك: $_orderScore / ${wordOrderQuestions.length}',
                  style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Cartoon'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await saveStatisticsData();
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
            // حساب نقاط التمرين عند الانتقال إلى الصفحة الثالثة
            _orderScore = 0;
            for (int i = 0; i < wordOrderQuestions.length; i++) {
              if (_selectedOptions[i] == wordOrderAnswers[i]) {
                _orderScore++;
              }
            }
            // تحديث نقاط القواعد بناءً على مجموع النقاط
            setState(() {
              _isCompleted = true;
            });
            updateGrammarPointsBasedOnScores();
          }
        },
      ),
    );
  }
}


/////////////////////////////////////

class WordOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ترتيب الكلمات في الجملة', style: TextStyle(fontFamily: 'Cartoon')),
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
                child: Icon(Icons.sort_by_alpha, color: Colors.blue.shade700, size: 50),
              ).animate().scale(duration: 600.ms),
              SizedBox(height: 20),
              Text(
                'ترتيب الكلمات في الجملة',
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
                      'في اللغة الإنجليزية، الترتيب الشائع للكلمات في الجملة هو:\n',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Text(
                      'الفاعل (Subject) + الفعل (Verb) + المفعول به (Object)',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'هذا الترتيب يساعد على فهم المعنى المقصود من الجملة ويجعلها صحيحة نحويًا.',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ).animate().slide(duration: 500.ms),
              SizedBox(height: 20),
              Text(
                'أمثلة:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              ).animate().fadeIn(duration: 600.ms),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _exampleCard(
                    'I eat an apple.',
                    'الفاعل: I\nالفعل: eat\nالمفعول به: an apple',
                  ),
                  _exampleCard(
                    'She reads a book.',
                    'الفاعل: She\nالفعل: reads\nالمفعول به: a book',
                  ),
                  _exampleCard(
                    'They play football.',
                    'الفاعل: They\nالفعل: play\nالمفعول به: football',
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
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
                  child: Text('التالي', style: TextStyle(fontSize: 20, color: Colors.white)),
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
            Text(sentence, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 10),
            Text(explanation, style: TextStyle(fontSize: 16, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
