import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage10 extends StatefulWidget {
  @override
  _ReadingAssessmentPage10State createState() => _ReadingAssessmentPage10State();
}

class _ReadingAssessmentPage10State extends State<ReadingAssessmentPage10>     with SingleTickerProviderStateMixin {
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
    // النصوص السابقة
    '''
    Layla loved baking with her grandmother. Every Saturday, they would make delicious cookies together. One day, they decided to try a new recipe for chocolate chip cookies. They mixed the ingredients, and the kitchen smelled amazing. After baking, they enjoyed the warm cookies with a glass of milk. Layla felt happy to create something tasty with her grandmother.
    ''',
    // القصة الجديدة
    '''
    Khaled was excited to join the school's art club. He loved drawing and painting. On the first day, the teacher showed them how to paint with watercolors. Khaled created a beautiful landscape with mountains and a river. Everyone admired his work. Khaled felt proud and knew he wanted to be an artist when he grew up.
    '''
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    // الأسئلة السابقة
    [
      ReadingQuestion(
        questionText: "1. Who did Layla bake cookies with?",
        options: ["Her mother", "Her sister", "Her grandmother", "Her friend"],
        correctAnswer: "Her grandmother",
        hint: "They baked together every Saturday.",
      ),
      ReadingQuestion(
        questionText: "2. What type of cookies did they make?",
        options: ["Oatmeal cookies", "Chocolate chip cookies", "Peanut butter cookies", "Sugar cookies"],
        correctAnswer: "Chocolate chip cookies",
        hint: "It was a new recipe they tried.",
      ),
      ReadingQuestion(
        questionText: "3. How did Layla feel after baking?",
        options: ["Sad", "Angry", "Happy", "Bored"],
        correctAnswer: "Happy",
        hint: "She created something tasty.",
      ),
    ],
    // الأسئلة للقصة الجديدة
    [
      ReadingQuestion(
        questionText: "1. What did Khaled join at school?",
        options: ["The music club", "The sports team", "The art club", "The science club"],
        correctAnswer: "The art club",
        hint: "He loved drawing and painting.",
      ),
      ReadingQuestion(
        questionText: "2. What did the teacher show them how to use?",
        options: ["Crayons", "Watercolors", "Markers", "Pencils"],
        correctAnswer: "Watercolors",
        hint: "They learned to paint with them.",
      ),
      ReadingQuestion(
        questionText: "3. What did Khaled paint?",
        options: ["A portrait", "A landscape", "An animal", "A still life"],
        correctAnswer: "A landscape",
        hint: "It had mountains and a river.",
      ),
    ],
  ];
}


class ReadingQuestion {
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  final String? hint;
  String? selectedAnswer;

  ReadingQuestion({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    this.hint,
    this.selectedAnswer,
  });
}
