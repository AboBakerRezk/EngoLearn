import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnologyArticleQuizPage17 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage17State createState() => _TechnologyArticleQuizPage17State();
}

class _TechnologyArticleQuizPage17State extends State<TechnologyArticleQuizPage17>
    with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  List<TextEditingController> _answerControllers = [];

  String _article =
      "In a small village in Morocco, a grandmother named Fatima was well-known for her storytelling. Every Friday evening, children from the village would gather in her courtyard, eager to hear tales of ancient heroes, magical creatures, and the rich history of their culture. Fatima's stories not only entertained but also taught valuable lessons about kindness, bravery, and the importance of family.\n\nOne evening, as the sun began to set, Fatima decided to tell a story about a legendary hero named Amir. Amir was known for his bravery and wisdom, and he embarked on a journey to protect his village from a fierce dragon that threatened their crops. The children listened intently as Fatima described Amir’s courage and how he united the villagers to confront the dragon together.\n\nAs the story unfolded, Fatima emphasized the values of teamwork and perseverance. She described how Amir inspired the villagers to work together, each contributing their unique skills to defeat the dragon. By the end of the tale, the children were captivated, cheering for Amir and his friends as they triumphed over adversity.\n\nAfter the story, Fatima encouraged the children to share their own ideas about bravery and how they could help their community. Inspired by Amir's courage, the children brainstormed ways to help their families, such as cleaning up the village and planting trees. Fatima smiled, knowing that the stories she shared were helping to instill a sense of responsibility and pride in their heritage. That night, as the stars sparkled above, the children left her courtyard filled with inspiration, ready to make a difference in their village.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What was Fatima known for in the village?",
      "options": ["Cooking", "Storytelling", "Farming", "Weaving"],
      "answer": "Storytelling"
    },
    {
      "question": "Who was the hero of Fatima's story?",
      "options": ["Amir", "Ali", "Hassan", "Youssef"],
      "answer": "Amir"
    },
    {
      "question": "What did Amir protect his village from?",
      "options": ["A flood", "A dragon", "A band of thieves", "A drought"],
      "answer": "A dragon"
    },
    {
      "question": "What values did Fatima emphasize in her story?",
      "options": ["Greed and selfishness", "Teamwork and perseverance", "Fear and doubt", "Isolation and despair"],
      "answer": "Teamwork and perseverance"
    },
    {
      "question": "What did the children plan to do after hearing the story?",
      "options": ["Go home", "Ignore their chores", "Help their community", "Play games"],
      "answer": "Help their community"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "What lessons did the children learn from Amir's story?"},
    {"question": "How did Fatima inspire the children to be brave?"},
    {"question": "Why are storytelling traditions important in Arab culture?"},
    {"question": "What role does community play in the story?"},
    {"question": "How can children contribute to their village?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];
  List<String> _correctWrittenAnswers = [
    "They learned the importance of bravery, teamwork, and perseverance.",
    "Fatima inspired the children by telling them about Amir's bravery and how he united the villagers.",
    "Storytelling traditions help preserve culture and pass down important values through generations.",
    "The community plays a key role by coming together to solve problems and protect the village.",
    "Children can contribute by helping their families, cleaning the village, and planting trees."
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  // Progress levels and points
  int listeningProgressLevel = 0;
  int bottleFillLevel = 0;
  int _pronounScore = 0;
  int _verbScore = 0;
  double lessonPoints = 0.0;
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

  @override
  void dispose() {
    _answerControllers.forEach((controller) => controller.dispose());
    _controller.dispose();
    flutterTts.stop();
    super.dispose();
  }

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

  // Text-to-Speech functions
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

  // Answer checking functions
  void _checkMultipleChoiceAnswer(int index, String selectedOption) {
    setState(() {
      _selectedMultipleChoiceAnswers[index] = selectedOption;
      if (selectedOption == _multipleChoiceQuestions[index]["answer"]) {
        _pronounScore += 10; // Increase pronoun score
      }
    });
  }

  void _checkWrittenAnswer(int index) {
    setState(() {
      _writtenAnswers[index] = _answerControllers[index].text;
      if (_writtenAnswers[index].trim().toLowerCase() ==
          _correctWrittenAnswers[index].trim().toLowerCase()) {
        listeningPoints += 5; // Increase lesson points
      }
    });
  }

  // Update progress levels
  void updateProgressLevels() {
    int totalScore = _pronounScore + _verbScore;

    // Update listening progress
    listeningProgressLevel += (totalScore * 0.5).toInt();
    if (listeningProgressLevel > 500) listeningProgressLevel = 500;
    // تحديث مستوى الاستماع
    listeningPoints += (totalScore * 0.5).toInt();
    if (listeningPoints > 500) listeningPoints = 500;
    // Update bottle fill level
    bottleFillLevel += (totalScore * 0.5).toInt();
    if (bottleFillLevel > 6000) bottleFillLevel = 6000;

    // Reset scores
    _pronounScore = 0;
    _verbScore = 0;
  }

  // Show results
  void _showResults() {
    int correctMCQ = 0;
    int correctWritten = 0;

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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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
      if (isCorrect) correctWritten++;

      writtenResults.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${i + 1}: ${_writtenQuestions[i]["question"]}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              "Your answer: ${userAnswer.isNotEmpty ? _writtenAnswers[i] : 'No answer'}",
              style: TextStyle(
                color: isCorrect ? Colors.green : Colors.red,
              ),
            ),
            Text(
              "Correct answer: ${_correctWrittenAnswers[i]}",
              style: TextStyle(color: Colors.green),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }

    int totalCorrect = correctMCQ + correctWritten;
    int totalQuestions = _multipleChoiceQuestions.length + _writtenQuestions.length;

    // Update progress levels
    updateProgressLevels();
    saveProgressDataToPreferences();

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
                Text("Multiple Choice Results:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                Text("You got $correctMCQ out of ${_multipleChoiceQuestions.length} correct!", style: TextStyle(color: Colors.white)),
                ...mcqResults,
                SizedBox(height: 20),
                Text("Written Questions Results:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                Text("You got $correctWritten out of ${_writtenQuestions.length} correct!", style: TextStyle(color: Colors.white)),
                ...writtenResults,
                SizedBox(height: 20),
                Text("Total Correct: $totalCorrect out of $totalQuestions", style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                Text("Total Lesson Points: $lessonPoints", style: TextStyle(color: Colors.white)),
                Text("Pronoun Score: $_pronounScore", style: TextStyle(color: Colors.white)),
                Text("Verb Score: $_verbScore", style: TextStyle(color: Colors.white)),
                Text("Listening Progress Level: $listeningProgressLevel", style: TextStyle(color: Colors.white)),
                Text("Bottle Fill Level: $bottleFillLevel", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: _resetQuiz,
              child: Text("Retry", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Reset quiz
  void _resetQuiz() {
    Navigator.of(context).pop();
    setState(() {
      _selectedMultipleChoiceAnswers = List.filled(_multipleChoiceQuestions.length, "");
      _writtenAnswers = List.filled(_writtenQuestions.length, "");
      _answerControllers.forEach((controller) => controller.clear());

      // Reset scores and progress
      _pronounScore = 0;
      _verbScore = 0;
      lessonPoints = 0.0;
      listeningProgressLevel = 0;
      bottleFillLevel = 0;
    });
    saveProgressDataToPreferences();
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
        child: Column(
            children: [
              SizedBox(height: 20,),
              // Text-to-Speech controls
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
              // Quiz content
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'Test Your Knowledge:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    // Multiple-choice questions
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
                    // Written questions
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
                    // Show results button
                    ElevatedButton(
                      onPressed: () {
                        // Check written answers
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

    );
  }
}
