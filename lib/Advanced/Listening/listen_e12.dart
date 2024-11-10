import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnologyArticleQuizPage12 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage12State createState() => _TechnologyArticleQuizPage12State();
}

class _TechnologyArticleQuizPage12State extends State<TechnologyArticleQuizPage12>
    with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  List<TextEditingController> _answerControllers = [];

  String _article =
      "In a lively village in Lebanon, two friends, Omar and Nour, were eagerly looking forward to the annual Cedar Festival, celebrating the famous cedar trees of their country. Omar was a skilled carpenter who loved to carve beautiful designs out of cedar wood, while Nour was passionate about traditional Lebanese dance, the ‘Dabke.’ On the day of the festival, the village was filled with music, colorful banners, and the scent of delicious Lebanese food. Omar showcased his intricately carved cedar furniture, drawing admiration from visitors. Meanwhile, Nour led a group of dancers in a Dabke performance, bringing joy and excitement to everyone. As the festival came to an end, Omar and Nour felt a deep appreciation for their heritage, proud to share their crafts and culture with their community.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What festival were Omar and Nour excited about?",
      "options": ["Cedar Festival", "Harvest Festival", "Spring Festival", "Summer Festival"],
      "answer": "Cedar Festival"
    },
    {
      "question": "What craft did Omar specialize in?",
      "options": ["Pottery", "Weaving", "Carpentry", "Painting"],
      "answer": "Carpentry"
    },
    {
      "question": "What traditional dance did Nour perform?",
      "options": ["Ballet", "Dabke", "Samba", "Hip-hop"],
      "answer": "Dabke"
    },
    {
      "question": "What was the atmosphere like during the festival?",
      "options": ["Quiet and dull", "Lively and festive", "Chaotic and stressful", "Boring"],
      "answer": "Lively and festive"
    },
    {
      "question": "How did Omar and Nour feel at the end of the festival?",
      "options": ["Proud", "Embarrassed", "Sad", "Angry"],
      "answer": "Proud"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "What types of designs did Omar carve out of cedar wood?"},
    {"question": "How did Nour prepare for the Dabke performance?"},
    {"question": "What kinds of food were served at the festival?"},
    {"question": "Why are cedar trees significant to Lebanon?"},
    {"question": "How do crafts and dances contribute to cultural identity?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];
  List<String> _correctWrittenAnswers = [
    "Omar carved beautiful designs out of cedar wood.", // Question 1
    "Nour practiced the traditional Lebanese dance, Dabke.", // Question 2
    "Delicious Lebanese food like grilled meats and pastries were served.", // Question 3
    "Cedar trees are a symbol of Lebanon and represent strength and longevity.", // Question 4
    "Crafts and dances preserve cultural heritage and create a sense of identity." // Question 5
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
        _pronounScore += 10; // زيادة النقاط بـ 10 للإجابة الصحيحة
      }
    });
  }

  // التحقق من إجابات الأسئلة الكتابية
  void _checkWrittenAnswer(int index) {
    setState(() {
      _writtenAnswers[index] = _answerControllers[index].text;
      if (_writtenAnswers[index].trim().toLowerCase() == _correctWrittenAnswers[index].trim().toLowerCase()) {
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

    // نتائج الأسئلة المتعددة الخيارات
    List<Widget> multipleChoiceResultsWidgets = [];
    for (int i = 0; i < _multipleChoiceQuestions.length; i++) {
      String selectedAnswer = _selectedMultipleChoiceAnswers[i];
      String correctAnswer = _multipleChoiceQuestions[i]["answer"];

      if (selectedAnswer == correctAnswer) {
        correctMCQ++;
      }

      multipleChoiceResultsWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${i + 1}: ${_multipleChoiceQuestions[i]["question"]}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "Your answer: $selectedAnswer",
              style: TextStyle(
                color: selectedAnswer == correctAnswer ? Colors.green : Colors.red,
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

    // نتائج الأسئلة الكتابية
    List<Widget> writtenResultsWidgets = [];
    for (int i = 0; i < _writtenQuestions.length; i++) {
      String userAnswer = _writtenAnswers[i];
      String correctAnswer = _correctWrittenAnswers[i];

      bool isCorrect = userAnswer.trim().toLowerCase() == correctAnswer.trim().toLowerCase();
      if (isCorrect) {
        listeningPoints += 5; // زيادة نقاط الدرس بـ 5 للإجابة الصحيحة
      }

      writtenResultsWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${i + 1}: ${_writtenQuestions[i]["question"]}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

    // عرض مربع الحوار للنتائج
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text("Quiz Results", style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // نتائج الأسئلة المتعددة الخيارات
                Text("Multiple Choice Results:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                Text(
                  "You answered $correctMCQ out of ${_multipleChoiceQuestions.length} questions correctly!",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                ...multipleChoiceResultsWidgets,
                SizedBox(height: 20),
                // نتائج الأسئلة الكتابية
                Text("Written Questions Results:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ...writtenResultsWidgets,
                SizedBox(height: 20),
                // عرض النقاط ومستويات التقدم
                Text("Total Lesson Points: $listeningPoints", style: TextStyle(color: Colors.white)),
                Text("Pronoun Score: $_pronounScore", style: TextStyle(color: Colors.white)),
                Text("Verb Score: $_verbScore", style: TextStyle(color: Colors.white)),
                Text("Listening Progress Level: $listeningProgressLevel", style: TextStyle(color: Colors.white)),
                Text("Bottle Fill Level: $bottleFillLevel", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK", style: TextStyle(color: Colors.white)),
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
              child: Text("Retry", style: TextStyle(color: Colors.white)),
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
              Expanded(
                child: ListView(
                  children: [
                    // عنوان الاختبار
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
