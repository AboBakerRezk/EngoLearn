import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MemorizationPage3 extends StatefulWidget {
  @override
  _MemorizationPage3State createState() => _MemorizationPage3State();
}

class _MemorizationPage3State extends State<MemorizationPage3> {
  int currentExercise = 0; // 0: عرض الكلمات، 1-6: التمارين
  int _currentWordIndex = 0;
  int score = 0;
  int currentPage = 0; // مؤشر الصفحة الحالية من الكلمات
  int questionCount = 0; // عدد الأسئلة الحالية
  bool _isCorrect = false;
  String feedbackMessage = '';

  // الكلمات مقسمة إلى 4 مجموعات، كل مجموعة تحتوي على 5 كلمات
  final List<List<List<String>>> allWords = [
    [
      ['all', 'الكل'],
      ['also', 'أيضاً'],
      ['how', 'كيف'],
      ['many', 'كثير'],
      ['do', 'افعل'],
    ],
    [
      ['has', 'لديه'],
      ['most', 'معظم'],
      ['people', 'الناس'],
      ['other', 'آخر'],
      ['time', 'وقت'],
    ],
    [
      ['so', 'لذلك'],
      ['was', 'كان'],
      ['we', 'نحن'],
      ['these', 'هؤلاء'],
      ['may', 'قد'],
    ],
    [
      ['like', 'مثل'],
      ['use', 'يستخدم'],
      ['into', 'إلى'],
      ['than', 'من'],
      ['up', 'أعلى'],
    ],
  ];

  // الصور المقابلة لكل مجموعة كلمات
  final List<List<String>> allImages = [
    [
      'assets/all.png',
      'assets/also.png',
      'assets/how.png',
      'assets/many.png',
      'assets/do.png',
    ],
    [
      'assets/has.png',
      'assets/most.png',
      'assets/people.png',
      'assets/other.png',
      'assets/time.png',
    ],
    [
      'assets/so.png',
      'assets/was.png',
      'assets/we.png',
      'assets/these.png',
      'assets/may.png',
    ],
    [
      'assets/like.png',
      'assets/use.png',
      'assets/into.png',
      'assets/than.png',
      'assets/up.png',
    ],
  ];

  List<List<String>> getWords() {
    return allWords[currentPage];
  }

  List<String> getImages() {
    return allImages[currentPage];
  }

