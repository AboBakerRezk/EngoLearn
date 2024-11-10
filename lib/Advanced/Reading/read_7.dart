import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage7 extends StatefulWidget {
  @override
  _ReadingAssessmentPage7State createState() => _ReadingAssessmentPage7State();
}

class _ReadingAssessmentPage7State extends State<ReadingAssessmentPage7>     with SingleTickerProviderStateMixin {
  int _currentStoryIndex = 0;
  int _currentQuestionIndex = 0;
  int _score = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E);

  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int speakingProgressLevel = 0; // New variable for Speaking
  int bottleFillLevel = 0;

  double readingPoints = 0.0;

// Load saved data
  Future<void> loadSavedProgressData() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    setState(() {
      readingProgressLevel = sharedPreferencesInstance.getInt('readingProgressLevel') ?? 0;
      bottleFillLevel = sharedPreferencesInstance.getInt('bottleFillLevel') ?? 0;
      readingPoints = sharedPreferencesInstance.getDouble('readingPoints') ?? 0.0;
    });
  }

// Save data
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    await sharedPreferencesInstance.setInt('readingProgressLevel', readingProgressLevel);
    await sharedPreferencesInstance.setInt('bottleFillLevel', bottleFillLevel);
    await sharedPreferencesInstance.setDouble('readingPoints', readingPoints);
  }

  @override
  void initState() {
    super.initState();
    loadSavedProgressData();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        _score += 10;
        readingProgressLevel += (_score * 0.5).toInt();
        if (readingProgressLevel > 500) readingProgressLevel = 500;

        // تحديث نقاط الاستماع
        readingPoints += (_score * 0.5).toInt();
        if (readingPoints > 500) readingPoints = 500;

        // زيادة مستوى تعبئة الزجاجة
        bottleFillLevel += _score;
        if (bottleFillLevel > 6000) bottleFillLevel = 6000;
        // تحديث مستويات التقدم
        saveProgressDataToPreferences();
      } else {
        _score -= 5;
      }

      // Check if there are more questions in the current story
      if (_currentQuestionIndex < ReadingData.questionsList[_currentStoryIndex].length - 1) {
        _currentQuestionIndex++;
      } else if (_currentStoryIndex < ReadingData.readingTexts.length - 1) {
        _currentStoryIndex++;
        _currentQuestionIndex = 0;
      } else {
        _showPerformanceStats();
      }

      // Save progress data
      saveProgressDataToPreferences();
    });
  }

  Widget _buildButton(String option, bool isCorrect) {
    return FadeTransition(
      opacity: _animation,
      child: ElevatedButton(
        onPressed: () {
          checkAnswer(isCorrect);

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        child: Text(
          option,
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }

  void _showPerformanceStats() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Performance Statistics'),
        content: Text('Score: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentText = ReadingData.readingTexts[_currentStoryIndex];
    List<ReadingQuestion> currentQuestions = ReadingData.questionsList[_currentStoryIndex];
    ReadingQuestion currentQuestion = currentQuestions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Reading Quiz',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, primaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              Text(
                'Read the following text:',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                currentText,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                currentQuestion.questionText,
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              SizedBox(height: 20),
              ...currentQuestion.options.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _buildButton(option, option == currentQuestion.correctAnswer),
                );
              }).toList(),
              SizedBox(height: 30),
              Text(
                'Score: $_score',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ReadingData {
  // قائمة النصوص
  static final List<String> readingTexts = [
    '''
    Omar wanted to grow a plant in his garden. His grandmother gave him some seeds and told him to water them every day. Omar was very excited and followed her advice carefully. After a few weeks, a small green plant started to grow. Omar was very proud of his plant and showed it to his friends.
    ''',
    '''
    Laila loves baking cookies with her mother. Every weekend, they try new recipes together. Last Saturday, they made chocolate chip cookies, and Laila shared them with her neighbors. Everyone loved the cookies and asked her for the recipe.
    ''',
    '''
    Youssef enjoys riding his bicycle around the neighborhood. One afternoon, while riding, he found a kitten stuck in a tree. Youssef quickly called his father for help. Together, they managed to rescue the kitten, and Youssef felt happy knowing he helped the little animal.
    '''
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What did Omar want to grow?",
        options: ["A tree", "A plant", "Flowers", "Vegetables"],
        correctAnswer: "A plant",
        hint: "He was excited to grow something in his garden.",
      ),
      ReadingQuestion(
        questionText: "2. Who gave Omar the seeds?",
        options: ["His mother", "His teacher", "His grandmother", "His friend"],
        correctAnswer: "His grandmother",
        hint: "She also gave him advice on how to care for the plant.",
      ),
      ReadingQuestion(
        questionText: "3. How did Omar feel when the plant started to grow?",
        options: ["Sad", "Proud", "Angry", "Confused"],
        correctAnswer: "Proud",
        hint: "He was happy to show the plant to his friends.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What does Laila love to do with her mother?",
        options: ["Play games", "Bake cookies", "Go shopping", "Watch TV"],
        correctAnswer: "Bake cookies",
        hint: "They try new recipes every weekend.",
      ),
      ReadingQuestion(
        questionText: "2. What kind of cookies did they make last Saturday?",
        options: ["Sugar cookies", "Oatmeal cookies", "Chocolate chip cookies", "Peanut butter cookies"],
        correctAnswer: "Chocolate chip cookies",
        hint: "They shared them with their neighbors.",
      ),
      ReadingQuestion(
        questionText: "3. What did Laila's neighbors ask for?",
        options: ["More cookies", "The recipe", "A cup of tea", "A cake"],
        correctAnswer: "The recipe",
        hint: "Everyone loved the cookies and wanted to make them too.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What does Youssef enjoy doing in the neighborhood?",
        options: ["Playing football", "Riding his bicycle", "Walking his dog", "Visiting friends"],
        correctAnswer: "Riding his bicycle",
        hint: "He likes exploring the area while riding.",
      ),
      ReadingQuestion(
        questionText: "2. What did Youssef find stuck in a tree?",
        options: ["A bird", "A kite", "A kitten", "A squirrel"],
        correctAnswer: "A kitten",
        hint: "He helped rescue it with his father.",
      ),
      ReadingQuestion(
        questionText: "3. How did Youssef feel after helping the kitten?",
        options: ["Sad", "Angry", "Happy", "Scared"],
        correctAnswer: "Happy",
        hint: "He felt good about helping the little animal.",
      ),
    ],
  ];
}

class ReadingQuestion {
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  final String hint;

  ReadingQuestion({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    required this.hint,
  });
}

