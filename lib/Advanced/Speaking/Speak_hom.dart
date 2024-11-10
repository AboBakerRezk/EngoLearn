import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'package:string_similarity/string_similarity.dart';

import '../../settings/setting_2.dart';
import 'Speak_1.dart';
import 'Speak_10.dart';
import 'Speak_11.dart';
import 'Speak_12.dart';
import 'Speak_13.dart';
import 'Speak_14.dart';
import 'Speak_15.dart';
import 'Speak_2.dart';
import 'Speak_3.dart';
import 'Speak_4.dart';
import 'Speak_5.dart';
import 'Speak_6.dart';
import 'Speak_7.dart';
import 'Speak_8.dart';
import 'Speak_9.dart';





class Speak_Home extends StatefulWidget {
  @override
  _Speak_HomeState createState() => _Speak_HomeState();
}

class _Speak_HomeState extends State<Speak_Home> {
  List<bool> _isButtonEnabled = List.generate(25, (index) => true); // جميع الأزرار مفعلة

  @override
  void initState() {
    super.initState();
    // تمكين جميع الأزرار دون الحاجة إلى تحميل الحالة
    _enableAllButtons();
  }

  void _enableAllButtons() {
    for (int i = 0; i < _isButtonEnabled.length; i++) {
      _isButtonEnabled[i] = true; // تفعيل كل الأزرار
    }
    setState(() {});
  }

