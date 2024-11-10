import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningPage5 extends StatefulWidget {
  @override
  _LearningPage5State createState() => _LearningPage5State();
}

class _LearningPage5State extends State<LearningPage5> {
  PageController _controller = PageController();
  int _negationScore = 0;
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

  // تمارين النفي
  List<String> negationQuestions = [
    'I ___ tea.',                            // الإجابة الصحيحة: do not
    'She ___ to school yesterday.',          // الإجابة الصحيحة: did not
    'They ___ football tomorrow.',            // الإجابة الصحيحة: will not
    'He ___ the book now.',                  // الإجابة الصحيحة: is not
    'We ___ the report last night.',         // الإجابة الصحيحة: did not
    'You ___ for the exam.',                 // الإجابة الصحيحة: are not
    'It ___ yesterday.',                      // الإجابة الصحيحة: was not
    'They ___ at the meeting next week.',    // الإجابة الصحيحة: will not be
    'I ___ at work yesterday.',               // الإجابة الصحيحة: was not
    'We ___ at the beach tomorrow.'          // الإجابة الصحيحة: will not be
  ];

  // خيارات النفي (مع إجابة صحيحة واحدة وخيارين خاطئين)
  List<List<String>> negationOptions = [
    ['do not', 'will not', 'wants'],
    ['went', 'is', 'did not'],
    ['will not', 'are', 'wants'],
    ['is not', 'am', 'sees'],
    ['did not', 'were', 'saw'],
    ['are not', 'is', 'doing'],
    ['was not', 'is', 'go'],
    ['will not be', 'is', 'are'],
    ['was not', 'am', 'saw'],
    ['will not be', 'is', 'doing']
  ];

  // الإجابات الصحيحة (مؤشرات الخيارات الصحيحة في كل سؤال)
  List<int> negationAnswers = [0, 2, 0, 0, 1, 2, 0, 0, 1, 0];

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
  // Save Progress Levels to SharedPreferences
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('progressReading', readingProgressLevel);
    await prefs.setInt('progressListening', listeningProgressLevel);
    await prefs.setInt('progressWriting', writingProgressLevel);
    await prefs.setInt('progressGrammar', grammarProgressLevel);
    await prefs.setInt('bottleLevel', bottleFillLevel);
  }
  // دالة لزيادة نقاط القواعد بناءً على مجموع النقاط
  void updateGrammarPointsBasedOnScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      int totalScore = _negationScore;

      grammarPoints += totalScore;

      // تحديث مستويات التقدم بناءً على النقاط الجديدة
      if (grammarProgressLevel < 500) {
        grammarProgressLevel += (totalScore * 0.50).toInt();
        if (grammarProgressLevel > 500) grammarProgressLevel = 500;
      }
      if (bottleFillLevel < 6000) {
        bottleFillLevel += (totalScore * 0.50).toInt();
        if (bottleFillLevel > 6000) bottleFillLevel = 6000;
      }
    });

    await prefs.setDouble('grammarPoints', grammarPoints);
    await saveProgressDataToPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' النفي', style: TextStyle(fontFamily: 'Cartoon')),
        backgroundColor: Colors.blue.shade900,
      ),
      backgroundColor: Colors.blue.shade100,
      body: PageView(
        controller: _controller,
        children: [
          // الصفحة الأولى: شرح النفي
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.not_interested, color: Colors.blue.shade700, size: 50),
                  ).animate().scale(duration: Duration(milliseconds: 600)),
                  SizedBox(height: 20),
                  Text(
                    'النفي (Negation)',
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
                          'لإضافة النفي في الجمل الإنجليزية، نستخدم "not" بعد الفعل المساعد.',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        _negationExplanationCard(
                            'نفي المضارع (Present Simple):',
                            'يتم استخدام "do not" أو "does not" مع الأفعال في المضارع البسيط.',
                            [
                              'I do not (don’t) like tea. (أنا لا أحب الشاي)',
                              'She does not (doesn’t) play football. (هي لا تلعب كرة القدم)',
                              'They do not (don’t) eat meat. (هم لا يأكلون اللحم)',
                              'We do not (don’t) have any money. (ليس لدينا أي مال)',
                              'He does not (doesn’t) work on Sundays. (هو لا يعمل أيام الأحد)'
                            ]
                        ),
                        SizedBox(height: 20),
                        _negationExplanationCard(
                            'نفي الماضي (Past Simple):',
                            'يتم استخدام "did not" مع الأفعال في الماضي البسيط.',
                            [
                              'I did not (didn’t) go to the party. (لم أذهب إلى الحفلة)',
                              'She did not (didn’t) finish her homework. (هي لم تنهِ واجبها المنزلي)',
                              'They did not (didn’t) see the movie. (هم لم يشاهدوا الفيلم)',
                              'We did not (didn’t) eat breakfast. (نحن لم نتناول الفطور)',
                              'He did not (didn’t) call me. (هو لم يتصل بي)'
                            ]
                        ),
                        SizedBox(height: 20),
                        _negationExplanationCard(
                            'نفي المستقبل (Future Simple):',
                            'يتم استخدام "will not" أو "won’t" مع الأفعال في المستقبل البسيط.',
                            [
                              'I will not (won’t) be there tomorrow. (لن أكون هناك غدًا)',
                              'She will not (won’t) come to the meeting. (هي لن تأتي إلى الاجتماع)',
                              'They will not (won’t) play football next week. (هم لن يلعبوا كرة القدم الأسبوع القادم)',
                              'We will not (won’t) travel this year. (نحن لن نسافر هذا العام)',
                              'He will not (won’t) buy a new car. (هو لن يشتري سيارة جديدة)'
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
                    child: Text('التالي: تمارين النفي', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          // الصفحة الثانية: تمارين النفي
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تمارين النفي',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
                ).animate().fadeIn(duration: Duration(milliseconds: 600)),
                Expanded(
                  child: ListView.builder(
                    itemCount: negationQuestions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              negationQuestions[index],
                              style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Cartoon'),
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: List.generate(negationOptions[index].length, (i) {
                                bool isSelected = _selectedOptions[index] == i;
                                bool isCorrect = negationAnswers[index] == i;
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

                                        if (i == negationAnswers[index]) {
                                          _feedbackMessages[index] = 'إجابة صحيحة!';
                                        } else {
                                          _feedbackMessages[index] = 'إجابة خاطئة، حاول مرة أخرى.';
                                        }
                                      });
                                    },
                                    child: Text(
                                      negationOptions[index][i],
                                      style: TextStyle(fontSize: 18, fontFamily: 'Cartoon'),
                                    ),
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
                  'نقاطك: $_negationScore / ${negationQuestions.length}',
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
            _negationScore = 0;
            for (int i = 0; i < negationQuestions.length; i++) {
              if (_selectedOptions[i] == negationAnswers[i]) {
                _negationScore++;
              }
            }
            setState(() {
              _isCompleted = true;
            });
            updateGrammarPointsBasedOnScores();
          }
        },
      ),
    );
  }

  Widget _negationExplanationCard(String title, String explanation, List<String> examples) {
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
