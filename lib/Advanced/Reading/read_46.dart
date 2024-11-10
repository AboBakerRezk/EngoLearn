import 'package:flutter/material.dart';


//S
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage46 extends StatefulWidget {
  @override
  _ReadingAssessmentPage46State createState() => _ReadingAssessmentPage46State();
}

class _ReadingAssessmentPage46State extends State<ReadingAssessmentPage46>
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
    In a small town, there was a family consisting of Ali, Fatima, and their three children: Hani, Lina, and Sami. Ali and Fatima loved their children deeply, but they often made mistakes in how they raised them.

    Ali was always busy with work and often brought his stress home. He would yell at the kids when they made noise or interrupted him while he was working from home. Fatima, on the other hand, tried to make everything perfect. She wanted her children to excel in school, so she pushed them hard to get good grades and participate in many extracurricular activities.

    Hani, the oldest, felt overwhelmed with the pressure to succeed. He was a bright student, but he started to lose interest in learning because he felt like he was never good enough for his parents. Lina, the middle child, was shy and often felt ignored. She struggled to get her parents' attention, which made her feel invisible in the family. Sami, the youngest, wanted to be like his older siblings but was often scolded for his mistakes, making him feel discouraged.

    One weekend, the family went on a trip to the countryside. During the trip, Ali and Fatima realized how distant they had become from their children. They spent more time arguing about how to parent than enjoying their time together. While sitting around the campfire, the children opened up about their feelings. Hani shared how stressed he felt about his grades, Lina expressed her sadness over feeling overlooked, and Sami talked about how he just wanted to play and have fun without being criticized.

    Ali and Fatima were taken aback. They had been so focused on achieving success that they forgot to nurture their children's happiness and individuality. They apologized to their kids and promised to be more present and supportive. From that day on, they made a conscious effort to listen to their children, celebrate their achievements, and allow them to make mistakes without fear of punishment.

    Over time, the family grew closer. Hani regained his love for learning, Lina became more confident in expressing herself, and Sami enjoyed his childhood without the pressure of expectations. Ali and Fatima learned that parenting is not just about setting goals, but also about understanding, patience, and unconditional love.
    ''',
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What mistake did Ali make regarding his children?",
        options: [
          "He spent too much time with them.",
          "He yelled at them when they made noise.",
          "He helped them with their homework.",
          "He took them on trips."
        ],
        correctAnswer: "He yelled at them when they made noise.",
        hint: "Ali was often stressed from work.",
      ),
      ReadingQuestion(
        questionText: "2. How did Fatima approach her children's education?",
        options: [
          "She encouraged them to relax.",
          "She pushed them hard to succeed.",
          "She ignored their schoolwork.",
          "She focused on their happiness."
        ],
        correctAnswer: "She pushed them hard to succeed.",
        hint: "Fatima wanted everything to be perfect.",
      ),
      ReadingQuestion(
        questionText: "3. What did Hani feel because of the pressure?",
        options: [
          "Excited to learn more.",
          "Overwhelmed and uninterested.",
          "Happy and confident.",
          "Proud of his achievements."
        ],
        correctAnswer: "Overwhelmed and uninterested.",
        hint: "He felt he was never good enough.",
      ),
      ReadingQuestion(
        questionText: "4. How did Lina feel in the family?",
        options: [
          "She felt very happy.",
          "She felt ignored and invisible.",
          "She felt like the favorite child.",
          "She felt overachieved."
        ],
        correctAnswer: "She felt ignored and invisible.",
        hint: "She struggled to get her parents' attention.",
      ),
      ReadingQuestion(
        questionText: "5. What realization did Ali and Fatima have during the trip?",
        options: [
          "They were great parents.",
          "They had become distant from their children.",
          "They should work harder.",
          "They needed more vacations."
        ],
        correctAnswer: "They had become distant from their children.",
        hint: "They spent more time arguing than enjoying.",
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

