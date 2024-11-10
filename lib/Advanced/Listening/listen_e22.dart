import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnologyArticleQuizPage22 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage22State createState() => _TechnologyArticleQuizPage22State();
}

class _TechnologyArticleQuizPage22State extends State<TechnologyArticleQuizPage22> with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  double _speechRate = 1.0;
  List<TextEditingController> _answerControllers = [];
  String _article =
      "In the heart of Cairo, a young poet named Omar lived in a bustling neighborhood. Surrounded by the noise and activity of the city, he found solace in his words, expressing emotions and thoughts through poetry. "
      "Omar's dream was to become a renowned poet, but the challenges of gaining recognition in a city filled with various forms of entertainment were many. "
      "Despite this, he remained committed to his craft, attending poetry readings and writing late into the night. His childhood friend, Layla, had always supported him. She believed in his talent and often attended his readings to show her support. "
      "One day, Layla had an idea—she would compose a melody to accompany Omar's poetry. She believed that adding music would enhance the emotional impact of his words, creating an unforgettable experience for the audience. "
      "Omar hesitated at first, but Layla’s conviction gave him the confidence to try something new. Together, they prepared for a poetry competition to be held at Al-Azhar University, one of the most prestigious venues in Cairo. "
      "The day of the competition arrived, and Omar stood nervously on stage. As he began to recite his poem, Layla's gentle melody played in the background, and the combination of words and music moved the audience deeply. "
      "His poem explored themes of love, loss, and freedom—universal experiences that resonated with everyone present. By the end of his performance, the room was silent, filled with the weight of Omar's words and Layla's music. "
      "To his surprise, Omar won the competition. His poetry, once confined to small gatherings, now reached a much wider audience. The competition opened new doors for him, allowing him to share his work with others. "
      "Omar and Layla's collaboration became well-known throughout Cairo, and their partnership showed the power of art when different forms come together. "
      "Omar continued to write, with Layla by his side, proving that with support and collaboration, one’s dreams could come true.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What did Omar aspire to be?",
      "options": ["A musician", "A painter", "A poet", "A novelist"],
      "answer": "A poet"
    },
    {
      "question": "Who was Omar's childhood friend?",
      "options": ["Fatima", "Layla", "Sara", "Amina"],
      "answer": "Layla"
    },
    {
      "question": "Where was the poetry competition held?",
      "options": ["Cairo Opera House", "Al-Azhar University", "The Pyramids", "The Nile River"],
      "answer": "Al-Azhar University"
    },
    {
      "question": "What did Layla compose to accompany Omar's poetry?",
      "options": ["A dance", "A melody", "A play", "A painting"],
      "answer": "A melody"
    },
    {
      "question": "What themes did Omar's poem explore?",
      "options": ["Nature and wildlife", "Love, loss, and freedom", "Science and technology", "History and politics"],
      "answer": "Love, loss, and freedom"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "What challenges did Omar face as a poet?"},
    {"question": "How did Layla support Omar in the competition?"},
    {"question": "What impact did the competition have on Omar's life?"},
    {"question": "How does the story highlight the importance of collaboration in art?"},
    {"question": "What message do you think Omar's poem conveyed to the audience?"}
  ];


  // User Answers
  late List<String> _selectedMultipleChoiceAnswers;
  late List<String> _writtenAnswers;

  final List<String> _correctWrittenAnswers = [
    "Omar struggled to find an audience due to the popularity of other entertainment forms.",
    "Layla composed a melody to accompany Omar's poetry, making it more captivating.",
    "The competition helped Omar gain recognition and opened new doors for him.",
    "It shows that collaboration, like between Omar and Layla, enhances artistic expression.",
    "The poem likely conveyed themes of love, loss, and the longing for freedom."
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
    _selectedMultipleChoiceAnswers =
        List.filled(_multipleChoiceQuestions.length, "");
    _writtenAnswers = List.filled(_writtenQuestions.length, "");
    _answerControllers =
        List.generate(_writtenQuestions.length, (_) => TextEditingController());
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
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
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
      // Optionally clear the text field after submission
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
                // Multiple Choice Results
                Text(
                  "Multiple Choice Results:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "You answered $correctMCQ out of ${_multipleChoiceQuestions.length} questions correctly!"),
                SizedBox(height: 10),
                ..._buildMCQResults(),
                SizedBox(height: 20),
                // Written Questions Results
                Text(
                  "Written Questions Results:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "You answered $correctWritten out of ${_writtenQuestions.length} written questions correctly!"),
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

      bool isCorrect = userAnswer.trim().toLowerCase() ==
          correctAnswer.trim().toLowerCase();

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
      _selectedMultipleChoiceAnswers =
          List.filled(_multipleChoiceQuestions.length, "");
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
            Text(_writtenQuestions[index]["question"]!,
                style: TextStyle(color: Colors.white)),
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
