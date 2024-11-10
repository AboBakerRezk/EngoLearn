import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnologyArticleQuizPage21 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage21State createState() => _TechnologyArticleQuizPage21State();
}

class _TechnologyArticleQuizPage21State extends State<TechnologyArticleQuizPage21> with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  double _speechRate = 1.0;
  List<TextEditingController> _answerControllers = [];
  String _article =
      "In the bustling city of Marrakech, Morocco, lived a young artist named Yasmine. She was known for her vibrant paintings that captured the essence of Moroccan culture. "
      "Her art depicted themes of tradition, family, and the struggles women faced in her society. "
      "Though talented, Yasmine faced many challenges as a female artist in a society that often looked down upon women expressing themselves in public. "
      "She had always dreamed of showcasing her work in international exhibitions, but the road to recognition was not easy. "
      "One day, a man named Amir, an art enthusiast and a friend of Yasmine, offered to help her prepare for an upcoming exhibition in Marrakech. "
      "Amir believed that Yasmine's art was powerful and that it could spark important conversations about women’s rights and cultural identity. "
      "At first, the community criticized Yasmine for attempting to showcase her art publicly. However, with Amir’s support and her own determination, she pressed on. "
      "The gathering in Marrakech became a turning point in Yasmine’s life. Her work was appreciated by many, and she gained new recognition and respect within the art world. "
      "Afterward, Yasmine was invited to exhibit her paintings in Paris, where her art garnered even more attention and praise. "
      "It was during this exhibition that Yasmine realized the true impact of her art—art had the power to inspire change and challenge societal norms. "
      "Through her journey, Yasmine became a symbol of hope and perseverance for future generations of women artists. She showed them that no matter the obstacles, their voices could be heard through their creativity and passion for art.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What is Yasmine known for?",
      "options": ["Sculpting", "Vibrant paintings", "Photography", "Dancing"],
      "answer": "Vibrant paintings"
    },
    {
      "question": "Who offered to help Yasmine prepare for the exhibition?",
      "options": ["Her mother", "Amir", "A famous artist", "Her friend"],
      "answer": "Amir"
    },
    {
      "question": "What themes did Yasmine explore in her art?",
      "options": ["Nature and wildlife", "Tradition, family, and women's struggles", "Abstract concepts", "Technology"],
      "answer": "Tradition, family, and women's struggles"
    },
    {
      "question": "How did the community initially react to Yasmine's plans?",
      "options": ["They supported her", "They criticized her", "They were indifferent", "They organized a protest"],
      "answer": "They criticized her"
    },
    {
      "question": "What did Yasmine realize after her exhibition in Paris?",
      "options": ["Art is not important", "Art can inspire change", "Exhibitions are overrated", "Only men should create art"],
      "answer": "Art can inspire change"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "What challenges did Yasmine face as a woman artist?"},
    {"question": "How did Amir influence Yasmine's journey?"},
    {"question": "Why was the gathering in Marrakech important for Yasmine?"},
    {"question": "What message did Yasmine hope to convey through her art?"},
    {"question": "How did Yasmine's journey impact future generations of women artists?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];
  List<String> _correctWrittenAnswers = [
    "Yasmine faced challenges as a woman in a society that often underestimated women in the arts.",
    "Amir encouraged Yasmine and helped her prepare for the exhibition.",
    "The gathering in Marrakech helped Yasmine gain support from her community.",
    "Yasmine's art conveyed the message of women's struggles and the importance of cultural identity.",
    "Yasmine paved the way for future generations of women artists by showing them how to embrace their creativity."
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
