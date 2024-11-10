import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
final List<List<String>> allWords = [
  ['The book is on your desk.', 'الكتاب موجود على مكتبك.'],
  ['You can have a cup of tea.', 'ممكن تاخد كباية شاي.'],
  ['It is nice to be with friends.', 'جميل لما تبقى مع صحابك.'],
  ['Are you in the garden?', 'إنت في الجنينه ولا لأ؟'],
  ['That is the house of my friend.', 'ده بيت صاحبي.'],
  ['I want to go for a walk.', 'نفسي أخرج أتمشى شوية.'],
  ['You are in the right place.', 'إنت في المكان الصح.'],
  ['Can you help me with this task?', 'تقدر تساعدني في المهمة دي؟'],
  ['The weather is very hot today.', 'الجو حار جدًا النهارده.'],
  ['She is reading a new book.', 'هي بتقرأ كتاب جديد.'],
  ['I need to charge my phone.', 'لازم أشحن موبايلي.'],
  ['Do you have any plans for the weekend?', 'عندك خطط للويك إند؟'],
  ['The children are playing in the park.', 'العيال بتلعب في الجنينة.'],
  ['My favorite color is blue.', 'لوني المفضل الأزرق.'],
  ['Please close the door when you leave.', 'اقفل الباب لما تمشي.'],
  ['We are going to the cinema tonight.', 'هنروح السينما النهارده بالليل.'],
  ['I will meet you at the cafe.', 'هقابلك في الكافيه.'],
  ['He always forgets his keys.', 'دائمًا بينسى مفاتيحه.'],
  ['I love watching the sunset.', 'بحب أتفرج على غروب الشمس.'],
  ['The store closes at 9 PM.', 'المحل بيقفل الساعة 9.'],
  ['You should try this delicious cake.', 'جرب الكيك دا، طعمه حلو.'],
  ['She bought a new car last week.', 'اشترت عربية جديدة الأسبوع اللي فات.'],
  ['This is the best restaurant in town.', 'ده أحسن مطعم في المنطقة.'],
  ['I will call you later.', 'هكلمك بعدين.'],
  ['We are studying for the exam.', 'إحنا بنذاكر للامتحان.'],
  ['The sky is clear today.', 'السماء صافية النهارده.'],
  ['He traveled to Paris last summer.', 'سافر باريس الصيف اللي فات.'],
];

class ListeningGames9 extends StatefulWidget {
  @override
  _ListeningGames9State createState() => _ListeningGames9State();
}

class _ListeningGames9State extends State<ListeningGames9>
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

class TechnologyArticleQuizPage9 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage9State createState() => _TechnologyArticleQuizPage9State();
}

