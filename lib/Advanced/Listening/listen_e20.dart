import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnologyArticleQuizPage20 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage20State createState() => _TechnologyArticleQuizPage20State();
}

class _TechnologyArticleQuizPage20State extends State<TechnologyArticleQuizPage20> with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  double _speechRate = 1.0;  // Speech rate control
  List<TextEditingController> _answerControllers = [];
  String _article =
      "In a small village in Lebanon, there lived an elderly woman named Fatima. She was known for her warmth and hospitality, welcoming everyone into her home. "
      "Fatima loved to cook and often prepared large meals for her family and friends, using recipes that had been passed down through generations. "
      "One summer, her granddaughter, Sara, visited from the city. Sara was fascinated by the stories her grandmother told about the village and the traditions that had been preserved over time. "
      "One day, Fatima invited Sara to join her in the kitchen to prepare a special meal for the family. Together, they made two traditional dishes: tabbouleh and kibbeh. "
      "As they chopped vegetables and prepared the ingredients, Fatima explained that tabbouleh symbolized freshness and community. It was a dish that brought people together, and it reminded everyone of the importance of sharing. "
      "Kibbeh, on the other hand, was a labor-intensive dish that required patience and skill, much like life itself. Fatima told Sara that making kibbeh was a way to connect with their ancestors, who had passed down the recipe through the generations. "
      "That evening, as the family gathered for dinner, Fatima greeted them with open arms. Sara realized how important it was to maintain these traditions and keep the spirit of hospitality alive. "
      "Through this experience, Sara learned that food was not just about nourishment, but also about love, connection, and the bonds that hold a family together. She vowed to carry on her grandmother’s traditions, ensuring that future generations would also know the joy of gathering around the table for a meal made with love.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What was Fatima known for?",
      "options": ["Her gardening skills", "Her hospitality", "Her storytelling", "Her painting"],
      "answer": "Her hospitality"
    },
    {
      "question": "Which two dishes did Fatima and Sara cook together?",
      "options": ["Hummus and falafel", "Tabbouleh and kibbeh", "Mansaf and maklouba", "Baklava and qatayef"],
      "answer": "Tabbouleh and kibbeh"
    },
    {
      "question": "What does tabbouleh symbolize according to Fatima?",
      "options": ["Love", "Freshness and community", "Wealth", "Health"],
      "answer": "Freshness and community"
    },
    {
      "question": "How did Fatima greet her guests at dinner?",
      "options": ["With a speech", "With open arms", "With silence", "With a song"],
      "answer": "With open arms"
    },
    {
      "question": "What lesson did Sara learn from her grandmother?",
      "options": ["The importance of studying", "The value of friendship", "The essence of hospitality", "The joy of traveling"],
      "answer": "The essence of hospitality"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "What role does food play in Fatima's culture?"},
    {"question": "How did Sara feel while cooking with her grandmother?"},
    {"question": "Why is hospitality important in Arab culture?"},
    {"question": "What traditions did Sara vow to continue?"},
    {"question": "How can sharing a meal strengthen community bonds?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];
  List<String> _correctWrittenAnswers = [
    "Food plays a significant role in bringing people together.",
    "Sara felt joy and connection to her grandmother.",
    "Hospitality is a core value in Arab culture, emphasizing generosity and warmth.",
    "Sara vowed to continue the traditions of hospitality and cooking.",
    "Sharing a meal strengthens community bonds by fostering connection and unity."
  ];



  // Animation Controller
  late AnimationController _controller;
  late Animation<double> _animation;

  // Progress Levels
  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int speakingProgressLevel = 0;
  int bottleFillLevel = 0;
  double listeningPoints = 0.0;

  @override
  void initState() {
    super.initState();
    loadSavedProgressData();
    initializeControllers();
    initializeTts();
    initializeAnimation();
  }

  @override
  void dispose() {
    _answerControllers.forEach((controller) => controller.dispose());
    _controller.dispose();
    flutterTts.stop();
    super.dispose();
  }

  void initializeControllers() {
    _selectedMultipleChoiceAnswers =
        List.filled(_multipleChoiceQuestions.length, "");
    _answerControllers = List.generate(
        _writtenQuestions.length, (_) => TextEditingController());
  }

  void initializeTts() {
    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });
  }

  void initializeAnimation() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  // Load saved data
  Future<void> loadSavedProgressData() async {
    SharedPreferences sharedPreferencesInstance =
    await SharedPreferences.getInstance();
    setState(() {
      listeningProgressLevel =
          sharedPreferencesInstance.getInt('progressListening') ?? 0;
      bottleFillLevel = sharedPreferencesInstance.getInt('bottleFillLevel') ?? 0;
      listeningPoints = sharedPreferencesInstance.getDouble('listeningPoints') ?? 0.0;

    });
  }

  // Save data
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences sharedPreferencesInstance =
    await SharedPreferences.getInstance();
    await sharedPreferencesInstance.setInt(
        'progressListening', listeningProgressLevel);
    await sharedPreferencesInstance.setInt('bottleFillLevel', bottleFillLevel);
    await sharedPreferencesInstance.setDouble('listeningPoints', listeningPoints);

  }


  // TTS Functions
  Future<void> _speakArticle() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(_speechRate);
    setState(() {
      isPlaying = true;
    });
    await flutterTts.speak(_article);
  }

  // Answer Checking
  void _checkMultipleChoiceAnswer(int index, String selectedOption) {
    setState(() {
      _selectedMultipleChoiceAnswers[index] = selectedOption;
    });
  }

  void _updateSpeechRate(double rate) {
    setState(() {
      _speechRate = rate;
    });
  }

  // Results Calculation
  int _calculateCorrectMCQAnswers() {
    int correctCount = 0;
    for (int i = 0; i < _multipleChoiceQuestions.length; i++) {
      if (_selectedMultipleChoiceAnswers[i] ==
          _multipleChoiceQuestions[i]["answer"]) {
        correctCount++;
      }
    }
    return correctCount;
  }

  int _calculateCorrectWrittenAnswers() {
    int correctCount = 0;
    for (int i = 0; i < _writtenQuestions.length; i++) {
      String userAnswer = _answerControllers[i].text.trim().toLowerCase();
      String correctAnswer = _correctWrittenAnswers[i].trim().toLowerCase();
      if (userAnswer == correctAnswer) {
        correctCount++;
      }
    }
    return correctCount;
  }

  void _showResults() {
    int correctMCQ = _calculateCorrectMCQAnswers();
    int correctWritten = _calculateCorrectWrittenAnswers();
    int totalCorrect = correctMCQ + correctWritten;
    int totalQuestions =
        _multipleChoiceQuestions.length + _writtenQuestions.length;

    _updateProgressLevels(totalCorrect);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Quiz Results'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Multiple Choice Results:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "You answered $correctMCQ out of ${_multipleChoiceQuestions.length} questions correctly!"),
                SizedBox(height: 10),
                Text(
                  "Written Questions Results:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "You answered $correctWritten out of ${_writtenQuestions.length} written questions correctly!"),
                SizedBox(height: 10),
                Text(
                  "Total Correct Answers: $totalCorrect out of $totalQuestions",
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Retry'),
              onPressed: _retryQuiz,
            ),
          ],
        );
      },
    );
  }

  void _updateProgressLevels(int totalCorrect) {
    setState(() {
      listeningProgressLevel += totalCorrect * 5;
      if (listeningProgressLevel > 500) listeningProgressLevel = 500;
      // تحديث مستوى الاستماع
      listeningPoints += (totalCorrect * 0.5).toInt();
      if (listeningPoints > 500) listeningPoints = 500;
      bottleFillLevel += totalCorrect;
      if (bottleFillLevel > 6000) bottleFillLevel = 6000;
    });
    saveProgressDataToPreferences();
  }

  void _retryQuiz() {
    Navigator.of(context).pop();
    setState(() {
      _selectedMultipleChoiceAnswers =
          List.filled(_multipleChoiceQuestions.length, "");
      _answerControllers.forEach((controller) => controller.clear());
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFF13194E);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, primaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TTS Controls and Slider
            _buildTtsControls(primaryColor),
            _buildSpeechRateSlider(),
            SizedBox(height: 20),
            Expanded(child: _buildQuizContent(primaryColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildTtsControls(Color primaryColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTtsControlButton('Play', isPlaying ? null : _speakArticle, primaryColor),
        _buildTtsControlButton('Pause', isPlaying ? flutterTts.pause : null, primaryColor),
        _buildTtsControlButton('Stop', isPlaying ? flutterTts.stop : null, primaryColor),
      ],
    );
  }

  Widget _buildTtsControlButton(String label, VoidCallback? onPressed, Color color) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildSpeechRateSlider() {
    return Slider(
      value: _speechRate,
      onChanged: _updateSpeechRate,
      min: 0.5,
      max: 1.5,
      divisions: 10,
      label: _speechRate.toStringAsFixed(1),
    );
  }

  Widget _buildQuizContent(Color primaryColor) {
    return ListView(
      children: [
        _buildSectionTitle('Test Your Knowledge:'),
        _buildMultipleChoiceQuestions(),
        _buildSectionTitle('Written Questions:'),
        _buildWrittenQuestions(primaryColor),
        SizedBox(height: 20),
        _buildShowResultsButton(primaryColor),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style:
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _buildMultipleChoiceQuestions() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _multipleChoiceQuestions.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _multipleChoiceQuestions[index]["question"],
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            ...(_multipleChoiceQuestions[index]["options"] as List<String>)
                .map((option) {
              return RadioListTile<String>(
                title: Text(option, style: TextStyle(color: Colors.white)),
                value: option,
                groupValue: _selectedMultipleChoiceAnswers[index],
                onChanged: (value) => _checkMultipleChoiceAnswer(index, value!),
              );
            }).toList(),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _buildWrittenQuestions(Color primaryColor) {
    return Column(
      children: List.generate(_writtenQuestions.length, (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_writtenQuestions[index]["question"]!,
                style: TextStyle(color: Colors.white)),
            TextField(
              controller: _answerControllers[index],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Write your answer here',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
          ],
        );
      }),
    );
  }

  Widget _buildShowResultsButton(Color primaryColor) {
    return ElevatedButton(
      onPressed: _showResults,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text('Show Results', style: TextStyle(color: Colors.white)),
    );
  }
}
