import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningPage15 extends StatefulWidget {
  @override
  _LearningPage15State createState() => _LearningPage15State();
}

class _LearningPage15State extends State<LearningPage15> {
  PageController _controller = PageController();
  int _conditionalScore = 0;
  bool _isCompleted = false;

  // User Points
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

  // Progress Levels
  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int bottleFillLevel = 0;

  // Conditional Sentences Exercises
  List<String> conditionalQuestions = [
    'If I ___ tired, I will go to bed early.',              // الإجابة الصحيحة: am
    'If it ___, we will cancel the picnic.',                // الإجابة الصحيحة: rains
    'She will call you if she ___ time.',                   // الإجابة الصحيحة: has
    'If they ___ hard, they will pass the exam.',           // الإجابة الصحيحة: study
    'We will miss the train if we ___ .',                   // الإجابة الصحيحة: do not hurry
    'If you ___ too much, you will feel sick.',             // الإجابة الصحيحة: eat
    'If he ___ late, he will miss the meeting.',            // الإجابة الصحيحة: comes
    'She will help you if you ___ her.',                     // الإجابة الصحيحة: ask
    'If the weather ___ nice, we will go for a walk.',      // الإجابة الصحيحة: is
    'If I ___ your book, I will let you know.'              // الإجابة الصحيحة: find
  ];

  // خيارات الجمل الشرطية
  List<List<String>> conditionalOptions = [
    ['am', 'is', 'are'],                                   // If I ___ tired, I will go to bed early.
    ['rain', 'rains', 'rained'],                           // If it ___, we will cancel the picnic.
    ['has', 'have', 'had'],                                // She will call you if she ___ time.
    ['studies', 'study', 'studied'],                       // If they ___ hard, they will pass the exam.
    ['not hurry', 'did not hurry', 'do not hurry'],       // We will miss the train if we ___.
    ['eat', 'eats', 'ate'],                                // If you ___ too much, you will feel sick.
    ['come', 'comes', 'came'],                             // If he ___ late, he will miss the meeting.
    ['ask', 'asks', 'asked'],                              // She will help you if you ___ her.
    ['is', 'are', 'was'],                                  // If the weather ___ nice, we will go for a walk.
    ['found', 'find', 'finds']                             // If I ___ your book, I will let you know.
  ];

  // الإجابات الصحيحة
  List<int> conditionalAnswers = [0, 1, 1, 0, 2, 0, 1, 0, 0, 1];

  // متغيرات لحفظ إجابات المستخدم ورسائل التغذية الراجعة
  List<int> _selectedOptions = List.filled(10, -1);
  List<String> _feedbackMessages = List.filled(10, '');

  @override
  void initState() {
    super.initState();
    _loadStatisticsData();
    loadSavedProgressData(); // Load saved data on initialization
  }

  // Load user points from SharedPreferences
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

  // Load progress levels from SharedPreferences
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

