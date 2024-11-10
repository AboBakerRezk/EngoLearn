import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
final List<List<String>> allWords = [
  ['I’m bored.', 'زهقت.'],
  ['Let’s do something fun.', 'يلا نعمل حاجة ممتعة.'],
  ['I need to call my friend.', 'لازم أكلم صاحبي.'],
  ['I’m running out of time.', 'الوقت بيعدي بسرعة.'],
  ['I’ll grab something to eat.', 'هجيب حاجة أكلها.'],
  ['Did you see that?', 'شوفت اللي حصل؟'],
  ['I can’t find my wallet.', 'مش لاقي المحفظة.'],
  ['I’m waiting for your reply.', 'مستني ردك.'],
  ['Let’s finish this quickly.', 'يلا نخلص ده بسرعة.'],
  ['I’m not in the mood.', 'مالييش مزاج دلوقتي.'],
  ['The car broke down.', 'العربية عطلت.'],
  ['I’ll fix it later.', 'هصلحها بعدين.'],
  ['I’m going out with some friends.', 'خارج مع شوية صحاب.'],
  ['I forgot my umbrella.', 'نسيت الشمسيه بتاعتي.'],
  ['I’m heading to the gym.', 'رايح الجيم دلوقتي.'],
  ['I need to buy new shoes.', 'محتاج أشتري جزمة جديدة.'],
  ['Let’s grab some dessert.', 'تعالى ناخد حاجة حلوة.'],
  ['I’m so sleepy.', 'نعسان جداً.'],
  ['I’ll talk to you tomorrow.', 'هكلمك بكرة.'],
];

class ListeningGames3 extends StatefulWidget {
  @override
  _ListeningGames3State createState() => _ListeningGames3State();
}

class _ListeningGames3State extends State<ListeningGames3>
    with SingleTickerProviderStateMixin {
  int _currentWordIndex = 0;
  int score = 0;
  int pressCount = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  final Color primaryColor = Color(0xFF13194E);
  FlutterTts flutterTts = FlutterTts();
  String userInput = '';
  bool isCorrect = false;
  bool isGameStarted = false;
  List<int> _usedWords = [];

  // نقاط الضمائر والأفعال
  int _pronounScore = 0;
  int _verbScore = 0;

  // النقاط والمستويات
  double listeningPoints = 0;
  int listeningProgressLevel = 0;
  int bottleFillLevel = 0;

  // لعرض الكلمة الصحيحة عند الخطأ
  String correctWord = '';

  @override
  void initState() {
    super.initState();
    loadSavedData();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    _generateRandomWord();
  }

  @override
  void dispose() {
    _controller.dispose();
    flutterTts.stop();
    super.dispose();
  }

  // دالة للحصول على جميع الكلمات
  List<List<String>> getWords() {
    return allWords;
  }

  // دالة لتوليد كلمة عشوائية
  void _generateRandomWord() {
    setState(() {
      Random random = Random();
      List<List<String>> allAvailableWords = getWords();

      if (_usedWords.length == allAvailableWords.length) {
        _usedWords.clear();
      }

      do {
        _currentWordIndex = random.nextInt(allAvailableWords.length);
      } while (_usedWords.contains(_currentWordIndex));

      _usedWords.add(_currentWordIndex);
      userInput = '';
      isCorrect = false;
      isGameStarted = true;
      pressCount = 0;

      // تحديث الكلمة الصحيحة الحالية
      correctWord = getWords()[_currentWordIndex][0];
    });
  }

  // دالة لتحديث نقاط القواعد بناءً على نقاط الضمائر والأفعال
  void updateGrammarPointsBasedOnScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      int totalScore = _pronounScore + _verbScore;

      // إضافة نقاط الضمائر والأفعال إلى نقاط القواعد
      listeningPoints += totalScore;

      // تحديث مستوى التقدم بناءً على النقاط الجديدة
      if (listeningProgressLevel < 500) {
        listeningProgressLevel += (totalScore * 0.50).toInt();
        if (listeningProgressLevel > 500) listeningProgressLevel = 500; // الحد الأقصى
      }
      if (bottleFillLevel < 6000) {
        bottleFillLevel += (totalScore * 0.50).toInt();
        if (bottleFillLevel > 6000) bottleFillLevel = 6000; // الحد الأقصى
      }

      // إعادة تعيين نقاط الضمائر والأفعال بعد دمجها
      _pronounScore = 0;
      _verbScore = 0;
    });

    // حفظ النقاط والمستويات المحدثة
    await prefs.setDouble('listeningPoints', listeningPoints);
    await saveProgressDataToPreferences();
  }

  // دالة لنطق الكلمة
  Future<void> _speakWord(String word) async {
    double speechRate;

    if (pressCount == 0) {
      speechRate = 1.0;
    } else if (pressCount == 1) {
      speechRate = 0.75;
    } else {
      speechRate = 0.5;
    }

    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.speak(word);

    setState(() {
      pressCount = (pressCount + 1) % 3;
    });
  }

  // دالة للتحقق من إجابة المستخدم
  void _checkAnswer() {
    String userAnswer = userInput.trim().toLowerCase();
    String correctAnswer = correctWord.trim().toLowerCase();

    setState(() {
      if (userAnswer == correctAnswer) {
        isCorrect = true;
        score += 1; // إضافة نقطة واحدة فقط عند الإجابة الصحيحة
        _pronounScore += 5; // تحديث نقاط الضمائر
        _verbScore += 5; // تحديث نقاط الأفعال
        updateGrammarPointsBasedOnScores(); // دمج تحديث نقاط القواعد
        _generateRandomWord();
      } else {
        isCorrect = false;
        // عدم نقصان النقاط عند الإجابة الخاطئة
      }
      saveDataToPreferences();
    });
  }

  // دالة لبناء حقل الإدخال
  Widget _buildInputField() {
    return FadeTransition(
      opacity: _animation,
      child: TextField(
        onChanged: (value) {
          userInput = value;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'اكتب الجملة هنا...',
        ),
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }

  // دالة لبناء الأزرار
  Widget _buildButton(String text, VoidCallback onPressed) {
    return FadeTransition(
      opacity: _animation,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }

  // دالة لحفظ بيانات التقدم
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('lessonPoints', listeningPoints);
    await prefs.setInt('progressListening', listeningProgressLevel);
    await prefs.setInt('bottleLevel', bottleFillLevel);
  }

  // دالة لتحميل جميع البيانات المحفوظة
  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listeningPoints = prefs.getDouble('lessonPoints') ?? 0;
      listeningProgressLevel = prefs.getInt('progressListening') ?? 0;
      bottleFillLevel = prefs.getInt('bottleLevel') ?? 0;
    });
  }

  // دالة لحفظ البيانات الأخرى (إذا لزم الأمر)
  Future<void> saveDataToPreferences() async {
    // حفظ البيانات الأخرى إذا كانت هناك حاجة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, primaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(height: 30),
              _buildButton('استمع للجملة', () => _speakWord(correctWord)),
              SizedBox(height: 30),
              _buildInputField(),
              SizedBox(height: 20),
              _buildButton('تحقق', _checkAnswer),
              SizedBox(height: 20),
              // عرض الكلمة الصحيحة فقط عند الخطأ
              if (!isCorrect && userInput.isNotEmpty)
                Column(
                  children: [
                    Text(
                      'إجابة خاطئة، حاول مجددًا.',
                      style: TextStyle(fontSize: 26, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'الجملة الصحيحة: $correctWord',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              if (isCorrect)
                Text(
                  'إجابة صحيحة!',
                  style: TextStyle(fontSize: 26, color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: 30),
              _buildScoreSection(),
              SizedBox(height: 20),
              _buildButton('جملة أخرى', _generateRandomWord),
            ],
          ),
        ),
      ),
    );
  }

  // ودجت لعرض نقاط اللعبة
  Widget _buildScoreSection() {
    return Text(
      'النقاط: $score',
      style: TextStyle(fontSize: 26, color: Colors.white),
      textAlign: TextAlign.center,
    );
  }
}



