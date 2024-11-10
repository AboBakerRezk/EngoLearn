import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
final List<List<String>> allWords = [
  ['The book is on your desk.', 'الكتاب مرمي على مكتبك.'],
  ['You can have a cup of tea.', 'خد لك كباية شاي.'],
  ['It is nice to be with friends.', 'حلو لما تبقى قاعد مع صحابك.'],
  ['Are you in the garden?', 'إنت في الجنينه ولا إيه؟'],
  ['That is the house of my friend.', 'ده بيت صاحبي يا معلم.'],
  ['I want to go for a walk.', 'نفسي أتمشى شوية.'],
  ['You are in the right place.', 'إنت في المكان المظبوط.'],
  ['Can you help me with this task?', 'تقدر تفكني في الشغلانة دي؟'],
  ['The weather is very hot today.', 'الجو نار النهارده.'],
  ['She is reading a new book.', 'هي ماسكة كتاب جديد وبتقراه.'],
  ['I need to charge my phone.', 'موبايلي فاصل شحن، لازم أشحنه.'],
  ['Do you have any plans for the weekend?', 'إيه أخبارك في الويك إند؟'],
  ['The children are playing in the park.', 'العيال بتلعب في الجنينة.'],
  ['My favorite color is blue.', 'بحب اللون الأزرق.'],
  ['Please close the door when you leave.', 'اقفل الباب وراك وانت ماشي.'],
  ['We are going to the cinema tonight.', 'إحنا رايحين السينما النهارده بالليل.'],
  ['I will meet you at the cafe.', 'هقابلك في الكافيه.'],
  ['He always forgets his keys.', 'على طول بينسى مفاتيحه.'],
  ['I love watching the sunset.', 'بحب أتفرج على غروب الشمس.'],
  ['The store closes at 9 PM.', 'المحل بيقفل على 9 بالليل.'],
  ['You should try this delicious cake.', 'لازم تجرب الكيك دا، تحفة.'],
  ['She bought a new car last week.', 'اشترت عربية جديدة الأسبوع اللي فات.'],
  ['This is the best restaurant in town.', 'ده أحسن مطعم في المنطقة كلها.'],
  ['I will call you later.', 'هكلمك بعدين.'],
  ['We are studying for the exam.', 'إحنا بنذاكر للامتحان.'],
  ['The sky is clear today.', 'السماء صافية النهارده.'],
  ['He traveled to Paris last summer.', 'سافر باريس الصيف اللي فات.'],
];

class ListeningGames10 extends StatefulWidget {
  @override
  _ListeningGames10State createState() => _ListeningGames10State();
}

class _ListeningGames10State extends State<ListeningGames10>
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




class TechnologyArticleQuizPage10 extends StatefulWidget {
  @override
  _TechnologyArticleQuizPage10State createState() =>
      _TechnologyArticleQuizPage10State();
}

