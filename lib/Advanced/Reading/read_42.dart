import 'package:flutter/material.dart';


//S
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage42 extends StatefulWidget {
  @override
  _ReadingAssessmentPage42State createState() => _ReadingAssessmentPage42State();
}

class _ReadingAssessmentPage42State extends State<ReadingAssessmentPage42>
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
    In a small village surrounded by mountains and green fields, lived a family consisting of a father, a mother, and their two children: Leila and Amir. The father, Ahmad, was a hardworking farmer, while the mother, Fatima, was a homemaker who took care of the children and taught them values and morals.

    Leila was an intelligent and curious girl, always asking questions about everything around her. Amir, who was two years younger, was passionate about technology and electrical devices. He dreamed of becoming an engineer one day.

    They had a small garden where they grew vegetables and fruits. Fatima taught her children how to take care of the plants and how the earth could provide them with what they needed if they took care of it. She would say, "The earth is our mother, and we must respect it and take care of it."

    One day, Fatima decided to take her children on a trip to the nearby mountain. She hoped this trip would be an opportunity to instill a love of nature in them. As they walked, they saw various types of flowers and trees. Leila was excited, taking pictures, while Amir enjoyed searching for insects.

    But during the trip, they were faced with a sudden storm. Rain started pouring heavily, and the family got scattered while looking for shelter. The children felt scared, but Ahmad and Fatima encouraged them to be brave. "We need to find a safe place until the storm passes," said Ahmad.

    After several minutes of searching, they found a small cave. They entered to shelter from the rain. While sitting in the cave, Fatima began to tell stories about their ancestors and how they overcame difficulties. "Life is not always easy, but with faith and hope, we can overcome any obstacle," said Fatima.

    After the storm calmed down, they decided to return home. When they reached their village, they were wet but happy. The children learned a valuable lesson about the strength of family and hope during tough times.

    In the following days, Leila and Amir worked hard in the garden with their parents. They grew vegetables and fruit trees, taking care of them diligently. Amir used simple technology to improve the plants’ growth, while Leila maintained the flower garden, making their family's garden thrive.

    Years passed, and Leila and Amir grew up. Leila received a scholarship to study at a prestigious university, while Amir became a successful engineer at a leading technology company. However, they never forgot the lessons of their childhood.

    They returned to the village every summer to visit their parents and decided to contribute to improving their village's life. They established a sustainable agricultural project aimed at helping local farmers use modern technology in their farming.

    Leila and Amir learned that life is not just about personal success, but also about giving back and helping others. Thanks to their parents' teachings, they became influential individuals in their community.
    ''',
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. Where did the family live?",
        options: ["In a city", "In a village", "In a forest", "In the mountains"],
        correctAnswer: "In a village",
        hint: "They lived in a small village surrounded by mountains.",
      ),
      ReadingQuestion(
        questionText: "2. What was Amir passionate about?",
        options: ["Farming", "Art", "Technology", "Sports"],
        correctAnswer: "Technology",
        hint: "He dreamed of becoming an engineer.",
      ),
      ReadingQuestion(
        questionText: "3. What did Fatima teach her children?",
        options: ["How to cook", "How to respect the earth", "How to play games", "How to read"],
        correctAnswer: "How to respect the earth",
        hint: "She taught them the importance of caring for the plants.",
      ),
      ReadingQuestion(
        questionText: "4. What happened during their trip?",
        options: ["They got lost", "They found treasure", "A storm occurred", "They saw wild animals"],
        correctAnswer: "A storm occurred",
        hint: "A sudden storm made them search for shelter.",
      ),
      ReadingQuestion(
        questionText: "5. What lesson did the children learn from their experience?",
        options: ["To be afraid of storms", "To always stay home", "About the strength of family and hope", "To avoid going to the mountains"],
        correctAnswer: "About the strength of family and hope",
        hint: "They learned the value of family during tough times.",
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


