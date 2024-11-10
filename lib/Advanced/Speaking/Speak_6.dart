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

final Map<String, String> sentences6 = {
  'Good morning!': 'Good morning to you too!',
  'Where is the train station?': 'It is right around the corner.',
  'Do you know where I can buy a book?': 'Yes, there’s a bookstore nearby.',
  'Is there a pharmacy close to here?': 'Yes, just across the street.',
  'What is your favorite hobby?': 'I enjoy painting in my free time.',
  'Have you seen the latest movie?': 'Yes, it was amazing!',
  'Do you want to go out for dinner tonight?': 'Sure, I would love to!',
  'What are your weekend plans?': 'I am planning to go to the beach.',
  'How is your family doing?': 'They are doing well, thank you.',
  'Can you speak any other languages?': 'Yes, I speak French and Spanish.',
  'Have you been to this restaurant before?': 'No, it’s my first time here.',
  'How far is the airport?': 'It’s about a 30-minute drive.',
  'What’s the weather like tomorrow?': 'It is supposed to rain all day.',
  'Do you enjoy reading books?': 'Yes, I read every night before bed.',
  'Are you planning any trips soon?': 'Yes, I’m going to Italy next month.',
  'Where do you usually shop for clothes?': 'I usually shop online.',
  'Do you prefer watching movies at home or at the cinema?': 'I prefer watching at home.',
  'What do you do for fun?': 'I like hiking and cycling.',
  'What type of food do you like?': 'I love trying new international dishes.',
  'Do you like spicy food?': 'Yes, the spicier, the better!',
  'What’s your favorite dessert?': 'I love chocolate cake.',
  'Do you play any sports?': 'Yes, I play basketball.',
  'What do you think about this city?': 'It’s a beautiful place to live.',
  'How long have you been working here?': 'I’ve been working here for 5 years.',
  'Do you like working from home?': 'Yes, it gives me more flexibility.',
  'What’s your favorite thing about your job?': 'I enjoy collaborating with my team.',
  'What’s your dream vacation?': 'I would love to visit Japan one day.',
  'Do you enjoy cooking?': 'Yes, I cook every day.',
  'What do you like to cook?': 'I love making Italian pasta dishes.',
  'How do you relax after a long day?': 'I usually watch TV or listen to music.',
  'Do you follow any sports teams?': 'Yes, I’m a big fan of football.',
  'Have you read any good books lately?': 'Yes, I just finished a great novel.',
  'What’s your favorite type of music?': 'I enjoy listening to jazz.',
  'Do you enjoy going to concerts?': 'Yes, I love live music.',
  'Where did you go to school?': 'I studied at a university in London.',
  'What is your favorite memory?': 'My favorite memory is traveling with my family.',
  'How often do you go to the gym?': 'I try to go three times a week.',
  'Do you watch any TV shows?': 'Yes, I’m currently watching a comedy series.',
  'What’s your favorite season?': 'I love autumn the most.',
  'Have you ever tried skydiving?': 'No, but I would love to try it one day.',
  'What do you usually do on weekends?': 'I like to relax and catch up on sleep.',
  'Do you collect anything?': 'Yes, I collect vintage postcards.',
  'Have you ever been to a music festival?': 'Yes, I went to one last summer.',
  'What’s your favorite drink?': 'I love drinking iced tea.',
  'Do you enjoy playing video games?': 'Yes, I play occasionally.',
  'How do you usually spend your holidays?': 'I like to travel and explore new places.',
  'Do you enjoy working in teams?': 'Yes, teamwork makes everything better.',
  'What’s the best meal you’ve ever had?': 'The best meal I had was sushi in Japan.',
  'Do you believe in luck?': 'Yes, sometimes I do.'
};

