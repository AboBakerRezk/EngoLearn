import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningPage17 extends StatefulWidget {
  @override
  _LearningPage17State createState() => _LearningPage17State();
}

class _LearningPage17State extends State<LearningPage17> {
  PageController _controller = PageController();
  int _nounScore = 0;
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

  // تمارين الأسماء المعدودة وغير المعدودة
  List<String> nounQuestions = [
    'An ___ is on the table.',
    'There is some ___ in the bottle.',
    'We bought three ___ yesterday.',
    'Can you give me a little ___?',
    'He ate two ___ for lunch.',
    'I need a bit of ___ for the cake.',
    'She has many ___ in her class.',
    'Do you want a piece of ___?',
    'We saw a lot of ___ in the store.',
    'I have two ___ at home.'
  ];

  // خيارات الأسماء المعدودة وغير المعدودة
  List<List<String>> nounOptions = [
    ['countable', 'uncountable'],         // An ___ is on the table.
    ['uncountable', 'countable'],         // There is some ___ in the bottle.
    ['countable', 'uncountable'],         // We bought three ___ yesterday.
    ['uncountable', 'countable'],         // Can you give me a little ___?
    ['countable', 'uncountable'],         // He ate two ___ for lunch.
    ['uncountable', 'countable'],         // I need a bit of ___ for the cake.
    ['countable', 'uncountable'],         // She has many ___ in her class.
    ['uncountable', 'countable'],         // Do you want a piece of ___?
    ['uncountable', 'countable'],         // We saw a lot of ___ in the store.
    ['countable', 'uncountable']          // I have two ___ at home.
  ];

  // الإجابات الصحيحة
  List<int> nounAnswers = [0, 0, 0, 0, 0, 0, 0, 1, 0, 0];

  // متغيرات لحفظ إجابات المستخدم ورسائل التغذية الراجعة
  List<int> _selectedNounTypes = List.filled(10, -1);
  List<String> _feedbackNouns = List.filled(10, '');

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
      int totalScore = _nounScore;

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
        title: Text('الأسماء المعدودة وغير المعدودة', style: TextStyle(fontFamily: 'Cartoon')),
        backgroundColor: Colors.blue.shade900, // لون أزرق داكن
      ),
      backgroundColor: Colors.blue.shade100, // لون الخلفية الأزرق الفاتح
      body: PageView(
        controller: _controller,
        children: [
          // الصفحة الأولى: شرح الأسماء المعدودة وغير المعدودة مع أمثلة إضافية
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.cake, color: Colors.blue.shade700, size: 50),
                  ).animate().scale(duration: 600.ms),
                  SizedBox(height: 20),
                  Text(
                    'الأسماء المعدودة وغير المعدودة (Countable and Uncountable Nouns)',
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
                          'الأسماء المعدودة هي الأسماء التي يمكن عدها مثل: "apple" (تفاحة). أما الأسماء غير المعدودة فهي التي لا يمكن عدها مثل: "water" (ماء).',
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
                          '- "book" (كتاب) هو اسم معدود، يمكن أن نقول: "one book, two books".\n'
                              '- "water" (ماء) هو اسم غير معدود، لا يمكن أن نقول: "one water, two waters".\n'
                              '- "friend" (صديق) هو اسم معدود، يمكن أن نقول: "one friend, many friends".\n'
                              '- "milk" (حليب) هو اسم غير معدود، لا يمكن أن نقول: "one milk, two milks".\n'
                              '- "furniture" (أثاث) هو اسم غير معدود، لا يمكن أن نقول: "one furniture, two furnitures".',
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
                    child: Text('التالي: تمارين الأسماء المعدودة وغير المعدودة', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          // الصفحة الثانية: تمارين الأسماء المعدودة وغير المعدودة
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تمارين الأسماء المعدودة وغير المعدودة',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
                ).animate().fadeIn(duration: 600.ms),
                Expanded(
                  child: ListView.builder(
                    itemCount: nounQuestions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              nounQuestions[index],
                              style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Cartoon'),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(nounOptions[index].length, (i) {
                                bool isSelected = _selectedNounTypes[index] == i;
                                bool isCorrect = nounAnswers[index] == i;
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
                                      _selectedNounTypes[index] = i;
                                      if (i == nounAnswers[index]) {
                                        _feedbackNouns[index] = 'إجابة صحيحة!';
                                        _nounScore++;
                                      } else {
                                        _feedbackNouns[index] = 'إجابة خاطئة، حاول مرة أخرى.';
                                      }
                                    });
                                  },
                                  child: Text(nounOptions[index][i], style: TextStyle(fontSize: 18, fontFamily: 'Cartoon')),
                                );
                              }),
                            ),
                            SizedBox(height: 5),
                            if (_feedbackNouns[index].isNotEmpty) // إظهار الملاحظات فقط إذا كانت متوفرة
                              Text(
                                _feedbackNouns[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: _feedbackNouns[index].contains('صحيحة') ? Colors.green : Colors.red,
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
                  'نقاطك: $_nounScore / ${nounQuestions.length}',
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
            _nounScore = 0;
            for (int i = 0; i < nounQuestions.length; i++) {
              if (_selectedNounTypes[i] == nounAnswers[i]) {
                _nounScore++;
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

  // بطاقة شرح الأسماء المعدودة وغير المعدودة (اختيارية إذا كنت تستخدمها)
  Widget _nounExplanationCard(String title, String explanation, List<String> examples) {
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