class _TechnologyArticleQuizPage9State extends State<TechnologyArticleQuizPage9>
    with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  List<TextEditingController> _answerControllers = [];
  String _article =
      "In a small village in Egypt, two friends, Fatima and Ahmed, were excited for the annual Folklore Festival, where people celebrated their rich heritage. Fatima was known for her beautiful embroidery, and she planned to showcase her work at the festival. Ahmed, a talented storyteller, wanted to share traditional tales of their ancestors. On the day of the festival, the village square was decorated with colorful banners and lights. Fatima displayed her embroidered shawls and attracted many visitors who admired her craftsmanship. Meanwhile, Ahmed gathered a crowd under a big tree and captivated them with stories about ancient Egyptian heroes and legends. As the sun set, they both felt a deep sense of pride in their culture, knowing they played a part in keeping their traditions alive.";

  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What festival were Fatima and Ahmed excited for?",
      "options": ["Winter Festival", "Folklore Festival", "Harvest Festival", "New Year Festival"],
      "answer": "Folklore Festival"
    },
    {
      "question": "What skill is Fatima known for?",
      "options": ["Cooking", "Embroidery", "Dancing", "Singing"],
      "answer": "Embroidery"
    },
    {
      "question": "What did Ahmed want to share at the festival?",
      "options": ["Traditional recipes", "Stories", "Songs", "Dance moves"],
      "answer": "Stories"
    },
    {
      "question": "Where did Ahmed gather a crowd?",
      "options": ["Under a big tree", "At the market", "In a school", "At the river"],
      "answer": "Under a big tree"
    },
    {
      "question": "How did Fatima and Ahmed feel at the end of the festival?",
      "options": ["Disappointed", "Bored", "Proud", "Nervous"],
      "answer": "Proud"
    },
  ];

  List<Map<String, String>> _writtenQuestions = [
    {"question": "What types of traditional stories did Ahmed share?"},
    {"question": "How did Fatima prepare for the festival?"},
    {"question": "What decorations were used in the village square?"},
    {"question": "Why is it important to celebrate folklore?"},
    {"question": "What role do stories play in preserving culture?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];

  // الإجابات المثالية للأسئلة الكتابية
  List<String> _correctWrittenAnswers = [
    "Ahmed shared stories about ancient Egyptian heroes and legends.",
    "Fatima prepared her beautiful embroidered shawls to display at the festival.",
    "The village square was decorated with colorful banners and lights.",
    "Celebrating folklore helps preserve cultural traditions and history.",
    "Stories help pass down knowledge and traditions from generation to generation."
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  // النقاط ومستويات التقدم
  int listeningProgressLevel = 0;
  int bottleFillLevel = 0;
  int listeningPoints = 0;

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
    super.dispose();
  }

  // تحميل البيانات المحفوظة من SharedPreferences
  Future<void> loadSavedProgressData() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    setState(() {
      listeningProgressLevel = sharedPreferencesInstance.getInt('progressListening') ?? 0;
      bottleFillLevel = sharedPreferencesInstance.getInt('bottleFillLevel') ?? 0;
      listeningPoints = sharedPreferencesInstance.getInt('listeningPoints') ?? 0;
    });
  }

  // حفظ البيانات إلى SharedPreferences
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    await sharedPreferencesInstance.setInt('progressListening', listeningProgressLevel);
    await sharedPreferencesInstance.setInt('bottleFillLevel', bottleFillLevel);
    await sharedPreferencesInstance.setInt('listeningPoints', listeningPoints);
  }

  // التحكم في قراءة النص
  Future<void> _setTtsLanguage() async {
    await flutterTts.setLanguage("en-US");
  }

  Future<void> _speakArticle() async {
    await _setTtsLanguage();
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

  // التحقق من الإجابات المتعددة الخيارات
  void _checkMultipleChoiceAnswer(int index, String selectedOption) {
    setState(() {
      _selectedMultipleChoiceAnswers[index] = selectedOption;
      if (selectedOption == _multipleChoiceQuestions[index]["answer"]) {
        listeningPoints += 10;
      }
    });
  }

  // التحقق من الإجابات الكتابية
  void _checkWrittenAnswer(int index) {
    setState(() {
      _writtenAnswers[index] = _answerControllers[index].text;
      if (_writtenAnswers[index].trim().toLowerCase() == _correctWrittenAnswers[index].trim().toLowerCase()) {
        listeningPoints += 5;
      }
    });
  }

  // عرض النتائج
  void _showResults() {
    int correctMCQ = 0;

    // بناء النتائج للأسئلة المتعددة الخيارات
    List<Widget> multipleChoiceResultsWidgets = [];
    int correctWritten = 0;

    for (int i = 0; i < _multipleChoiceQuestions.length; i++) {
      String selectedAnswer = _selectedMultipleChoiceAnswers[i];
      String correctAnswer = _multipleChoiceQuestions[i]["answer"];
      bool isCorrect = selectedAnswer.trim().toLowerCase() == correctAnswer.trim().toLowerCase();

      if (isCorrect) {
        correctWritten++;
        // زيادة النقاط إذا كانت الإجابة صحيحة

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

    // بناء النتائج للأسئلة الكتابية
    List<Widget> writtenResultsWidgets = [];
    for (int i = 0; i < _writtenQuestions.length; i++) {
      String userAnswer = _writtenAnswers[i];
      String correctAnswer = _correctWrittenAnswers[i];

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
                color: userAnswer.trim().toLowerCase() == correctAnswer.trim().toLowerCase()
                    ? Colors.green
                    : Colors.red,
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

    // حفظ البيانات وتحديث النقاط والمستويات
    saveProgressDataToPreferences();

    // عرض مربع الحوار للنتائج
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
                Text("You answered $correctMCQ out of ${_multipleChoiceQuestions.length} correctly!",
                    style: TextStyle(color: Colors.black)),
                ...multipleChoiceResultsWidgets,
                SizedBox(height: 20),
                Text("Written Questions Results:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                ...writtenResultsWidgets,
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
                  listeningPoints = 0;
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
                      onPressed: _showResults,
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