final List<String> sentencesQ6 = [
  'صباح الخير! صباح الخير لك أيضًا!',
  'أين محطة القطار؟ إنها على زاوية الشارع.',
  'هل تعرف أين يمكنني شراء كتاب؟ نعم، هناك مكتبة بالقرب من هنا.',
  'هل توجد صيدلية قريبة من هنا؟ نعم، على الجانب الآخر من الشارع.',
  'ما هي هوايتك المفضلة؟ أحب الرسم في وقت فراغي.',
  'هل شاهدت الفيلم الأخير؟ نعم، كان مذهلاً!',
  'هل ترغب في الخروج لتناول العشاء الليلة؟ بالطبع، سأحب ذلك!',
  'ما هي خططك لعطلة نهاية الأسبوع؟ أخطط للذهاب إلى الشاطئ.',
  'كيف حال عائلتك؟ إنهم بخير، شكرًا لك.',
  'هل تتحدث أي لغات أخرى؟ نعم، أتكلم الفرنسية والإسبانية.',
  'هل سبق أن زرت هذا المطعم؟ لا، هذه المرة الأولى لي هنا.',
  'كم يبعد المطار؟ إنه على بعد حوالي 30 دقيقة بالسيارة.',
  'كيف سيكون الطقس غدًا؟ من المتوقع أن تمطر طوال اليوم.',
  'هل تستمتع بقراءة الكتب؟ نعم، أقرأ كل ليلة قبل النوم.',
  'هل تخطط لرحلات قريبًا؟ نعم، سأذهب إلى إيطاليا الشهر القادم.',
  'أين تشتري ملابسك عادةً؟ أشتري غالبًا عبر الإنترنت.',
  'هل تفضل مشاهدة الأفلام في المنزل أم في السينما؟ أفضل المشاهدة في المنزل.',
  'ماذا تفعل للتسلية؟ أحب المشي لمسافات طويلة وركوب الدراجة.',
  'ما نوع الطعام الذي تحبه؟ أحب تجربة الأطباق العالمية الجديدة.',
  'هل تحب الطعام الحار؟ نعم، كلما كان أكثر حرارة كان أفضل!',
  'ما هي الحلوى المفضلة لديك؟ أحب كعكة الشوكولاتة.',
  'هل تمارس أي رياضة؟ نعم، ألعب كرة السلة.',
  'ما رأيك في هذه المدينة؟ إنها مكان جميل للعيش.',
  'كم مدة عملك هنا؟ أعمل هنا منذ 5 سنوات.',
  'هل تحب العمل من المنزل؟ نعم، يمنحني مرونة أكبر.',
  'ما هو الشيء المفضل في وظيفتك؟ أحب التعاون مع فريقي.',
  'ما هي عطلتك المثالية؟ أحب زيارة اليابان يومًا ما.',
  'هل تستمتع بالطبخ؟ نعم، أطبخ كل يوم.',
  'ما الذي تحب أن تطبخه؟ أحب تحضير أطباق المعكرونة الإيطالية.',
  'كيف تسترخي بعد يوم طويل؟ عادةً ما أشاهد التلفاز أو أستمع إلى الموسيقى.',
  'هل تتابع أي فرق رياضية؟ نعم، أنا من مشجعي كرة القدم.',
  'هل قرأت أي كتب جيدة مؤخرًا؟ نعم، انتهيت من رواية رائعة.',
  'ما هو نوع الموسيقى المفضل لديك؟ أحب الاستماع إلى موسيقى الجاز.',
  'هل تستمتع بحضور الحفلات الموسيقية؟ نعم، أحب الموسيقى الحية.',
  'أين درست؟ درست في جامعة في لندن.',
  'ما هي ذكراك المفضلة؟ ذكريتي المفضلة هي السفر مع عائلتي.',
  'كم مرة تذهب إلى صالة الألعاب الرياضية؟ أحاول الذهاب ثلاث مرات في الأسبوع.',
  'هل تشاهد أي برامج تلفزيونية؟ نعم، أتابع حاليًا مسلسل كوميدي.',
  'ما هو فصل السنة المفضل لديك؟ أحب فصل الخريف أكثر.',
  'هل جربت القفز بالمظلات من قبل؟ لا، ولكن أود تجربتها يومًا ما.',
  'ماذا تفعل عادةً في عطلات نهاية الأسبوع؟ أحب الاسترخاء وتعويض النوم.',
  'هل تجمع أي شيء؟ نعم، أجمع البطاقات البريدية القديمة.',
  'هل سبق لك أن ذهبت إلى مهرجان موسيقي؟ نعم، ذهبت إلى واحد الصيف الماضي.',
  'ما هو مشروبك المفضل؟ أحب شرب الشاي المثلج.',
  'هل تستمتع بلعب ألعاب الفيديو؟ نعم، ألعب أحيانًا.',
  'كيف تقضي إجازاتك عادةً؟ أحب السفر واستكشاف أماكن جديدة.',
  'هل تستمتع بالعمل في فرق؟ نعم، العمل الجماعي يجعل الأمور أفضل.',
  'ما هي أفضل وجبة تناولتها على الإطلاق؟ أفضل وجبة تناولتها كانت السوشي في اليابان.',
  'هل تؤمن بالحظ؟ نعم، أحيانًا أؤمن به.'
];


class SpeakingPage6 extends StatefulWidget {
  @override
  _SpeakingPage6State createState() => _SpeakingPage6State();
}

class _SpeakingPage6State extends State<SpeakingPage6> with SingleTickerProviderStateMixin {
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
  final Color primaryColor = Color(0xFF13194E); // اللون الأساسي

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
    setState(() {
      _feedbackMessage = '';
      _answerController.clear();
      _transcribedText = '';
      // اختر جملة عشوائية من sentences6
      _currentSentence = sentences6.keys.elementAt(Random().nextInt(sentences6.length));
      _correctAnswer = sentences6[_currentSentence]!.trim(); // احصل على الجواب الصحيح
    });

    _speak(_currentSentence);
  }


  Future<void> _speak(String text) async {
    String language = 'en-US';
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
          'النقاط: $_score',
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
              SizedBox(height: 40),
              Text(
                'الجملة الحالية:',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Text(
                    // إضافة النص العربي فوق النص الإنجليزي
                    sentencesQ6[sentences6.keys.toList().indexOf(_currentSentence)] ?? '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5), // إضافة مساحة بين النصين
                  Text(
                    _currentSentence,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
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
