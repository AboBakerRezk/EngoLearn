import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningPage3 extends StatefulWidget {
  @override
  _LearningPage3State createState() => _LearningPage3State();
}

class _LearningPage3State extends State<LearningPage3> {
  PageController _controller = PageController();
  int _tenseScore = 0;
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

  // Tense Exercises
  List<String> tenseQuestions = [
    'I ___ an apple every day.',        // Correct Answer: eat
    'She ___ to school yesterday.',      // Correct Answer: went
    'We ___ football tomorrow.',         // Correct Answer: will play
    'He ___ a book last night.',         // Correct Answer: read
    'They ___ the homework next week.',   // Correct Answer: will write
    'You ___ English every morning.',     // Correct Answer: study
    'They ___ in the restaurant yesterday.', // Correct Answer: ate
    'She ___ tennis next Saturday.',      // Correct Answer: will play
    'I ___ to work yesterday.',           // Correct Answer: went
    'We ___ tea tomorrow.'                // Correct Answer: will drink
  ];

  // Tense Options (Correct Option + Two Incorrect Options)
  List<List<String>> tenseOptions = [
    ['eat', 'drank', 'will eat'],        // Correct: eat
    ['goes', 'went', 'stay'],            // Correct: went
    ['will play', 'play', 'playing'],    // Correct: will play
    ['reads', 'read', 'wrote'],          // Correct: read
    ['will write', 'write', 'did write'], // Correct: will write
    ['study', 'studied', 'speak'],       // Correct: study
    ['eat', 'ate', 'cooked'],            // Correct: ate
    ['plays', 'will play', 'danced'],    // Correct: will play
    ['go', 'went', 'come'],              // Correct: went
    ['will drink', 'drink', 'sipped']    // Correct: will drink
  ];

  // Correct Answers Indices
  List<int> tenseAnswers = [0, 1, 0, 1, 0, 0, 1, 0, 1, 0];

  // User Selections and Feedback
  List<int> _selectedOptions = List.filled(10, -1);
  List<String> _feedbackMessages = List.filled(10, '');

  @override
  void initState() {
    super.initState();
    _loadStatisticsData();
    loadSavedProgressData(); // Load saved progress when the page starts
  }

  // Load Points Data from SharedPreferences
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

  // Load Progress Levels from SharedPreferences
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

