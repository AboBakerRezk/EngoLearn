import 'package:flutter/material.dart';


//S
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage48 extends StatefulWidget {
  @override
  _ReadingAssessmentPage48State createState() => _ReadingAssessmentPage48State();
}

class _ReadingAssessmentPage48State extends State<ReadingAssessmentPage48>
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
    In a small town, there lived a father named Ahmed and his daughter, Nora. Ahmed was a hardworking man who wanted the best for his daughter. He often worked long hours to provide for her, believing that financial stability was the key to a happy life.

    However, Ahmed often neglected spending quality time with Nora. She would wait for him to come home, hoping they could play or talk about her day, but most of the time, he was too tired or busy with work. Nora felt lonely and missed her father's presence in her life.

    One day, at school, Nora's teacher noticed she was not her usual cheerful self. When asked, she explained that she missed her father and wished they could spend more time together. The teacher suggested that Nora write a letter to her father expressing her feelings.

    That evening, after finishing her homework, Nora wrote a heartfelt letter to Ahmed. In her letter, she wrote, "Dear Dad, I love you so much, but I feel sad when you are not around. I want us to have fun together, like we used to. Please spend more time with me."

    When Ahmed got home and read Nora's letter, his heart sank. He realized that in his pursuit of providing for Nora, he had overlooked the most important thing – being present in her life. He felt guilty for not noticing her feelings sooner.

    The next day, Ahmed decided to change his ways. He took a day off work and surprised Nora by taking her to the park. They played games, had a picnic, and talked for hours. Nora's face lit up with joy, and for the first time in a long while, she felt truly happy.

    From that day on, Ahmed made a conscious effort to balance work and family. He set aside specific times each week to spend with Nora, whether it was playing games, reading stories, or just talking about their day. He learned that being present in her life was far more valuable than any material gift he could provide.

    Nora flourished with her father's love and attention. Their bond grew stronger, and she felt more secure and confident knowing her father was always there for her. Ahmed realized that the greatest gift he could give his daughter was his time and affection. Together, they created beautiful memories that would last a lifetime.
    ''',
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What was Ahmed's main goal as a father?",
        options: [
          "To spend time with Nora",
          "To provide financial stability",
          "To be a strict parent",
          "To support Nora's hobbies"
        ],
        correctAnswer: "To provide financial stability",
        hint: "He worked long hours for this reason.",
      ),
      ReadingQuestion(
        questionText: "2. How did Nora feel about her father's absence?",
        options: [
          "Happy and content",
          "Lonely and sad",
          "Excited and energetic",
          "Indifferent and relaxed"
        ],
        correctAnswer: "Lonely and sad",
        hint: "She missed her father's presence.",
      ),
      ReadingQuestion(
        questionText: "3. What did Nora's teacher suggest she do?",
        options: [
          "Talk to her friends",
          "Write a letter to her father",
          "Draw a picture",
          "Ignore her feelings"
        ],
        correctAnswer: "Write a letter to her father",
        hint: "She needed to express her feelings.",
      ),
      ReadingQuestion(
        questionText: "4. How did Ahmed feel after reading Nora's letter?",
        options: [
          "Happy and proud",
          "Guilty and sad",
          "Angry and frustrated",
          "Indifferent and relaxed"
        ],
        correctAnswer: "Guilty and sad",
        hint: "He realized he had overlooked her feelings.",
      ),
      ReadingQuestion(
        questionText: "5. What change did Ahmed make in his life?",
        options: [
          "He worked longer hours",
          "He spent more time with Nora",
          "He hired a babysitter",
          "He moved to a different city"
        ],
        correctAnswer: "He spent more time with Nora",
        hint: "He wanted to be present in her life.",
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