  // دالة لتشغيل الصوت باستخدام Google Translate TTS
  void playPronunciation(String word) async {
    final player = AudioPlayer();
    final url = 'https://translate.google.com/translate_tts?ie=UTF-8&tl=en&client=tw-ob&q=$word';
    await player.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
              ),
            ),
          ),
          _getExerciseWidget(),
        ],
      ),
    );
  }

  Widget _getExerciseWidget() {
    if (currentExercise == 0) {
      return _buildWordsPage();
    } else if (currentExercise == 1) {
      return _buildChooseCorrectSentenceExercise();
    } else if (currentExercise == 2) {
      return _buildFillInTheBlanksExercise();
    } else if (currentExercise == 3) {
      return _buildTranslateSentenceExercise();
    } else if (currentExercise == 4) {
      return _buildChooseCorrectWordExercise();
    } else if (currentExercise == 5) {
      return _buildCorrectErrorsExercise();
    } else if (currentExercise == 6) {
      return _buildMultipleChoiceExercise();
    } else {
      return _buildSummaryPage();
    }
  }

  Widget _buildWordsPage() {
    List<List<String>> words = getWords();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            'Score: $score',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          Spacer(),
          SizedBox(height: 20),
          Text(
            words[_currentWordIndex][0],
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            words[_currentWordIndex][1],
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          IconButton(
            icon: Icon(Icons.volume_up, color: Colors.blue, size: 40),
            onPressed: () {
              playPronunciation(words[_currentWordIndex][0]);
            },
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (_currentWordIndex < words.length - 1) {
                  _currentWordIndex++;
                } else {
                  // بعد عرض الكلمات الخمس، الانتقال إلى التمرين الأول
                  currentExercise = 1;
                  _currentWordIndex = 0;
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF13194E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.white, width: 2),
              ),
            ),
            child: Text('Next', style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  // التمرين 1: اختيار الجملة الصحيحة
  Widget _buildChooseCorrectSentenceExercise() {
    if (questionCount >= 10) return _buildSummaryPage();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Choose the correct sentence:',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          ...['The cat is on the mat.', 'The cat mat is the on.', 'Cat is the on mat.'].map((sentence) {
            return ListTile(
              title: Text(
                sentence,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onTap: () {
                _checkAnswer(sentence == 'The cat is on the mat.');
              },
            );
          }).toList(),
          _nextExerciseButton(),
        ],
      ),
    );
  }

  // التمرين 2: الملء في الفراغ
  Widget _buildFillInTheBlanksExercise() {
    if (questionCount >= 10) return _buildSummaryPage();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Fill in the blanks:',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          Text(
            'She _____ to the market.',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          ...['goes', 'gone', 'go'].map((option) {
            return ListTile(
              title: Text(
                option,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onTap: () {
                _checkAnswer(option == 'goes');
              },
            );
          }).toList(),
          _nextExerciseButton(),
        ],
      ),
    );
  }

  // التمرين 3: ترجمة الجملة
  Widget _buildTranslateSentenceExercise() {
    if (questionCount >= 10) return _buildSummaryPage();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Translate the sentence:',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          Text(
            'I love programming.',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          _nextExerciseButton(),
        ],
      ),
    );
  }

  // التمرين 4: اختيار الكلمة الصحيحة
  Widget _buildChooseCorrectWordExercise() {
    if (questionCount >= 10) return _buildSummaryPage();
    List<List<String>> words = getWords();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Choose the correct word:',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: words.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    words[index][0],
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onTap: () {
                    _checkAnswer(index == _currentWordIndex);
                  },
                );
              },
            ),
          ),
          _nextExerciseButton(),
        ],
      ),
    );
  }

  // التمرين 5: تصحيح الأخطاء
  Widget _buildCorrectErrorsExercise() {
    if (questionCount >= 10) return _buildSummaryPage();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Correct the errors:',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          Text(
            'He don’t like apples.',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          _nextExerciseButton(),
        ],
      ),
    );
  }

  // التمرين 6: الأسئلة المتعددة الخيارات
  Widget _buildMultipleChoiceExercise() {
    if (questionCount >= 10) return _buildSummaryPage();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Multiple choice questions:',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          ...['What is the capital of France?', 'London', 'Paris', 'Berlin'].map((option) {
            return ListTile(
              title: Text(
                option,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onTap: () {
                _checkAnswer(option == 'Paris');
              },
            );
          }).toList(),
          _nextExerciseButton(),
        ],
      ),
    );
  }

  Widget _nextExerciseButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (questionCount < 10) {
            if (currentExercise < 6) {
              currentExercise++; // الانتقال إلى التمرين التالي
              questionCount++;
            } else {
              if (currentPage < allWords.length - 1) {
                currentPage++;
                currentExercise = 0; // العودة إلى عرض الكلمات
                _currentWordIndex = 0;
                questionCount = 0; // إعادة ضبط عدد الأسئلة للمجموعة التالية
              } else {
                currentExercise++;
              }
            }
          } else {
            currentExercise++;
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF13194E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: Text('Next', style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }

  Widget _buildSummaryPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your Score: $score',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            'Well done! You have completed all exercises.',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                currentExercise = 0;
                _currentWordIndex = 0;
                score = 0;
                currentPage = 0;
                questionCount = 0;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF13194E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.white, width: 2),
              ),
            ),
            child: Text('Restart', style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _checkAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        score += 10;
        feedbackMessage = 'Correct!';
      } else {
        feedbackMessage = 'Try Again!';
      }
      _isCorrect = isCorrect;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(feedbackMessage),
        backgroundColor: _isCorrect ? Colors.green : Colors.red,
        duration: Duration(seconds: 1),
      ),
    );
  }
}
