import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//S
class ReadingAssessmentPage4 extends StatefulWidget {
  @override
  _ReadingAssessmentPage4State createState() => _ReadingAssessmentPage4State();
}

class _ReadingAssessmentPage4State extends State<ReadingAssessmentPage4>    with SingleTickerProviderStateMixin {
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
    Sara loves to read books. Every evening, she sits by the window and reads her favorite stories. One day, her mother gave her a new book about space. Sara was excited because she had always wanted to learn about the stars and planets. As she read, she imagined flying in a spaceship and visiting different planets. It was her new favorite book!
    ''',
    '''
    Ali's school had a sports day last Friday. All the students participated in different games like running, jumping, and throwing balls. Ali was excited because he practiced a lot for the running race. When the race started, Ali ran as fast as he could. He didn't win, but he was proud of himself for trying his best.
    ''',
    '''
    Leila loves baking with her grandmother. Every weekend, they bake something new. Last weekend, they decided to make cookies. Leila mixed the ingredients while her grandmother showed her how to make the dough. After they finished baking, the cookies smelled delicious! Leila and her grandmother enjoyed eating them with some milk.
    '''
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What does Sara love to do every evening?",
        options: ["Watch TV", "Read books", "Play outside", "Draw pictures"],
        correctAnswer: "Read books",
        hint: "It’s a quiet activity she enjoys by the window.",
      ),
      ReadingQuestion(
        questionText: "2. What was the new book about?",
        options: ["Animals", "Space", "History", "Magic"],
        correctAnswer: "Space",
        hint: "The book talks about stars and planets.",
      ),
      ReadingQuestion(
        questionText: "3. How did Sara feel about the new book?",
        options: ["Bored", "Excited", "Confused", "Scared"],
        correctAnswer: "Excited",
        hint: "She was happy to learn about space.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What event took place at Ali's school?",
        options: ["A science fair", "A sports day", "A music concert", "A field trip"],
        correctAnswer: "A sports day",
        hint: "It was a day with many games and activities.",
      ),
      ReadingQuestion(
        questionText: "2. What game did Ali participate in?",
        options: ["The running race", "Jumping rope", "Throwing balls", "Swimming"],
        correctAnswer: "The running race",
        hint: "Ali ran as fast as he could.",
      ),
      ReadingQuestion(
        questionText: "3. How did Ali feel after the race?",
        options: ["Sad", "Proud", "Angry", "Tired"],
        correctAnswer: "Proud",
        hint: "He didn’t win but was happy with his effort.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What does Leila love to do with her grandmother?",
        options: ["Baking", "Painting", "Gardening", "Dancing"],
        correctAnswer: "Baking",
        hint: "They make something delicious together every weekend.",
      ),
      ReadingQuestion(
        questionText: "2. What did Leila and her grandmother bake last weekend?",
        options: ["Cakes", "Cookies", "Bread", "Pizza"],
        correctAnswer: "Cookies",
        hint: "They baked something sweet and small.",
      ),
      ReadingQuestion(
        questionText: "3. How did the cookies smell after baking?",
        options: ["Bad", "Delicious", "Strange", "Burnt"],
        correctAnswer: "Delicious",
        hint: "Leila and her grandmother enjoyed eating them.",
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

