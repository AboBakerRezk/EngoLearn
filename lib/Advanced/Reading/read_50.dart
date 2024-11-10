import 'package:flutter/material.dart';


//S
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage50 extends StatefulWidget {
  @override
  _ReadingAssessmentPage50State createState() => _ReadingAssessmentPage50State();
}

class _ReadingAssessmentPage50State extends State<ReadingAssessmentPage50>
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
    In a small village, there lived a father named Ahmed and his daughter, Noor. Ahmed was a hardworking farmer who spent most of his time in the fields. He loved Noor dearly but often struggled to express his feelings. He believed that providing for her financially was enough to show his love.

    One day, Noor came home from school, excited to share her school project about the environment. She wanted to present it to her father, hoping he would appreciate her hard work. However, when she found her father busy in the fields, she hesitated and decided to wait until he finished.

    Later that evening, Noor gathered the courage to show her project to Ahmed. She explained her research on pollution and how it affected their village. Instead of listening carefully, Ahmed interrupted her, saying, "You should focus more on helping me in the fields. School projects won’t put food on the table."

    Noor felt crushed and disappointed. She had worked hard on her project, but her father's response made her feel unimportant. The next day, she decided to present her project to her teacher instead. Her teacher praised her efforts and encouraged her to continue learning.

    As days passed, Ahmed noticed Noor's change in behavior. She seemed less enthusiastic and more withdrawn. Concerned, he approached her and asked, "Why are you so quiet these days, Noor?"

    Noor replied, "I want to share my ideas and dreams with you, but you never listen." 

    Ahmed realized that he had been too focused on work and hadn't given Noor the attention she needed. He felt guilty for not supporting her passions. Determined to change, Ahmed promised to spend more quality time with her.

    They began to explore the village together, discussing various topics, including nature and the importance of protecting it. Ahmed learned to appreciate Noor's interests and dreams, and Noor felt more connected to her father.

    Over time, their bond grew stronger. Ahmed understood that being a good parent was not just about providing for his child but also about being present and supportive in their lives. Noor flourished with her father’s newfound support, and they both learned the value of communication and understanding.
    ''',
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What was Ahmed's profession?",
        options: [
          "A teacher",
          "A doctor",
          "A farmer",
          "A merchant"
        ],
        correctAnswer: "A farmer",
        hint: "He spent most of his time in the fields.",
      ),
      ReadingQuestion(
        questionText: "2. What project did Noor want to share with her father?",
        options: [
          "A science project",
          "A drawing",
          "A project about the environment",
          "A math assignment"
        ],
        correctAnswer: "A project about the environment",
        hint: "She researched pollution and its effects.",
      ),
      ReadingQuestion(
        questionText: "3. How did Ahmed react to Noor's project?",
        options: [
          "He was proud of her",
          "He ignored it",
          "He praised her work",
          "He wanted her to help him instead"
        ],
        correctAnswer: "He wanted her to help him instead",
        hint: "He thought she should focus on helping him.",
      ),
      ReadingQuestion(
        questionText: "4. What did Noor decide to do after her father's reaction?",
        options: [
          "She stopped studying",
          "She presented her project to her teacher",
          "She helped her father in the fields",
          "She ignored her project"
        ],
        correctAnswer: "She presented her project to her teacher",
        hint: "She wanted someone to appreciate her work.",
      ),
      ReadingQuestion(
        questionText: "5. What lesson did Ahmed learn?",
        options: [
          "To work harder in the fields",
          "To listen and support his daughter",
          "To focus only on finances",
          "To avoid school projects"
        ],
        correctAnswer: "To listen and support his daughter",
        hint: "He realized the importance of being present.",
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