  Future<void> _openLesson(int index) async {
    // التنقل إلى الصفحة المناسبة عند الضغط على الزر
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => getPage(index + 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.black87], // لون الخلفية التدرجية
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: GridView.builder(
            padding: EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // عدد الأزرار في كل صف
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 15,
            itemBuilder: (context, index) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // لون النص
                  backgroundColor: Colors.blue,  // لون الخلفية الأزرق
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  elevation: 5, // إضافة ظل للزر
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // زوايا مستديرة للزر
                    side: BorderSide(color: Colors.blueAccent, width: 2), // حدود الزر بلون أزرق فاتح
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // حجم الزر
                ),
                onPressed: () => _openLesson(index), // فتح الدرس المناسب عند الضغط
                child: Text('${AppLocale.S30.getString(context)} ${index + 1}'), // النص داخل الزر
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getPage(int pageNumber) {
    // هنا يتم تحديد أي صفحة يتم فتحها حسب رقم الدرس
    switch (pageNumber) {
      case 1:
        return SpeakingPage1();
      case 2:
        return SpeakingPage2();
      case 3:
        return SpeakingPage3();
      case 4:
        return SpeakingPage4();
      case 5:
        return SpeakingPage5();
      case 6:
        return SpeakingPage6();
      case 7:
        return SpeakingPage7();
      case 8:
        return SpeakingPage8();
      case 9:
        return SpeakingPage9();
      case 10:
        return SpeakingPage10();
      case 11:
        return SpeakingPage11();
      case 12:
        return SpeakingPage12();
      case 13:
        return SpeakingPage13();
      case 14:
        return SpeakingPage14();
      case 15:
        return SpeakingPage15();
      default:
        return SpeakingPage1(); // الافتراضي إذا حدث خطأ
    }
  }
}






























final List<String> sentences = [
  'Hello, how are you? I am fine, thank you. - مرحبًا، كيف حالك؟ أنا بخير، شكرًا!',
  'What is your name? My name is John. - ما اسمك؟ اسمي جون.',
  'How old are you? I am 25 years old. - كم عمرك؟ عمري 25 سنة.',
  'Where are you from? I am from the United States. - من أين أنت؟ أنا من الولايات المتحدة.',
  'What do you do? I am a teacher. - ماذا تعمل؟ أنا معلم.',
  'Do you speak English? Yes, I speak English. - هل تتحدث الإنجليزية؟ نعم، أتحدث الإنجليزية.',
  'Can you help me? Yes, of course! - هل يمكنك مساعدتي؟ نعم بالطبع!',
  'Where is the nearest hospital? It is two blocks away. - أين أقرب مستشفى؟ يبعد بمقدار مبنيين.',
  'What time is it? It is 10 o\'clock. - كم الساعة؟ الساعة العاشرة.',
  'How much does this cost? It costs \$50. - كم يكلف هذا؟ يكلف 50 دولارًا.',
  'Can I have the bill, please? Sure, here it is. - هل يمكنني الحصول على الفاتورة من فضلك؟ بالتأكيد، ها هي.',
  'Do you have a reservation? Yes, I have a reservation. - هل لديك حجز؟ نعم، لدي حجز.',
  'Where is the bathroom? The bathroom is down the hall. - أين الحمام؟ الحمام في نهاية الممر.',
  'How is the weather today? It is sunny and warm. - كيف الطقس اليوم؟ الجو مشمس ودافئ.',
  'Can you give me directions? Yes, go straight and turn left. - هل يمكنك إعطائي الاتجاهات؟ نعم، اذهب مستقيمًا ثم انعطف يسارًا.',
  'What did you do yesterday? I went to the park. - ماذا فعلت بالأمس؟ ذهبت إلى الحديقة.',
  'Are you busy right now? No, I am free. - هل أنت مشغول الآن؟ لا، أنا متاح.',
  'Do you like coffee? Yes, I love coffee! - هل تحب القهوة؟ نعم، أحب القهوة!',
  'What is your favorite food? My favorite food is pizza. - ما هو طعامك المفضل؟ طعامي المفضل هو البيتزا.',
  'Where do you live? I live in New York. - أين تعيش؟ أعيش في نيويورك.',
  'How can I get to the airport? You can take a taxi or the bus. - كيف يمكنني الوصول إلى المطار؟ يمكنك أخذ سيارة أجرة أو الحافلة.',
  'What time does the train leave? The train leaves at 5 PM. - متى يغادر القطار؟ يغادر القطار في الساعة الخامسة مساءً.',
  'How long does the flight take? The flight takes about 3 hours. - كم يستغرق وقت الرحلة؟ تستغرق الرحلة حوالي 3 ساعات.',
  'What is your favorite movie? My favorite movie is Inception. - ما هو فيلمك المفضل؟ فيلمي المفضل هو Inception.',
  'Do you like music? Yes, I love music. - هل تحب الموسيقى؟ نعم، أحب الموسيقى.',
  'Can you play any instruments? Yes, I play the guitar. - هل يمكنك العزف على أي آلة موسيقية؟ نعم، أعزف على الجيتار.',
  'Do you have any pets? Yes, I have a dog. - هل لديك حيوانات أليفة؟ نعم، لدي كلب.',
  'How many languages do you speak? I speak two languages. - كم عدد اللغات التي تتحدثها؟ أتحدث لغتين.',
  'What is your favorite color? My favorite color is blue. - ما هو لونك المفضل؟ لوني المفضل هو الأزرق.',
  'What time do you usually wake up? I usually wake up at 6 AM. - في أي وقت تستيقظ عادةً؟ أستيقظ عادةً في الساعة السادسة صباحًا.',
  'Do you like sports? Yes, I like football. - هل تحب الرياضة؟ نعم، أحب كرة القدم.',
  'Have you ever been to Europe? Yes, I have been to Europe. - هل سبق لك أن ذهبت إلى أوروبا؟ نعم، لقد ذهبت إلى أوروبا.',
  'What is your job? I am a software engineer. - ما هو عملك؟ أنا مهندس برمجيات.',
  'Can you drive a car? Yes, I can drive. - هل تستطيع قيادة السيارة؟ نعم، أستطيع القيادة.',
  'What are your hobbies? I like reading and hiking. - ما هي هواياتك؟ أحب القراءة والمشي.',
  'What is your favorite book? My favorite book is 1984 by George Orwell. - ما هو كتابك المفضل؟ كتابي المفضل هو 1984 لجورج أورويل.',
  'What do you like to do in your free time? I like to watch movies. - ماذا تحب أن تفعل في وقت فراغك؟ أحب مشاهدة الأفلام.',
  'Do you have any brothers or sisters? Yes, I have one sister. - هل لديك إخوة أو أخوات؟ نعم، لدي أخت واحدة.',
  'What is your favorite season? My favorite season is spring. - ما هو فصلك المفضل؟ فصلي المفضل هو الربيع.',
  'How often do you exercise? I exercise three times a week. - كم مرة تمارس الرياضة؟ أمارس الرياضة ثلاث مرات في الأسبوع.',
  'Do you like traveling? Yes, I love traveling. - هل تحب السفر؟ نعم، أحب السفر.',
  'What is your favorite country? My favorite country is Japan. - ما هي دولتك المفضلة؟ دولتي المفضلة هي اليابان.',
  'What kind of music do you like? I like pop music. - ما نوع الموسيقى التي تحبها؟ أحب موسيقى البوب.',
  'Where do you work? I work at a tech company. - أين تعمل؟ أعمل في شركة تقنية.',
  'How do you get to work? I take the subway. - كيف تصل إلى العمل؟ أستقل المترو.',
  'Do you enjoy your job? Yes, I enjoy my job. - هل تستمتع بعملك؟ نعم، أستمتع بعملي.',
  'What are you doing this weekend? I am going hiking. - ماذا ستفعل في عطلة نهاية الأسبوع؟ سأذهب في نزهة.',
  'Do you prefer tea or coffee? I prefer tea. - هل تفضل الشاي أم القهوة؟ أفضل الشاي.',
  'What time do you go to bed? I go to bed at 10 PM. - في أي وقت تذهب إلى السرير؟ أذهب إلى السرير في الساعة العاشرة مساءً.',
  'What is your favorite holiday? My favorite holiday is Christmas. - ما هي عطلتك المفضلة؟ عطلتي المفضلة هي عيد الميلاد.',
  'What is your phone number? My phone number is 123-456-7890. - ما هو رقم هاتفك؟ رقم هاتفي هو 123-456-7890.'
];







class SpeakingPage extends StatefulWidget {
  @override
  _SpeakingPageState createState() => _SpeakingPageState();
}

class _SpeakingPageState extends State<SpeakingPage> with SingleTickerProviderStateMixin {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _transcribedText = '';
  TextEditingController _answerController = TextEditingController();
  String _feedbackMessage = '';
  late FlutterTts _flutterTts;
  int _score = 0;
  int _level = 1;
  String _currentSentence = '';
  String _correctAnswer = '';
  String _title = '';
  bool _isTranslating = false; // لتحديد حالة الترجمة
  final Color primaryColor = Color(0xFF13194E); // اللون الأساسي

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
    _loadScore();
    _startNewSentence();
  }

