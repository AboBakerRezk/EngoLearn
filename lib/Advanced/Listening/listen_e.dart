import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<List<String>> allWords = [
  ['The book is on your desk.', 'الكتاب على مكتبك.'],
  ['You can have a cup of tea.', 'يمكنك أن تأخذ فنجانًا من الشاي.'],
  ['It is nice to be with friends.', 'من الجميل أن تكون مع الأصدقاء.'],
  ['Are you in the garden?', 'هل أنت في الحديقة؟'],
  ['That is the house of my friend.', 'هذا هو بيت صديقي.'],
  ['I want to go for a walk.', 'أريد أن أذهب في نزهة.'],
  ['You are in the right place.', 'أنت في المكان الصحيح.'],
  ['Can you help me with this task?', 'هل يمكنك مساعدتي في هذه المهمة؟'],
  ['The weather is very hot today.', 'الطقس حار جداً اليوم.'],
  ['She is reading a new book.', 'هي تقرأ كتابًا جديدًا.'],
  ['I need to charge my phone.', 'أحتاج إلى شحن هاتفي.'],
  ['Do you have any plans for the weekend?', 'هل لديك أي خطط لعطلة نهاية الأسبوع؟'],
  ['The children are playing in the park.', 'الأطفال يلعبون في الحديقة.'],
  ['My favorite color is blue.', 'لوني المفضل هو الأزرق.'],
  ['Please close the door when you leave.', 'من فضلك أغلق الباب عند خروجك.'],
  ['We are going to the cinema tonight.', 'نحن ذاهبون إلى السينما الليلة.'],
  ['I will meet you at the cafe.', 'سألتقي بك في المقهى.'],
  ['He always forgets his keys.', 'هو دائمًا ينسى مفاتيحه.'],
  ['I love watching the sunset.', 'أحب مشاهدة غروب الشمس.'],
  ['The store closes at 9 PM.', 'المتجر يغلق في الساعة التاسعة مساءً.'],
  ['You should try this delicious cake.', 'يجب أن تجرب هذا الكعك اللذيذ.'],
  ['She bought a new car last week.', 'اشترت سيارة جديدة الأسبوع الماضي.'],
  ['This is the best restaurant in town.', 'هذا هو أفضل مطعم في المدينة.'],
  ['I will call you later.', 'سأتصل بك لاحقًا.'],
  ['We are studying for the exam.', 'نحن ندرس للامتحان.'],
  ['The sky is clear today.', 'السماء صافية اليوم.'],
  ['He traveled to Paris last summer.', 'سافر إلى باريس الصيف الماضي.'],
];





class ListeningGames1 extends StatefulWidget {
  @override
  _ListeningGames1State createState() => _ListeningGames1State();
}

class _ListeningGames1State extends State<ListeningGames1>
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



class TechnologyArticleQuizPage extends StatefulWidget {
  @override
  _TechnologyArticleQuizPageState createState() => _TechnologyArticleQuizPageState();
}

