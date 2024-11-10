import 'package:flutter/material.dart';


//S
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage30 extends StatefulWidget {
  @override
  _ReadingAssessmentPage30State createState() => _ReadingAssessmentPage30State();
}

class _ReadingAssessmentPage30State extends State<ReadingAssessmentPage30>
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
    In a small village in the desert, there lived a young boy named Samir. Samir loved to play outside and explore the beautiful nature around him. Every day after school, he would run to the oasis nearby, where he could see palm trees, sparkling water, and colorful birds.

    One hot afternoon, while playing near the water, Samir noticed something shiny under a bush. Curious, he went closer and found a small, golden lamp. Excited, he picked it up and began to polish it. Suddenly, a cloud of smoke appeared, and out came a magical genie!

    "Thank you for freeing me!" said the genie. "In return, I will grant you three wishes."

    Samir couldn't believe his ears. He thought carefully about his wishes. For his first wish, he asked for a beautiful treehouse where he could play with his friends. The genie waved his hand, and in an instant, a magnificent treehouse appeared in the tallest palm tree.

    For his second wish, Samir wanted a big basket of delicious fruits. The genie clapped his hands, and a basket filled with juicy oranges, sweet dates, and fresh figs appeared before him.

    Now, it was time for Samir's final wish. He wanted to help the people in his village. So, he wished for a well that would provide fresh water for everyone. The genie smiled and granted his wish. A sparkling well appeared, and the villagers cheered with joy.

    Samir learned that true happiness comes from helping others. He enjoyed his treehouse and delicious fruits, but the joy of bringing fresh water to his village made him the happiest of all. From that day on, he became a hero in his village, known for his kindness and generosity.
    '''
  ];

  // قائمة الأسئلة للنص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. Where did Samir live?",
        options: ["In a big city", "In a small village in the desert", "In a forest", "Near the ocean"],
        correctAnswer: "In a small village in the desert",
        hint: "The story begins in a village located in the desert.",
      ),
      ReadingQuestion(
        questionText: "2. What did Samir find near the oasis?",
        options: ["A treasure chest", "A golden lamp", "A magic book", "A rare bird"],
        correctAnswer: "A golden lamp",
        hint: "It was shiny and hidden under a bush.",
      ),
      ReadingQuestion(
        questionText: "3. What was Samir's first wish?",
        options: ["A basket of fruits", "A treehouse", "A magic carpet", "A new friend"],
        correctAnswer: "A treehouse",
        hint: "He wanted a place to play with his friends.",
      ),
      ReadingQuestion(
        questionText: "4. What did Samir wish for last?",
        options: ["To be rich", "A well for fresh water", "A big party", "A new bicycle"],
        correctAnswer: "A well for fresh water",
        hint: "He wanted to help the people in his village.",
      ),
      ReadingQuestion(
        questionText: "5. What did Samir learn from his experience?",
        options: ["To keep wishes for himself", "That true happiness comes from helping others", "To wish for more wishes", "To play alone"],
        correctAnswer: "That true happiness comes from helping others",
        hint: "His final wish brought joy to everyone.",
      ),
    ]
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