class TechnologyArticleQuizPage3 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage3State createState() => _TechnologyArticleQuizPage3State();
}

class _TechnologyArticleQuizPage3State extends State<TechnologyArticleQuizPage3>
    with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  List<TextEditingController> _answerControllers = [];
  String _article =
      "In a bustling city, there were two siblings, Jack and Mia. They were very different from each other. Jack was quiet and loved reading, while Mia was energetic and loved sports. One day, they decided to visit the city's largest park. Jack brought his favorite book, and Mia brought her soccer ball. As they walked through the park, they found a small lost puppy. Jack suggested they take it to the animal shelter, while Mia wanted to search for its owner. After some discussion, they decided to do both. Together, they found the puppy's owner and felt proud of their teamwork, realizing that even though they were different, they made a great team.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What did Jack love to do?",
      "options": ["Read books", "Play soccer", "Cook food", "Travel"],
      "answer": "Read books"
    },
    {
      "question": "What did Mia bring to the park?",
      "options": ["Her favorite book", "Her soccer ball", "A frisbee", "A picnic basket"],
      "answer": "Her soccer ball"
    },
    {
      "question": "What did Jack suggest they do with the lost puppy?",
      "options": ["Take it to the animal shelter", "Keep it", "Leave it in the park", "Sell it"],
      "answer": "Take it to the animal shelter"
    },
    {
      "question": "What did Mia want to do with the lost puppy?",
      "options": ["Search for its owner", "Train it", "Ignore it", "Play with it"],
      "answer": "Search for its owner"
    },
    {
      "question": "What lesson did Jack and Mia learn?",
      "options": ["To be selfish", "The importance of teamwork", "To give up easily", "That adventure is boring"],
      "answer": "The importance of teamwork"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "How were Jack and Mia different?"},
    {"question": "Why did they decide to do both tasks with the puppy?"},
    {"question": "What did they feel after finding the puppy's owner?"},
    {"question": "How did their differences contribute to solving the problem?"},
    {"question": "What would you do if you found a lost puppy?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];

  // Ideal answers taken from the story
  List<String> _correctWrittenAnswers = [
    "Jack was quiet and loved reading, while Mia was energetic and loved sports.",
    "They decided to do both tasks to ensure the puppy was cared for and its owner was found.",
    "They felt proud of their teamwork.",
    "Their differences allowed them to approach the problem from different perspectives, leading to a successful resolution.",
    "If I found a lost puppy, I would try to find its owner or take it to a shelter."
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  // Scoring Variables
  int _pronounScore = 0; // يمكنك تغيير هذا المتغير ليتناسب مع نوع الأسئلة
  int _verbScore = 0;    // يمكنك تغيير هذا المتغير ليتناسب مع نوع الأسئلة
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

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
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
    super.dispose();
  }

  // Load saved data
  Future<void> loadSavedProgressData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listeningProgressLevel = prefs.getInt('progressListening') ?? 0;
      bottleFillLevel = prefs.getInt('bottleFillLevel') ?? 0;
      listeningPoints = prefs.getDouble('listeningPoints') ?? 0.0;
      _pronounScore = prefs.getInt('pronounScore') ?? 0;
      _verbScore = prefs.getInt('verbScore') ?? 0;
    });
  }

  // Save progress data
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('progressListening', listeningProgressLevel);
    await prefs.setInt('bottleFillLevel', bottleFillLevel);
    await prefs.setDouble('listeningPoints', listeningPoints);
    await prefs.setInt('pronounScore', _pronounScore);
    await prefs.setInt('verbScore', _verbScore);
  }

  // Control text-to-speech
  Future<void> _speakArticle() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.4);

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

  // Handle multiple choice answers
  void _checkMultipleChoiceAnswer(int index, String selectedOption) {
    setState(() {
      _selectedMultipleChoiceAnswers[index] = selectedOption;
      if (selectedOption == _multipleChoiceQuestions[index]["answer"]) {
        // يمكنك تخصيص النقاط بناءً على نوع السؤال أو أي معيار آخر
        _pronounScore += 10;
      }
    });
  }

  // Handle written answers
  void _checkWrittenAnswer(int index) {
    setState(() {
      _writtenAnswers[index] = _answerControllers[index].text;
      if (_writtenAnswers[index].trim().toLowerCase() == _correctWrittenAnswers[index].trim().toLowerCase()) {
        listeningPoints += 5;
      }
    });
  }

  // Update grammar points based on scores
  void updateGrammarPointsBasedOnScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      int totalScore = _pronounScore + _verbScore;
      listeningPoints += totalScore;

      if (listeningProgressLevel < 500) {
        listeningProgressLevel += (totalScore * 0.50).toInt();
        if (listeningProgressLevel > 500) listeningProgressLevel = 500;
      }
      if (bottleFillLevel < 6000) {
        bottleFillLevel += (totalScore * 0.50).toInt();
        if (bottleFillLevel > 6000) bottleFillLevel = 6000;
      }
    });

    await prefs.setDouble('listeningPoints', listeningPoints);
    await saveProgressDataToPreferences();
  }

  // Display quiz results
  void _showResults() {
    int correctMCQ = 0;

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
              style: TextStyle(color: userAnswer == correctAnswer ? Colors.green : Colors.red),
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
    int correctWritten = 0;

    for (int i = 0; i < _writtenQuestions.length; i++) {
      String userAnswer = _writtenAnswers[i];
      String correctAnswer = _correctWrittenAnswers[i];

      bool isCorrect = userAnswer.trim().toLowerCase() == correctAnswer.trim().toLowerCase();
      if (isCorrect) {
        correctWritten++;
        // زيادة النقاط إذا كانت الإجابة صحيحة
        listeningPoints += 5; // مثال: زيادة 5 نقاط لكل إجابة صحيحة
      }
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
              style: TextStyle(color: isCorrect ? Colors.green : Colors.red),
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

    // Calculate and update points based on correct answers
    updateGrammarPointsBasedOnScores();
    int totalCorrect = correctMCQ + correctWritten;

    // Show results in a dialog
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
                Text("Multiple Choice Results:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                Text("You answered $correctMCQ out of ${_multipleChoiceQuestions.length} questions correctly!",
                    style: TextStyle(color: Colors.black)),
                SizedBox(height: 10),
                ...mcqResults,
                SizedBox(height: 20),
                Text("Written Questions Results:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                ...writtenResults,

                SizedBox(height: 10),
                Text("Total Correct: $totalCorrect out of 10", style: TextStyle(color: Colors.black)),
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
              // Control buttons for TTS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: isPlaying ? null : _speakArticle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text('Play', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: isPlaying ? _pauseSpeaking : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text('Pause', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: isPlaying ? _stopSpeaking : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                    // Multiple Choice Questions
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
                    // Written Questions
                    for (int i = 0; i < _writtenQuestions.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _writtenQuestions[i]["question"]!,
                            style: TextStyle(color: Colors.white),
                          ),
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
                    // Show Results Button
                    ElevatedButton(
                      onPressed: () {
                        // Check all written answers before showing results
                        for (int i = 0; i < _writtenQuestions.length; i++) {
                          _checkWrittenAnswer(i);
                        }
                        _showResults();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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

