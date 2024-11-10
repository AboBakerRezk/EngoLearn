import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnologyArticleQuizPage18 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage18State createState() => _TechnologyArticleQuizPage18State();
}

class _TechnologyArticleQuizPage18State extends State<TechnologyArticleQuizPage18> with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  List<TextEditingController> _answerControllers = [];
  double _speechRate = 1.0;
  late AnimationController _controller;
  late Animation<double> _animation;

  // Article Content
  String _article =
      "In a picturesque town in Tunisia, a young girl named Amina lived with her family. Amina was passionate about her culture and admired the traditional crafts that her town was famous for, especially pottery. "
      "Her father, Hassan, was a skilled potter known for his beautiful ceramic pieces that reflected the vibrant colors of the Tunisian landscape. "
      "From a young age, Amina would watch her father shape clay into stunning works of art, and over time, she developed a deep love for the craft. "
      "One day, Hassan decided to teach Amina the art of pottery. He showed her how to mold the clay, how to create intricate designs, and how to carefully glaze each piece. "
      "Under her father’s guidance, Amina created her first set of ceramic pots and vases, each one showcasing her unique style while honoring the traditions of her town. "
      "When the annual arts festival arrived, Amina had the opportunity to showcase her work alongside her father’s. She was nervous but excited to share her creations with the world. "
      "As visitors strolled through the festival, many stopped at Amina’s booth, admiring her craftsmanship and the vibrant colors that mirrored the Tunisian scenery. "
      "To Amina's surprise, her pottery sparked a renewed interest in the craft, and people from different towns began asking about her techniques and the stories behind each piece. "
      "By the end of the festival, Amina had not only sold several of her pots but also inspired others to explore the art of pottery. "
      "Through this experience, Amina realized the importance of preserving her cultural heritage through art. She vowed to continue practicing her craft and passing on the knowledge she had learned from her father, ensuring that the rich traditions of her town would live on for generations to come.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What craft was Amina passionate about?",
      "options": ["Weaving", "Pottery", "Painting", "Metalworking"],
      "answer": "Pottery"
    },
    {
      "question": "What was Amina's father's name?",
      "options": ["Hassan", "Ali", "Omar", "Youssef"],
      "answer": "Hassan"
    },
    {
      "question": "What did Hassan teach Amina about pottery?",
      "options": ["How to cook", "How to shape clay", "How to draw", "How to sing"],
      "answer": "How to shape clay"
    },
    {
      "question": "What did Amina create for the annual arts festival?",
      "options": ["Ceramic pots and vases", "Paintings", "Textiles", "Wooden sculptures"],
      "answer": "Ceramic pots and vases"
    },
    {
      "question": "What impact did Amina's work have at the festival?",
      "options": ["No one noticed her booth", "She sparked interest in pottery", "Everyone ignored her", "She sold only one pot"],
      "answer": "She sparked interest in pottery"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "Why is pottery an important tradition in Amina's culture?"},
    {"question": "What did Amina learn from her father about creating pottery?"},
    {"question": "How did Amina feel when people admired her work at the festival?"},
    {"question": "What role does art play in preserving cultural heritage?"},
    {"question": "How can younger generations contribute to traditional crafts?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];
  List<String> _correctWrittenAnswers = [
    "Because it represents their heritage and reflects the vibrant colors of the Tunisian landscape.",
    "She learned how to shape clay and create intricate designs.",
    "She felt proud and inspired to represent her culture through her art.",
    "Art helps preserve cultural heritage by passing down traditions and inspiring appreciation.",
    "By learning traditional crafts and keeping the traditions alive."
  ];

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
    initializeAnswerLists();
    initializeAnimation();
    initializeTtsHandlers();
  }

  @override
  void dispose() {
    _answerControllers.forEach((controller) => controller.dispose());
    _controller.dispose();
    flutterTts.stop();
    super.dispose();
  }

  void initializeAnswerLists() {
    _selectedMultipleChoiceAnswers = List.filled(_multipleChoiceQuestions.length, "");
    _writtenAnswers = List.filled(_writtenQuestions.length, "");
    _answerControllers = List.generate(_writtenQuestions.length, (_) => TextEditingController());
  }

  void initializeAnimation() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  void initializeTtsHandlers() {
    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });
  }

// تحميل البيانات المحفوظة
  Future<void> loadSavedProgressData() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    setState(() {
      listeningProgressLevel = sharedPreferencesInstance.getInt('progressListening') ?? 0;
      bottleFillLevel = sharedPreferencesInstance.getInt('bottleFillLevel') ?? 0;
      listeningPoints = sharedPreferencesInstance.getDouble('listeningPoints') ?? 0.0;
    });
  }

// حفظ البيانات
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    await sharedPreferencesInstance.setInt('progressListening', listeningProgressLevel);
    await sharedPreferencesInstance.setInt('bottleFillLevel', bottleFillLevel);
    await sharedPreferencesInstance.setDouble('listeningPoints', listeningPoints);
  }


  Future<void> _speakArticle() async {
    await flutterTts.setLanguage("en-US");
    flutterTts.setSpeechRate(_speechRate);
    setState(() {
      isPlaying = true;
    });
    await flutterTts.speak(_article);
  }

  void _updateSpeechRate(double rate) {
    setState(() {
      _speechRate = rate;
    });
  }

  void _checkMultipleChoiceAnswer(int index, String selectedOption) {
    setState(() {
      _selectedMultipleChoiceAnswers[index] = selectedOption;
    });
  }

