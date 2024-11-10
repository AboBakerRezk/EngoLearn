import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage6 extends StatefulWidget {
  @override
  _ReadingAssessmentPage6State createState() => _ReadingAssessmentPage6State();
}

class _ReadingAssessmentPage6State extends State<ReadingAssessmentPage6>     with SingleTickerProviderStateMixin {
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
    Ali loves playing football with his friends after school. One day, he scored the winning goal in an important match. His team was very proud of him, and everyone cheered. After the game, his coach told him that he had a lot of talent and could become a great player in the future if he keeps practicing.
    ''',
    '''
    Sara enjoys painting in her free time. She has a special art room at home where she keeps her brushes, colors, and canvas. Last week, she painted a beautiful picture of a sunset over the mountains. Her family loved it and decided to hang it in the living room.
    ''',
    '''
    Ahmed likes to read adventure books. His favorite book is about a brave knight who goes on a journey to find a lost treasure. One evening, Ahmed was so interested in the book that he didn't realize how late it was. He finished reading the last chapter just before going to bed.
    '''
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What sport does Ali like to play?",
        options: ["Basketball", "Tennis", "Football", "Swimming"],
        correctAnswer: "Football",
        hint: "He plays it with his friends after school.",
      ),
      ReadingQuestion(
        questionText: "2. What did Ali do in the important match?",
        options: ["Missed a goal", "Scored the winning goal", "Was the goalkeeper", "Got injured"],
        correctAnswer: "Scored the winning goal",
        hint: "His team was very proud of him.",
      ),
      ReadingQuestion(
        questionText: "3. What did Ali's coach tell him?",
        options: ["That he needs more practice", "That he has a lot of talent", "That he should stop playing", "That he was not good"],
        correctAnswer: "That he has a lot of talent",
        hint: "His coach was impressed by his performance.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What does Sara like to do in her free time?",
        options: ["Read books", "Paint", "Play sports", "Cook"],
        correctAnswer: "Paint",
        hint: "She enjoys creating art.",
      ),
      ReadingQuestion(
        questionText: "2. What did Sara paint last week?",
        options: ["A beach", "A sunset over the mountains", "A forest", "A river"],
        correctAnswer: "A sunset over the mountains",
        hint: "Her family loved the picture and hung it in the living room.",
      ),
      ReadingQuestion(
        questionText: "3. Where did Sara's family hang her painting?",
        options: ["In her room", "In the living room", "In the kitchen", "In the hallway"],
        correctAnswer: "In the living room",
        hint: "They wanted to display it for everyone to see.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What kind of books does Ahmed like to read?",
        options: ["Adventure books", "Science fiction books", "Mystery books", "History books"],
        correctAnswer: "Adventure books",
        hint: "His favorite book is about a knight's journey.",
      ),
      ReadingQuestion(
        questionText: "2. What is Ahmed's favorite book about?",
        options: ["A wizard", "A knight", "A pirate", "A detective"],
        correctAnswer: "A knight",
        hint: "The knight is brave and goes on a journey to find treasure.",
      ),
      ReadingQuestion(
        questionText: "3. What happened while Ahmed was reading?",
        options: ["He fell asleep", "He lost the book", "He didn't realize how late it was", "He forgot to finish his homework"],
        correctAnswer: "He didn't realize how late it was",
        hint: "He was so interested in the book.",
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

