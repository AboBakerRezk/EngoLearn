import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'package:string_similarity/string_similarity.dart';

final List<String> sentences2 = [
  'Hello, how have you been? I\'ve been doing quite well, thank you. - مرحبًا، كيف حالك؟ أنا بخير جدًا، شكرًا!',
  'Could you tell me your name? My name is John Doe. - هل يمكنك أن تخبرني باسمك؟ اسمي جون دو.',
  'What age are you currently? I am 25 years old and counting. - كم عمرك حاليًا؟ عمري 25 سنة وما زلت أعد.',
  'Which country do you hail from? I am originally from the United States. - من أي بلد أنت؟ أنا من الولايات المتحدة في الأصل.',
  'What is your profession? I work as a teacher at a local school. - ما هي مهنتك؟ أعمل كمعلم في مدرسة محلية.',
  'Do you have proficiency in English? Yes, I am fluent in English. - هل لديك إتقان للغة الإنجليزية؟ نعم، أنا طليق في اللغة الإنجليزية.',
  'Would you mind assisting me? Absolutely, I\'d be happy to help! - هل تمانع في مساعدتي؟ بالطبع، سأكون سعيدًا لمساعدتك!',
  'Could you tell me where the nearest hospital is located? It\'s just two blocks away. - هل يمكنك إخباري أين يقع أقرب مستشفى؟ إنه يبعد فقط بمقدار مبنيين.',
  'What is the current time? It is exactly 10 o\'clock. - ما هو الوقت الحالي؟ إنها تمام الساعة العاشرة.',
  'How much is this item priced at? It costs \$50. - كم ثمن هذا المنتج؟ يكلف 50 دولارًا.',
  'May I see the bill, please? Certainly, here you go. - هل يمكنني رؤية الفاتورة من فضلك؟ بالتأكيد، ها هي.',
  'Do you happen to have a reservation? Yes, I made a reservation. - هل لديك حجز؟ نعم، لقد قمت بعمل حجز.',
  'Can you direct me to the bathroom? The bathroom is located down the hall. - هل يمكنك إرشادي إلى الحمام؟ الحمام يقع في نهاية الممر.',
  'How is the weather treating you today? It is sunny and pleasantly warm. - كيف يتعامل الطقس معك اليوم؟ الجو مشمس ودافئ بشكل لطيف.',
  'Could you provide me with directions? Sure, just go straight and then turn left. - هل يمكنك أن تعطني الاتجاهات؟ بالتأكيد، اذهب مباشرة ثم انعطف يسارًا.',
  'What did you accomplish yesterday? I spent the day at the park. - ماذا أنجزت بالأمس؟ قضيت اليوم في الحديقة.',
  'Are you occupied at the moment? No, I am currently free. - هل أنت مشغول في هذه اللحظة؟ لا، أنا متاح حاليًا.',
  'Are you a fan of coffee? Yes, I absolutely adore coffee! - هل أنت من محبي القهوة؟ نعم، أنا أحب القهوة بشدة!',
  'What dish do you enjoy the most? My favorite dish is pizza. - ما هو الطبق الذي تستمتع به أكثر؟ طعامي المفضل هو البيتزا.',
  'Which city do you reside in? I live in New York City. - في أي مدينة تعيش؟ أعيش في مدينة نيويورك.',
  'How can I reach the airport from here? You can take a taxi or the bus service. - كيف يمكنني الوصول إلى المطار من هنا؟ يمكنك أخذ سيارة أجرة أو خدمة الحافلات.',
  'When does the train typically depart? The train leaves at 5 PM sharp. - متى يغادر القطار عادة؟ يغادر القطار في الساعة الخامسة مساءً بالضبط.',
  'How long is the flight duration? The flight takes approximately 3 hours. - كم تستغرق الرحلة من الوقت؟ تستغرق الرحلة حوالي 3 ساعات.',
  'What is your all-time favorite movie? My favorite movie is Inception. - ما هو فيلمك المفضل على مر العصور؟ فيلمي المفضل هو Inception.',
  'Are you passionate about music? Yes, I truly love music. - هل لديك شغف بالموسيقى؟ نعم، أحب الموسيقى حقًا.',
  'Can you play any musical instruments? Yes, I play the guitar quite well. - هل يمكنك العزف على أي آلة موسيقية؟ نعم، أعزف على الجيتار بشكل جيد.',
  'Do you own any pets? Yes, I have a lovely dog. - هل تملك أي حيوانات أليفة؟ نعم، لدي كلب جميل.',
  'How many languages are you proficient in? I am fluent in two languages. - كم عدد اللغات التي تجيدها؟ أنا طليق في لغتين.',
  'What color do you prefer the most? My preferred color is blue. - ما هو اللون الذي تفضله أكثر؟ لوني المفضل هو الأزرق.',
  'At what time do you usually wake up in the morning? I typically wake up at 6 AM. - في أي وقت تستيقظ عادةً في الصباح؟ أستيقظ عادةً في الساعة السادسة صباحًا.',
  'Do you enjoy playing sports? Yes, I particularly like football. - هل تستمتع بممارسة الرياضة؟ نعم، أحب كرة القدم بشكل خاص.',
  'Have you ever visited Europe? Yes, I have had the chance to visit Europe. - هل سبق لك أن زرت أوروبا؟ نعم، أتيحت لي الفرصة لزيارة أوروبا.',
  'What is your current occupation? I work as a software engineer. - ما هي وظيفتك الحالية؟ أعمل كمهندس برمجيات.',
  'Are you capable of driving a car? Yes, I am able to drive. - هل يمكنك قيادة السيارة؟ نعم، يمكنني القيادة.',
  'What are your favorite pastimes? I enjoy reading and hiking. - ما هي هواياتك المفضلة؟ أحب القراءة والمشي.',
  'Which book has had the most impact on you? My favorite book is 1984 by George Orwell. - أي كتاب كان له أكبر تأثير عليك؟ كتابي المفضل هو 1984 لجورج أورويل.',
  'What do you like to do during your leisure time? I enjoy watching movies. - ماذا تحب أن تفعل في وقت فراغك؟ أحب مشاهدة الأفلام.',
  'Do you have siblings? Yes, I have one sister and one brother. - هل لديك إخوة؟ نعم، لدي أخت واحدة وأخ واحد.',
  'What season do you enjoy the most? My favorite season is spring. - ما هو الفصل الذي تستمتع به أكثر؟ فصلي المفضل هو الربيع.',
  'How frequently do you engage in physical exercise? I work out three times a week. - كم مرة تمارس الرياضة؟ أمارس الرياضة ثلاث مرات في الأسبوع.',
  'Are you a fan of traveling? Yes, I absolutely love traveling. - هل أنت من محبي السفر؟ نعم، أحب السفر بشدة.',
  'Which country captures your heart? My favorite country is Japan. - أي دولة تأسر قلبك؟ دولتي المفضلة هي اليابان.',
  'What genre of music do you enjoy? I like pop music. - ما نوع الموسيقى التي تستمتع بها؟ أحب موسيقى البوب.',
  'Where is your workplace located? I work at a technology firm. - أين يقع مكان عملك؟ أعمل في شركة تكنولوجيا.',
  'What is your mode of transport to work? I usually take the subway. - ما هو وسيلة نقلك إلى العمل؟ عادةً ما أستقل المترو.',
  'Do you find satisfaction in your job? Yes, I find my job very fulfilling. - هل تجد رضا في عملك؟ نعم، أجد عملي مُرضيًا جدًا.',
  'What plans do you have for this weekend? I plan on going hiking. - ما هي خططك لعطلة نهاية الأسبوع؟ أخطط للذهاب في نزهة.',
  'Do you prefer tea or coffee when relaxing? I prefer tea over coffee. - هل تفضل الشاي أم القهوة أثناء الاسترخاء؟ أفضل الشاي على القهوة.',
  'At what hour do you usually retire for the night? I go to bed at 10 PM every night. - في أي ساعة تذهب عادةً إلى الفراش؟ أذهب إلى الفراش في الساعة العاشرة مساءً كل ليلة.',
  'What is your favorite holiday celebration? My favorite holiday is Christmas. - ما هي احتفالات عطلتك المفضلة؟ عطلتي المفضلة هي عيد الميلاد.',
  'Could you please provide your phone number? My phone number is 123-456-7890. - هل يمكنك تزويدي برقم هاتفك؟ رقم هاتفي هو 123-456-7890.'
];







