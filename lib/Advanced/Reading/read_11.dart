import 'package:flutter/material.dart';


//S
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage11 extends StatefulWidget {
  @override
  _ReadingAssessmentPage11State createState() => _ReadingAssessmentPage11State();
}

class _ReadingAssessmentPage11State extends State<ReadingAssessmentPage11>
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
    John is a teacher. He teaches English to beginners. Every day, he helps his students learn new words. John uses pictures and simple sentences. His students love learning with him because he makes learning fun. One day, John gave his class a new word: "Apple." He showed them a picture of an apple and said, "This is an apple." The students repeated after him. By the end of the lesson, everyone knew the word "apple" and could use it in a sentence!
    ''',
    '''
    Sarah is learning English. She started at the beginner level. At first, Sarah found it hard to understand the words. But her teacher, Mr. John, helped her every day. He used simple examples, like showing her an apple and saying, "This is an apple." Slowly, Sarah started to understand. Now, she can say many English words, and she is happy with her progress.
    ''',
    '''
    Ahmed is a student in John's class. One day, John taught him the word "book." He showed a book to the class and said, "This is a book." Ahmed practiced saying the word many times. Later, when Ahmed went home, he showed his family a book and said, "This is a book!" His family was proud of him. Ahmed was happy because he could say the word correctly.
    '''
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What does John teach?",
        options: ["Math", "Science", "English", "History"],
        correctAnswer: "English",
        hint: "John is a teacher of a language.",
      ),
      ReadingQuestion(
        questionText: "2. What word did John teach his class?",
        options: ["Banana", "Apple", "Car", "Dog"],
        correctAnswer: "Apple",
        hint: "John showed a picture of a fruit.",
      ),
      ReadingQuestion(
        questionText: "3. How did the students feel about learning with John?",
        options: ["Bored", "Happy", "Confused", "Angry"],
        correctAnswer: "Happy",
        hint: "The students enjoyed learning with John.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What level is Sarah learning?",
        options: ["Advanced", "Intermediate", "Beginner", "Expert"],
        correctAnswer: "Beginner",
        hint: "Sarah is just starting to learn English.",
      ),
      ReadingQuestion(
        questionText: "2. Who is Sarah's teacher?",
        options: ["Mr. John", "Ms. Anna", "Mr. David", "Mrs. Lucy"],
        correctAnswer: "Mr. John",
        hint: "Her teacher helped her every day.",
      ),
      ReadingQuestion(
        questionText: "3. What did Sarah learn about in the lesson?",
        options: ["A car", "A book", "A cat", "An apple"],
        correctAnswer: "An apple",
        hint: "Her teacher used a simple example with a fruit.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What word did Ahmed learn?",
        options: ["Dog", "Car", "Book", "Apple"],
        correctAnswer: "Book",
        hint: "John showed the class an object to read.",
      ),
      ReadingQuestion(
        questionText: "2. How did Ahmed's family feel when he said the word?",
        options: ["Angry", "Proud", "Sad", "Surprised"],
        correctAnswer: "Proud",
        hint: "Ahmed's family was happy with his progress.",
      ),
      ReadingQuestion(
        questionText: "3. How did Ahmed practice the word?",
        options: ["In the park", "At school", "At home", "In the store"],
        correctAnswer: "At home",
        hint: "Ahmed practiced after school with his family.",
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

