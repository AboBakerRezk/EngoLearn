import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة تشغيل الصوت

class MemorizationPage25 extends StatefulWidget {
  @override
  _MemorizationPage25State createState() => _MemorizationPage25State();
}

class _MemorizationPage25State extends State<MemorizationPage25> {
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
      ['live', 'يعيش'],
      ['nothing', 'لا شيء'],
      ['period', 'فترة'],
      ['physics', 'فيزياء'],
      ['plan', 'خطة'],
    ],
    [
      ['store', 'متجر'],
      ['tax', 'ضريبة'],
      ['analysis', 'تحليل'],
      ['cold', 'بارد'],
      ['commercial', 'تجاري'],
    ],
    [
      ['directly', 'مباشرة'],
      ['full', 'ممتلئ'],
      ['involved', 'متورط'],
      ['itself', 'ذاته'],
      ['low', 'منخفض'],
    ],
    [
      ['old', 'قديم'],
      ['policy', 'سياسة'],
      ['political', 'سياسي'],
      ['purchase', 'شراء'],
      ['series', 'سلسلة'],
    ],
  ];

  // الصور المقابلة لكل مجموعة كلمات
  final List<List<String>> allImages = [
    [
      'assets/live.png',
      'assets/nothing.png',
      'assets/period.png',
      'assets/physics.png',
      'assets/plan.png',
    ],
    [
      'assets/store.png',
      'assets/tax.png',
      'assets/analysis.png',
      'assets/cold.png',
      'assets/commercial.png',
    ],
    [
      'assets/directly.png',
      'assets/full.png',
      'assets/involved.png',
      'assets/itself.png',
      'assets/low.png',
    ],
    [
      'assets/old.png',
      'assets/policy.png',
      'assets/political.png',
      'assets/purchase.png',
      'assets/series.png',
    ],
  ];

  // دالة لتشغيل الصوت باستخدام Google Translate TTS
  void playPronunciation(String word) async {
    final player = AudioPlayer();
    final url =
        'https://translate.google.com/translate_tts?ie=UTF-8&tl=en&client=tw-ob&q=$word';
    try {
      await player.play(UrlSource(url));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to play audio.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  List<List<String>> getWords() {
    return allWords[currentPage];
  }

  List<String> getImages() {
    return allImages[currentPage];
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
                  currentExercise = 1; // الانتقال إلى التمرين الأول
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
          SizedBox(height: 20)
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







class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ألعاب الكلمات', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'اختر لعبة:',
              style: TextStyle(fontSize: 26, color: Colors.blue[900]), // زيادة حجم الخط
            ),
            SizedBox(height: 30), // إبعاد النص عن الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20), // تكبير الأزرار
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseCorrectWordPage()),
                );
              },
              child: Text('لعبة اختيار الكلمة الصحيحة', style: TextStyle(fontSize: 22)), // تكبير الخط
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),

            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseCorrectWordPage2()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksGamePage()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CrosswordPuzzlePage()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
          ],
        ),
      ),
    );
  }
}

// الكلمات المستخدمة في الألعاب
final List<List<List<String>>> allWords = [
  [
    ['live', 'يعيش'],
    ['nothing', 'لا شيء'],
    ['period', 'فترة'],
    ['physics', 'فيزياء'],
    ['plan', 'خطة'],
  ],
  [
    ['store', 'متجر'],
    ['tax', 'ضريبة'],
    ['analysis', 'تحليل'],
    ['cold', 'بارد'],
    ['commercial', 'تجاري'],
  ],
  [
    ['directly', 'مباشرة'],
    ['full', 'ممتلئ'],
    ['involved', 'متورط'],
    ['itself', 'ذاته'],
    ['low', 'منخفض'],
  ],
  [
    ['old', 'قديم'],
    ['policy', 'سياسة'],
    ['political', 'سياسي'],
    ['purchase', 'شراء'],
    ['series', 'سلسلة'],
  ],
];

// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
class ChooseCorrectWordPage extends StatefulWidget {
  @override
  _ChooseCorrectWordPageState createState() => _ChooseCorrectWordPageState();
}

class _ChooseCorrectWordPageState extends State<ChooseCorrectWordPage> {
  int _currentWordIndex = 0;
  int currentPage = 0;
  int score = 0;

  List<List<String>> getWords() {
    return allWords[currentPage];
  }

  List<String> getWordOptions(String correctWord) {
    List<String> options = [...getWords().map((e) => e[0])];
    options.shuffle();
    return [correctWord, options[0], options[1]]..shuffle();
  }

