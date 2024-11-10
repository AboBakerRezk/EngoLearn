import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Foundational_lessons/home_sady.dart';


class Qu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Color(0xFF2C2F5A),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'اهلا بك',
                    style: TextStyle(
                      fontSize: 36, // حجم أكبر للنص
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InitialAssessmentPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF13194E),
                      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // تقليل الانحناء إلى 4
                        side: BorderSide(color: Colors.white, width: 2), // إضافة الحواف البيضاء
                      ),
                    ),
                    child: Text(
                      'اختبار تحديد المستوى',
                      style: TextStyle(
                        fontSize: 28, // حجم كبير للنص في الزر
                        color: Colors.white,
                      ),
                    ),
                  ),


                ],
              ),
            ),
            Spacer(),
             Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InitialAssessmentPage()),
                    );
                  },
                  child: Text(
                    'تخطي',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),

            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),

    );
  }
}

//القواعد



class InitialAssessmentPage extends StatefulWidget {
  @override
  _InitialAssessmentPageState createState() => _InitialAssessmentPageState();
}

class _InitialAssessmentPageState extends State<InitialAssessmentPage> {
  int _currentQuestionIndex = 0;
  int _correctAnswersCount = 0; // عدد الإجابات الصحيحة
  List<Question> _questions = [
    Question(
      questionText: "1. She _____ to the market every day.",
      options: ["go", "goes", "going", "gone"],
      correctAnswer: "goes",
    ),
    Question(
      questionText: "2. They _____ playing football now.",
      options: ["is", "are", "was", "were"],
      correctAnswer: "are",
    ),
    Question(
      questionText: "3. I have _____ my homework.",
      options: ["finish", "finishes", "finished", "finishing"],
      correctAnswer: "finished",
    ),
    Question(
      questionText: "4. The cat _____ on the mat yesterday.",
      options: ["sit", "sits", "sat", "sitting"],
      correctAnswer: "sat",
    ),
    Question(
      questionText: "5. She _____ to the gym every morning.",
      options: ["go", "goes", "went", "going"],
      correctAnswer: "goes",
    ),
    Question(
      questionText: "6. We _____ seen that movie already.",
      options: ["has", "have", "having", "had"],
      correctAnswer: "have",
    ),
    Question(
      questionText: "7. If I _____ rich, I would travel the world.",
      options: ["am", "was", "were", "be"],
      correctAnswer: "were",
    ),
    Question(
      questionText: "8. They _____ at the park when it started to rain.",
      options: ["is", "was", "were", "being"],
      correctAnswer: "were",
    ),
    Question(
      questionText: "9. He _____ finish his project by tomorrow.",
      options: ["must", "can", "should", "might"],
      correctAnswer: "must",
    ),
    Question(
      questionText: "10. I _____ help you with your homework later.",
      options: ["will", "can", "shall", "would"],
      correctAnswer: "will",
    ),
  ];

  void _nextQuestion() {
    // تحقق من صحة الإجابة وحساب عدد الإجابات الصحيحة
    if (_questions[_currentQuestionIndex].selectedAnswer ==
        _questions[_currentQuestionIndex].correctAnswer) {
      _correctAnswersCount++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _showResult(context); // عرض النتيجة بعد انتهاء الأسئلة
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _showResult(BuildContext context) {
    String level = _determineLevel(); // تحديد المستوى بناءً على عدد الإجابات الصحيحة
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultPage(level: level)),
    );
  }

  String _determineLevel() {
    // تحديد المستوى بناءً على عدد الإجابات الصحيحة
    if (_correctAnswersCount >= 8) {
      return "متقدم";
    } else if (_correctAnswersCount >= 5) {
      return "متوسط";
    } else {
      return "مبتدئ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grammar Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _questions[_currentQuestionIndex].questionText,
              style: TextStyle(fontSize: 18),
            ),
            ..._questions[_currentQuestionIndex].options.map((option) =>
                RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _questions[_currentQuestionIndex].selectedAnswer,
                  onChanged: (value) {
                    setState(() {
                      _questions[_currentQuestionIndex].selectedAnswer = value;
                    });
                  },
                )).toList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _previousQuestion,
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: _nextQuestion,
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  String? selectedAnswer;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    this.selectedAnswer,
  });
}

// صفحة النتيجة

class ResultPage extends StatelessWidget {
  final String level;

  ResultPage({required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نتيجة الاختبار'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'مستواك هو: $level',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReadingAssessmentPage()),
                );              },
              child: Text('اختبار القرائه'),
            ),
          ],
        ),
      ),
    );
  }
}


//القرائه



class ReadingAssessmentPage extends StatefulWidget {
  @override
  _ReadingAssessmentPageState createState() => _ReadingAssessmentPageState();
}

