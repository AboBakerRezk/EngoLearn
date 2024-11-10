import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ReadingAssessmentPage5 extends StatefulWidget {
  @override
  _ReadingAssessmentPage5State createState() => _ReadingAssessmentPage5State();
}

class _ReadingAssessmentPage5State extends State<ReadingAssessmentPage5>    with SingleTickerProviderStateMixin {
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
    Omar loves animals. One day, he went to the zoo with his family. He saw lions, elephants, and monkeys. His favorite animal was the giraffe because it was so tall and gentle. Omar's father bought him a small giraffe toy from the gift shop. It was the best day ever for Omar!
    ''',
    '''
    Fatima enjoys helping her mother in the garden. They plant flowers, water the plants, and take care of the vegetables. Last weekend, they planted some sunflowers. Fatima was excited because the sunflowers would grow tall. She can't wait to see them bloom in the summer.
    ''',
    '''
    Samir went to the beach with his cousins. They built sandcastles and played in the water. Samir collected seashells and found a very big one. His cousins were amazed by the size of the shell. After that, they all had ice cream and watched the sunset together. It was a fun and relaxing day at the beach.
    '''
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. Where did Omar go with his family?",
        options: ["To the zoo", "To the park", "To the beach", "To the museum"],
        correctAnswer: "To the zoo",
        hint: "He saw different animals.",
      ),
      ReadingQuestion(
        questionText: "2. What was Omar's favorite animal?",
        options: ["Lion", "Elephant", "Monkey", "Giraffe"],
        correctAnswer: "Giraffe",
        hint: "It was tall and gentle.",
      ),
      ReadingQuestion(
        questionText: "3. What did Omar's father buy him?",
        options: ["A lion toy", "A giraffe toy", "An elephant toy", "A monkey toy"],
        correctAnswer: "A giraffe toy",
        hint: "His favorite animal was a giraffe.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What does Fatima help her mother with?",
        options: ["Cooking", "Cleaning", "Gardening", "Shopping"],
        correctAnswer: "Gardening",
        hint: "They plant flowers and vegetables together.",
      ),
      ReadingQuestion(
        questionText: "2. What did they plant last weekend?",
        options: ["Roses", "Sunflowers", "Tomatoes", "Trees"],
        correctAnswer: "Sunflowers",
        hint: "They planted something that grows tall.",
      ),
      ReadingQuestion(
        questionText: "3. Why is Fatima excited about the sunflowers?",
        options: ["Because they will grow tall", "Because they will be colorful", "Because they will bloom in the winter", "Because they will smell nice"],
        correctAnswer: "Because they will grow tall",
        hint: "She is excited because they will be tall.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. Where did Samir go with his cousins?",
        options: ["To the mountains", "To the park", "To the beach", "To the zoo"],
        correctAnswer: "To the beach",
        hint: "They built sandcastles and played in the water.",
      ),
      ReadingQuestion(
        questionText: "2. What did Samir collect?",
        options: ["Rocks", "Seashells", "Flowers", "Stones"],
        correctAnswer: "Seashells",
        hint: "He found a very big one.",
      ),
      ReadingQuestion(
        questionText: "3. What did they do after collecting seashells?",
        options: ["Went home", "Played soccer", "Ate ice cream", "Swam in the water"],
        correctAnswer: "Ate ice cream",
        hint: "They enjoyed a cold treat after their fun activities.",
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

