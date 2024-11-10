import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnologyArticleQuizPage25 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage25State createState() => _TechnologyArticleQuizPage25State();
}

class _TechnologyArticleQuizPage25State extends State<TechnologyArticleQuizPage25> with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  double _speechRate = 1.0;
  List<TextEditingController> _answerControllers = [];
  String _article =
      "In a vibrant market in Cairo, there lived a talented artisan named Layla. Known for her exquisite pottery, her work reflected the traditions and history of her ancestors. "
      "One day, a wealthy merchant approached her with a proposition. He admired her craftsmanship and wanted to commission her for a large project. Layla, however, hesitated. "
      "She had always followed her own creative instincts, rather than catering to the demands of others. Layla's grandmother, a wise woman, advised her to trust her instincts and stay true to herself. "
      "Inspired by her grandmother's words, Layla decided to take on the project, but with a twist—she would blend her traditional techniques with her own unique, modern style."
      "At the exhibition, her pottery stood out, not just because of its beauty, but because it was a true reflection of her identity. The merchant, Tariq, was impressed, and so were the crowds. "
      "Tariq learned a valuable lesson that day: true art comes from authenticity, and supporting such creativity was far more important than imposing his own ideas. Layla's pottery became a symbol of cultural pride, blending the past with the future, and she continued to thrive as an artisan."
      "Her story serves as a reminder that creativity, when grounded in personal truth, has the power to inspire and transform the world.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What was Layla known for?",
      "options": ["Jewelry making", "Pottery", "Weaving", "Painting"],
      "answer": "Pottery"
    },
    {
      "question": "Who approached Layla with a proposal?",
      "options": ["A fellow artisan", "A wealthy merchant", "A friend", "A customer"],
      "answer": "A wealthy merchant"
    },
    {
      "question": "What did Layla's grandmother advise her?",
      "options": ["To change her style", "To trust her instincts", "To follow trends", "To sell her work"],
      "answer": "To trust her instincts"
    },
    {
      "question": "What did Layla's pottery reflect?",
      "options": ["Modern trends", "Her identity", "Famous artists", "Nature only"],
      "answer": "Her identity"
    },
    {
      "question": "What lesson did Tariq learn?",
      "options": ["To buy more art", "To support authentic creativity", "To impose his ideas", "To avoid local artisans"],
      "answer": "To support authentic creativity"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "How did Layla's background influence her artwork?"},
    {"question": "What role did Layla's grandmother play in her journey as an artist?"},
    {"question": "Discuss the importance of authenticity in art as portrayed in the story."},
    {"question": "What does the story reveal about the relationship between culture and creativity?"},
    {"question": "How did Layla's experience at the exhibition shape her future as an artisan?"}
  ];
  // Correct Written Answers
  final List<String> _correctWrittenAnswers = [
    "The story conveys values of mutual support, unity, and the strength that comes from working together as a family.",
    "Samir dreamed of becoming a farmer and staying in the village, while Rami longed for adventure and traveling the world. Their differing dreams led Rami to leave the village, but ultimately their collaboration brought prosperity back to the village.",
    "The brothers' experience teaches us the importance of combining traditional knowledge with new ideas, and how collaboration can overcome significant challenges.",
    "The story highlights cultural heritage by showing Hassan's deep understanding of the land and traditions, and how preserving these can be integrated with innovation for community benefit.",
    "Rami's travels broadened his perspective, allowing him to bring new techniques and ideas back to the village, demonstrating how exposure to different cultures and practices can enhance one's own capabilities."
  ];
  // User Answers
  late List<String> _selectedMultipleChoiceAnswers;
  late List<String> _writtenAnswers;

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
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
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
              onPressed: () {
                Navigator.of(context).pop();
                // Optionally, update progress further or perform other actions
              },
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
