import 'package:flutter/material.dart';


//S
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage47 extends StatefulWidget {
  @override
  _ReadingAssessmentPage47State createState() => _ReadingAssessmentPage47State();
}

class _ReadingAssessmentPage47State extends State<ReadingAssessmentPage47>
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
    In a vibrant city, there lived a couple named Omar and Sara. They had two children, Rami and Layla. Omar was a hardworking man who often spent long hours at the office, while Sara was a stay-at-home mom who dedicated her time to raising the children.

    Omar and Sara loved their children deeply, but they struggled with finding the right balance in their parenting styles. Omar believed in strict discipline and often imposed rules without much explanation. He thought that structure and order were the keys to success. On the other hand, Sara was more lenient. She believed in allowing the kids to express themselves freely and make their own choices.

    Rami, the eldest, was caught in the middle. He often felt torn between his father's expectations and his mother's desire for him to be independent. He was a bright boy who loved to draw and paint, but Omar insisted that he focus on his studies to secure a good future. Rami began to feel anxious and unfulfilled, as he was not able to pursue his passion.

    Layla, the youngest, was a free spirit who enjoyed dancing and playing outdoors. She thrived under Sara's nurturing approach but often felt overshadowed by Rami's academic achievements. As a result, she started to seek attention through mischievous behavior, trying to prove herself to her parents.

    One day, during a family meeting, Omar and Sara realized that their differing parenting styles were causing confusion and frustration for their children. They decided to come together and create a balanced approach to parenting that would allow their children to thrive.

    They agreed to set aside time each week to discuss their children's progress and feelings. Omar learned to appreciate Rami's artistic talents, while Sara encouraged Rami to focus on his studies as well. They also made a point to celebrate Layla's achievements, no matter how small, which helped her gain confidence.

    Over time, Rami began to excel in his studies while still pursuing his love for art. Layla found her own balance between play and responsibility. Omar and Sara learned that parenting is not about being strict or lenient but about understanding, compromise, and support. The family grew closer, and their home became a nurturing environment where both children could flourish.
    ''',
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What were the names of Omar and Sara's children?",
        options: [
          "Rami and Layla",
          "Omar and Sara",
          "Ali and Fatima",
          "Hassan and Zainab"
        ],
        correctAnswer: "Rami and Layla",
        hint: "They are the children of Omar and Sara.",
      ),
      ReadingQuestion(
        questionText: "2. What was Omar's parenting style?",
        options: [
          "Lenient and relaxed",
          "Strict and disciplined",
          "Flexible and understanding",
          "Indifferent and distant"
        ],
        correctAnswer: "Strict and disciplined",
        hint: "He imposed rules without much explanation.",
      ),
      ReadingQuestion(
        questionText: "3. How did Rami feel about his father's expectations?",
        options: [
          "Happy and fulfilled",
          "Anxious and unfulfilled",
          "Excited and motivated",
          "Indifferent and relaxed"
        ],
        correctAnswer: "Anxious and unfulfilled",
        hint: "He felt torn between expectations.",
      ),
      ReadingQuestion(
        questionText: "4. What did Layla do to seek attention?",
        options: [
          "Studied hard",
          "Helped with chores",
          "Acted mischievously",
          "Ignored her parents"
        ],
        correctAnswer: "Acted mischievously",
        hint: "She tried to prove herself to her parents.",
      ),
      ReadingQuestion(
        questionText: "5. What did Omar and Sara decide to do?",
        options: [
          "Have separate parenting styles",
          "Work together to create a balanced approach",
          "Ignore their children's feelings",
          "Spend more time at work"
        ],
        correctAnswer: "Work together to create a balanced approach",
        hint: "They wanted their children to thrive.",
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

