import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnologyArticleQuizPage15 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage15State createState() => _TechnologyArticleQuizPage15State();
}

class _TechnologyArticleQuizPage15State extends State<TechnologyArticleQuizPage15>
    with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  List<TextEditingController> _answerControllers = [];
  String _article =
      "In the heart of Morocco, two sisters, Amina and Yasmin, were preparing for the annual Marrakech Artisans' Fair. Amina was an expert in traditional Moroccan textile weaving, known for her colorful carpets, while Yasmin was a talented calligrapher who loved to write beautiful Arabic scripts. As the fair approached, Amina worked diligently on her latest carpet, incorporating intricate patterns, while Yasmin practiced her calligraphy on parchment, creating stunning pieces for display. On the day of the fair, the market was alive with music, laughter, and the vibrant colors of handmade crafts. Amina showcased her carpets, drawing in many admirers, while Yasmin’s calligraphy captivated visitors. As the sun set over the bustling market, the sisters felt a deep sense of pride in their heritage and joy in sharing their crafts with the world.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What fair were Amina and Yasmin preparing for?",
      "options": ["Marrakech Artisans' Fair", "Casablanca Festival", "Fes Crafts Fair", "Agadir Arts Festival"],
      "answer": "Marrakech Artisans' Fair"
    },
    {
      "question": "What skill did Amina excel in?",
      "options": ["Pottery", "Textile weaving", "Calligraphy", "Painting"],
      "answer": "Textile weaving"
    },
    {
      "question": "What art form did Yasmin specialize in?",
      "options": ["Photography", "Dance", "Calligraphy", "Music"],
      "answer": "Calligraphy"
    },
    {
      "question": "What was the atmosphere like during the fair?",
      "options": ["Boring and quiet", "Lively and colorful", "Dark and gloomy", "Cold and rainy"],
      "answer": "Lively and colorful"
    },
    {
      "question": "How did Amina and Yasmin feel at the end of the fair?",
      "options": ["Proud", "Disappointed", "Frustrated", "Indifferent"],
      "answer": "Proud"
    },
  ];
  double listeningPoints = 0.0;

  List<Map<String, String>> _writtenQuestions = [
    {"question": "What patterns did Amina include in her carpets?"},
    {"question": "What inspired Yasmin's calligraphy?"},
    {"question": "How did the fair promote Moroccan culture?"},
    {"question": "Why is it important to showcase traditional crafts?"},
    {"question": "How do crafts and art forms reflect a community's identity?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];
  List<String> _correctWrittenAnswers = [
    "Amina included intricate and colorful patterns in her carpets, reflecting traditional Moroccan designs.",
    "Yasmin was inspired by beautiful Arabic scripts and traditional Moroccan calligraphy techniques.",
    "The fair promoted Moroccan culture by showcasing handmade crafts, traditional music, and vibrant colors.",
    "Showcasing traditional crafts helps preserve cultural heritage and fosters appreciation for artisanal skills.",
    "Crafts and art forms reflect a community's identity by displaying its unique traditions, values, and aesthetic preferences."
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int speakingProgressLevel = 0;
  int bottleFillLevel = 0;

  @override
  void initState() {
    super.initState();
    loadSavedProgressData();
    _selectedMultipleChoiceAnswers = List.filled(_multipleChoiceQuestions.length, "");
    _writtenAnswers = List.filled(_writtenQuestions.length, "");
    _answerControllers = List.generate(_writtenQuestions.length, (_) => TextEditingController());

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });
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

  Future<void> _speakArticle() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);

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

  void _checkMultipleChoiceAnswer(int index, String selectedOption) {
    setState(() {
      _selectedMultipleChoiceAnswers[index] = selectedOption;
    });
  }

  void _checkWrittenAnswer(int index) {
    setState(() {
      _writtenAnswers[index] = _answerControllers[index].text;
    });
  }

  void _showResults() {
    int correctMCQ = 0;
    int correctWritten = 0;

    List<Widget> mcqResults = [];
    for (int i = 0; i < _multipleChoiceQuestions.length; i++) {
      String userAnswer = _selectedMultipleChoiceAnswers[i];
      String correctAnswer = _multipleChoiceQuestions[i]["answer"];

      if (userAnswer == correctAnswer) {
        correctMCQ++;
        listeningPoints += 10; // أضف 10 نقاط لكل إجابة صحيحة
      }

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

    List<Widget> writtenResults = [];
    for (int i = 0; i < _writtenQuestions.length; i++) {
      String userAnswer = _writtenAnswers[i].trim().toLowerCase();
      String correctAnswer = _correctWrittenAnswers[i].trim().toLowerCase();

      bool isCorrect = userAnswer == correctAnswer;
      if (isCorrect) {
        correctWritten++;
        listeningPoints += 10; // أضف 10 نقاط لكل إجابة صحيحة
      }

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

    int totalCorrect = correctMCQ + correctWritten;
    int totalQuestions = _multipleChoiceQuestions.length + _writtenQuestions.length;

    // تحديث التقدم بناءً على إجمالي النقاط
    setState(() {
      int totalScore = correctMCQ + correctWritten;
      listeningProgressLevel += (totalScore * 0.50).toInt();
      bottleFillLevel += (totalScore * 0.50).toInt();
      listeningPoints += totalScore * 10; // إجمالي النقاط المستحقة

      if (listeningProgressLevel > 500) listeningProgressLevel = 500;
      if (bottleFillLevel > 6000) bottleFillLevel = 6000;
    });

    // حفظ النقاط بعد التحديث
    saveProgressDataToPreferences();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Quiz Results"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Multiple Choice Results:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("You got $correctMCQ out of ${_multipleChoiceQuestions.length} correct!"),
                ...mcqResults,
                SizedBox(height: 20),
                Text("Written Questions Results:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("You got $correctWritten out of ${_writtenQuestions.length} correct!"),
                ...writtenResults,
                SizedBox(height: 20),
                Text("Total Correct: $totalCorrect out of $totalQuestions"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _selectedMultipleChoiceAnswers = List.filled(_multipleChoiceQuestions.length, "");
                  _writtenAnswers = List.filled(_writtenQuestions.length, "");
                  _answerControllers.forEach((controller) => controller.clear());
                  listeningPoints = 0.0;
                  listeningProgressLevel = 0;
                  bottleFillLevel = 0;
                });
              },
              child: Text("Retry"),
            ),
          ],
        );
      },
    );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: isPlaying ? null : _speakArticle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text('Play', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: isPlaying ? _pauseSpeaking : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text('Pause', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: isPlaying ? _stopSpeaking : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text('Stop', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'Test Your Knowledge:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    ListView.builder(
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
                    ),
                    Text(
                      'Written Questions:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    for (int i = 0; i < _writtenQuestions.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_writtenQuestions[i]["question"]!, style: TextStyle(color: Colors.white)),
                          TextField(
                            controller: _answerControllers[i],
                            onSubmitted: (_) => _checkWrittenAnswer(i),
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
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // if (listeningProgressLevel < 0) {
                        //   listeningProgressLevel += 5;
                        //   listeningPoints += 5;
                        // }
                        // if (bottleFillLevel < 6000) {
                        //   bottleFillLevel += 1;
                        // }
                        // saveProgressDataToPreferences();
                        _showResults();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text('Show Results', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
