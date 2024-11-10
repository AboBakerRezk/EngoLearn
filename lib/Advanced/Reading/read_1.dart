import 'package:flutter/material.dart';


//S
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage1 extends StatefulWidget {
  @override
  _ReadingAssessmentPage1State createState() => _ReadingAssessmentPage1State();
}

class _ReadingAssessmentPage1State extends State<ReadingAssessmentPage1>
    with SingleTickerProviderStateMixin {
  int _currentStoryIndex = 0;
  int _currentQuestionIndex = 0;
  int _score = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E);


  @override
  void initState() {
    super.initState();
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
  int readingProgressLevel = 0;
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

// Check answer and update progress
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
    Adam is learning English. His teacher gave him a simple sentence: "The cat is on the chair." Adam repeated the sentence many times. He practiced reading it at home. The next day, Adam told his teacher that he could now say the sentence without looking at the paper. His teacher was very proud of him and told him to keep practicing every day.
    ''',
    '''
    Emily loves to draw. One day, her teacher asked the class to draw an animal and write its name in English. Emily drew a dog and wrote "dog" next to her drawing. Her teacher smiled and said, "Well done, Emily!" Emily was happy because she loves drawing and learning new words in English.
    ''',
    '''
    Mark has a new friend named Sam. Sam speaks English very well. Mark wants to learn English like Sam. Every day, Sam teaches Mark a new word. Today, Sam taught Mark the word "car." Mark practiced saying "car" all day. Now, Mark can say many words in English, and he is very happy to have Sam as his friend.
    '''
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What sentence did Adam learn?",
        options: ["The dog is on the chair.", "The cat is on the chair.", "The bird is on the tree.", "The fish is in the water."],
        correctAnswer: "The cat is on the chair.",
        hint: "Adam repeated a sentence about a cat and a chair.",
      ),
      ReadingQuestion(
        questionText: "2. What did Adam's teacher feel after Adam's practice?",
        options: ["Angry", "Sad", "Proud", "Surprised"],
        correctAnswer: "Proud",
        hint: "The teacher was happy with Adam's progress.",
      ),
      ReadingQuestion(
        questionText: "3. What did Adam do at home?",
        options: ["Played games", "Watched TV", "Practiced reading the sentence", "Slept"],
        correctAnswer: "Practiced reading the sentence",
        hint: "Adam practiced the sentence his teacher gave him.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What does Emily love to do?",
        options: ["Play soccer", "Sing songs", "Draw", "Read books"],
        correctAnswer: "Draw",
        hint: "Emily loves a creative activity.",
      ),
      ReadingQuestion(
        questionText: "2. What animal did Emily draw?",
        options: ["Cat", "Dog", "Bird", "Fish"],
        correctAnswer: "Dog",
        hint: "Emily drew an animal that barks.",
      ),
      ReadingQuestion(
        questionText: "3. What did the teacher say to Emily?",
        options: ["Try again", "Well done", "Be quiet", "Go outside"],
        correctAnswer: "Well done",
        hint: "The teacher was happy with Emily's drawing.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. Who is Mark's new friend?",
        options: ["John", "Sam", "David", "Tom"],
        correctAnswer: "Sam",
        hint: "Mark's friend is very good at English.",
      ),
      ReadingQuestion(
        questionText: "2. What word did Sam teach Mark today?",
        options: ["House", "Car", "Dog", "Book"],
        correctAnswer: "Car",
        hint: "Sam taught a word for something people drive.",
      ),
      ReadingQuestion(
        questionText: "3. How does Mark feel about learning English?",
        options: ["Angry", "Excited", "Bored", "Tired"],
        correctAnswer: "Excited",
        hint: "Mark is happy to learn new words every day.",
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