class _TechnologyArticleQuizPage10State
    extends State<TechnologyArticleQuizPage10> with SingleTickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  List<TextEditingController> _answerControllers = [];

  // Extended story in English
  final String _article =
      "In a vibrant city in the United Arab Emirates, two friends, Zain and Layla, were excited about the annual Cultural Heritage Day. Zain, passionate about traditional music, spent weeks practicing the oud, a classical Middle Eastern string instrument. Layla, an enthusiast of traditional Arabic calligraphy, was eager to showcase her art at the event. "
      "Preparations began early, with Layla attending workshops to enhance her calligraphy skills. She collaborated with other artists to create beautiful pieces. Meanwhile, Zain organized rehearsals with his friends to perform special musical pieces during the day. "
      "On the day of the festival, the city was adorned with vibrant colors and the aromatic scents of traditional foods filled the air. Layla displayed her artwork in a dedicated gallery, attracting many visitors and media attention. Zain and his musical group performed traditional songs, adding joy and celebration to the atmosphere. "
      "The event successfully brought the community together, sharing stories and traditions among attendees. Zain and Layla felt proud of their contributions, helping preserve cultural heritage and passing it on to future generations.";

  // Adjusted to 5 multiple-choice questions in English
  List<Map<String, dynamic>> _multipleChoiceQuestions = [
    {
      "question": "What event were Zain and Layla excited about?",
      "options": [
        "Cultural Heritage Day",
        "National Day",
        "Food Festival",
        "Music Festival"
      ],
      "answer": "Cultural Heritage Day"
    },
    {
      "question": "Which instrument did Zain practice?",
      "options": ["Oud", "Guitar", "Piano", "Violin"],
      "answer": "Oud"
    },
    {
      "question": "What art form was Layla passionate about?",
      "options": [
        "Arabic Calligraphy",
        "Watercolor Painting",
        "Sculpting",
        "Photography"
      ],
      "answer": "Arabic Calligraphy"
    },
    {
      "question": "How did Layla prepare for the event?",
      "options": [
        "Attended workshops to enhance her skills",
        "Decorated the venue",
        "Prepared traditional foods",
        "Organized musical performances"
      ],
      "answer": "Attended workshops to enhance her skills"
    },
    {
      "question": "How did Zain and Layla feel after the event?",
      "options": ["Proud", "Disappointed", "Indifferent", "Anxious"],
      "answer": "Proud"
    },
  ];

  // 5 Written questions in English
  List<Map<String, String>> _writtenQuestions = [
    {"question": "How did Zain prepare for Cultural Heritage Day?"},
    {"question": "What did Layla do to enhance her calligraphy skills?"},
    {"question": "Describe the contributions of Zain and Layla to the event."},
    {"question": "Why was the event important to the community?"},
    {"question": "What impact did the event have on future generations?"}
  ];

  List<String> _selectedMultipleChoiceAnswers = [];
  List<String> _writtenAnswers = [];

  // Ideal answers for written questions
  List<String> _correctWrittenAnswers = [
    "Zain practiced the oud and organized rehearsals with his friends.",
    "Layla attended workshops and collaborated with other artists.",
    "They showcased traditional arts; Zain performed music, and Layla displayed calligraphy.",
    "It brought the community together, sharing stories and traditions.",
    "It helped preserve cultural heritage and passed it on to future generations."
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  // Points and levels
  double listeningPoints = 0.0;
  int listeningProgressLevel = 0;
  int bottleFillLevel = 0;

  // Grammar scores
  int _pronounScore = 0;
  int _verbScore = 0;

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
      _pronounScore = sharedPreferencesInstance.getInt('pronounScore') ?? 0;
      _verbScore = sharedPreferencesInstance.getInt('verbScore') ?? 0;
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
    await sharedPreferencesInstance.setInt('pronounScore', _pronounScore);
    await sharedPreferencesInstance.setInt('verbScore', _verbScore);
  }

  // TTS controls
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

  // Multiple-choice answer handling
  void _checkMultipleChoiceAnswer(int index, String selectedOption) {
    setState(() {
      _selectedMultipleChoiceAnswers[index] = selectedOption;
      if (selectedOption == _multipleChoiceQuestions[index]["answer"]) {
        _pronounScore += 10;
      }
    });
  }

  // Written answer handling
  void _checkWrittenAnswer(int index) {
    setState(() {
      _writtenAnswers[index] = _answerControllers[index].text;
      if (_writtenAnswers[index].trim().toLowerCase() ==
          _correctWrittenAnswers[index].trim().toLowerCase()) {
        listeningPoints += 5;
      }
    });
  }

  // Update grammar points
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

      _pronounScore = 0;
      _verbScore = 0;
    });

    await prefs.setDouble('listeningPoints', listeningPoints);
    await saveProgressDataToPreferences();
  }

  // Show results
  void _showResults() {
    int correctMCQ = 0;

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
                color:
                selectedAnswer == correctAnswer ? Colors.green : Colors.red,
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

    List<Widget> writtenResultsWidgets = [];
    int correctWritten = 0;

    for (int i = 0; i < _writtenQuestions.length; i++) {
      String userAnswer = _writtenAnswers[i];
      String correctAnswer = _correctWrittenAnswers[i];

      bool isCorrect = userAnswer.trim().toLowerCase() ==
          correctAnswer.trim().toLowerCase();

      if (isCorrect) {
        correctWritten++;
        _pronounScore += 5;
        _verbScore += 5;
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
    int totalCorrect = correctMCQ + correctWritten;

    updateGrammarPointsBasedOnScores();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Quiz Results"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Multiple Choice Results:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "You answered $correctMCQ out of ${_multipleChoiceQuestions.length} questions correctly!"),
                SizedBox(height: 10),
                ...multipleChoiceResultsWidgets,
                SizedBox(height: 20),
                Text(
                  "Written Questions Results:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...writtenResultsWidgets,
                SizedBox(height: 10),
                Text("Total Correct: $totalCorrect out of 10"),
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
                  _selectedMultipleChoiceAnswers =
                      List.filled(_multipleChoiceQuestions.length, "");
                  _writtenAnswers =
                      List.filled(_writtenQuestions.length, "");
                  _answerControllers.forEach((controller) => controller.clear());

                  _pronounScore = 0;
                  _verbScore = 0;
                  listeningPoints = 0.0;
                  listeningProgressLevel = 0;
                  bottleFillLevel = 0;
                });
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
              // TTS controls
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
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            ...(_multipleChoiceQuestions[index]["options"]
                            as List<String>)
                                .map((option) {
                              return RadioListTile<String>(
                                title: Text(option,
                                    style: TextStyle(color: Colors.white)),
                                value: option,
                                groupValue:
                                _selectedMultipleChoiceAnswers[index],
                                onChanged: (value) =>
                                    _checkMultipleChoiceAnswer(index, value!),
                              );
                            }).toList(),
                            SizedBox(height: 20),
                          ],
                        );
                      },
                    ),
                    Text(
                      'Written Questions:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    // Written questions
                    for (int i = 0; i < _writtenQuestions.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_writtenQuestions[i]["question"]!,
                              style: TextStyle(color: Colors.white)),
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
                      child:
                      Text('Show Results', style: TextStyle(color: Colors.white)),
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