  // Save Progress Levels to SharedPreferences
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('progressReading', readingProgressLevel);
    await prefs.setInt('progressListening', listeningProgressLevel);
    await prefs.setInt('progressWriting', writingProgressLevel);
    await prefs.setInt('progressGrammar', grammarProgressLevel);
    await prefs.setInt('bottleLevel', bottleFillLevel);
  }

  // Save Points Data to SharedPreferences
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

  // Update Grammar Points Based on Scores
  void updateGrammarPointsBasedOnScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      int totalScore = _tenseScore;
      void increasePoints(String section, int points) {
        if (section == 'grammar') {
          totalScore += points;
        }
      }
      increasePoints('grammar', 0); // Example: Add additional points if needed
      print(totalScore);
      // Update grammar points
      grammarPoints += totalScore;

      // Update progress levels based on new points
      if (grammarProgressLevel < 500) {
        grammarProgressLevel += (totalScore * 0.50).toInt();
        if (grammarProgressLevel > 500) grammarProgressLevel = 500; // Maximum limit
      }
      if (bottleFillLevel < 6000) {
        bottleFillLevel += (totalScore * 0.50).toInt();
        if (bottleFillLevel > 6000) bottleFillLevel = 6000; // Maximum limit
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
        title: Text('الأزمنة البسيطة', style: TextStyle(fontFamily: 'Cartoon')),
        backgroundColor: Colors.blue.shade900, // Dark blue color
      ),
      backgroundColor: Colors.blue.shade100, // Light blue background
      body: PageView(
        controller: _controller,
        children: [
          // Page 1: Tense Explanation
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.access_time, color: Colors.blue.shade700, size: 50),
                  ).animate().scale(duration: Duration(milliseconds: 600)),
                  SizedBox(height: 20),
                  Text(
                    'الأزمنة البسيطة',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Cartoon',
                    ),
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
                          'في اللغة الإنجليزية، هناك ثلاث أزمنة بسيطة رئيسية:',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        _tenseExplanationCard(
                          'المضارع البسيط (Present Simple):',
                          'يستخدم للتعبير عن الحقائق العامة، العادات، والأحداث الروتينية التي تحدث بانتظام.',
                          [
                            '1. I eat an apple every day. (أنا آكل تفاحة كل يوم)',
                            '2. She works at a hospital. (هي تعمل في مستشفى)',
                            '3. They play football on Sundays. (هم يلعبون كرة القدم أيام الأحد)',
                            '4. He drinks coffee every morning. (هو يشرب القهوة كل صباح)',
                            '5. The sun rises in the east. (الشمس تشرق من الشرق)',
                            '6. We live in London. (نحن نعيش في لندن)',
                            '7. You study English. (أنت تدرس الإنجليزية)',
                            '8. Birds fly in the sky. (الطيور تطير في السماء)',
                            '9. Water boils at 100 degrees Celsius. (الماء يغلي عند 100 درجة مئوية)',
                            '10. Cats catch mice. (القطط تصطاد الفئران)'
                          ],
                        ),
                        SizedBox(height: 20),
                        _tenseExplanationCard(
                          'الماضي البسيط (Past Simple):',
                          'يستخدم للتعبير عن الأحداث التي وقعت في وقت محدد في الماضي.',
                          [
                            '1. I ate an apple yesterday. (أنا أكلت تفاحة أمس)',
                            '2. She went to school last Monday. (هي ذهبت إلى المدرسة الاثنين الماضي)',
                            '3. They played football last week. (هم لعبوا كرة القدم الأسبوع الماضي)',
                            '4. He watched a movie last night. (هو شاهد فيلمًا الليلة الماضية)',
                            '5. We visited our grandparents last summer. (نحن زرنا أجدادنا الصيف الماضي)',
                            '6. You called me yesterday. (أنت اتصلت بي أمس)',
                            '7. The train arrived late. (القطار وصل متأخرًا)',
                            '8. She finished her homework last evening. (هي أنهت واجبها المنزلي مساء أمس)',
                            '9. He bought a new car last year. (هو اشترى سيارة جديدة العام الماضي)',
                            '10. They danced at the party. (هم رقصوا في الحفلة)'
                          ],
                        ),
                        SizedBox(height: 20),
                        _tenseExplanationCard(
                          'المستقبل البسيط (Future Simple):',
                          'يستخدم للتعبير عن الأحداث التي ستحدث في وقت لاحق في المستقبل.',
                          [
                            '1. I will eat an apple tomorrow. (سوف آكل تفاحة غدًا)',
                            '2. She will go to school next Monday. (هي سوف تذهب إلى المدرسة الاثنين القادم)',
                            '3. They will play football next Sunday. (هم سوف يلعبون كرة القدم الأحد القادم)',
                            '4. He will watch a movie tonight. (هو سوف يشاهد فيلمًا الليلة)',
                            '5. We will visit our grandparents next summer. (نحن سوف نزور أجدادنا الصيف القادم)',
                            '6. You will call me later. (أنت سوف تتصل بي لاحقًا)',
                            '7. The train will arrive on time. (القطار سوف يصل في الوقت المحدد)',
                            '8. She will finish her homework tonight. (هي سوف تنهي واجبها المنزلي الليلة)',
                            '9. He will buy a new car next year. (هو سوف يشتري سيارة جديدة العام القادم)',
                            '10. They will dance at the party. (هم سوف يرقصون في الحفلة)'
                          ],
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
                    child: Text('التالي: تمارين الأزمنة', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          // Page 2: Tense Exercises
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تمارين الأزمنة',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Cartoon',
                  ),
                ).animate().fadeIn(duration: Duration(milliseconds: 600)),
                Expanded(
                  child: ListView.builder(
                    itemCount: tenseQuestions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              tenseQuestions[index],
                              style: TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Cartoon'),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(tenseOptions[index].length, (i) {
                                bool isSelected = _selectedOptions[index] == i;
                                bool isCorrect = tenseAnswers[index] == i;
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

                                      if (i == tenseAnswers[index]) {
                                        _feedbackMessages[index] = 'إجابة صحيحة!';
                                      } else {
                                        _feedbackMessages[index] = 'إجابة خاطئة، حاول مرة أخرى.';
                                      }
                                    });
                                  },
                                  child: Text(
                                    tenseOptions[index][i],
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
          // Page 3: Results
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
                ).animate().fadeIn(duration: Duration(milliseconds: 600)),
                SizedBox(height: 20),
                Text(
                  'نقاطك: $_tenseScore / ${tenseQuestions.length}',
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
            // Calculate the total score when moving to the results page
            _tenseScore = 0;
            for (int i = 0; i < tenseQuestions.length; i++) {
              if (_selectedOptions[i] == tenseAnswers[i]) {
                _tenseScore++;
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

  // Widget for Tense Explanation Cards
  Widget _tenseExplanationCard(String title, String explanation, List<String> examples) {
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