  // Save progress levels to SharedPreferences
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('progressReading', readingProgressLevel);
    await prefs.setInt('progressListening', listeningProgressLevel);
    await prefs.setInt('progressWriting', writingProgressLevel);
    await prefs.setInt('progressGrammar', grammarProgressLevel);
    await prefs.setInt('bottleLevel', bottleFillLevel);
  }

  // Save user points to SharedPreferences
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

  // Update grammar points based on the total score
  void updateGrammarPointsBasedOnScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      int totalScore = _conditionalScore;

      // Increase grammar points by the total score
      grammarPoints += totalScore;

      // Update progress levels based on new points
      if (grammarProgressLevel < 500) {
        grammarProgressLevel += (totalScore * 0.50).toInt();
        if (grammarProgressLevel > 500) grammarProgressLevel = 500; // Maximum cap
      }
      if (bottleFillLevel < 6000) {
        bottleFillLevel += (totalScore * 0.50).toInt();
        if (bottleFillLevel > 6000) bottleFillLevel = 6000; // Maximum cap
      }
    });

    // Save updated points and progress levels
    await prefs.setDouble('grammarPoints', grammarPoints);
    await saveProgressDataToPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الجمل الشرطية البسيطة', style: TextStyle(fontFamily: 'Cartoon')),
        backgroundColor: Colors.blue.shade900, // Dark blue color
      ),
      backgroundColor: Colors.blue.shade100, // Light blue background
      body: PageView(
        controller: _controller,
        children: [
          // Page 1: Explanation with Additional Examples
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.question_mark, color: Colors.blue.shade700, size: 50),
                  ).animate().scale(duration: 600.ms),
                  SizedBox(height: 20),
                  Text(
                    'الجمل الشرطية البسيطة (Simple Conditionals)',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Cartoon',
                    ),
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
                          'نستخدم "if" للتحدث عن الاحتمالات أو الشروط. مثل: "If it rains, I will stay home" (إذا أمطرت، سأبقى في المنزل). الجملة الشرطية تحتوي على شرط ونتيجة مترتبة عليه.',
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
                          '- If I find your phone, I will call you. (إذا وجدت هاتفك، سأقوم بالاتصال بك.)\n'
                              '- If you work hard, you will succeed. (إذا عملت بجد، ستنجح.)\n'
                              '- If they invite us, we will go. (إذا دعونا، سنذهب.)\n'
                              '- If she doesn’t eat, she will be hungry. (إذا لم تأكل، ستكون جائعة.)\n'
                              '- If the store is closed, we will come back later. (إذا كان المتجر مغلقاً، سنعود لاحقاً.)',
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
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Text(
                      'التالي: تمارين الجمل الشرطية',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Page 2: Conditional Sentences Exercises
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تمارين الجمل الشرطية البسيطة',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Cartoon',
                  ),
                ).animate().fadeIn(duration: 600.ms),
                Expanded(
                  child: ListView.builder(
                    itemCount: conditionalQuestions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              conditionalQuestions[index],
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontFamily: 'Cartoon',
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(conditionalOptions[index].length, (i) {
                                bool isSelected = _selectedOptions[index] == i;
                                bool isCorrect = conditionalAnswers[index] == i;
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

                                      if (i == conditionalAnswers[index]) {
                                        _feedbackMessages[index] = 'إجابة صحيحة!';
                                        _conditionalScore++;
                                      } else {
                                        _feedbackMessages[index] = 'إجابة خاطئة، حاول مرة أخرى.';
                                      }
                                    });
                                  },
                                  child: Text(
                                    conditionalOptions[index][i],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Cartoon',
                                    ),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 5),
                            Text(
                              _selectedOptions[index] != -1 ? _feedbackMessages[index] : '',
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
                    _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  child: Text(
                    'التالي: عرض النتائج',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Page 3: Results Display
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'النتائج',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Cartoon',
                  ),
                ).animate().fadeIn(duration: 600.ms),
                SizedBox(height: 20),
                Text(
                  'نقاطك:$_conditionalScore / ${conditionalQuestions.length} .',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontFamily: 'Cartoon',
                  ),
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
                  child: Text(
                    'إنهاء',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
        onPageChanged: (index) {
          if (index == 2) {
            // Calculate score when navigating to the results page
            _conditionalScore = 0;
            for (int i = 0; i < conditionalQuestions.length; i++) {
              if (_selectedOptions[i] == conditionalAnswers[i]) {
                _conditionalScore++;
              }
            }
            // Update grammar points based on total score
            setState(() {
              _isCompleted = true;
            });
            updateGrammarPointsBasedOnScores();
          }
        },
      ),
    );
  }

  // Explanation Card Widget
  Widget _conditionalExplanationCard(String title, String explanation, List<String> examples) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            SizedBox(height: 10),
            Text(
              explanation,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 10),
            ...examples.map((example) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '- $example',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