class _ReadingAssessmentPageState extends State<ReadingAssessmentPage> {
  int _currentQuestionIndex = 0;
  int _correctAnswersCount = 0; // عدد الإجابات الصحيحة

  // نص القراءة
  final String _readingText = '''
  Sarah and her family decided to go to the beach last weekend. The weather was sunny and warm, perfect for a day out. They packed their bags with towels, sunscreen, and snacks. At the beach, Sarah built a big sandcastle, and her brother collected shells. In the afternoon, they had a picnic by the sea. Everyone enjoyed the day, and they went home feeling happy and relaxed.
  ''';

  // الأسئلة المتعلقة بالنص
  List<ReadingQuestion> _questions = [
    ReadingQuestion(
      questionText: "1. Where did Sarah and her family go last weekend?",
      options: ["To the park", "To the mountains", "To the beach", "To the city"],
      correctAnswer: "To the beach",
    ),
    ReadingQuestion(
      questionText: "2. What was the weather like?",
      options: ["Rainy", "Cloudy", "Snowy", "Sunny and warm"],
      correctAnswer: "Sunny and warm",
    ),
    ReadingQuestion(
      questionText: "3. What did Sarah build at the beach?",
      options: ["A tent", "A sandcastle", "A house", "A boat"],
      correctAnswer: "A sandcastle",
    ),
    ReadingQuestion(
      questionText: "4. Who collected shells?",
      options: ["Sarah", "Her mother", "Her brother", "Her father"],
      correctAnswer: "Her brother",
    ),
    ReadingQuestion(
      questionText: "5. How did the family feel after their day at the beach?",
      options: ["Tired", "Angry", "Happy and relaxed", "Sad"],
      correctAnswer: "Happy and relaxed",
    ),
    ReadingQuestion(
      questionText: "6. What did the family pack for their trip?",
      options: ["Books and games", "Towels, sunscreen, and snacks", "Fishing rods", "Toys"],
      correctAnswer: "Towels, sunscreen, and snacks",
    ),
    ReadingQuestion(
      questionText: "7. What did they do in the afternoon?",
      options: ["Went swimming", "Had a picnic by the sea", "Played volleyball", "Took a nap"],
      correctAnswer: "Had a picnic by the sea",
    ),
    ReadingQuestion(
      questionText: "8. What did Sarah's brother collect?",
      options: ["Seaweed", "Shells", "Rocks", "Sticks"],
      correctAnswer: "Shells",
    ),
    ReadingQuestion(
      questionText: "9. Why was the weather perfect for a day out?",
      options: ["It was rainy", "It was sunny and warm", "It was snowy", "It was windy"],
      correctAnswer: "It was sunny and warm",
    ),
    ReadingQuestion(
      questionText: "10. What did Sarah build her sandcastle with?",
      options: ["Sticks", "Her hands", "A shovel and bucket", "Plastic toys"],
      correctAnswer: "A shovel and bucket",
    ),
  ];

  void _nextQuestion() {
    // تحقق من صحة الإجابة وحساب عدد الإجابات الصحيحة
    if (_questions[_currentQuestionIndex].selectedAnswer ==
        _questions[_currentQuestionIndex].correctAnswer) {
      _correctAnswersCount++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _showResult(context); // عرض النتيجة بعد انتهاء الأسئلة
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _showResult(BuildContext context) {
    String level = _determineLevel(); // تحديد المستوى بناءً على عدد الإجابات الصحيحة
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultPage(level: level)),
    );
  }

  String _determineLevel() {
    // تحديد المستوى بناءً على عدد الإجابات الصحيحة
    if (_correctAnswersCount >= 8) {
      return "متقدم";
    } else if (_correctAnswersCount >= 5) {
      return "متوسط";
    } else {
      return "مبتدئ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Read the following text:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              _readingText,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              _questions[_currentQuestionIndex].questionText,
              style: TextStyle(fontSize: 18),
            ),
            ..._questions[_currentQuestionIndex]
                .options
                .map((option) => RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: _questions[_currentQuestionIndex].selectedAnswer,
              onChanged: (value) {
                setState(() {
                  _questions[_currentQuestionIndex].selectedAnswer = value;
                });
              },
            ))
                .toList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _previousQuestion,
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: _nextQuestion,
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReadingQuestion {
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  String? selectedAnswer;

  ReadingQuestion({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    this.selectedAnswer,
  });
}

// صفحة النتيجة

class ResultPage2 extends StatelessWidget {
  final String level;

  ResultPage2({required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نتيجة الاختبار'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'مستواك هو: $level',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReadingAssessmentPage()),
                );                },
              child: Text('اختبار الاستماع '),
            ),
          ],
        ),
      ),
    );
  }
}



//الاستماع




class ListeningSection extends StatefulWidget {
  @override
  _ListeningSectionState createState() => _ListeningSectionState();
}

