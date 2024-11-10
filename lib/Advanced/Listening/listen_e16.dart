import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnologyArticleQuizPage16 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage16State createState() => _TechnologyArticleQuizPage16State();
}

class _TechnologyArticleQuizPage16State extends State<TechnologyArticleQuizPage16>
    with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  List<TextEditingController> _answerControllers = [];
  String _article =
      "In the bustling city of Cairo, two cousins, Leila and Adam, were eagerly looking forward to the annual Cairo International Book Fair. Leila, an aspiring writer, had been working on her first novel, inspired by the rich history and culture of Egypt. Adam, an avid reader, loved exploring different genres and was excited to discover new authors. As the fair approached, Leila prepared for a book signing event, while Adam made a list of must-visit stalls...";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What event were Leila and Adam looking forward to?",
      "options": ["Cairo International Film Festival", "Cairo International Book Fair", "Cairo Food Festival", "Cairo Arts Festival"],
      "answer": "Cairo International Book Fair"
    },
    {
      "question": "What was Leila working on?",
      "options": ["A painting", "A novel", "A poem", "A script"],
      "answer": "A novel"
    },
    {
      "question": "What genre of literature did Adam enjoy exploring?",
      "options": ["Science fiction", "Fantasy", "Poetry", "All of the above"],
      "answer": "All of the above"
    },
    {
      "question": "How did Leila feel during her book signing event?",
      "options": ["Nervous", "Excited", "Bored", "Indifferent"],
      "answer": "Excited"
    },
    {
      "question": "What did Adam find at the poetry stall?",
      "options": ["A new book", "An old manuscript", "A famous poet", "A writing workshop"],
      "answer": "A famous poet"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "What inspired Leila to write her novel?"},
    {"question": "How did Adam prepare for the book fair?"},
    {"question": "Why is the Cairo International Book Fair significant?"},
    {"question": "What impact did the fair have on Leila and Adam?"},
    {"question": "How does literature reflect cultural identity in Egypt?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];

  List<String> _correctWrittenAnswers = [
    "Leila was inspired by the rich history and culture of Egypt to write her novel.",
    "Adam prepared for the book fair by making a list of must-visit stalls and exploring different genres.",
    "The Cairo International Book Fair is significant because it promotes cultural exchange and literacy.",
    "The fair gave Leila and Adam a renewed sense of purpose and passion for their crafts.",
    "Literature reflects cultural identity in Egypt by showcasing its history, traditions, and societal values."
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

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

    List<Widget> mcqResults = _generateMultipleChoiceResults(correctMCQ);
    List<Widget> writtenResults = _generateWrittenResults(correctWritten);

    int totalCorrect = correctMCQ + correctWritten;
    int totalQuestions = _multipleChoiceQuestions.length + _writtenQuestions.length;

// تحديث مستوى التقدم بناءً على الإجابات الصحيحة
// تحديث مستوى التقدم بناءً على الإجابات الصحيحة
    setState(() {
      // زيادة مستوى تقدم الاستماع
      listeningProgressLevel += (totalQuestions * 0.5).toInt();
      if (listeningProgressLevel > 500) listeningProgressLevel = 500;

      // تحديث نقاط الاستماع
      listeningPoints += (totalQuestions * 0.5).toInt();
      if (listeningPoints > 500) listeningPoints = 500;

      // زيادة مستوى تعبئة الزجاجة
      bottleFillLevel += totalQuestions;
      if (bottleFillLevel > 6000) bottleFillLevel = 6000;
      // تحديث مستويات التقدم
      saveProgressDataToPreferences();
    });



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
              onPressed: _resetQuiz,
              child: Text("Retry"),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _generateMultipleChoiceResults(int correctMCQ) {
    List<Widget> results = [];
    for (int i = 0; i < _multipleChoiceQuestions.length; i++) {
      String userAnswer = _selectedMultipleChoiceAnswers[i];
      String correctAnswer = _multipleChoiceQuestions[i]["answer"];

      if (userAnswer == correctAnswer) {
        correctMCQ++;
      }

      results.add(
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
    return results;
  }

  List<Widget> _generateWrittenResults(int correctWritten) {
    List<Widget> results = [];
    for (int i = 0; i < _writtenQuestions.length; i++) {
      String userAnswer = _writtenAnswers[i];
      String correctAnswer = _correctWrittenAnswers[i];

      bool isCorrect = userAnswer.trim().toLowerCase() == correctAnswer.trim().toLowerCase();
      if (isCorrect) correctWritten++;

      results.add(
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
    return results;
  }

  void _resetQuiz() {
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTTSControls(primaryColor),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildMCQSection(),
                    _buildWrittenQuestionsSection(primaryColor),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _showResults,
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

  Widget _buildTTSControls(Color primaryColor) {
    return Row(
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
    );
  }

  Widget _buildMCQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
      ],
    );
  }

  Widget _buildWrittenQuestionsSection(Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }
}