class SpeakingPage2 extends StatefulWidget {
  @override
  _SpeakingPage2State createState() => _SpeakingPage2State();
}

class _SpeakingPage2State extends State<SpeakingPage2> with SingleTickerProviderStateMixin {
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
      _currentSentence = sentences2[Random().nextInt(sentences2.length)];
      _correctAnswer = _currentSentence.split(' - ')[0].trim();
    });


    // حفظ البيانات المحدثة
    saveProgressDataToPreferences();
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
        debugLogging: true,
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _transcribedText = val.recognizedWords;
            });
          },
          localeId: 'en_US', // Ensure you are using the correct parameter name
        );

        Timer(Duration(seconds: 9), () {
          if (_isListening) {
            _speech.stop();
            setState(() {
              _isListening = false;
            });
            _analyzeAnswer();
          }
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }


  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int speakingProgressLevel = 0; // New variable for Speaking
  int bottleFillLevel = 0;

  // دالة لتحميل البيانات المحفوظة من SharedPreferences
  Future<void> loadSavedProgressData() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    setState(() {
      readingProgressLevel = sharedPreferencesInstance.getInt('progressReading') ?? 0;
      listeningProgressLevel = sharedPreferencesInstance.getInt('progressListening') ?? 0;
      writingProgressLevel = sharedPreferencesInstance.getInt('progressWriting') ?? 0;
      grammarProgressLevel = sharedPreferencesInstance.getInt('progressGrammar') ?? 0;
      speakingProgressLevel = sharedPreferencesInstance.getInt('progressSpeaking') ?? 0; // Load Speaking
      bottleFillLevel = sharedPreferencesInstance.getInt('bottleLevel') ?? 0;
    });
  }

  // دالة لحفظ البيانات إلى SharedPreferences
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    await sharedPreferencesInstance.setInt('progressReading', readingProgressLevel);
    await sharedPreferencesInstance.setInt('progressListening', listeningProgressLevel);
    await sharedPreferencesInstance.setInt('progressWriting', writingProgressLevel);
    await sharedPreferencesInstance.setInt('progressGrammar', grammarProgressLevel);
    await sharedPreferencesInstance.setInt('progressSpeaking', speakingProgressLevel); // Save Speaking
    await sharedPreferencesInstance.setInt('bottleLevel', bottleFillLevel);
  }

  Future<void> _loadStatisticsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      grammarPoints = prefs.getDouble('grammarPoints') ?? 0;
      lessonPoints = prefs.getDouble('lessonPoints') ?? 0;
      studyHoursPoints = prefs.getDouble('studyHoursPoints') ?? 0;
      listeningPoints = prefs.getDouble('listeningPoints') ?? 0;
      speakingPoints = prefs.getDouble('speakingPoints') ?? 0;
      readingPoints = prefs.getDouble('readingPoints') ?? 0;
      writingPoints = prefs.getDouble('writingPoints') ?? 0;
      exercisePoints = prefs.getDouble('exercisePoints') ?? 0;
      sentenceFormationPoints = prefs.getDouble('sentenceFormationPoints') ?? 0;
      gamePoints = prefs.getDouble('gamePoints') ?? 900;
    });
  }
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
    _loadScore();
    _startNewSentence();

    // Load progress and statistics data
    loadSavedProgressData();
    _loadStatisticsData();
  }



  // دالة لتحميل البيانات المحفوظة من SharedPreferences

  // دالة لحفظ البيانات إلى SharedPreferences
  // Variables for different points
  double grammarPoints = 0;
  double lessonPoints = 0;
  double studyHoursPoints = 0;
  double listeningPoints = 0;
  double speakingPoints = 0;
  double readingPoints = 0;
  double writingPoints = 0;
  double exercisePoints = 0;
  double sentenceFormationPoints = 0;
  double gamePoints = 0;
