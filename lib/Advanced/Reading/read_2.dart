
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


//S
class ReadingAssessmentPage2 extends StatefulWidget {
  @override
  _ReadingAssessmentPage2State createState() => _ReadingAssessmentPage2State();
}

class _ReadingAssessmentPage2State extends State<ReadingAssessmentPage2>
    with SingleTickerProviderStateMixin {
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

  // دالة لتحميل البيانات المحفوظة من SharedPreferences
  // Load saved data
  Future<void> loadSavedProgressData() async {
    SharedPreferences sharedPreferencesInstance =
    await SharedPreferences.getInstance();
    setState(() {
      listeningProgressLevel =
          sharedPreferencesInstance.getInt('readingProgressLevel') ?? 0;
      bottleFillLevel = sharedPreferencesInstance.getInt('bottleFillLevel') ?? 0;
      readingPoints = sharedPreferencesInstance.getDouble('readingPoints') ?? 0.0;

    });
  }

  // Save data
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences sharedPreferencesInstance =
    await SharedPreferences.getInstance();
    await sharedPreferencesInstance.setInt(
        'progressListening', listeningProgressLevel);
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
    Sarah loves to bake. Every weekend, she bakes cookies with her mom. This Saturday, they decided to bake chocolate chip cookies. Sarah mixed the ingredients and her mom helped her put the cookies in the oven. After 15 minutes, the cookies were ready. They smelled delicious! Sarah shared the cookies with her family, and everyone said they were the best cookies ever.
    ''',
    '''
    Jake enjoys riding his bicycle. One day, he wanted to try riding it in the park. He wore his helmet and rode around the trees and flowers. While riding, he saw a little cat stuck in a tree. Jake stopped his bike and helped the cat get down safely. The cat followed Jake as he continued riding in the park. They became friends and Jake visited the cat every time he went to the park.
    ''',
    '''
    Lucy has a garden with many flowers. Every morning, she waters the flowers and takes care of them. One day, she noticed a beautiful butterfly flying around her garden. Lucy sat and watched the butterfly for a long time. She was happy to see how much the butterfly liked her flowers. From that day on, Lucy saw more butterflies coming to her garden, and she loved her flowers even more.
    '''
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What did Sarah bake with her mom?",
        options: ["Cakes", "Pies", "Chocolate chip cookies", "Brownies"],
        correctAnswer: "Chocolate chip cookies",
        hint: "They baked something with chocolate.",
      ),
      ReadingQuestion(
        questionText: "2. How long did the cookies take to bake?",
        options: ["10 minutes", "15 minutes", "20 minutes", "30 minutes"],
        correctAnswer: "15 minutes",
        hint: "It’s mentioned before the cookies were ready.",
      ),
      ReadingQuestion(
        questionText: "3. Who helped Sarah put the cookies in the oven?",
        options: ["Her dad", "Her mom", "Her brother", "Her sister"],
        correctAnswer: "Her mom",
        hint: "Sarah baked with a family member.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What does Jake enjoy doing?",
        options: ["Playing soccer", "Riding his bicycle", "Swimming", "Drawing"],
        correctAnswer: "Riding his bicycle",
        hint: "Jake enjoys an activity that involves wheels.",
      ),
      ReadingQuestion(
        questionText: "2. What did Jake find in the park?",
        options: ["A bird", "A cat", "A dog", "A squirrel"],
        correctAnswer: "A cat",
        hint: "He found an animal stuck in a tree.",
      ),
      ReadingQuestion(
        questionText: "3. What did Jake do to help the cat?",
        options: ["Gave it food", "Took it home", "Helped it get down from the tree", "Played with it"],
        correctAnswer: "Helped it get down from the tree",
        hint: "Jake helped the cat safely.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What does Lucy have in her garden?",
        options: ["Vegetables", "Trees", "Flowers", "Grass"],
        correctAnswer: "Flowers",
        hint: "Her garden is full of something colorful.",
      ),
      ReadingQuestion(
        questionText: "2. What did Lucy see flying around her garden?",
        options: ["A bee", "A bird", "A butterfly", "A dragonfly"],
        correctAnswer: "A butterfly",
        hint: "It’s something that flies and has colorful wings.",
      ),
      ReadingQuestion(
        questionText: "3. How did Lucy feel when she saw the butterfly?",
        options: ["Sad", "Angry", "Happy", "Scared"],
        correctAnswer: "Happy",
        hint: "Lucy was pleased to see the butterfly in her garden.",
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
