import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnologyArticleQuizPage13 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage13State createState() => _TechnologyArticleQuizPage13State();
}

class _TechnologyArticleQuizPage13State extends State<TechnologyArticleQuizPage13>
    with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  List<TextEditingController> _answerControllers = [];

  String _article =
      "In a small village in Egypt, two brothers, Ahmed and Samir, were preparing for the annual Pharaohs Festival, which celebrated their rich ancient history. Ahmed loved history and had read many books about the Pharaohs, while Samir enjoyed creating traditional Egyptian crafts, especially pottery. On the day of the festival, the village was adorned with colorful banners, and the sound of folk music filled the air. Ahmed set up a booth where he shared fascinating stories about ancient Egyptian civilization, attracting many curious visitors. Samir displayed his beautifully crafted pottery, showcasing designs inspired by ancient motifs. As the sun began to set, both brothers felt a sense of pride in their heritage, knowing they had played a part in sharing the beauty of their culture with others.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What festival were Ahmed and Samir preparing for?",
      "options": ["Pharaohs Festival", "Nile Festival", "Harvest Festival", "Ancient Culture Festival"],
      "answer": "Pharaohs Festival"
    },
    {
      "question": "What subject did Ahmed enjoy learning about?",
      "options": ["Math", "History", "Science", "Geography"],
      "answer": "History"
    },
    {
      "question": "What craft did Samir specialize in?",
      "options": ["Woodworking", "Pottery", "Weaving", "Painting"],
      "answer": "Pottery"
    },
    {
      "question": "What atmosphere filled the village during the festival?",
      "options": ["Silent and dull", "Busy and chaotic", "Colorful and musical", "Sad and gloomy"],
      "answer": "Colorful and musical"
    },
    {
      "question": "How did Ahmed and Samir feel at the end of the festival?",
      "options": ["Proud", "Embarrassed", "Sad", "Angry"],
      "answer": "Proud"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "What historical facts did Ahmed share at his booth?"},
    {"question": "How did Samir's pottery reflect Egyptian culture?"},
    {"question": "What types of decorations were used for the festival?"},
    {"question": "Why is it important to celebrate cultural history?"},
    {"question": "How do crafts and storytelling preserve a culture's legacy?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];
  List<String> _correctWrittenAnswers = [
    "Ahmed shared fascinating stories about ancient Egyptian civilization and Pharaohs.", // سؤال 1
    "Samir's pottery featured designs inspired by ancient Egyptian motifs, reflecting the culture.", // سؤال 2
    "The festival used colorful banners and folk music decorations to create a vibrant atmosphere.", // سؤال 3
    "Celebrating cultural history helps preserve traditions and fosters a sense of identity.", // سؤال 4
    "Crafts and storytelling pass down knowledge and traditions, keeping the culture's legacy alive." // سؤال 5
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  // متغيرات النقاط ومستويات التقدم
  int _pronounScore = 0;
  int _verbScore = 0;
  double listeningPoints = 0.0;
  int listeningProgressLevel = 0;
  int bottleFillLevel = 0;

  @override
  void initState() {
    super.initState();
    loadSavedProgressData();

    _selectedMultipleChoiceAnswers = List.filled(_multipleChoiceQuestions.length, "");
    _writtenAnswers = List.filled(_writtenQuestions.length, "");
    _answerControllers = List.generate(_writtenQuestions.length, (_) => TextEditingController());

    _controller = AnimationController(
      vsync: this, // يتم استخدام SingleTickerProviderStateMixin
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

  @override
  void dispose() {
    _answerControllers.forEach((controller) => controller.dispose());
    _controller.dispose();
    flutterTts.stop();
    super.dispose();
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

  // التحكم في النص إلى كلام
  Future<void> _setTtsLanguage() async {
    await flutterTts.setLanguage("en-US");
  }

  Future<void> _speakArticle() async {
    await _setTtsLanguage(); // تعيين اللغة الإنجليزية
    await flutterTts.setSpeechRate(0.5); // تعيين السرعة لتكون أبطأ قليلاً من الطبيعي

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

  // التحقق من إجابات الأسئلة المتعددة الخيارات
  void _checkMultipleChoiceAnswer(int index, String selectedOption) {
    setState(() {
      _selectedMultipleChoiceAnswers[index] = selectedOption;
      if (selectedOption == _multipleChoiceQuestions[index]["answer"]) {
        _pronounScore += 5; // زيادة النقاط بـ 10 للإجابة الصحيحة
      }
    });
  }

  // التحقق من إجابات الأسئلة الكتابية
  void _checkWrittenAnswer(int index) {
    setState(() {
      _writtenAnswers[index] = _answerControllers[index].text;
      if (_writtenAnswers[index].trim().toLowerCase() ==
          _correctWrittenAnswers[index].trim().toLowerCase()) {
        listeningPoints += 5; // زيادة نقاط الدرس بـ 5 للإجابة الصحيحة
      }
    });
  }

  // تحديث مستويات التقدم بناءً على النقاط
  void updateProgressLevels() {
    int totalScore = _pronounScore + _verbScore;

    // تحديث مستوى الاستماع
    listeningProgressLevel += (totalScore * 0.5).toInt();
    if (listeningProgressLevel > 500) listeningProgressLevel = 500; // الحد الأقصى
    // تحديث مستوى الاستماع
    listeningPoints += (totalScore * 0.5).toInt();
    if (listeningPoints > 500) listeningPoints = 500;
    // تحديث مستوى زجاجة الماء
    bottleFillLevel += (totalScore * 0.5).toInt();
    if (bottleFillLevel > 6000) bottleFillLevel = 6000; // الحد الأقصى

    // إعادة تعيين النقاط
    _pronounScore = 0;
    _verbScore = 0;
  }

  // عرض النتائج
  void _showResults() {
    int correctMCQ = 0;

    // بناء نتائج الأسئلة متعددة الخيارات
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
              "Your answer: $userAnswer",
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

    // بناء نتائج الأسئلة الكتابية
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              "Your answer: $userAnswer",
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

    // تحديث مستويات التقدم
    updateProgressLevels();
    saveProgressDataToPreferences();

    // عرض النتائج في مربع حوار
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Quiz Results", style: TextStyle(color: Colors.black)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // نتائج الأسئلة المتعددة الخيارات
                Text("Multiple Choice Results:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                Text(
                  "You answered $correctMCQ out of ${_multipleChoiceQuestions.length} questions correctly!",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 10),
                ...mcqResults,
                SizedBox(height: 20),
                // نتائج الأسئلة الكتابية
                Text("Written Questions Results:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                ...writtenResults,
                SizedBox(height: 20),
                // عرض النقاط ومستويات التقدم
                Text("Total Lesson Points: $listeningPoints", style: TextStyle(color: Colors.black)),

              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  _selectedMultipleChoiceAnswers = List.filled(_multipleChoiceQuestions.length, "");
                  _writtenAnswers = List.filled(_writtenQuestions.length, "");
                  _answerControllers.forEach((controller) => controller.clear());

                  // إعادة تعيين النقاط ومستويات التقدم
                  _pronounScore = 0;
                  _verbScore = 0;
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
              // أزرار التحكم في النص إلى كلام
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
              // Expanded list of questions
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'Test Your Knowledge:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    // أسئلة متعددة الخيارات
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
                    // أسئلة كتابية
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
                    // زر عرض النتائج
                    ElevatedButton(
                      onPressed: () {
                        // التحقق من الإجابات الكتابية قبل عرض النتائج
                        for (int i = 0; i < _writtenQuestions.length; i++) {
                          _checkWrittenAnswer(i);
                        }
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