  Future<void> _loadScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _score = prefs.getInt('score') ?? 0;
      _title = prefs.getString('title') ?? _getTitle(_score);
      _level = (_score ~/ 100) + 1;
    });
  }

  Future<void> _saveScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', _score);
    await prefs.setString('title', _title);
  }

  String _getTitle(int score) {
    // الدالة كما هي
    if (score < 100) return 'مبتدئ';
    if (score < 200) return 'ممارس';
    if (score < 300) return 'متوسط';
    if (score < 400) return 'متقدم';
    if (score < 500) return 'خبير';
    if (score < 600) return 'ماهر';
    if (score < 700) return 'محترف';
    if (score < 800) return 'خبير متمكن';
    if (score < 900) return 'أسطورة';
    return 'عبقري';
  }

  void _startNewSentence() {
    // بدء جملة جديدة
    setState(() {
      _feedbackMessage = '';
      _answerController.clear();
      _transcribedText = '';
      _currentSentence = sentences[Random().nextInt(sentences.length)];
      _correctAnswer = _currentSentence.split(' - ')[0].trim();
    });
    _speak(_currentSentence);
  }

  Future<void> _speak(String text) async {
    String language = 'en-US'; // استخدام اللغة الإنجليزية
    await _flutterTts.setLanguage(language);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('Status: $val'),
        onError: (val) => print('Error: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _transcribedText = val.recognizedWords;
            });
          },
        );

        // أضف مؤقت لإيقاف التسجيل بعد 5 ثواني
        Timer(Duration(seconds: 9), () {
          if (_isListening) {
            _speech.stop();
            setState(() {
              _isListening = false;
            });
            _analyzeAnswer(); // تحليل الإجابة مباشرة بعد إيقاف التسجيل
          }
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _analyzeAnswer() {
    // تحليل الإجابة
    double similarity = _transcribedText.similarityTo(_correctAnswer) * 100;

    setState(() {
      if (similarity == 100) {
        _feedbackMessage = 'إجابة ممتازة! (100%)';
        _score += 10; // نقاط للإجابة المثالية
      } else if (similarity >= 80) {
        _feedbackMessage = 'إجابة جيدة جدًا! (80%)';
        _score += 8; // نقاط للإجابة الجيدة
      } else if (similarity >= 60) {
        _feedbackMessage = 'إجابة لا بأس بها! (60%)';
        _score += 5; // نقاط للإجابة المتوسطة
      } else {
        _feedbackMessage = 'يمكنك تحسين الإجابة. (أقل من 60%)';
      }
      _title = _getTitle(_score); // تحديث اللقب بناءً على النقاط
      _saveScore(); // حفظ النقاط واللقب
    });
  }

  @override
  void dispose() {
    _speech.stop();
    _flutterTts.stop();
    _answerController.dispose();
    super.dispose();
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    // دالة لإنشاء الأزرار
    return ElevatedButton(
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
        label,
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'النقاط: $_score', // عرض النقاط في شريط التطبيق
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(height: 20),

              Text(
                'الجملة الحالية:',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                _currentSentence,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),
              IconButton(
                iconSize: 48.0,
                icon: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: _isListening ? Colors.red : Colors.white,
                ),
                onPressed: _listen,
              ),
              SizedBox(height: 10),
              _buildButton('استمع إلى الجملة', () => _speak(_currentSentence)),
              SizedBox(height: 20),

              _buildButton('التالى', _startNewSentence),
              SizedBox(height: 10),
              Text(
                _feedbackMessage,
                style: TextStyle(
                  fontSize: 18,
                  color: _feedbackMessage.contains('إجابة') ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'اللقب: $_title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              if (_transcribedText.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ما قلته:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      _transcribedText,
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ],
                ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}



class SpeakHom extends StatefulWidget {
  const SpeakHom({super.key});

  @override
  State<SpeakHom> createState() => _SpeakHomState();
}

class _SpeakHomState extends State<SpeakHom> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

final List<List<List<String>>> allWords = [
  [
    ['this', 'هذا'],
    ['an', 'أ'],
    ['by', 'بواسطة'],
    ['not', 'ليس'],
    ['but', 'لكن'],
  ],
  [
    ['at', 'في'],
    ['from', 'من'],
    ['I', 'أنا'],
    ['they', 'هم'],
    ['more', 'أكثر'],
  ],
  [
    ['will', 'سوف'],
    ['if', 'إذا'],
    ['some', 'بعض'],
    ['there', 'هناك'],
    ['what', 'ماذا'],
  ],
  [
    ['about', 'حول'],
    ['which', 'التي'],
    ['when', 'متى'],
    ['one', 'واحد'],
    ['their', 'لهم'],
  ],
];





class SpeechPages extends StatefulWidget {
  @override
  _SpeechPagesState createState() => _SpeechPagesState();
}

class _SpeechPagesState extends State<SpeechPages> with SingleTickerProviderStateMixin {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isListening = false;
  String _spokenText = "";
  String _targetText = "";
  int _currentWordIndex = 0;
  int currentPage = 0;
  int score = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E);


  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    _targetText = allWords[currentPage][_currentWordIndex][0]; // تعيين الكلمة الأولى
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          setState(() {
            _spokenText = val.recognizedWords;
            _isListening = false;
            _checkResult();
          });
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _checkResult() {
    String spoken = _spokenText.toLowerCase().trim();
    String target = _targetText.toLowerCase().trim();

    // إزالة المسافات الزائدة
    spoken = spoken.replaceAll(RegExp(r'\s+'), ' ');

    // تقسيم النص المنطوق إلى كلمات
    List<String> spokenWords = spoken.split(' ');

    // التحقق إذا كانت جميع الكلمات هي نفس الكلمة المستهدفة
    bool allWordsMatch = spokenWords.every((word) => word == target);

    if (allWordsMatch) {
      setState(() {
        score += 10;
      });
    } else {
      setState(() {
        score -= 5;
      });
    }
  }

  // الانتقال إلى الكلمة التالية
  void _nextWord() {
    setState(() {
      if (_currentWordIndex < allWords[currentPage].length - 1) {
        _currentWordIndex++;
      } else {
        _currentWordIndex = 0;
        if (currentPage < allWords.length - 1) {
          currentPage++;
        } else {
          currentPage = 0; // إعادة التعيين إذا انتهت القائمة
        }
      }
      _targetText = allWords[currentPage][_currentWordIndex][0]; // تحديث الكلمة التالية
    });
  }

  void _speakText() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(_targetText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'التحدث',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
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
              Text(
                'قل الكلمة التالية:',
                style: TextStyle(fontSize: 26, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                _targetText, // الكلمة المطلوبة
                style: TextStyle(fontSize: 32, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              FadeTransition(
                opacity: _animation,
                child: ElevatedButton(
                  onPressed: _listen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    _isListening ? 'التحدث...' : 'ابدأ التحدث',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              FadeTransition(
                opacity: _animation,
                child: ElevatedButton(
                  onPressed: _speakText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    'استمع إلى الكلمة',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              FadeTransition(
                opacity: _animation,
                child: ElevatedButton(
                  onPressed: _nextWord, // الانتقال إلى الكلمة التالية
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    'الكلمة التالية',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'الكلام المنطوق:',
                style: TextStyle(fontSize: 26, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                _spokenText,
                style: TextStyle(fontSize: 32, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                'النقاط: $score',
                style: TextStyle(fontSize: 26, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class InstantTranslationPage extends StatefulWidget {
  @override
  _InstantTranslationPageState createState() => _InstantTranslationPageState();
}

class _InstantTranslationPageState extends State<InstantTranslationPage>
    with SingleTickerProviderStateMixin {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isListening = false;
  bool _isTranslating = false;
  String _text = '';
  String _translatedText = '';
  String _currentLocaleId = 'ar_AR';
  String _statusMessage = 'اضغط على الميكروفون للبدء';
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _englishTextController = TextEditingController();
  final TextEditingController _arabicTextController = TextEditingController();
  String _selectedLanguage = 'ar-SA'; // اللغة الافتراضية للنطق

  final Color primaryColor = Color(0xFF13194E);

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _englishTextController.dispose();
    _arabicTextController.dispose();
    super.dispose();
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          _isListening = true;
          _statusMessage = 'جاري الاستماع...';
        });
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
          localeId: _currentLocaleId,
        );
      } else {
        setState(() {
          _statusMessage = 'فشل في تفعيل الميكروفون';
        });
      }
    } else {
      setState(() {
        _isListening = false;
        _statusMessage = 'تم الاستماع، جاري الترجمة...';
      });
      _speech.stop();
      await _processTranslation();
    }
  }

  Future<String> translateText(String input, String targetLang) async {
    try {
      final response = await http.post(
        Uri.parse('https://translation.googleapis.com/language/translate/v2?key=YOUR_API_KEY'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'q': input,
          'target': targetLang,
          'format': 'text',
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['data']['translations'][0]['translatedText'];
      } else {
        print('Error response: ${response.body}');
        return 'خطأ في الترجمة';
      }
    } catch (e) {
      print('Translation Error: $e');
      return 'فشل في الاتصال بخدمة الترجمة';
    }
  }

  Future<void> _speak(String text, String language) async {
    try {
      await _flutterTts.setLanguage(language);
      await _flutterTts.speak(text);
    } catch (e) {
      print('Speech Error: $e');
    }
  }

  Future<void> _processTranslation() async {
    setState(() {
      _isTranslating = true;
      _statusMessage = 'جاري الترجمة...';
    });

    String inputText = _currentLocaleId == 'ar_AR'
        ? _arabicTextController.text
        : _englishTextController.text;

    String targetLang = _currentLocaleId == 'ar_AR' ? 'en' : 'ar';
    String translatedText = await translateText(inputText, targetLang);
    String ttsLanguage = _selectedLanguage;

    setState(() {
      _translatedText = translatedText;
      _isTranslating = false;
      _statusMessage = 'تمت الترجمة، جاري النطق...';
    });

    await _speak(translatedText, ttsLanguage);
    setState(() {
      _statusMessage = 'جاهز لاستماع جديد';
    });
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
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
          label,
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return DropdownButton<String>(
      value: _selectedLanguage,
      dropdownColor: primaryColor,
      iconEnabledColor: Colors.white,
      items: [
        DropdownMenuItem(
          value: 'ar-SA',
          child: Text('العربية', style: TextStyle(color: Colors.white)),
        ),
        DropdownMenuItem(
          value: 'en-US',
          child: Text('English', style: TextStyle(color: Colors.white)),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'الترجمة الفورية',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
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
              Text(
                'الترجمة من العربية إلى الإنجليزية:',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _arabicTextController,
                style: TextStyle(fontSize: 20, color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'أدخل النص بالعربية',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 20),
              Text(
                'الترجمة من الإنجليزية إلى العربية:',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _englishTextController,
                style: TextStyle(fontSize: 20, color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter text in English',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'اختر لغة النطق:',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  _buildLanguageDropdown(),
                ],
              ),
              SizedBox(height: 30),
              _buildButton('ترجمة النصوص', _processTranslation),
              SizedBox(height: 30),
              Text(
                'النص المُترجم:',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                _translatedText,
                style: TextStyle(fontSize: 24.0, color: Colors.blue),
              ),
              SizedBox(height: 30),
              Text(
                _statusMessage,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              if (_isTranslating)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