class _TechnologyArticleQuizPageState extends State<TechnologyArticleQuizPage>
    with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  List<TextEditingController> _answerControllers = [];
  String _article = "In a small village, there were two best friends, Noah and Emma. They loved solving puzzles and mysteries together. One day, they heard about a mysterious old house at the edge of the village. Noah, always adventurous, suggested they explore it. Emma, being careful, was unsure but agreed. As they entered the house, they found strange clues hidden in different rooms. They worked together to solve the puzzles and discovered a secret room filled with ancient books. By the end of the day, they realized that their teamwork and trust in each other were what made them succeed.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What did Noah and Emma love to do together?",
      "options": ["Cook food", "Solve puzzles", "Watch movies", "Play sports"],
      "answer": "Solve puzzles"
    },
    {
      "question": "What was mysterious about the house?",
      "options": ["It was full of people", "It had hidden clues", "It was very small", "It had no roof"],
      "answer": "It had hidden clues"
    },
    {
      "question": "Who was the adventurous one?",
      "options": ["Noah", "Emma", "Both", "Neither"],
      "answer": "Noah"
    },
    {
      "question": "What did they find in the secret room?",
      "options": ["Gold", "Books", "Animals", "Paintings"],
      "answer": "Books"
    },
    {
      "question": "What helped Noah and Emma succeed?",
      "options": ["Luck", "Teamwork", "Money", "Time"],
      "answer": "Teamwork"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "Describe how Noah and Emma worked together."},
    {"question": "Why was Emma unsure about exploring the house?"},
    {"question": "What do you think was inside the old books they found?"},
    {"question": "How did teamwork help them solve the mystery?"},
    {"question": "What would you do if you found a mysterious house?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];

  // الإجابات المثالية المأخوذة من القصة
  List<String> _correctWrittenAnswers = [
    "They worked together to solve the puzzles and discovered a secret room filled with ancient books.", // Question 1
    "Emma, being careful, was unsure but agreed.", // Question 2
    "They found ancient books in the secret room.", // Question 3
    "Teamwork helped them solve the puzzles and discover the secret room.", // Question 4
    "If I found a mysterious house, I would explore it cautiously and look for clues." // Question 5
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  // متغيرات لتحديث نقاط القواعد النحوية
  int _pronounScore = 0;
  int _verbScore = 0;
  double listeningPoints = 0.0;
  int listeningProgressLevel = 0;
  int bottleFillLevel = 0;

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  // تعيين اللغة الإنجليزية
  Future<void> _setTtsLanguage() async {
    await flutterTts.setLanguage("en-US");
  }

  // التحكم في القراءة
  Future<void> _speakArticle() async {
    await _setTtsLanguage();
    // تعيين اللغة الإنجليزية
    await flutterTts.setSpeechRate(0.4); // تعيين السرعة لتكون أبطأ قليلاً من الطبيعي

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

// التحكم في الإجابات المتعددة الاختيارات
  void _checkMultipleChoiceAnswer(int index, String selectedOption) {
    setState(() {
      _selectedMultipleChoiceAnswers[index] = selectedOption;
      // تحديث النقاط فقط في حالة الإجابة الصحيحة
      if (selectedOption == _multipleChoiceQuestions[index]["answer"]) {
        _pronounScore += 10; // زيادة النقاط فقط للإجابات الصحيحة
      }
    });
  }

  void _checkWrittenAnswer(int index) {
    setState(() {
      _writtenAnswers[index] = _answerControllers[index].text;
      // إضافة النقاط فقط إذا كانت الإجابة صحيحة
      if (_writtenAnswers[index].trim().toLowerCase() == _correctWrittenAnswers[index].trim().toLowerCase()) {
        listeningPoints += 5; // إضافة النقاط للإجابات الصحيحة فقط
      }
    });
  }



  // دالة لتحديث نقاط القواعد بناءً على النقاط الحالية
  void updateGrammarPointsBasedOnScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      int totalScore = _pronounScore + _verbScore;

      void increasePoints(String section, int points) {
        if (section == 'listeningPoints') {
          totalScore += points;
        }
      }
      increasePoints('listeningPoints', 0); // يمكنك تعديل القيمة هنا لزيادة النقاط المطلوبة

      // زيادة نقاط القواعد بمقدار مجموع نقاط الضمائر والأفعال
      listeningPoints += totalScore;

      // تحديث مستويات التقدم بناءً على النقاط الجديدة
      if (listeningProgressLevel < 500) {
        listeningProgressLevel += (totalScore * 0.50).toInt();
        if (listeningProgressLevel > 500) listeningProgressLevel = 500; // الحد الأقصى
      }
      if (bottleFillLevel < 6000) {
        bottleFillLevel += (totalScore * 0.50).toInt();
        if (bottleFillLevel > 6000) bottleFillLevel = 6000; // الحد الأقصى
      }
      // print(totalScore); // 22500
    });

    // حفظ النقاط والمستويات المحدثة
    await prefs.setDouble('listeningPoints', listeningPoints);
    await saveProgressDataToPreferences();
  }

  // دالة لحفظ بيانات التقدم (يجب تنفيذها حسب متطلباتك)
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('listeningPoints', listeningProgressLevel);
    await prefs.setInt('bottleFillLevel', bottleFillLevel);
    // أضف أي بيانات أخرى تحتاج إلى حفظها هنا
  }

  // عرض النتائج
  void _showResults() {
    int correctMCQ = 0;

    // بناء نص لعرض النتائج المتعددة الاختيارات مع الإجابات الصحيحة والخاطئة بألوان مختلفة
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
                color: selectedAnswer == correctAnswer ? Colors.green : Colors.red, // الأخطاء بالأحمر والصحيحة بالأخضر
              ),
            ),
            Text(
              "Correct answer: $correctAnswer",
              style: TextStyle(color: Colors.green), // الإجابة الصحيحة باللون الأخضر دائمًا
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }

    // بناء نص لعرض النتائج الكتابية مع التحقق من الإجابات
    List<Widget> writtenResultsWidgets = [];
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
              style: TextStyle(color: Colors.green), // الإجابة الصحيحة باللون الأخضر دائمًا
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }
    int totalCorrect = correctMCQ + correctWritten;

    // حساب وتحديث النقاط بناءً على الإجابات الصحيحة
    updateGrammarPointsBasedOnScores();

    // عرض النتائج في مربع حوار
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
                Text("You answered $correctMCQ out of ${_multipleChoiceQuestions.length} questions correctly!"),
                SizedBox(height: 10),
                ...multipleChoiceResultsWidgets, // عرض نتائج الأسئلة المتعددة الاختيارات
                SizedBox(height: 20),
                Text("Written Questions Results:", style: TextStyle(fontWeight: FontWeight.bold)),
                ...writtenResultsWidgets, // عرض نتائج الأسئلة الكتابية
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
              child: Text("OK"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  // إعادة تعيين الإجابات المتعددة الاختيارات والإجابات الكتابية ومسح المتحكمات
                  _selectedMultipleChoiceAnswers = List.filled(_multipleChoiceQuestions.length, "");
                  _writtenAnswers = List.filled(_writtenQuestions.length, "");
                  _answerControllers.forEach((controller) => controller.clear());

                  // إعادة تعيين الدرجات إذا لزم الأمر
                  _pronounScore = 0;
                  _verbScore = 0;
                  listeningPoints = 0.0;
                  listeningProgressLevel = 0;
                  bottleFillLevel = 0;
                });
                // حفظ البيانات المحدثة
                await saveProgressDataToPreferences();
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



