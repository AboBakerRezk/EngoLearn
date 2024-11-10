import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
final List<List<String>> allWords = [
  ['I’m going to bed early.', 'هروح أنام بدري النهارده.'],
  ['Do you want to watch something?', 'تحب نتفرج على حاجة؟'],
  ['I didn’t understand what you said.', 'مش فاهم إنت قلت إيه.'],
  ['I need to go to the market.', 'لازم أروح السوق.'],
  ['I’ll be right back.', 'هرجع حالاً.'],
  ['Let’s order some food.', 'يلا نطلب أكل.'],
  ['Can you drop me off?', 'ممكن توصلني؟'],
  ['I forgot to bring my charger.', 'نسيت أجيب الشاحن بتاعي.'],
  ['How much is this?', 'الحاجة دي بكام؟'],
  ['I’ll think about it and let you know.', 'هفكر فيها وأقولك.'],
  ['I’ve been really busy lately.', 'كنت مشغول جدًا الفترة اللي فاتت.'],
  ['Do you want to grab a snack?', 'عايز نجيب حاجة خفيفة ناكلها؟'],
  ['I need to clean the house.', 'لازم أنضف البيت.'],
  ['I’ll send you the details later.', 'هابعث لك التفاصيل بعدين.'],
  ['What’s for dinner?', 'العشا إيه النهارده؟'],
  ['I’m feeling better now.', 'حاسس إني أحسن دلوقتي.'],
  ['Can you come over tomorrow?', 'ممكن تيجي بكرة؟'],
  ['I don’t have time right now.', 'معنديش وقت دلوقتي.'],
  ['Let’s meet up this weekend.', 'يلا نتقابل الويك إند ده.'],
  ['I just finished my work.', 'لسه مخلص شغلي حالاً.'],
];

class ListeningGames4 extends StatefulWidget {
  @override
  _ListeningGames4State createState() => _ListeningGames4State();
}

class _ListeningGames4State extends State<ListeningGames4>
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

class TechnologyArticleQuizPage4 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage4State createState() => _TechnologyArticleQuizPage4State();
}