  void checkAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        score += 10;
      } else {
        score -= 5;
      }

      if (_currentWordIndex < getWords().length - 1) {
        _currentWordIndex++;
      } else {
        _currentWordIndex = 0;
        if (currentPage < allWords.length - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> words = getWords();
    String correctWord = words[_currentWordIndex][0];

    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة اختيار الكلمة الصحيحة', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'اختر الكلمة الصحيحة:',
              style: TextStyle(fontSize: 26, color: Colors.blue[900]),
            ),
            SizedBox(height: 30),
            Text(
              words[_currentWordIndex][1],
              style: TextStyle(fontSize: 32, color: Colors.blue[700]), // تكبير حجم النص
            ),
            SizedBox(height: 30), // إبعاد بين النص والأزرار
            ...getWordOptions(correctWord).map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0), // إضافة مسافات بين الأزرار
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300), // إضافة الحركة عند التغيير
                  curve: Curves.easeInOut,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600], // تم تغيير primary إلى backgroundColor
                      foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20), // تكبير الأزرار
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      checkAnswer(option == correctWord);
                    },
                    child: Text(option, style: TextStyle(fontSize: 22)),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 30),
            Text('النقاط: $score', style: TextStyle(fontSize: 26, color: Colors.blue[900])),
          ],
        ),
      ),
    );
  }
}
//في 10 ثواني الصفحة : لعبة اختيار الكلمة الصحيحة

class ChooseCorrectWordPage2 extends StatefulWidget {
  @override
  _ChooseCorrectWordPage2State createState() => _ChooseCorrectWordPage2State();
}

class _ChooseCorrectWordPage2State extends State<ChooseCorrectWordPage2> {
  int _currentWordIndex = 0;
  int currentPage = 0;
  int score = 0;
  int streak = 0; // لتتبع الأجوبة المتتالية الصحيحة
  int timeLeft = 10; // المؤقت
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer(); // البدء بالمؤقت عند تشغيل الصفحة
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          checkAnswer(false); // في حال انتهاء الوقت، تعتبر الإجابة خاطئة
        }
      });
    });
  }

  List<List<String>> getWords() {
    return allWords[currentPage];
  }

  List<String> getWordOptions(String correctWord) {
    List<String> options = [...getWords().map((e) => e[0])];
    options.shuffle();
    return [correctWord, options[0], options[1]]..shuffle();
  }

  void checkAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        score += 10;
        streak++;
        if (streak % 5 == 0) {
          score += 20; // مكافأة لتوالي الإجابات الصحيحة
        }
      } else {
        score -= 5;
        streak = 0; // إعادة تعيين المتتالية
      }

      // الانتقال إلى السؤال التالي
      if (_currentWordIndex < getWords().length - 1) {
        _currentWordIndex++;
      } else {
        _currentWordIndex = 0;
        if (currentPage < allWords.length - 1) {
          currentPage++;
        } else {
          // عرض شاشة النهاية
          showGameOverDialog();
        }
      }

      timeLeft = 10; // إعادة تعيين المؤقت
      startTimer(); // إعادة بدء المؤقت
    });
  }

  void showGameOverDialog() {
    timer?.cancel(); // إيقاف المؤقت
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('انتهت اللعبة'),
          content: Text('النقاط النهائية: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetGame(); // إعادة تعيين اللعبة
              },
              child: Text('إعادة اللعب'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      score = 0;
      _currentWordIndex = 0;
      currentPage = 0;
      streak = 0;
      timeLeft = 10;
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> words = getWords();
    String correctWord = words[_currentWordIndex][0];

    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة اختيار الكلمة الصحيحة', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'اختر الكلمة الصحيحة:',
              style: TextStyle(fontSize: 26, color: Colors.blue[900]),
            ),
            SizedBox(height: 30),
            Text(
              words[_currentWordIndex][1],
              style: TextStyle(fontSize: 32, color: Colors.blue[700]),
            ),
            SizedBox(height: 30),
            // عرض المؤقت
            Text(
              'الوقت المتبقي: $timeLeft ثانية',
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
            SizedBox(height: 30),
            ...getWordOptions(correctWord).map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      checkAnswer(option == correctWord);
                    },
                    child: Text(option, style: TextStyle(fontSize: 22)),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 30),
            Text('النقاط: $score', style: TextStyle(fontSize: 26, color: Colors.blue[900])),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel(); // إيقاف المؤقت عند الخروج من الصفحة
    super.dispose();
  }
}

// الصفحة الثانية: لعبة ملء الفراغات


class FillInTheBlanksPage extends StatefulWidget {
  @override
  _FillInTheBlanksPageState createState() => _FillInTheBlanksPageState();
}

class _FillInTheBlanksPageState extends State<FillInTheBlanksPage> {
  int score = 0;
  int level = 1;
  int correctAnswersInLevel = 0;
  int _currentSentenceIndex = 0;

