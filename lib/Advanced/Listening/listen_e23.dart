import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnologyArticleQuizPage23 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage23State createState() => _TechnologyArticleQuizPage23State();
}

class _TechnologyArticleQuizPage23State extends State<TechnologyArticleQuizPage23> with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  double _speechRate = 1.0;
  List<TextEditingController> _answerControllers = [];
  String _article =
      "In a small village in the heart of Morocco, a talented calligrapher named Hassan dedicated his life to mastering the art of Arabic calligraphy. "
      "His work was admired by many in the village, but he never ventured beyond the borders of his hometown to share his art with the world. "
      "One day, a traveler named Amina, who had a deep appreciation for art, visited the village. "
      "She was immediately captivated by Hassan's work and saw great potential in it. Amina encouraged Hassan to showcase his art in a larger city, suggesting Marrakech as the ideal place for an exhibition. "
      "At first, Hassan was hesitant. He feared that his traditional style might not be appreciated in a world that seemed to favor more modern, abstract forms. "
      "But Amina’s enthusiasm and confidence in his talent gave him the courage to take the leap. "
      "Together, they organized an exhibition in Marrakech where Hassan's work was displayed alongside other contemporary artists. "
      "Hassan decided to blend traditional and modern styles for the exhibition, creating pieces that honored his cultural heritage while also introducing new elements. "
      "The exhibition was a huge success. Hassan’s unique blend of old and new resonated with the audience, and he sold several pieces. "
      "His work was not only appreciated but also recognized as a beautiful representation of Morocco’s artistic history. "
      "Through this experience, Hassan realized the importance of preserving and sharing his cultural heritage, while also embracing change and innovation. "
      "He returned to his village, not just as a respected artist, but as a symbol of how blending tradition with modernity could create something truly exceptional.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What is Hassan known for?",
      "options": ["Painting", "Sculpting", "Calligraphy", "Photography"],
      "answer": "Calligraphy"
    },
    {
      "question": "Who is Amina?",
      "options": ["A traveler and art enthusiast", "A local artist", "Hassan's sister", "A gallery owner"],
      "answer": "A traveler and art enthusiast"
    },
    {
      "question": "Where did Hassan showcase his art?",
      "options": ["Casablanca", "Marrakech", "Rabat", "Fez"],
      "answer": "Marrakech"
    },
    {
      "question": "What did Hassan blend in his new pieces for the exhibition?",
      "options": ["Traditional and modern styles", "Nature and abstract art", "Photography and sculpture", "Music and poetry"],
      "answer": "Traditional and modern styles"
    },
    {
      "question": "What was the outcome of the exhibition for Hassan?",
      "options": ["He decided to stop painting", "He received recognition and sold several pieces", "He moved to another village", "He gave up on art"],
      "answer": "He received recognition and sold several pieces"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "How did Hassan feel about sharing his art before the exhibition?"},
    {"question": "What role did Amina play in Hassan's journey?"},
    {"question": "What does the story say about the importance of cultural heritage?"},
    {"question": "How did the exhibition impact the appreciation of Arabic calligraphy?"},
    {"question": "What message do you think Hassan's success conveys to aspiring artists?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];
  List<String> _correctWrittenAnswers = [
    "He was nervous and unsure about sharing his art with a larger audience.",
    "Amina encouraged and helped Hassan to organize his exhibition.",
    "Cultural heritage is important because it preserves history and connects people through art.",
    "The exhibition sparked a newfound appreciation for Arabic calligraphy.",
    "Hassan’s success shows that embracing one’s heritage can lead to global recognition."
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

  // Initialize Controllers
  void initializeControllers() {
    _selectedMultipleChoiceAnswers = List.filled(_multipleChoiceQuestions.length, "");
    _writtenAnswers = List.filled(_writtenQuestions.length, "");
    _answerControllers = List.generate(_writtenQuestions.length, (_) => TextEditingController());
  }

  // Initialize Text-to-Speech
  void initializeTts() {
    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });
  }

  // Initialize Animation
  void initializeAnimation() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
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


  // Text-to-Speech Functions
  Future<void> _speakArticle() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(_speechRate);
    setState(() {
      isPlaying = true;
    });
    await flutterTts.speak(_article);
  }

  Future<void> _stopSpeaking() async {
    await flutterTts.stop();
    setState(() {
      isPlaying = false;
    });
  }

  Future<void> _pauseSpeaking() async {
    await flutterTts.pause();
    setState(() {
      isPlaying = false;
    });
  }

  // Answer Checking Functions
  void _checkMultipleChoiceAnswer(int index, String selectedOption) {
    setState(() {
      _selectedMultipleChoiceAnswers[index] = selectedOption;
    });
  }

  void _checkWrittenAnswer(int index) {
    setState(() {
      _writtenAnswers[index] = _answerControllers[index].text;
      // Optionally, clear the text field after submission
      // _answerControllers[index].clear();
    });
  }

  // Speech Rate Control
  void _changeSpeechRate(double rate) {
    setState(() {
      _speechRate = rate;
    });
  }

  // Results Calculation
  int _calculateCorrectMCQAnswers() {
    int correctCount = 0;
    for (int i = 0; i < _multipleChoiceQuestions.length; i++) {
      if (_selectedMultipleChoiceAnswers[i] == _multipleChoiceQuestions[i]["answer"]) {
        correctCount++;
      }
    }
    return correctCount;
  }

  int _calculateCorrectWrittenAnswers() {
    int correctCount = 0;
    for (int i = 0; i < _writtenQuestions.length; i++) {
      String userAnswer = _writtenAnswers[i].trim().toLowerCase();
      String correctAnswer = _correctWrittenAnswers[i].trim().toLowerCase();
      if (userAnswer == correctAnswer) {
        correctCount++;
      }
    }
    return correctCount;
  }

  // Show Results Dialog
  void _showResults() {
    int correctMCQ = _calculateCorrectMCQAnswers();
    int correctWritten = _calculateCorrectWrittenAnswers();
    int totalCorrect = correctMCQ + correctWritten;
    int totalQuestions = _multipleChoiceQuestions.length + _writtenQuestions.length;

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
                // Multiple Choice Results
                Text(
                  "Multiple Choice Results:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("You answered $correctMCQ out of ${_multipleChoiceQuestions.length} questions correctly!"),
                SizedBox(height: 10),
                ..._buildMCQResults(),
                SizedBox(height: 20),
                // Written Questions Results
                Text(
                  "Written Questions Results:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("You answered $correctWritten out of ${_writtenQuestions.length} written questions correctly!"),
                SizedBox(height: 10),
                ..._buildWrittenResults(),
                SizedBox(height: 20),
                // Total Correct
                Text("Total Correct Answers: $totalCorrect out of $totalQuestions"),
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

  // Build Multiple Choice Results Widgets
  List<Widget> _buildMCQResults() {
    List<Widget> mcqResults = [];
    for (int i = 0; i < _multipleChoiceQuestions.length; i++) {
      String userAnswer = _selectedMultipleChoiceAnswers[i];
      String correctAnswer = _multipleChoiceQuestions[i]["answer"];

      mcqResults.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${i + 1}: ${_multipleChoiceQuestions[i]["question"]}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "Your answer: ${userAnswer.isNotEmpty ? userAnswer : 'No answer'}",
              style: TextStyle(
                color: userAnswer == correctAnswer ? Colors.green : Colors.red,
              ),
            ),
            Text(
              "Correct answer: $correctAnswer",
              style: TextStyle(color: Colors.green),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }
    return mcqResults;
  }

  // Build Written Questions Results Widgets
  List<Widget> _buildWrittenResults() {
    List<Widget> writtenResults = [];
    for (int i = 0; i < _writtenQuestions.length; i++) {
      String userAnswer = _writtenAnswers[i];
      String correctAnswer = _correctWrittenAnswers[i];

      bool isCorrect = userAnswer.trim().toLowerCase() == correctAnswer.trim().toLowerCase();

      writtenResults.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${i + 1}: ${_writtenQuestions[i]["question"]}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "Your answer: ${userAnswer.isNotEmpty ? userAnswer : 'No answer'}",
              style: TextStyle(
                color: isCorrect ? Colors.green : Colors.red,
              ),
            ),
            Text(
              "Correct answer: $correctAnswer",
              style: TextStyle(color: Colors.green),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }
    return writtenResults;
  }

  // Update Progress Levels Based on Results
  void _updateProgressLevels(int totalCorrect) {
    setState(() {
      // Example: Increment listening progress based on correct answers
      listeningProgressLevel += totalCorrect * 5;
      if (listeningProgressLevel > 500) listeningProgressLevel = 500;
      // تحديث مستوى الاستماع
      listeningPoints += (totalCorrect * 0.5).toInt();
      if (listeningPoints > 500) listeningPoints = 500;
      // Increment bottle fill level
      bottleFillLevel += totalCorrect;
      if (bottleFillLevel > 6000) bottleFillLevel = 6000;
    });
    saveProgressDataToPreferences();
  }

  // Retry Quiz Function
  void _retryQuiz() {
    Navigator.of(context).pop();
    setState(() {
      _selectedMultipleChoiceAnswers = List.filled(_multipleChoiceQuestions.length, "");
      _writtenAnswers = List.filled(_writtenQuestions.length, "");
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
            // Quiz Content
            Expanded(child: _buildQuizContent(primaryColor)),
          ],
        ),
      ),
    );
  }

  // Build TTS Controls
  Widget _buildTtsControls(Color primaryColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTtsControlButton('Play', isPlaying ? null : _speakArticle, primaryColor),
        _buildTtsControlButton('Pause', isPlaying ? _pauseSpeaking : null, primaryColor),
        _buildTtsControlButton('Stop', isPlaying ? _stopSpeaking : null, primaryColor),
      ],
    );
  }

  // Build Individual TTS Control Button
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

  // Build Speech Rate Slider
  Widget _buildSpeechRateSlider() {
    return Slider(
      value: _speechRate,
      onChanged: _changeSpeechRate,
      min: 0.5,
      max: 1.5,
      divisions: 10,
      label: _speechRate.toStringAsFixed(1),
    );
  }

  // Build Quiz Content
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

  // Build Section Title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  // Build Multiple Choice Questions
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            ...(_multipleChoiceQuestions[index]["options"] as List<String>).map((option) {
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

  // Build Written Questions
  Widget _buildWrittenQuestions(Color primaryColor) {
    return Column(
      children: List.generate(_writtenQuestions.length, (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _writtenQuestions[index]["question"]!,
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: _answerControllers[index],
              onChanged: (_) => _checkWrittenAnswer(index),
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

  // Build Show Results Button
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
