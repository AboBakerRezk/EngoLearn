import 'package:flutter/material.dart';


//S
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage49 extends StatefulWidget {
  @override
  _ReadingAssessmentPage49State createState() => _ReadingAssessmentPage49State();
}

class _ReadingAssessmentPage49State extends State<ReadingAssessmentPage49>
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
    In a busy city, there lived a mother named Layla and her son, Samir. Layla was a loving and caring mother who wanted the best for Samir. However, she often found herself overwhelmed with work and household chores. She was determined to raise Samir well but struggled to balance everything.

    One day, Samir came home from school with a report card that showed low grades. He felt anxious and scared to show it to his mother. When Layla saw the report card, she became upset. "Why didn’t you study harder, Samir? You need to focus on your education!" she exclaimed.

    Instead of understanding his feelings, Layla scolded him, which made Samir feel ashamed and discouraged. He thought that no matter how hard he tried, he would never be good enough for his mother.

    The next day, Samir’s teacher noticed his distress and called Layla to discuss it. She explained, "Samir is a bright child, but he needs your support and encouragement. Instead of criticizing him, try to understand his struggles and help him find a way to improve."

    Layla realized that her approach had been wrong. She decided to change her way of communicating with Samir. That evening, she sat down with him and asked, "How do you feel about your grades, Samir? What can we do together to help you improve?"

    Samir was surprised but relieved to hear his mother's kind words. They talked about the subjects he found difficult, and Layla promised to help him with his homework. They created a study schedule together, making learning fun and engaging.

    Over the following weeks, Samir's grades began to improve. With his mother's support and encouragement, he gained confidence in his abilities. Layla learned the importance of being a positive influence and offering support instead of criticism.

    By the end of the school year, Samir had transformed into a motivated student, and his bond with Layla grew stronger. She realized that love, understanding, and encouragement were the keys to raising a happy and successful child.
    ''',
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. How did Layla feel when she saw Samir's report card?",
        options: [
          "Proud and happy",
          "Upset and disappointed",
          "Indifferent and relaxed",
          "Excited and cheerful"
        ],
        correctAnswer: "Upset and disappointed",
        hint: "She reacted strongly to his low grades.",
      ),
      ReadingQuestion(
        questionText: "2. How did Samir feel after receiving his grades?",
        options: [
          "Confident and proud",
          "Anxious and scared",
          "Excited and happy",
          "Indifferent and relaxed"
        ],
        correctAnswer: "Anxious and scared",
        hint: "He was worried about showing it to his mother.",
      ),
      ReadingQuestion(
        questionText: "3. What did Samir's teacher suggest to Layla?",
        options: [
          "To punish Samir",
          "To understand Samir's struggles",
          "To hire a tutor",
          "To ignore the grades"
        ],
        correctAnswer: "To understand Samir's struggles",
        hint: "She emphasized the importance of support.",
      ),
      ReadingQuestion(
        questionText: "4. What change did Layla make in her approach?",
        options: [
          "She became stricter",
          "She decided to support Samir",
          "She ignored his studies",
          "She focused on her work"
        ],
        correctAnswer: "She decided to support Samir",
        hint: "She wanted to understand and help him.",
      ),
      ReadingQuestion(
        questionText: "5. What was the result of Layla's new approach?",
        options: [
          "Samir's grades improved",
          "Samir became rebellious",
          "Layla became more busy",
          "Samir lost interest in school"
        ],
        correctAnswer: "Samir's grades improved",
        hint: "He gained confidence with her support.",
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