  // مجموعة الجمل مع كلمات مفقودة
  final List<Map<String, dynamic>> sentences = [
    {'sentence': 'I love to _____ every morning.', 'correctWord': 'run'},
    {'sentence': 'She is _____ the dishes.', 'correctWord': 'washing'},
    {'sentence': 'The sky is full of bright _____.', 'correctWord': 'stars'},
    {'sentence': 'My favorite fruit is an _____.', 'correctWord': 'apple'},
    {'sentence': 'He _____ to school every day.', 'correctWord': 'walks'},
    {'sentence': 'They are _____ at the party.', 'correctWord': 'dancing'},
    {'sentence': 'The dog is _____ loudly.', 'correctWord': 'barking'},
    {'sentence': 'He likes to _____ books.', 'correctWord': 'read'},
    {'sentence': 'She _____ a beautiful dress.', 'correctWord': 'wears'},
    {'sentence': 'The birds are _____ in the sky.', 'correctWord': 'flying'},
    {'sentence': 'We _____ pizza for dinner.', 'correctWord': 'ate'},
    {'sentence': 'The baby is _____ in the crib.', 'correctWord': 'sleeping'},
    {'sentence': 'He _____ a new car.', 'correctWord': 'bought'},
    {'sentence': 'They _____ to the park on Sundays.', 'correctWord': 'go'},
    {'sentence': 'The sun is _____ brightly.', 'correctWord': 'shining'},
    {'sentence': 'She _____ a letter to her friend.', 'correctWord': 'wrote'},
    {'sentence': 'He _____ the door open.', 'correctWord': 'kicked'},
    {'sentence': 'They are _____ a movie.', 'correctWord': 'watching'},
    {'sentence': 'I _____ to the music.', 'correctWord': 'listen'},
    {'sentence': 'She _____ a cake for the party.', 'correctWord': 'baked'},
  ];

  // دالة لتوليد خيارات عشوائية للكلمات
  List<String> getWordOptions(String correctWord) {
    List<String> options = [...sentences.map((e) => e['correctWord'])];
    options.remove(correctWord); // إزالة الكلمة الصحيحة من الخيارات
    options.shuffle(); // خلط الكلمات
    return [correctWord, options[0], options[1]]..shuffle();
  }

  // دالة لاختيار جملة عشوائية من القائمة
  Map<String, dynamic> getRandomSentence() {
    return sentences[_currentSentenceIndex];
  }

  // دالة للتحقق من الإجابة الصحيحة
  void checkAnswer(String option, String correctWord) {
    setState(() {
      if (option == correctWord) {
        score += 10;
        correctAnswersInLevel++;
        if (correctAnswersInLevel % 5 == 0) {
          level++;
          correctAnswersInLevel = 0;
        }
      } else {
        score -= 5;
      }

      // التبديل إلى الجملة التالية
      if (_currentSentenceIndex < sentences.length - 1) {
        _currentSentenceIndex++;
      } else {
        showGameOverDialog();
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('انتهت اللعبة'),
          content: Text('النقاط النهائية: $score\nالمستوى النهائي: $level'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetGame(); // إعادة تعيين اللعبة
              },
              child: Text('إعادة اللعب'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      score = 0;
      _currentSentenceIndex = 0;
      level = 1;
      correctAnswersInLevel = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentSentence = getRandomSentence();
    String sentence = currentSentence['sentence'];
    String correctWord = currentSentence['correctWord'];

    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة ملء الفراغات', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // عرض الجملة مع الفراغ
            Text(
              sentence.replaceAll('_____', '_____'),
              style: TextStyle(fontSize: 26, color: Colors.blue[900]),
            ),
            SizedBox(height: 30),
            // عرض المرحلة الحالية
            Text(
              'المستوى الحالي: $level',
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
            SizedBox(height: 30),
            // عرض الخيارات للإجابة
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getWordOptions(correctWord).map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[400],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        checkAnswer(option, correctWord);
                      },
                      child: Text(option, style: TextStyle(fontSize: 22)),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            // عرض النقاط الحالية
            Text('النقاط: $score', style: TextStyle(fontSize: 26, color: Colors.blue[900])),
          ],
        ),
      ),
    );
  }
}
// الصفحة الرابعه: لعبة  خمن


class MatchWordToImagePage extends StatefulWidget {
  @override
  _MatchWordToImagePageState createState() => _MatchWordToImagePageState();
}

class _MatchWordToImagePageState extends State<MatchWordToImagePage> {
  int score = 0;
  int currentIndex = 0;

