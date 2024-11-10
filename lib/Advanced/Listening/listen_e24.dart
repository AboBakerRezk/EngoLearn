import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnologyArticleQuizPage24 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage24State createState() => _TechnologyArticleQuizPage24State();
}

class _TechnologyArticleQuizPage24State extends State<TechnologyArticleQuizPage24> with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  // Text-to-Speech Variables
  bool isPlaying = false;
  double _speechRate = 1.0;

  // Controllers
  late List<TextEditingController> _answerControllers;
  String _article =
      "In a small village nestled in the mountains of Lebanon, there lived a wise old man named Hassan. "
      "Hassan was known throughout the region for his deep understanding of the land, the seasons, and the ways of the earth. "
      "He had two grandsons, Samir and Rami. Samir was content with the peaceful life of the village and dreamed of becoming a farmer, like his grandfather. "
      "Rami, on the other hand, longed for adventure. He dreamed of traveling the world, seeing new places, and meeting new people. "
      "Though their dreams were different, the brothers were close and supported each other in every way. "
      "One day, Rami decided to leave the village and set out on his travels. He promised to return with stories and experiences to share with his family. "
      "Years passed, and true to his word, Rami returned, bringing with him not only stories but also spices, fabrics, and knowledge from the lands he had visited. "
      "But upon his return, the village was facing a great drought. Crops were failing, and the villagers were struggling. "
      "Hassan, now older and frailer, called upon his grandsons to work together to help save the village. "
      "Samir and Rami combined their skills — Samir with his knowledge of the land, and Rami with the new techniques and ideas he had learned from his travels. "
      "Together, they created new irrigation systems and introduced new crops that could withstand the harsh conditions. "
      "The village thrived once again, and the brothers learned the true value of collaboration. "
      "Rami's travels had expanded his mind, and Samir's connection to the land had grounded their efforts, teaching the village the importance of embracing both tradition and innovation.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What did Samir aspire to become?",
      "options": ["A traveler", "A teacher", "A farmer", "A musician"],
      "answer": "A farmer"
    },
    {
      "question": "What was Rami's dream?",
      "options": ["To stay in the village", "To become a doctor", "To travel the world", "To be a chef"],
      "answer": "To travel the world"
    },
    {
      "question": "What did Rami bring back from his travels?",
      "options": ["Books", "Stories and spices", "Musical instruments", "Clothes"],
      "answer": "Stories and spices"
    },
    {
      "question": "What challenge did the village face?",
      "options": ["A flood", "A drought", "A storm", "A fire"],
      "answer": "A drought"
    },
    {
      "question": "How did the brothers work together?",
      "options": ["They argued", "They ignored each other", "They combined their skills", "They competed against each other"],
      "answer": "They combined their skills"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "What values does the story convey about family and collaboration?"},
    {"question": "How did Samir and Rami's dreams differ and how did that affect their lives?"},
    {"question": "What lessons can we learn from the brothers' experience during the drought?"},
    {"question": "How does the story reflect the importance of cultural heritage in the village?"},
    {"question": "In what ways do you think Rami's travels influenced his perspective on life?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];
  // Correct Written Answers
  final List<String> _correctWrittenAnswers = [
    "The story conveys values of mutual support, unity, and the strength that comes from working together as a family.",
    "Samir dreamed of becoming a farmer and staying in the village, while Rami longed for adventure and traveling the world. Their differing dreams led Rami to leave the village, but ultimately their collaboration brought prosperity back to the village.",
    "The brothers' experience teaches us the importance of combining traditional knowledge with new ideas, and how collaboration can overcome significant challenges.",
    "The story highlights cultural heritage by showing Hassan's deep understanding of the land and traditions, and how preserving these can be integrated with innovation for community benefit.",
    "Rami's travels broadened his perspective, allowing him to bring new techniques and ideas back to the village, demonstrating how exposure to different cultures and practices can enhance one's own capabilities."
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

    _updateProgressLevels(correctMCQ, correctWritten);

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
  void _updateProgressLevels(int correctMCQ, int correctWritten) {
    setState(() {
      // Increment listening progress based on correct answers
      listeningProgressLevel += (correctMCQ + correctWritten) * 5;
      if (listeningProgressLevel > 500) listeningProgressLevel = 500;

      // تحديث مستوى الاستماع
      listeningPoints += (correctMCQ * 0.5).toInt();
      if (listeningPoints > 500) listeningPoints = 500;

      // Increment bottle fill level based on total correct answers
      bottleFillLevel += (correctMCQ + correctWritten);
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
      style:
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
