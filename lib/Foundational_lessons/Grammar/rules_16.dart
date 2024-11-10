import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningPage16 extends StatefulWidget {
  @override
  _LearningPage16State createState() => _LearningPage16State();
}

class _LearningPage16State extends State<LearningPage16> {
  PageController _controller = PageController();
  int _relativePronounScore = 0;
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

  // تمارين ضمائر الوصل
  List<String> relativePronounQuestions = [
    'The man ___ is standing over there is my uncle.',
    'This is the book ___ I told you about.',
    'The dog ___ barked all night belongs to my neighbor.',
    'She is the woman ___ helped me yesterday.',
    'The movie ___ we watched was fantastic.',
    'That is the car ___ hit my bike.',
    'The teacher ___ teaches math is very kind.',
    'I have a friend ___ lives in London.',
    'This is the house ___ was built last year.',
    'I found the key ___ opens the door.'
  ];

  // خيارات ضمائر الوصل
  List<List<String>> relativePronounOptions = [
    ['who', 'which', 'that'],   // The man ___ is standing over there is my uncle.
    ['that', 'who', 'which'],   // This is the book ___ I told you about.
    ['who', 'that', 'which'],   // The dog ___ barked all night belongs to my neighbor.
    ['that', 'which', 'who'],   // She is the woman ___ helped me yesterday.
    ['which', 'who', 'that'],   // The movie ___ we watched was fantastic.
    ['who', 'which', 'that'],   // That is the car ___ hit my bike.
    ['that', 'who', 'which'],   // The teacher ___ teaches math is very kind.
    ['who', 'that', 'which'],   // I have a friend ___ lives in London.
    ['that', 'which', 'who'],   // This is the house ___ was built last year.
    ['which', 'that', 'who']    // I found the key ___ opens the door.
  ];

  // الإجابات الصحيحة
  List<int> relativePronounAnswers = [0, 0, 2, 2, 0, 2, 1, 0, 0, 1];

  // متغيرات لحفظ إجابات المستخدم ورسائل التغذية الراجعة
  List<int> _selectedRelativePronouns = List.filled(10, -1);
  List<String> _feedbackRelativePronouns = List.filled(10, '');

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
      int totalScore = _relativePronounScore;

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
        title: Text('ضمائر الوصل', style: TextStyle(fontFamily: 'Cartoon')),
        backgroundColor: Colors.blue.shade900, // لون أزرق داكن
      ),
      backgroundColor: Colors.blue.shade100, // لون الخلفية الأزرق الفاتح
      body: PageView(
        controller: _controller,
        children: [
          // الصفحة الأولى: شرح ضمائر الوصل مع أمثلة إضافية
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.link, color: Colors.blue.shade700, size: 50),
                  ).animate().scale(duration: 600.ms),
                  SizedBox(height: 20),
                  Text(
                    'ضمائر الوصل (Relative Pronouns)',
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
                      children: [
                        Text(
                          'ضمائر الوصل تُستخدم لربط الجمل وتوضيح العلاقات بين الجملتين. مثل: "who" (الذي/التي للإنسان)، "which" (الذي/التي لغير الإنسان)، "that" (الذي/التي) لتوصيل الجمل.',
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
                          '- The boy **who** won the race is my cousin. (الصبي الذي فاز بالسباق هو ابن عمي.)\n'
                              '- This is the cake **which** I baked yesterday. (هذه هي الكعكة التي خبزتها بالأمس.)\n'
                              '- The person **that** called you is waiting outside. (الشخص الذي اتصل بك ينتظر في الخارج.)\n'
                              '- The cat **which** was in the garden is now inside. (القطة التي كانت في الحديقة هي الآن بالداخل.)\n'
                              '- The teacher **who** teaches us English is very patient. (المعلم الذي يدرسنا الإنجليزية صبور جداً.)',
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
                    child: Text('التالي: تمارين ضمائر الوصل', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          // الصفحة الثانية: تمارين ضمائر الوصل
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تمارين ضمائر الوصل',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
                ).animate().fadeIn(duration: 600.ms),
                Expanded(
                  child: ListView.builder(
                    itemCount: relativePronounQuestions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              relativePronounQuestions[index],
                              style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Cartoon'),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(relativePronounOptions[index].length, (i) {
                                bool isSelected = _selectedRelativePronouns[index] == i;
                                bool isCorrect = relativePronounAnswers[index] == i;
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
                                      _selectedRelativePronouns[index] = i;

                                      if (i == relativePronounAnswers[index]) {
                                        _feedbackRelativePronouns[index] = 'إجابة صحيحة!';
                                        _relativePronounScore++;
                                      } else {
                                        _feedbackRelativePronouns[index] = 'إجابة خاطئة، حاول مرة أخرى.';
                                      }
                                    });
                                  },
                                  child: Text(
                                    relativePronounOptions[index][i],
                                    style: TextStyle(fontSize: 18, fontFamily: 'Cartoon'),
                                  ),
                                );
                              }),
                            ),
                            if (_feedbackRelativePronouns[index].isNotEmpty) // إظهار الملاحظات فقط إذا كانت متوفرة
                              Text(
                                _feedbackRelativePronouns[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: _feedbackRelativePronouns[index].contains('صحيحة') ? Colors.green : Colors.red,
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
                  'نقاط ضمائر الوصل: $_relativePronounScore / ${relativePronounQuestions.length}',
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
            // حساب نقاط التمرين عند الانتقال إلى صفحة النتائج
            _relativePronounScore = 0;
            for (int i = 0; i < relativePronounQuestions.length; i++) {
              if (_selectedRelativePronouns[i] == relativePronounAnswers[i]) {
                _relativePronounScore++;
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

  // بطاقة شرح ضمائر الوصل
  Widget _relativePronounExplanationCard(String title, String explanation, List<String> examples) {
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