  // قائمة الكلمات مع رموز افتراضية (تستخدم الرموز الافتراضية كمثال فقط)
  final List<Map<String, String>> wordImages = [
    {'word': 'live', 'image': '🏠'},
    {'word': 'nothing', 'image': '⭕'},
    {'word': 'period', 'image': '⏳'},
    {'word': 'physics', 'image': '🔬'},
    {'word': 'plan', 'image': '📅'},
    {'word': 'store', 'image': '🏬'},
    {'word': 'tax', 'image': '💰'},
    {'word': 'analysis', 'image': '📊'},
    {'word': 'cold', 'image': '❄️'},
    {'word': 'commercial', 'image': '📺'},
    {'word': 'directly', 'image': '➡️'},
    {'word': 'full', 'image': '🍲'},
    {'word': 'involved', 'image': '🌀'},
    {'word': 'itself', 'image': '🧑‍🦰'},
    {'word': 'low', 'image': '⬇️'},
    {'word': 'old', 'image': '👴'},
    {'word': 'policy', 'image': '📜'},
    {'word': 'political', 'image': '🏛️'},
    {'word': 'purchase', 'image': '🛒'},
    {'word': 'series', 'image': '📚'},
  ];

  List<String> getWordOptions(String correctWord) {
    List<String> options = [...wordImages.map((e) => e['word']!)];
    options.remove(correctWord);
    options.shuffle();
    return [correctWord, options[0], options[1]]..shuffle();
  }

  void checkAnswer(String option, String correctWord) {
    setState(() {
      if (option == correctWord) {
        score += 10;
      } else {
        score -= 5;
      }

      if (currentIndex < wordImages.length - 1) {
        currentIndex++;
      } else {
        showGameOverDialog();
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('انتهت اللعبة'),
          content: Text('النقاط النهائية: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetGame();
              },
              child: Text('إعادة اللعب'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      score = 0;
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    String correctWord = wordImages[currentIndex]['word']!;
    String image = wordImages[currentIndex]['image']!;

    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة مطابقة الكلمة بالصورة', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // عرض الرمز أو الصورة
            Text(
              image,
              style: TextStyle(fontSize: 100),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getWordOptions(correctWord).map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      checkAnswer(option, correctWord);
                    },
                    child: Text(option, style: TextStyle(fontSize: 22)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            Text('النقاط: $score', style: TextStyle(fontSize: 26, color: Colors.blue[900])),
          ],
        ),
      ),
    );
  }
}
// الصفحة الخامسه: لعبة رتب الكلمة


class RearrangeLettersPage extends StatefulWidget {
  @override
  _RearrangeLettersPageState createState() => _RearrangeLettersPageState();
}

class _RearrangeLettersPageState extends State<RearrangeLettersPage> {
  int score = 0;
  int currentIndex = 0;

  final List<List<String>> words = [
    ['live', 'يعيش'],
    ['nothing', 'لا شيء'],
    ['period', 'فترة'],
    ['physics', 'فيزياء'],
    ['plan', 'خطة'],
    ['store', 'متجر'],
    ['tax', 'ضريبة'],
    ['analysis', 'تحليل'],
    ['cold', 'بارد'],
    ['commercial', 'تجاري'],
    ['directly', 'مباشرة'],
    ['full', 'ممتلئ'],
    ['involved', 'متورط'],
    ['itself', 'ذاته'],
    ['low', 'منخفض'],
    ['old', 'قديم'],
    ['policy', 'سياسة'],
    ['political', 'سياسي'],
    ['purchase', 'شراء'],
    ['series', 'سلسلة'],
  ];

  String shuffledWord(String word) {
    List<String> letters = word.split('')..shuffle();
    return letters.join();
  }

  void checkAnswer(String input, String correctWord) {
    setState(() {
      if (input == correctWord) {
        score += 10;
      } else {
        score -= 5;
      }

      if (currentIndex < words.length - 1) {
        currentIndex++;
      } else {
        showGameOverDialog();
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('انتهت اللعبة'),
          content: Text('النقاط النهائية: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetGame();
              },
              child: Text('إعادة اللعب'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      score = 0;
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    String correctWord = words[currentIndex][0];
    String shuffled = shuffledWord(correctWord);

    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة ترتيب الحروف', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'رتب الحروف لتكوين الكلمة الصحيحة:',
              style: TextStyle(fontSize: 26, color: Colors.blue[900]),
            ),
            SizedBox(height: 30),
            Text(
              shuffled,
              style: TextStyle(fontSize: 36, color: Colors.blue[700]),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'اكتب الكلمة الصحيحة هنا',
              ),
              onSubmitted: (input) {
                checkAnswer(input, correctWord);
              },
            ),
            SizedBox(height: 30),
            Text('النقاط: $score', style: TextStyle(fontSize: 26, color: Colors.blue[900])),
          ],
        ),
      ),
    );
  }
}

// الصفحة السادسة: لعبة اختيار الكلمة



class FillInTheBlanksGamePage extends StatefulWidget {
  @override
  _FillInTheBlanksGamePageState createState() => _FillInTheBlanksGamePageState();
}