class _ListeningSectionState extends State<ListeningSection> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  // تخزين إجابات المستخدم
  List<String> userAnswers = List.filled(10, '');

  // الإجابات الصحيحة
  List<String> correctAnswers = [
    "He went hiking in the mountains.",
    "She visited family and relaxed at home.",
    "Hiking.",
    "Her family.",
    "A barbecue on Saturday evening.",
    "Perfect.",
    "He loves them.",
    "Yes, a barbecue event.",
    "She'd love that.",
    "To keep in touch and plan it."
  ];

  void _playAudio() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(DeviceFileSource('assets/22.mp3')); // استخدم AudioSource الصحيح هنا
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _checkAnswers() {
    int score = 0;
    for (int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i].trim().toLowerCase() == correctAnswers[i].toLowerCase()) {
        score++;
      }
    }

    _showResult(context, score); // عرض النتيجة بناءً على الإجابات
  }

  void _showResult(BuildContext context, int score) {
    String level = _determineLevel(score); // تحديد المستوى بناءً على النتيجة
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Your Score'),
        content: Text('You got $score out of 10 correct! \nYour level is: $level'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  String _determineLevel(int score) {
    // تحديد المستوى بناءً على النتيجة
    if (score >= 8) {
      return "Advanced";
    } else if (score >= 5) {
      return "Intermediate";
    } else {
      return "Beginner";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listening Section'),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: _playAudio,
            style: ElevatedButton.styleFrom(
              backgroundColor: isPlaying ? Colors.red : Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              size: 28,
              color: Colors.white,
            ),
            label: Text(
              isPlaying ? 'Pause Audio' : 'Play Audio',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (int i = 1; i <= 10; i++)
                  ListTile(
                    title: Text('Question $i: '),
                    subtitle: Column(
                      children: [
                        Text(_getQuestion(i)),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              userAnswers[i - 1] = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Your Answer',
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _checkAnswers,
                child: Text('Check Answers'),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WritingSection()), // قم بتحديث المسار حسب القسم التالي
                  );
                },
                child: Text(
                  'اختبار القرائة',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getQuestion(int index) {
    List<String> questions = [
      "What did John do over the weekend?",
      "How did Lisa spend her weekend?",
      "What activity did John do in the mountains?",
      "Who did Lisa visit over the weekend?",
      "What special event did Lisa have with her family?",
      "What was the weather like during Lisa's barbecue?",
      "What does John think about barbecues?",
      "Did John invite Lisa to a future event? If so, what?",
      "How does Lisa feel about being invited to John's event?",
      "What did Lisa and John agree on at the end of their conversation?",
    ];
    return questions[index - 1];
  }
}

//الكتابة


class WritingSection extends StatefulWidget {
  @override
  _WritingSectionState createState() => _WritingSectionState();
}

class _WritingSectionState extends State<WritingSection> {
  String userWriting = ''; // لتخزين كتابة المستخدم
  int wordCount = 0; // عداد الكلمات
  String feedbackMessage = ''; // رسالة التغذية الراجعة
  String writingLevel = ''; // لتخزين مستوى الكتابة

  void _checkWriting() {
    // منطق بسيط لتحليل الكتابة وتقديم التغذية الراجعة
    if (userWriting.isEmpty) {
      feedbackMessage = 'Please write something before submitting.';
      writingLevel = 'No Submission';
    } else if (wordCount < 30) {
      feedbackMessage = 'Try to write at least 30 words for a complete answer.';
      writingLevel = 'Poor';
    } else if (wordCount < 50) {
      feedbackMessage = 'Good attempt! Try to elaborate more for a stronger answer.';
      writingLevel = 'Average';
    } else {
      feedbackMessage = 'Great job! Your writing is well-developed and clear.';
      writingLevel = 'Excellent';
    }

    // إظهار نافذة منبثقة بالتغذية الراجعة
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Writing Task Feedback'),
        content: Text('$feedbackMessage \nYour writing level is: $writingLevel'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _updateWordCount(String text) {
    setState(() {
      userWriting = text;
      wordCount = userWriting.split(' ').where((word) => word.isNotEmpty).length; // تحديث عداد الكلمات
    });
  }

  bool isLanguageSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Writing Section'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Writing Task:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Please write a short paragraph about your favorite hobby and why you enjoy it.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 5,
              onChanged: (value) {
                _updateWordCount(value); // تحديث عداد الكلمات عند التغيير
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Writing',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Word count: $wordCount', // عرض عداد الكلمات
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _checkWriting,
              icon: Icon(Icons.send),
              label: Text('Submit Writing'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: TextButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isLanguageSelected', true); // حفظ الحالة
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ButtonScreen()),
                        (Route<dynamic> route) => false, // إزالة جميع الصفحات السابقة
                  );
                },
                child: Text(
                  'التالي',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

