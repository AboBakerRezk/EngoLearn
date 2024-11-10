import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningPage9 extends StatefulWidget {
  @override
  _LearningPage9State createState() => _LearningPage9State();
}

class _LearningPage9State extends State<LearningPage9> {
  PageController _controller = PageController();
  int _pluralScore = 0;
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

  // تمارين الجمع والمفرد
  List<String> pluralQuestions = [
    'He has two ___.',                       // الإجابة الصحيحة: books
    'There are three ___ on the table.',     // الإجابة الصحيحة: boxes
    'She found several ___.',                // الإجابة الصحيحة: keys
    'They own many ___.',                    // الإجابة الصحيحة: cars
    'He bought some ___.',                   // الإجابة الصحيحة: watches
    'The park has a lot of ___.',            // الإجابة الصحيحة: trees
    'There are several ___.',                // الإجابة الصحيحة: dishes
    'She likes to read many ___.',           // الإجابة الصحيحة: stories
    'He has two ___.',                       // الإجابة الصحيحة: dogs
    'They have many ___.',                   // الإجابة الصحيحة: children
  ];

  // خيارات الجمع والمفرد (مع إجابة صحيحة واحدة وخيارين خاطئين)
  List<List<String>> pluralOptions = [
    ['book', 'books', 'books'],         // He has two ___.
    ['box', 'boxes', 'boxes'],         // There are three ___ on the table.
    ['key', 'keys', 'keys'],           // She found several ___.
    ['car', 'cars', 'cars'],           // They own many ___.
    ['watch', 'watches', 'watches'],   // He bought some ___.
    ['tree', 'trees', 'trees'],        // The park has a lot of ___.
    ['dish', 'dishes', 'dishes'],      // There are several ___.
    ['story', 'stories', 'stories'],    // She likes to read many ___.
    ['dog', 'dogs', 'dogs'],           // He has two ___.
    ['child', 'children', 'children'],  // They have many ___.
  ];

  // الإجابات الصحيحة (توزيع الإجابات)
  List<int> pluralAnswers = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]; // جميع الإجابات الصحيحة في الخيار الثاني

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

  // دالة لحساب وتحديث نقاط القواعد بناءً على مجموع النقاط
  void updateGrammarPointsBasedOnScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      int totalScore = _pluralScore;

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
        title: Text('الجمع والمفرد', style: TextStyle(fontFamily: 'Cartoon')),
        backgroundColor: Colors.blue.shade900, // لون أزرق داكن
      ),
      backgroundColor: Colors.blue.shade100, // لون الخلفية الأزرق الفاتح
      body: PageView(
        controller: _controller,
        children: [
          // الصفحة الأولى: شرح الجمع والمفرد
          SingleChildScrollView( // استخدام SingleChildScrollView لحل مشكلة Overflow
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.library_books, color: Colors.blue.shade700, size: 50),
                  ).animate().scale(duration: 600.ms),
                  SizedBox(height: 20),
                  Text(
                    'الجمع والمفرد (Singular and Plural)',
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
                          'معظم الأسماء تتحول إلى الجمع بإضافة "-s" أو "-es".',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        _pluralExplanationCard(
                            'أمثلة على تحويل المفرد إلى الجمع:',
                            'توضح هذه الأمثلة كيفية تحويل الأسماء من المفرد إلى الجمع.',
                            [
                              'book - books (كتاب - كتب)',
                              'box - boxes (صندوق - صناديق)',
                              'key - keys (مفتاح - مفاتيح)',
                              'car - cars (سيارة - سيارات)',
                              'watch - watches (ساعة - ساعات)',
                              'tree - trees (شجرة - أشجار)',
                              'dish - dishes (طبق - أطباق)',
                              'story - stories (قصة - قصص)',
                              'dog - dogs (كلب - كلاب)',
                              'child - children (طفل - أطفال)'
                            ]
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
                    child: Text('التالي: تمارين الجمع والمفرد', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          // الصفحة الثانية: تمارين الجمع والمفرد
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تمارين الجمع والمفرد',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Cartoon'),
                ).animate().fadeIn(duration: 600.ms),
                Expanded(
                  child: ListView.builder(
                    itemCount: pluralQuestions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              pluralQuestions[index],
                              style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Cartoon'),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(pluralOptions[index].length, (i) {
                                bool isSelected = _selectedOptions[index] == i;
                                bool isCorrect = pluralAnswers[index] == i;
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

                                      if (i == pluralAnswers[index]) {
                                        _feedbackMessages[index] = 'إجابة صحيحة!';
                                        _pluralScore++;
                                      } else {
                                        _feedbackMessages[index] = 'إجابة خاطئة، حاول مرة أخرى.';
                                      }
                                    });
                                  },
                                  child: Text(
                                    pluralOptions[index][i],
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
                ).animate().fadeIn(duration: 600.ms),
                SizedBox(height: 20),
                Text(
                  'نقاطك: $_pluralScore / ${pluralQuestions.length}',
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
            _pluralScore = 0;
            for (int i = 0; i < pluralQuestions.length; i++) {
              if (_selectedOptions[i] == pluralAnswers[i]) {
                _pluralScore++;
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

  Widget _pluralExplanationCard(String title, String explanation, List<String> examples) {
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