class _FillInTheBlanksGamePageState extends State<FillInTheBlanksGamePage> {
  int score = 0;
  int currentIndex = 0;

  final List<Map<String, String>> sentences = [
    {'sentence': 'The _____ is full of bright stars.', 'word': 'sky'},
    {'sentence': 'She _____ an apple for lunch.', 'word': 'ate'},
    {'sentence': 'He is _____ a movie tonight.', 'word': 'watching'},
    {'sentence': 'The _____ is shining brightly.', 'word': 'sun'},
  ];

  List<String> getOptions(String correctWord) {
    List<String> options = sentences.map((s) => s['word']!).toList();
    options.remove(correctWord);
    options.shuffle();
    return [correctWord, options[0], options[1]]..shuffle();
  }

  void checkAnswer(String option, String correctWord) {
    setState(() {
      if (option == correctWord) {
        score += 10;
      } else {
        score -= 5;
      }

      if (currentIndex < sentences.length - 1) {
        currentIndex++;
      } else {
        showGameOverDialog();
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('انتهت اللعبة'),
          content: Text('النقاط النهائية: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetGame();
              },
              child: Text('إعادة اللعب'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      score = 0;
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> sentenceData = sentences[currentIndex];
    String sentence = sentenceData['sentence']!;
    String correctWord = sentenceData['word']!;

    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة اختيار الكلمة الناقصة', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              sentence.replaceAll('_____', '_____'),
              style: TextStyle(fontSize: 26, color: Colors.blue[900]),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getOptions(correctWord).map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      checkAnswer(option, correctWord);
                    },
                    child: Text(option, style: TextStyle(fontSize: 22)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            Text('النقاط: $score', style: TextStyle(fontSize: 26, color: Colors.blue[900])),
          ],
        ),
      ),
    );
  }
}
/////////////////////////////////////////
///////////////////////////////////////////////////////
/////////////////////////////////////////
class MemoryGamePage extends StatefulWidget {
  @override
  _MemoryGamePageState createState() => _MemoryGamePageState();
}

class _MemoryGamePageState extends State<MemoryGamePage> {
  List<Map<String, String>> wordPairs = [
    {'english': 'live', 'arabic': 'يعيش'},
    {'english': 'nothing', 'arabic': 'لا شيء'},
    {'english': 'period', 'arabic': 'فترة'},
    {'english': 'physics', 'arabic': 'فيزياء'},
    {'english': 'plan', 'arabic': 'خطة'},
    {'english': 'store', 'arabic': 'متجر'},
    {'english': 'tax', 'arabic': 'ضريبة'},
    {'english': 'analysis', 'arabic': 'تحليل'},
    {'english': 'cold', 'arabic': 'بارد'},
    {'english': 'commercial', 'arabic': 'تجاري'},
    {'english': 'directly', 'arabic': 'مباشرة'},
    {'english': 'full', 'arabic': 'ممتلئ'},
    {'english': 'involved', 'arabic': 'متورط'},
    {'english': 'itself', 'arabic': 'ذاته'},
    {'english': 'low', 'arabic': 'منخفض'},
    {'english': 'old', 'arabic': 'قديم'},
    {'english': 'policy', 'arabic': 'سياسة'},
    {'english': 'political', 'arabic': 'سياسي'},
    {'english': 'purchase', 'arabic': 'شراء'},
    {'english': 'series', 'arabic': 'سلسلة'},
  ];

  List<String> shuffledWords = [];
  List<bool> flipped = [];
  int? firstIndex;
  int? secondIndex;
  int score = 0;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    shuffledWords = [];
    flipped = [];
    firstIndex = null;
    secondIndex = null;
    score = 0;

    // مزج الكلمات الإنجليزية والعربية
    for (var pair in wordPairs) {
      shuffledWords.add(pair['english']!);
      shuffledWords.add(pair['arabic']!);
    }

