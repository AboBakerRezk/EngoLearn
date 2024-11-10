import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnologyArticleQuizPage19 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage19State createState() =>
      _TechnologyArticleQuizPage19State();
}

class _TechnologyArticleQuizPage19State
    extends State<TechnologyArticleQuizPage19> with SingleTickerProviderStateMixin {
  // TTS Variables
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  double _speechRate = 1.0;

  // Article Content
  String _article = """
  In a lively village in Egypt, there lived a group of friends: Layla, Omar, and Samir. They were known for their strong bond and love for their traditions. Every year, the village held a grand festival to celebrate their cultural heritage, featuring music, dance, and delicious traditional foods.

  As the festival approached, Layla suggested that they perform a traditional folk dance. Omar, who played the oud, agreed to provide the music, while Samir offered to help organize the event. They spent weeks preparing, practicing their dance moves, and decorating the village square with colorful banners and lights.

  On the day of the festival, the village square buzzed with excitement. Families gathered, and the aroma of freshly cooked koshari filled the air. Layla, Omar, and Samir took to the stage, wearing traditional costumes that reflected their culture. As the music began to play, they danced with joy, their movements telling stories of their ancestors.

  The audience clapped along, and soon others joined in, creating a vibrant atmosphere. The dance not only entertained but also brought the community together, reminding everyone of their shared history and values. As the night went on, the village celebrated with laughter, music, and delicious food, strengthening their bonds as a community.
  """;

  // Questions
  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What festival did the village celebrate?",
      "options": [
        "Harvest festival",
        "Cultural heritage festival",
        "Music festival",
        "Sports festival"
      ],
      "answer": "Cultural heritage festival"
    },
    {
      "question": "What instrument did Omar play?",
      "options": ["Guitar", "Piano", "Drums", "Oud"],
      "answer": "Oud"
    },
    {
      "question": "What type of dance did Layla, Omar, and Samir perform?",
      "options": [
        "Contemporary dance",
        "Hip-hop",
        "Traditional folk dance",
        "Ballet"
      ],
      "answer": "Traditional folk dance"
    },
    {
      "question": "What food was mentioned in the story?",
      "options": ["Pizza", "Koshari", "Sushi", "Burgers"],
      "answer": "Koshari"
    },
    {
      "question": "What did the dance represent?",
      "options": [
        "Entertainment only",
        "Stories of their ancestors",
        "Fashion trends",
        "Modern culture"
      ],
      "answer": "Stories of their ancestors"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "What role did Layla, Omar, and Samir play in the festival?"},
    {"question": "How did the dance bring the community together?"},
    {"question": "Why is it important to celebrate cultural traditions?"},
    {"question": "How did the friends feel at the end of the festival?"},
    {"question": "What other traditions could the village celebrate in the future?"}
  ];

  // User Answers
  List<String> _selectedMultipleChoiceAnswers = [];
  List<TextEditingController> _answerControllers = [];
  List<String> _correctWrittenAnswers = [
    "They performed a traditional folk dance and organized the event.",
    "It united people by reminding them of their shared history and encouraging participation.",
    "Because it preserves heritage and strengthens community bonds.",
    "They felt proud and accomplished.",
    "They could celebrate traditional crafts, storytelling, or culinary traditions."
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
      label: _speechRate.toString(),
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
