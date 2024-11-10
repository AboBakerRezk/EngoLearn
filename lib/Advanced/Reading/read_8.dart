import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage8 extends StatefulWidget {
  @override
  _ReadingAssessmentPage8State createState() => _ReadingAssessmentPage8State();
}

class _ReadingAssessmentPage8State extends State<ReadingAssessmentPage8>    with SingleTickerProviderStateMixin {
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
    In a small town, there was a boy named Sam. He loved playing football with his friends every evening. One day, they found a new ball in the park. They played until sunset and had a lot of fun. Sam was very happy because he spent a great time with his friends.
    ''',
    '''
    Mary had a cat named Whiskers. Every morning, Whiskers would follow Mary to the bus stop. One day, Mary forgot her lunch at home. Whiskers returned and brought it to her just in time! Mary was very surprised and grateful to her clever cat.
    ''',
    '''
    Ahmad loved reading books. He would visit the library every Saturday. One day, he found a book about space. The book had pictures of planets and stars. Ahmad spent hours reading and dreamed of becoming an astronaut one day. He felt excited about the possibilities.
    ''',
    '''
    Fatima loved nature. Every season, she would go out to explore the changes. In spring, she saw flowers bloom. In summer, she enjoyed picnics with her family. In autumn, she collected colorful leaves. In winter, she built snowmen. Fatima appreciated the beauty of each season.
    '''
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What did Sam love to play?",
        options: ["Basketball", "Football", "Tennis", "Cricket"],
        correctAnswer: "Football",
        hint: "He played with his friends.",
      ),
      ReadingQuestion(
        questionText: "2. Where did Sam find the new ball?",
        options: ["At home", "In the park", "At school", "In the store"],
        correctAnswer: "In the park",
        hint: "They found it while playing.",
      ),
      ReadingQuestion(
        questionText: "3. How did Sam feel after playing?",
        options: ["Sad", "Happy", "Tired", "Angry"],
        correctAnswer: "Happy",
        hint: "He spent a great time.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What was the name of Mary's cat?",
        options: ["Fluffy", "Whiskers", "Tommy", "Bella"],
        correctAnswer: "Whiskers",
        hint: "It's mentioned in the story.",
      ),
      ReadingQuestion(
        questionText: "2. What did Mary forget at home?",
        options: ["Her backpack", "Her lunch", "Her book", "Her shoes"],
        correctAnswer: "Her lunch",
        hint: "She needed it at the bus stop.",
      ),
      ReadingQuestion(
        questionText: "3. How did Mary feel about Whiskers?",
        options: ["Surprised", "Angry", "Bored", "Scared"],
        correctAnswer: "Surprised",
        hint: "Whiskers brought her lunch.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What did Ahmad love?",
        options: ["Sports", "Video games", "Reading books", "Cooking"],
        correctAnswer: "Reading books",
        hint: "He visited the library.",
      ),
      ReadingQuestion(
        questionText: "2. What book did Ahmad find?",
        options: ["A storybook", "A science book", "A book about space", "A comic book"],
        correctAnswer: "A book about space",
        hint: "It had pictures of planets.",
      ),
      ReadingQuestion(
        questionText: "3. What did Ahmad dream of becoming?",
        options: ["A teacher", "A doctor", "An astronaut", "A pilot"],
        correctAnswer: "An astronaut",
        hint: "He was excited about space.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What did Fatima love?",
        options: ["Animals", "Nature", "Art", "Sports"],
        correctAnswer: "Nature",
        hint: "She explored the changes.",
      ),
      ReadingQuestion(
        questionText: "2. What did she collect in autumn?",
        options: ["Flowers", "Shells", "Colorful leaves", "Stones"],
        correctAnswer: "Colorful leaves",
        hint: "She appreciated the seasons.",
      ),
      ReadingQuestion(
        questionText: "3. What did Fatima do in winter?",
        options: ["Went swimming", "Built snowmen", "Picked flowers", "Hiked mountains"],
        correctAnswer: "Built snowmen",
        hint: "It was a winter activity.",
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
