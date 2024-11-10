import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningPage19 extends StatefulWidget {
  @override
  _LearningPage19State createState() => _LearningPage19State();
}

class _LearningPage19State extends State<LearningPage19> {
  PageController _controller = PageController();
  int _phrasalVerbScore = 0;
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

  // تمارين الأفعال المركبة
  List<String> phrasalVerbQuestions = [
    'She has to ___ her younger brother while her parents are away.',    // الإجابة الصحيحة: look after
    'I will never ___ on my dreams.',                                     // الإجابة الصحيحة: give up
    'He decided to ___ on sugar to improve his health.',                 // الإجابة الصحيحة: cut down
    'Please ___ the lights when you leave.',                              // الإجابة الصحيحة: turn off
    'We need to ___ a solution to this problem.',                        // الإجابة الصحيحة: figure out
    'He had to ___ the meeting due to an emergency.',                    // الإجابة الصحيحة: call off
    'Can you ___ the kids from school today?',                           // الإجابة الصحيحة: pick up
    'They ___ milk, so they went to buy more.',                          // الإجابة الصحيحة: ran out of
    'She is trying to ___ her fear of heights.',                         // الإجابة الصحيحة: get over
    'Let’s ___ the tent before it gets dark.'                            // الإجابة الصحيحة: set up
  ];

  // خيارات الأفعال المركبة
  List<List<String>> phrasalVerbOptions = [
    ['look over', 'look after', 'look into'],                           // She has to ___ her younger brother while her parents are away.
    ['give away', 'give up', 'give out'],                                // I will never ___ on my dreams.
    ['cut off', 'cut down', 'cut out'],                                  // He decided to ___ on sugar to improve his health.
    ['turn up', 'turn off', 'turn down'],                                // Please ___ the lights when you leave.
    ['figure in', 'figure out', 'figure up'],                            // We need to ___ a solution to this problem.
    ['call in', 'call off', 'call out'],                                 // He had to ___ the meeting due to an emergency.
    ['pick on', 'pick up', 'pick off'],                                  // Can you ___ the kids from school today?
    ['ran out of', 'run out on', 'run out with'],                        // They ___ milk, so they went to buy more.
    ['get over', 'get on', 'get by'],                                    // She is trying to ___ her fear of heights.
    ['set down', 'set up', 'set off']                                    // Let’s ___ the tent before it gets dark.
  ];

  // الإجابات الصحيحة
  List<int> phrasalVerbAnswers = [1, 1, 1, 1, 1, 1, 1, 0, 0, 1];

  // متغيرات لحفظ إجابات المستخدم ورسائل التغذية الراجعة
  List<int> _selectedPhrasalVerbs = List.filled(10, -1);
  List<String> _feedbackPhrasalVerbs = List.filled(10, '');

  @override
  void initState() {
    super.initState();
    _loadStatisticsData();
    loadSavedProgressData(); // تحميل البيانات المحفوظة عند بدء الصفحة
  }

  // تحميل بيانات النقاط المختلفة من SharedPreferences
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

  // دالة لحساب وتحديث نقاط القواعد بناءً على مجموع النقاط
  void updateGrammarPointsBasedOnScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      int totalScore = _phrasalVerbScore;

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

    // حفظ النقاط ومستويات التقدم المحدثة
    await prefs.setDouble('grammarPoints', grammarPoints);
    await saveProgressDataToPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الأفعال المركبة', style: TextStyle(fontFamily: 'Cartoon')),
        backgroundColor: Colors.blue.shade900, // لون أزرق داكن
      ),
      backgroundColor: Colors.blue.shade100, // لون الخلفية الأزرق الفاتح
      body: PageView(
        controller: _controller,
        children: [
          // الصفحة الأولى: شرح الأفعال المركبة مع أمثلة إضافية
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.lightbulb, color: Colors.blue.shade700, size: 50),
                  ).animate().scale(duration: 600.ms),
                  SizedBox(height: 20),
                  Text(
                    'الأفعال المركبة (Phrasal Verbs)',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
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
                      children: [
                        Text(
                          'الأفعال المركبة هي أفعال تتكون من فعل وكلمة إضافية (عادة ما تكون حرف جر) لتغيير معنى الفعل. على سبيل المثال: "look after" (يرعى) و"give up" (يستسلم). هذه الأفعال مهمة لفهم المحادثات اليومية.',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'أمثلة إضافية:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '- "Look after" (يرعى): She looks after her younger brother.\n'
                              '- "Give up" (يستسلم): Don’t give up on your dreams.\n'
                              '- "Cut down" (يقلل): He decided to cut down on sugar.\n'
                              '- "Turn off" (يطفئ): Please turn off the lights.\n'
                              '- "Figure out" (يكتشف): We need to figure out a solution.\n'
                              '- "Call off" (يلغي): They called off the meeting.\n'
                              '- "Pick up" (يلتقط/يأخذ): Can you pick up the kids?\n'
                              '- "Run out of" (ينفد): They ran out of milk.\n'
                              '- "Get over" (يتغلب): She is trying to get over her fear.\n'
                              '- "Set up" (يقيم/ينصب): Let’s set up the tent.',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
                    child: Text('التالي: تمارين الأفعال المركبة', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          // الصفحة الثانية: تمارين الأفعال المركبة
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تمارين الأفعال المركبة',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
                ).animate().fadeIn(duration: 600.ms),
                Expanded(
                  child: ListView.builder(
                    itemCount: phrasalVerbQuestions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              phrasalVerbQuestions[index],
                              style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Cartoon'),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(phrasalVerbOptions[index].length, (i) {
                                bool isSelected = _selectedPhrasalVerbs[index] == i;
                                bool isCorrect = phrasalVerbAnswers[index] == i;
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
                                      _selectedPhrasalVerbs[index] = i;
                                      if (i == phrasalVerbAnswers[index]) {
                                        _feedbackPhrasalVerbs[index] = 'إجابة صحيحة!';
                                        _phrasalVerbScore++;
                                      } else {
                                        _feedbackPhrasalVerbs[index] = 'إجابة خاطئة، حاول مرة أخرى.';
                                      }
                                    });
                                  },
                                  child: Text(phrasalVerbOptions[index][i], style: TextStyle(fontSize: 18, fontFamily: 'Cartoon')),
                                );
                              }),
                            ),
                            SizedBox(height: 5),
                            if (_feedbackPhrasalVerbs[index].isNotEmpty) // إظهار الملاحظات فقط إذا كانت متوفرة
                              Text(
                                _feedbackPhrasalVerbs[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: _feedbackPhrasalVerbs[index].contains('صحيحة') ? Colors.green : Colors.red,
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
                  'نقاطك: $_phrasalVerbScore / ${phrasalVerbQuestions.length}',
                  style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Cartoon'),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 600.ms),
                SizedBox(height: 40),
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
            // حساب نقاط التمرين عند الانتقال إلى صفحة النتائج
            _phrasalVerbScore = 0;
            for (int i = 0; i < phrasalVerbQuestions.length; i++) {
              if (_selectedPhrasalVerbs[i] == phrasalVerbAnswers[i]) {
                _phrasalVerbScore++;
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

  // بطاقة شرح الأفعال المركبة (اختيارية إذا كنت تستخدمها)
  Widget _phrasalVerbExplanationCard(String title, String explanation, List<String> examples) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 10),
            Text(explanation, style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            ...examples.map((example) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text('- $example',
                  style: TextStyle(fontSize: 16, color: Colors.black54)),
            )),
          ],
        ),
      ),
    );
  }
}