// عرض النتائج وتحديث التقدم
  void _showResults() async {
    int correctMCQ = 0;
    int correctWritten = 0;

    // Build results for multiple-choice questions
    List<Widget> mcqResults = [];
    for (int i = 0; i < _multipleChoiceQuestions.length; i++) {
      String userAnswer = _selectedMultipleChoiceAnswers[i];
      String correctAnswer = _multipleChoiceQuestions[i]["answer"];

      if (userAnswer == correctAnswer) {
        correctMCQ++;
      }

      mcqResults.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${i + 1}: ${_multipleChoiceQuestions[i]["question"]}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              "Your Answer: $userAnswer",
              style: TextStyle(
                color: userAnswer == correctAnswer ? Colors.green : Colors.red,
              ),
            ),
            Text(
              "Correct Answer: $correctAnswer",
              style: TextStyle(color: Colors.green),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }

    // Build results for written questions
    List<Widget> writtenResults = [];
    for (int i = 0; i < _writtenQuestions.length; i++) {
      String userAnswer = _writtenAnswers[i];
      String correctAnswer = _correctWrittenAnswers[i];

      bool isCorrect = userAnswer.trim().toLowerCase() == correctAnswer.trim().toLowerCase();
      if (isCorrect) {
        correctWritten++;
      }

      writtenResults.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Written Question ${i + 1}: ${_writtenQuestions[i]["question"]}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              "Your Answer: $userAnswer",
              style: TextStyle(
                color: isCorrect ? Colors.green : Colors.red,
              ),
            ),
            Text(
              "Correct Answer: $correctAnswer",
              style: TextStyle(color: Colors.green),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }

    // Calculate total correct answers and total questions
    int totalCorrect = correctMCQ + correctWritten;
    int totalQuestions = _multipleChoiceQuestions.length + _writtenQuestions.length;

    // Update progress levels based on correct answers
    setState(() {
      // Increase listening progress level
      listeningProgressLevel += totalCorrect * 5;
      if (listeningProgressLevel > 500) listeningProgressLevel = 500;

      // Update listening points
      listeningPoints += (correctMCQ * 0.5).toInt();
      if (listeningPoints > 500) listeningPoints = 500;

      // Increase bottle fill level
      bottleFillLevel += totalCorrect;
      if (bottleFillLevel > 6000) bottleFillLevel = 6000;
    });

    // Save data after updating
    await saveProgressDataToPreferences();

    // Display results in a dialog box
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Test Results", style: TextStyle(color: Colors.black)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Multiple-choice question results
                Text("Multiple-Choice Questions Results:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                Text(
                  "You answered $correctMCQ out of ${_multipleChoiceQuestions.length} questions correctly!",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 10),
                ...mcqResults,
                SizedBox(height: 20),
                // Written question results
                Text("Written Questions Results:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                Text(
                  "You answered $correctWritten out of ${_writtenQuestions.length} questions correctly!",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 10),
                ...writtenResults,
                // Display total correct answers and progress levels
                SizedBox(height: 10),
                Text("Total Correct Answers: $totalCorrect out of $totalQuestions", style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Okay", style: TextStyle(color: Colors.black)),
            ),
            // Button to retry the test
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  _selectedMultipleChoiceAnswers = List.filled(_multipleChoiceQuestions.length, "");
                  _writtenAnswers = List.filled(_writtenQuestions.length, "");
                  _answerControllers.forEach((controller) => controller.clear());

                  // Reset points and progress levels
                  listeningPoints = 0.0;
                  listeningProgressLevel = 0;
                  bottleFillLevel = 0;
                });
                await saveProgressDataToPreferences();
              },
              child: Text("Retry", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

// حذف دالة _displayResultsDialog إذا لم تعد بحاجة إليها
// void _displayResultsDialog(...) {
//   // يمكنك حذف هذه الدالة بالكامل
// }

// التأكد من استدعاء _showResults بدلاً من _displayResultsDialog

// مثال لدوال حساب الإجابات الصحيحة (تأكد من وجودها أو تعديلها حسب الحاجة)
  int _calculateCorrectMCQAnswers() {
    int correct = 0;
    for (int i = 0; i < _multipleChoiceQuestions.length; i++) {
      if (_selectedMultipleChoiceAnswers[i] == _multipleChoiceQuestions[i]["answer"]) {
        correct++;
      }
    }
    return correct;
  }

  int _calculateCorrectWrittenAnswers() {
    int correct = 0;
    for (int i = 0; i < _writtenQuestions.length; i++) {
      if (_writtenAnswers[i].trim().toLowerCase() == _correctWrittenAnswers[i].trim().toLowerCase()) {
        correct++;
      }
    }
    return correct;
  }

// دالة إعادة المحاولة (تأكد من أن هذه الدالة موجودة أو دمجها كما هو موضح أعلاه)
  void _retryQuiz() async {
    Navigator.of(context).pop();
    setState(() {
      _selectedMultipleChoiceAnswers = List.filled(_multipleChoiceQuestions.length, "");
      _writtenAnswers = List.filled(_writtenQuestions.length, "");
      _answerControllers.forEach((controller) => controller.clear());

      // إعادة تعيين النقاط ومستويات التقدم

      listeningPoints = 0.0;
      listeningProgressLevel = 0;
      bottleFillLevel = 0;
    });
    await saveProgressDataToPreferences();
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
        child: Padding(
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
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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

  Widget _buildWrittenQuestions(Color primaryColor) {
    return Column(
      children: List.generate(_writtenQuestions.length, (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_writtenQuestions[index]["question"]!, style: TextStyle(color: Colors.white)),
            TextField(
              controller: _answerControllers[index],
              onChanged: (_) => _writtenAnswers[index] = _answerControllers[index].text,
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