// Save statistics data
  Future<void> saveStatisticsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('grammarPoints', grammarPoints);
    await prefs.setDouble('lessonPoints', lessonPoints);
    await prefs.setDouble('studyHoursPoints', studyHoursPoints);
    await prefs.setDouble('listeningPoints', listeningPoints);
    await prefs.setDouble('speakingPoints', speakingPoints);
    await prefs.setDouble('readingPoints', readingPoints);
    await prefs.setDouble('writingPoints', writingPoints);
    await prefs.setDouble('exercisePoints', exercisePoints);
    await prefs.setDouble('sentenceFormationPoints', sentenceFormationPoints);
    await prefs.setDouble('gamePoints', gamePoints);
  }
  void _analyzeAnswer() {
    double similarity = _transcribedText.similarityTo(_correctAnswer) * 100;

    setState(() {
      if (similarity == 100) {
        _feedbackMessage = 'إجابة ممتازة! (100%)';
        _score += 10;
        increasePoints('speaking', 10);
        speakingProgressLevel += 10;
        if (speakingProgressLevel > 500) speakingProgressLevel = 500;
      } else if (similarity >= 80) {
        _feedbackMessage = 'إجابة جيدة جدًا! (80%)';
        _score += 8;
        increasePoints('speaking', 8);
        speakingProgressLevel += 8;
        if (speakingProgressLevel > 500) speakingProgressLevel = 500;
      } else if (similarity >= 60) {
        _feedbackMessage = 'إجابة لا بأس بها! (60%)';
        _score += 5;
        increasePoints('speaking', 5);
        speakingProgressLevel += 5;
        if (speakingProgressLevel > 500) speakingProgressLevel = 500;
      } else {
        _feedbackMessage = 'يمكنك تحسين الإجابة. (أقل من 60%)';
      }
      _title = _getTitle(_score);
      _saveScore();

      // Save updated progress data and statistics
      saveProgressDataToPreferences();
      saveStatisticsData();
    });
  }
  void increasePoints(String category, double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      switch (category) {
        case 'grammar':
          grammarPoints += amount;
          prefs.setDouble('grammarPoints', grammarPoints);
          break;
        case 'speaking':
          speakingPoints += amount;
          prefs.setDouble('speakingPoints', speakingPoints);
          break;
      // Add other cases as needed
      }
    });
  }

  @override
  void dispose() {
    _speech.stop();
    _flutterTts.stop();
    _answerController.dispose();
    // Save progress and statistics data
    saveProgressDataToPreferences();
    saveStatisticsData();
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

