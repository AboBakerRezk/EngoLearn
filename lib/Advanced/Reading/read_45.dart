import 'package:flutter/material.dart';


//S
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage45 extends StatefulWidget {
  @override
  _ReadingAssessmentPage45State createState() => _ReadingAssessmentPage45State();
}

class _ReadingAssessmentPage45State extends State<ReadingAssessmentPage45>
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
    In a bustling city, there lived a couple named Ahmed and Layla. They were loving parents to their two children, Sara and Omar. However, despite their good intentions, they often made mistakes in their parenting.

    One day, Ahmed was busy with work and decided to give Omar a tablet to keep him quiet while he finished his tasks. Layla, on the other hand, frequently scolded Sara for her grades without asking about her struggles in school. Instead of understanding her challenges, she focused only on the results.

    Over time, Omar became overly attached to the tablet and spent hours playing games instead of playing outside with his friends. He started neglecting his studies and lost interest in his hobbies. Meanwhile, Sara began to feel inadequate because of her mother's constant criticism. She started to doubt her abilities and lost motivation to improve.

    One evening, during dinner, Ahmed noticed that the atmosphere was tense. He asked his children about their day, but they were hesitant to share. After a moment of silence, Sara finally spoke up about how she felt overwhelmed by school and that her mother never seemed to understand. Omar then chimed in, expressing his frustration about always being given the tablet instead of spending time together as a family.

    Ahmed and Layla were taken aback. They realized that their actions, though unintentional, had a negative impact on their children's emotional well-being. They decided to make a change. Ahmed committed to spending more quality time with Omar, playing outside and engaging in activities together. Layla promised to support Sara in her studies and communicate openly with her about her feelings.

    As weeks went by, the family dynamics improved. Sara started to perform better in school, and Omar found joy in playing outside with friends. Ahmed and Layla learned that parenting is a journey that requires constant reflection, understanding, and adaptation. They vowed to be more attentive to their children's needs and to create an environment where they felt loved and supported.
    ''',
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What mistake did Ahmed make regarding Omar?",
        options: [
          "He didn't pay attention to his studies.",
          "He gave him a tablet to keep him quiet.",
          "He didn't play with him.",
          "He criticized him often."
        ],
        correctAnswer: "He gave him a tablet to keep him quiet.",
        hint: "Ahmed was busy with work.",
      ),
      ReadingQuestion(
        questionText: "2. How did Layla treat Sara's school performance?",
        options: [
          "She was supportive.",
          "She praised her.",
          "She scolded her without understanding.",
          "She ignored her."
        ],
        correctAnswer: "She scolded her without understanding.",
        hint: "Layla focused only on the grades.",
      ),
      ReadingQuestion(
        questionText: "3. What was the result of Omar's excessive tablet use?",
        options: [
          "He made more friends.",
          "He improved in school.",
          "He lost interest in his hobbies.",
          "He became more active."
        ],
        correctAnswer: "He lost interest in his hobbies.",
        hint: "He spent too much time on the tablet.",
      ),
      ReadingQuestion(
        questionText: "4. How did the children feel during dinner?",
        options: [
          "Happy and excited.",
          "Tense and hesitant to share.",
          "Bored and uninterested.",
          "Angry and frustrated."
        ],
        correctAnswer: "Tense and hesitant to share.",
        hint: "They were not eager to talk about their day.",
      ),
      ReadingQuestion(
        questionText: "5. What changes did Ahmed and Layla decide to make?",
        options: [
          "Spend less time with the children.",
          "Be more attentive and supportive.",
          "Focus only on their careers.",
          "Ignore their children's feelings."
        ],
        correctAnswer: "Be more attentive and supportive.",
        hint: "They learned from their mistakes.",
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