    // خلط القائمة
    shuffledWords.shuffle();
    // ضبط حالة البطاقات (مقلوبة)
    flipped = List<bool>.filled(shuffledWords.length, false);
  }

  void flipCard(int index) {
    setState(() {
      flipped[index] = true;

      if (firstIndex == null) {
        firstIndex = index;
      } else if (secondIndex == null) {
        secondIndex = index;

        // مهلة قبل التحقق من المطابقة
        Timer(Duration(seconds: 1), () {
          checkMatch();
        });
      }
    });
  }

  void checkMatch() {
    if (firstIndex != null && secondIndex != null) {
      String firstWord = shuffledWords[firstIndex!];
      String secondWord = shuffledWords[secondIndex!];

      bool isMatch = false;

      // التحقق من المطابقة
      for (var pair in wordPairs) {
        if ((firstWord == pair['english'] && secondWord == pair['arabic']) ||
            (firstWord == pair['arabic'] && secondWord == pair['english'])) {
          isMatch = true;
          break;
        }
      }

      setState(() {
        if (!isMatch) {
          flipped[firstIndex!] = false;
          flipped[secondIndex!] = false;
        } else {
          score += 10;
        }
        firstIndex = null;
        secondIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة الذاكرة - مطابقة الكلمات'),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // عدد الأعمدة في الشبكة
                childAspectRatio: 2, // نسبة العرض إلى الارتفاع
                mainAxisSpacing: 10, // المسافات بين الصفوف
                crossAxisSpacing: 10, // المسافات بين الأعمدة
              ),
              itemCount: shuffledWords.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (!flipped[index] && firstIndex != index && secondIndex == null) {
                      flipCard(index);
                    }
                  },
                  child: Card(
                    color: flipped[index] ? Colors.blue[200] : Colors.blue[800],
                    child: Center(
                      child: Text(
                        flipped[index] ? shuffledWords[index] : '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'النقاط: $score',
              style: TextStyle(fontSize: 24, color: Colors.blue[900]),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetGame,
              child: Text('إعادة اللعب'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

class CrosswordPuzzlePage extends StatefulWidget {
  @override
  _CrosswordPuzzlePageState createState() => _CrosswordPuzzlePageState();
}

class _CrosswordPuzzlePageState extends State<CrosswordPuzzlePage> {
  // الكلمات الإنجليزية مع ترجمتها العربية، والموقع في الشبكة
  final List<Map<String, dynamic>> words = [
    {'word': 'live', 'translation': 'يعيش', 'row': 0, 'col': 0, 'horizontal': true},
    {'word': 'plan', 'translation': 'خطة', 'row': 0, 'col': 4, 'horizontal': false},
    {'word': 'cold', 'translation': 'بارد', 'row': 2, 'col': 0, 'horizontal': true},
    {'word': 'tax', 'translation': 'ضريبة', 'row': 4, 'col': 0, 'horizontal': true},
    {'word': 'store', 'translation': 'متجر', 'row': 6, 'col': 0, 'horizontal': true},
    {'word': 'physics', 'translation': 'فيزياء', 'row': 8, 'col': 0, 'horizontal': true},
    {'word': 'analysis', 'translation': 'تحليل', 'row': 10, 'col': 0, 'horizontal': true},
    {'word': 'period', 'translation': 'فترة', 'row': 12, 'col': 0, 'horizontal': true},
    {'word': 'series', 'translation': 'سلسلة', 'row': 14, 'col': 0, 'horizontal': true},
    {'word': 'nothing', 'translation': 'لا شيء', 'row': 16, 'col': 0, 'horizontal': true},
    {'word': 'full', 'translation': 'ممتلئ', 'row': 18, 'col': 0, 'horizontal': true},
    {'word': 'low', 'translation': 'منخفض', 'row': 5, 'col': 10, 'horizontal': true},
    {'word': 'political', 'translation': 'سياسي', 'row': 7, 'col': 10, 'horizontal': true},
    {'word': 'policy', 'translation': 'سياسة', 'row': 9, 'col': 10, 'horizontal': true},
    {'word': 'purchase', 'translation': 'شراء', 'row': 11, 'col': 10, 'horizontal': true},
    {'word': 'commercial', 'translation': 'تجاري', 'row': 13, 'col': 10, 'horizontal': true},
    {'word': 'involved', 'translation': 'متورط', 'row': 15, 'col': 10, 'horizontal': true},
    {'word': 'itself', 'translation': 'ذاته', 'row': 17, 'col': 10, 'horizontal': true},
    {'word': 'directly', 'translation': 'مباشرة', 'row': 19, 'col': 10, 'horizontal': true},
    {'word': 'old', 'translation': 'قديم', 'row': 3, 'col': 6, 'horizontal': true},
  ];

  // حجم الشبكة 20x20
  List<List<String?>> grid = List.generate(20, (_) => List<String?>.filled(20, null));

  // حالة إدخال الحروف
  List<List<TextEditingController>> controllers = [];

  @override
  void initState() {
    super.initState();

    // تعبئة الشبكة بالكلمات المتقاطعة
    for (var wordData in words) {
      String word = wordData['word'];
      int row = wordData['row'];
      int col = wordData['col'];
      bool horizontal = wordData['horizontal'];

      for (int i = 0; i < word.length; i++) {
        if (horizontal) {
          grid[row][col + i] = word[i];
        } else {
          grid[row + i][col] = word[i];
        }
      }
    }

    // إنشاء محررات النصوص
    for (int i = 0; i < 20; i++) {
      controllers.add(List<TextEditingController>.generate(20, (_) => TextEditingController()));
    }
  }

  // دالة للتحقق من صحة الكلمات المدخلة
  bool checkCrossword() {
    for (var wordData in words) {
      String word = wordData['word'];
      int row = wordData['row'];
      int col = wordData['col'];
      bool horizontal = wordData['horizontal'];

      for (int i = 0; i < word.length; i++) {
        String? letter = horizontal ? controllers[row][col + i].text : controllers[row + i][col].text;

        if (letter == null || letter.isEmpty || letter != word[i]) {
          return false;
        }
      }
    }
    return true;
  }

  // واجهة المستخدم
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة الكلمات المتقاطعة'),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 20,
                  childAspectRatio: 1.0,
                ),
                itemCount: 400, // 20x20 شبكة
                itemBuilder: (context, index) {
                  int row = index ~/ 20;
                  int col = index % 20;

                  // إذا كانت الحروف جزءًا من الكلمة
                  if (grid[row][col] != null) {
                    return Padding(
                      padding: EdgeInsets.all(2),
                      child: TextField(
                        controller: controllers[row][col],
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    // مربع فارغ
                    return Container(
                      margin: EdgeInsets.all(2),
                      color: Colors.grey[300],
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                bool result = checkCrossword();
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(result ? 'مبروك!' : 'حاول مرة أخرى'),
                    content: Text(result
                        ? 'لقد أكملت الكلمات المتقاطعة بنجاح!'
                        : 'يوجد بعض الأخطاء.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('حسنًا'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('تحقق من الإجابات'),
            ),
          ],
        ),
      ),
    );
  }
}


/////////////////////////////////////////////////
///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////






class WordShootingGame extends StatefulWidget {
  @override
  _WordShootingGameState createState() => _WordShootingGameState();
}

class _WordShootingGameState extends State<WordShootingGame> {
  final List<Map<String, String>> wordPairs = [
    {'english': 'live', 'arabic': 'يعيش'},
    {'english': 'plan', 'arabic': 'خطة'},
    {'english': 'cold', 'arabic': 'بارد'},
    {'english': 'tax', 'arabic': 'ضريبة'},
    {'english': 'store', 'arabic': 'متجر'},
    {'english': 'physics', 'arabic': 'فيزياء'},
    {'english': 'analysis', 'arabic': 'تحليل'},
    {'english': 'period', 'arabic': 'فترة'},
    {'english': 'series', 'arabic': 'سلسلة'},
    {'english': 'nothing', 'arabic': 'لا شيء'},
    {'english': 'full', 'arabic': 'ممتلئ'},
    {'english': 'low', 'arabic': 'منخفض'},
    {'english': 'political', 'arabic': 'سياسي'},
    {'english': 'policy', 'arabic': 'سياسة'},
    {'english': 'purchase', 'arabic': 'شراء'},
    {'english': 'commercial', 'arabic': 'تجاري'},
    {'english': 'involved', 'arabic': 'متورط'},
    {'english': 'itself', 'arabic': 'ذاته'},
    {'english': 'directly', 'arabic': 'مباشرة'},
    {'english': 'old', 'arabic': 'قديم'},
  ];

  Random random = Random();
  List<_Word> words = [];
  int score = 0;
  String currentTranslation = '';
  bool gameRunning = true;
  Timer? spawnTimer;
  Timer? moveTimer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    spawnTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (gameRunning) {
        spawnWord();
      }
    });

    moveTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (gameRunning) {
        moveWords();
      }
    });

    nextTranslation();
  }

  void spawnWord() {
    setState(() {
      // اختيار كلمة عشوائية من القائمة
      int index = random.nextInt(wordPairs.length);
      String englishWord = wordPairs[index]['english']!;
      double startY = random.nextDouble() * MediaQuery.of(context).size.height / 2;

      words.add(_Word(
        word: englishWord,
        positionX: 0,
        positionY: startY,
      ));
    });
  }

  void nextTranslation() {
    int index = random.nextInt(wordPairs.length);
    setState(() {
      currentTranslation = wordPairs[index]['arabic']!;
    });
  }

  void removeWord(_Word word) {
    setState(() {
      words.remove(word);
    });
  }

  void checkWord(_Word word) {
    for (var pair in wordPairs) {
      if (pair['english'] == word.word && pair['arabic'] == currentTranslation) {
        setState(() {
          score += 10;
          removeWord(word);
          nextTranslation(); // انتقال إلى الترجمة التالية
        });
        return;
      }
    }
    setState(() {
      score -= 5; // خسارة نقاط إذا اختار الكلمة الخاطئة
      removeWord(word);
    });
  }

  void moveWords() {
    setState(() {
      words.forEach((word) {
        word.positionX += 2; // تحريك الكلمات نحو اليمين

        // إذا خرجت الكلمة من الشاشة، تتم إزالتها
        if (word.positionX > MediaQuery.of(context).size.width / 2 - 50) {
          removeWord(word);
        }
      });
    });
  }

  @override
  void dispose() {
    spawnTimer?.cancel();
    moveTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double halfWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة التصويب - Word Shooting'),
        backgroundColor: Colors.blue[800],
      ),
      body: Row(
        children: [
          // النصف الأيسر: الترجمة العربية الثابتة
          Container(
            width: halfWidth,
            color: Colors.blue[50],
            child: Center(
              child: Text(
                currentTranslation,
                style: TextStyle(fontSize: 32, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // النصف الأيمن: الكلمات الإنجليزية المتحركة
          Container(
            width: halfWidth,
            color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  right: 10,
                  child: Text(
                    'النقاط: $score',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                ...words.map((word) {
                  return Positioned(
                    top: word.positionY,
                    left: word.positionX,
                    child: GestureDetector(
                      onTap: () {
                        checkWord(word);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: Colors.blue[400],
                        child: Text(
                          word.word,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Word {
  String word;
  double positionX;
  double positionY;

  _Word({
    required this.word,
    required this.positionX,
    required this.positionY,
  });
}

/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////




class QuickMatchGame extends StatefulWidget {
  @override
  _QuickMatchGameState createState() => _QuickMatchGameState();
}

class _QuickMatchGameState extends State<QuickMatchGame> {
  final List<Map<String, String>> wordPairs = [
    {'english': 'live', 'arabic': 'يعيش'},
    {'english': 'plan', 'arabic': 'خطة'},
    {'english': 'cold', 'arabic': 'بارد'},
    {'english': 'tax', 'arabic': 'ضريبة'},
    {'english': 'store', 'arabic': 'متجر'},
    {'english': 'physics', 'arabic': 'فيزياء'},
    {'english': 'analysis', 'arabic': 'تحليل'},
    {'english': 'period', 'arabic': 'فترة'},
    {'english': 'series', 'arabic': 'سلسلة'},
    {'english': 'nothing', 'arabic': 'لا شيء'},
  ];

  List<String> englishWords = [];
  List<String> arabicWords = [];
  Map<String, bool> matchedPairs = {};
  int score = 0;
  int totalWords = 0;
  bool gameFinished = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      englishWords = wordPairs.map((pair) => pair['english']!).toList();
      arabicWords = wordPairs.map((pair) => pair['arabic']!).toList();
      englishWords.shuffle();
      arabicWords.shuffle();
      matchedPairs = {};
      score = 0;
      totalWords = wordPairs.length;
      gameFinished = false;
    });
  }

  void onDragEnd(String englishWord, String arabicWord) {
    setState(() {
      for (var pair in wordPairs) {
        if (pair['english'] == englishWord && pair['arabic'] == arabicWord) {
          matchedPairs[englishWord] = true;
          score += 10;
          if (matchedPairs.length == totalWords) {
            gameFinished = true;
          }
          return;
        }
      }
      // إذا كانت الإجابة خاطئة، لا نضيف نقاط
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة الجمع السريع - Quick Match'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (!gameFinished)
                Text(
                  'اسحب الكلمة الإنجليزية إلى الترجمة الصحيحة',
                  style: TextStyle(fontSize: 20),
                ),
              if (gameFinished)
                Text(
                  'مبروك! لقد أكملت اللعبة',
                  style: TextStyle(fontSize: 24, color: Colors.green),
                ),
              SizedBox(height: 20),
              Row(
                children: [
                  // الكلمات الإنجليزية التي يمكن سحبها
                  Expanded(
                    child: Column(
                      children: englishWords.map((englishWord) {
                        return Draggable<String>(
                          data: englishWord,
                          child: Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(16),
                            color: matchedPairs[englishWord] == true
                                ? Colors.green
                                : Colors.blue[200],
                            child: Text(
                              englishWord,
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                          feedback: Material(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              color: Colors.blue[200],
                              child: Text(
                                englishWord,
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          childWhenDragging: Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(16),
                            color: Colors.grey,
                            child: Text(
                              englishWord,
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  // المساحة بين الأعمدة
                  SizedBox(width: 20),
                  // الكلمات العربية
                  Expanded(
                    child: Column(
                      children: arabicWords.map((arabicWord) {
                        return DragTarget<String>(
                          onAccept: (englishWord) {
                            onDragEnd(englishWord, arabicWord);
                          },
                          builder: (context, candidateData, rejectedData) {
                            return Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(16),
                              color: Colors.orange[200],
                              child: Text(
                                arabicWord,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // عرض النقاط
              Text(
                'النقاط: $score',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              if (gameFinished)
                ElevatedButton(
                  onPressed: startGame,
                  child: Text('إعادة اللعب'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
