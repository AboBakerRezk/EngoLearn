import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


//S
class ReadingAssessmentPage3 extends StatefulWidget {
  @override
  _ReadingAssessmentPage3State createState() => _ReadingAssessmentPage3State();
}

class _ReadingAssessmentPage3State extends State<ReadingAssessmentPage3>     with SingleTickerProviderStateMixin {
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
    Omar loves to play football. Every afternoon, he goes to the park with his friends to play. One day, Omar kicked the ball too hard, and it went over the fence. He was worried he couldn’t get it back. Luckily, a kind man passing by helped Omar get the ball. Omar thanked the man and continued playing with his friends, being more careful this time.
    ''',
    '''
    Maya enjoys drawing animals. She has a big notebook where she draws all her favorite animals, like cats, dogs, and birds. One day, she saw a new animal at the zoo: a giraffe! Maya loved how tall the giraffe was, so she decided to draw it when she got home. She showed her drawing to her family, and they were very impressed.
    ''',
    '''
    Adam's family went on a picnic last weekend. They found a nice spot near a lake to sit and have lunch. Adam and his sister played with a ball while their parents prepared the food. After lunch, Adam saw some ducks swimming in the lake. He wanted to feed them, so his mother gave him some bread to throw to the ducks. Adam was happy to see the ducks eating the bread and swimming around.
    '''
  ];

  // قائمة الأسئلة لكل نص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What sport does Omar like to play?",
        options: ["Basketball", "Tennis", "Football", "Swimming"],
        correctAnswer: "Football",
        hint: "It’s a game played with a ball and a goal.",
      ),
      ReadingQuestion(
        questionText: "2. What happened to the ball?",
        options: ["It went over the fence", "It got lost", "It was broken", "It went into the tree"],
        correctAnswer: "It went over the fence",
        hint: "Omar kicked it too hard.",
      ),
      ReadingQuestion(
        questionText: "3. Who helped Omar get the ball back?",
        options: ["His friend", "A kind man", "His teacher", "His brother"],
        correctAnswer: "A kind man",
        hint: "A stranger passing by helped him.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. What does Maya like to draw?",
        options: ["Flowers", "Animals", "Houses", "Cars"],
        correctAnswer: "Animals",
        hint: "She has a notebook full of them.",
      ),
      ReadingQuestion(
        questionText: "2. Where did Maya see the giraffe?",
        options: ["At the park", "At school", "At the zoo", "At the museum"],
        correctAnswer: "At the zoo",
        hint: "She saw the animal in a place with many animals.",
      ),
      ReadingQuestion(
        questionText: "3. What did Maya’s family think of her drawing?",
        options: ["They were impressed", "They didn't like it", "They were confused", "They laughed"],
        correctAnswer: "They were impressed",
        hint: "Her family liked her drawing a lot.",
      ),
    ],
    [
      ReadingQuestion(
        questionText: "1. Where did Adam's family go for a picnic?",
        options: ["To the beach", "To the forest", "Near a lake", "In the mountains"],
        correctAnswer: "Near a lake",
        hint: "They sat near water.",
      ),
      ReadingQuestion(
        questionText: "2. What did Adam see in the lake?",
        options: ["Fish", "Ducks", "Frogs", "Boats"],
        correctAnswer: "Ducks",
        hint: "It’s an animal that swims in the water and quacks.",
      ),
      ReadingQuestion(
        questionText: "3. What did Adam feed the ducks?",
        options: ["Cookies", "Fruits", "Bread", "Rice"],
        correctAnswer: "Bread",
        hint: "His mother gave him this food to throw to the ducks.",
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