class _TechnologyArticleQuizPage4State extends State<TechnologyArticleQuizPage4>
    with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  final Color primaryColor = Color(0xFF13194E);

  List<TextEditingController> _answerControllers = [];
  String _article =
      "There were two friends, Oliver and Zoe, who lived in a quiet village near the mountains. Oliver loved painting landscapes, and Zoe enjoyed hiking through the mountains. One day, they decided to combine their hobbies. Oliver brought his painting tools, and Zoe guided them through the trails. As they climbed higher, they reached a beautiful spot overlooking the entire village. While Oliver started painting the view, Zoe explored the area. Together, they enjoyed the beauty of nature in their own way and realized that combining their interests made the day even more special.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What was Oliver's favorite hobby?",
      "options": ["Hiking", "Cooking", "Painting landscapes", "Reading"],
      "answer": "Painting landscapes"
    },
    {
      "question": "What did Zoe enjoy doing?",
      "options": ["Swimming", "Hiking", "Gardening", "Dancing"],
      "answer": "Hiking"
    },
    {
      "question": "Where did Oliver and Zoe go together?",
      "options": ["The beach", "A mountain", "A museum", "The village market"],
      "answer": "A mountain"
    },
    {
      "question": "What did Oliver bring with him?",
      "options": ["A book", "His painting tools", "A picnic basket", "A camera"],
      "answer": "His painting tools"
    },
    {
      "question": "What did Oliver and Zoe realize at the end?",
      "options": [
        "They should have stayed home",
        "Their interests combined made the day special",
        "Hiking is too tiring",
        "Painting is boring"
      ],
      "answer": "Their interests combined made the day special"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "What hobbies do Oliver and Zoe have?"},
    {"question": "How did Zoe help Oliver during their trip?"},
    {"question": "Why did Oliver and Zoe go to the mountains?"},
    {"question": "What was the lesson they learned at the end?"},
    {"question": "What would you do if you could combine your hobbies with a friend's?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];

  // الإجابات المثالية للأسئلة الكتابية
  List<String> _correctWrittenAnswers = [
    "Oliver loved painting landscapes, and Zoe enjoyed hiking.", // Question 1
    "Zoe guided Oliver through the trails to find the perfect spot for painting.", // Question 2
    "They went to the mountains to combine their hobbies.", // Question 3
    "They realized that combining their interests made the day special.", // Question 4
    "I would suggest combining creativity and activity, such as painting outdoors or writing while hiking." // Example answer for Question 5
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  // متغيرات لتتبع التقدم والنقاط
  double listeningPoints = 0.0;
  int listeningProgressLevel = 0;
  int bottleFillLevel = 0;

  @override
  void initState() {
    super.initState();
    loadSavedProgressData();
    _selectedMultipleChoiceAnswers =
        List.filled(_multipleChoiceQuestions.length, "");
    _writtenAnswers = List.filled(_writtenQuestions.length, "");
    _answerControllers =
        List.generate(_writtenQuestions.length, (_) => TextEditingController());

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
    super.dispose();
  }

  // تحميل البيانات المحفوظة من SharedPreferences
  Future<void> loadSavedProgressData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listeningPoints = prefs.getDouble('listeningPoints') ?? 0.0;
      listeningProgressLevel = prefs.getInt('progressListening') ?? 0;
      bottleFillLevel = prefs.getInt('bottleLevel') ?? 0;
    });
  }

  // حفظ البيانات إلى SharedPreferences
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('listeningPoints', listeningPoints);
    await prefs.setInt('progressListening', listeningProgressLevel);
    await prefs.setInt('bottleLevel', bottleFillLevel);
  }

  // تعيين اللغة الإنجليزية للـ TTS
  Future<void> _setTtsLanguage() async {
    await flutterTts.setLanguage("en-US");
  }

  // التحكم في القراءة (تشغيل)
  Future<void> _speakArticle() async {
    await _setTtsLanguage();
    await flutterTts.setSpeechRate(0.4); // تعيين سرعة القراءة

    setState(() {
      isPlaying = true;
    });
    await flutterTts.speak(_article);
  }

  // التحكم في القراءة (إيقاف)
  Future<void> _stopSpeaking() async {
    await flutterTts.stop();
    setState(() {
      isPlaying = false;
    });
  }

  // التحكم في القراءة (إيقاف مؤقت)
  Future<void> _pauseSpeaking() async {
    await flutterTts.pause();
    setState(() {
      isPlaying = false;
    });
  }

  // التعامل مع إجابات الأسئلة المتعددة الاختيارات
  void _checkMultipleChoiceAnswer(int index, String selectedOption) {
    setState(() {
      _selectedMultipleChoiceAnswers[index] = selectedOption;
      if (selectedOption == _multipleChoiceQuestions[index]["answer"]) {
        listeningPoints += 10; // زيادة النقاط للإجابة الصحيحة
      }
      saveProgressDataToPreferences(); // حفظ النقاط بعد كل إجابة
    });
  }

  // التعامل مع الإجابات الكتابية
  void _checkWrittenAnswer(int index) {
    setState(() {
      _writtenAnswers[index] = _answerControllers[index].text;
      if (_writtenAnswers[index].trim().toLowerCase() ==
          _correctWrittenAnswers[index].trim().toLowerCase()) {
        listeningPoints += 10; // زيادة النقاط للإجابة الصحيحة
      }
      saveProgressDataToPreferences(); // حفظ النقاط بعد كل إجابة
    });
  }

  // عرض النتائج
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
    int correctWritten = 0;

    for (int i = 0; i < _writtenQuestions.length; i++) {
      String userAnswer = _writtenAnswers[i];
      String correctAnswer = _correctWrittenAnswers[i];

      bool isCorrect = userAnswer.trim().toLowerCase() ==
          correctAnswer.trim().toLowerCase();
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

    // حفظ البيانات قبل عرض النتائج
    saveProgressDataToPreferences();

    // عرض النتائج في مربع حوار
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Quiz Results",
            style: TextStyle(color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Multiple Choice Results:",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  "You answered $correctMCQ out of ${_multipleChoiceQuestions.length} questions correctly!",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 10),
                ...mcqResults,
                SizedBox(height: 20),
                Text(
                  "Written Questions Results:",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
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
              child: Text(
                "OK",
                style: TextStyle(color: primaryColor),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  // إعادة تعيين الإجابات ونقاط الدرس
                  _selectedMultipleChoiceAnswers =
                      List.filled(_multipleChoiceQuestions.length, "");
                  _writtenAnswers = List.filled(_writtenQuestions.length, "");
                  _answerControllers.forEach((controller) => controller.clear());
                  listeningPoints = 0.0;
                  listeningProgressLevel = 0;
                  bottleFillLevel = 0;
                });
                await saveProgressDataToPreferences();
              },
              child: Text(
                "Retry",
                style: TextStyle(color: primaryColor),
              ),
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
              // أزرار التحكم في القراءة
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
                    // أسئلة الاختيار من متعدد
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
                    // أسئلة كتابية
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
}


