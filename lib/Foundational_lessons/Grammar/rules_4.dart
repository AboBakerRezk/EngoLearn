import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningPage4 extends StatefulWidget {
  @override
  _LearningPage4State createState() => _LearningPage4State();
}

class _LearningPage4State extends State<LearningPage4> {
  PageController _controller = PageController();
  int _beScore = 0;
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

  // تمارين الأزمنة للفعل "be"
  List<String> beQuestions = [
    'I ___ happy today.',                       // الإجابة الصحيحة: am
    'She ___ at the party yesterday.',           // الإجابة الصحيحة: was
    'They ___ playing football tomorrow.',       // الإجابة الصحيحة: will be
    'He ___ reading a book now.',                // الإجابة الصحيحة: is
    'We ___ writing the report last night.',     // الإجابة الصحيحة: were
    'You ___ studying for the exam now.',        // الإجابة الصحيحة: are
    'It ___ raining yesterday.',                  // الإجابة الصحيحة: was
    'They ___ at the meeting next week.',        // الإجابة الصحيحة: will be
    'I ___ at work yesterday.',                   // الإجابة الصحيحة: was
    'We ___ at the beach tomorrow.'              // الإجابة الصحيحة: will be
  ];

  // خيارات الأزمنة للفعل "be" (مع إجابة صحيحة واحدة وخيارين خاطئين)
  List<List<String>> beOptions = [
    ['am', 'is', 'book'],                       // I ___ happy today. (am)
    ['were', 'was', 'going'],                   // She ___ at the party yesterday. (was)
    ['is', 'will be', 'playing'],               // They ___ playing football tomorrow. (will be)
    ['reading', 'is', 'am'],                    // He ___ reading a book now. (is)
    ['were', 'was', 'pen'],                      // We ___ writing the report last night. (were)
    ['study', 'are', 'am'],                     // You ___ studying for the exam now. (are)
    ['was', 'rain', 'were'],                    // It ___ raining yesterday. (was)
    ['will be', 'is', 'meeting'],               // They ___ at the meeting next week. (will be)
    ['were', 'is', 'school'],                   // I ___ at work yesterday. (was)
    ['will be', 'drink', 'is']                  // We ___ at the beach tomorrow. (will be)
  ];

  // الإجابات الصحيحة (مؤشرات الخيارات الصحيحة في كل سؤال)
  List<int> beAnswers = [0, 1, 1, 1, 0, 1, 0, 0, 0, 0];

  // متغيرات لحفظ إجابات المستخدم ورسائل التغذية الراجعة
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
      int totalScore = _beScore;
      void increasePoints(String section, int points) {
        if (section == 'grammar') {
          totalScore += points;
        }
      }
      increasePoints('grammar', 0); // يمكنك تعديل هذا لتغيير نقاط إضافية إذا لزم الأمر

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
        title: Text('استخدام "be"', style: TextStyle(fontFamily: 'Cartoon')),
        backgroundColor: Colors.blue.shade900, // لون أزرق داكن
      ),
      backgroundColor: Colors.blue.shade100, // لون الخلفية الأزرق الفاتح
      body: PageView(
        controller: _controller,
        children: [
          // الصفحة الأولى: شرح استخدام "be"
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.help_outline, color: Colors.blue.shade700, size: 50),
                  ).animate().scale(duration: Duration(milliseconds: 600)),
                  SizedBox(height: 20),
                  Text(
                    'استخدام "be"',
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'فعل "be" هو فعل مساعد شائع ويأتي في أشكال مختلفة:',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        _beExplanationCard(
                            'المضارع (Present):',
                            'يستخدم "am", "is", و"are" في الزمن المضارع.',
                            [
                              'I am a student. (أنا طالب)',
                              'She is a doctor. (هي طبيبة)',
                              'They are friends. (هم أصدقاء)',
                              'He is happy. (هو سعيد)',
                              'We are ready. (نحن جاهزون)',
                              'You are welcome. (أنت مرحب بك)',
                              'It is raining. (إنه يمطر)',
                              'I am here. (أنا هنا)',
                              'They are playing. (هم يلعبون)',
                              'He is at work. (هو في العمل)'
                            ]
                        ),
                        SizedBox(height: 20),
                        _beExplanationCard(
                            'الماضي (Past):',
                            'يستخدم "was" و"were" في الزمن الماضي.',
                            [
                              'I was at home yesterday. (كنت في المنزل أمس)',
                              'She was tired last night. (كانت متعبة الليلة الماضية)',
                              'They were at the party. (كانوا في الحفلة)',
                              'He was happy yesterday. (كان سعيدًا أمس)',
                              'We were students last year. (كنا طلابًا في العام الماضي)',
                              'You were late. (كنت متأخراً)',
                              'It was cold last winter. (كان الجو بارداً الشتاء الماضي)',
                              'I was in London. (كنت في لندن)',
                              'They were singing. (كانوا يغنون)',
                              'He was at the meeting. (كان في الاجتماع)'
                            ]
                        ),
                        SizedBox(height: 20),
                        _beExplanationCard(
                            'المستقبل (Future):',
                            'يستخدم "will be" للتعبير عن المستقبل.',
                            [
                              'I will be there tomorrow. (سأكون هناك غدًا)',
                              'She will be a teacher next year. (ستكون معلمة العام القادم)',
                              'They will be happy. (سيكونون سعداء)',
                              'He will be here soon. (سيكون هنا قريباً)',
                              'We will be at the meeting. (سنكون في الاجتماع)',
                              'You will be fine. (ستكون بخير)',
                              'It will be sunny tomorrow. (سيكون مشمسًا غدًا)',
                              'I will be ready. (سأكون جاهزًا)',
                              'They will be dancing. (سيكونون يرقصون)',
                              'He will be late. (سيكون متأخراً)'
                            ]
                        ),
                      ],
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
                    child: Text('التالي: تمارين الفعل "be"', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          // الصفحة الثانية: تمارين الفعل "be"
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تمارين الفعل "be"',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
                ).animate().fadeIn(duration: Duration(milliseconds: 600)),
                Expanded(
                  child: ListView.builder(
                    itemCount: beQuestions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              beQuestions[index],
                              style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Cartoon'),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(beOptions[index].length, (i) {
                                bool isSelected = _selectedOptions[index] == i;
                                bool isCorrect = beAnswers[index] == i;
                                return ElevatedButton(
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

                                      if (i == beAnswers[index]) {
                                        _feedbackMessages[index] = 'إجابة صحيحة!';
                                      } else {
                                        _feedbackMessages[index] = 'إجابة خاطئة، حاول مرة أخرى.';
                                      }
                                    });
                                  },
                                  child: Text(
                                    beOptions[index][i],
                                    style: TextStyle(fontSize: 18, fontFamily: 'Cartoon'),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 5),
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
                ).animate().fadeIn(duration: Duration(milliseconds: 600)),
                SizedBox(height: 20),
                Text(
                  'نقاطك: $_beScore / ${beQuestions.length}',
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
            _beScore = 0;
            for (int i = 0; i < beQuestions.length; i++) {
              if (_selectedOptions[i] == beAnswers[i]) {
                _beScore++;
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

  // Widget لبطاقات شرح الفعل "be"
  Widget _beExplanationCard(String title, String explanation, List<String> examples) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 10),
            Text(explanation, style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            ...examples.map((example) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text('- $example', style: TextStyle(fontSize: 16, color: Colors.black54)),
            )),
          ],
        ),
      ),
    );
  }
}

