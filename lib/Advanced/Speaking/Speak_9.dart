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

final Map<String, String> sentences9 = {
  'What is your favorite way to spend a day off?': 'I love spending it at the beach.',
  'Do you enjoy cooking?': 'Yes, I love trying new recipes.',
  'Have you ever met a famous person?': 'Yes, I once met a famous actor.',
  'What’s your favorite type of dessert?': 'My favorite dessert is chocolate cake.',
  'What is the most exciting thing you’ve done recently?': 'I went skydiving last month.',
  'Do you prefer cats or dogs?': 'I prefer dogs because they are more playful.',
  'What’s your favorite season of the year?': 'I love autumn because of the cool weather.',
  'Have you ever tried skiing?': 'Yes, I tried it last winter and loved it.',
  'What’s the most beautiful place you’ve ever visited?': 'The Swiss Alps were breathtaking.',
  'Do you like playing video games?': 'Yes, I enjoy playing strategy games.',
  'What’s your favorite hobby?': 'I love painting in my free time.',
  'Do you prefer reading books or watching movies?': 'I prefer reading books.',
  'What’s your favorite place in the world?': 'My favorite place is the beach at sunset.',
  'What do you usually have for breakfast?': 'I usually have eggs and toast for breakfast.',
  'Do you like going to the gym?': 'Yes, I go to the gym three times a week.',
  'Have you ever been to a concert?': 'Yes, I went to a rock concert last year.',
  'What’s your favorite way to relax after a long day?': 'I like to relax by listening to music.',
  'Do you enjoy working in a team?': 'Yes, I find teamwork to be very motivating.',
  'What’s your favorite sport to play?': 'I love playing basketball with friends.',
  'What’s your favorite kind of food?': 'I enjoy Italian food the most.',
  'Do you like to stay up late or wake up early?': 'I’m more of a night owl, so I stay up late.',
  'What’s your favorite ice cream flavor?': 'My favorite flavor is vanilla.',
  'Have you ever tried surfing?': 'Yes, I tried it once, and it was fun!',
  'Do you enjoy watching TV shows?': 'Yes, I binge-watch shows on weekends.',
  'What’s your favorite kind of music to listen to?': 'I enjoy listening to jazz.',
  'Have you ever been scuba diving?': 'No, but I would love to try it one day.',
  'Do you enjoy writing?': 'Yes, I like writing short stories in my free time.',
  'What’s your favorite way to spend time outdoors?': 'I enjoy hiking in nature.',
  'What’s your dream vacation destination?': 'I would love to visit the Maldives.',
  'Do you like to dance?': 'Yes, I love dancing at parties.',
  'Have you ever taken a painting class?': 'Yes, I took a class last year.',
  'What’s your favorite animal?': 'My favorite animal is the elephant.',
  'Do you enjoy trying new foods?': 'Yes, I’m always open to tasting new dishes.',
  'What’s your favorite time of the day?': 'I love the quiet of early mornings.',
  'Do you like going to the movies?': 'Yes, I go to the cinema once a month.',
  'What’s your favorite beverage?': 'I love drinking iced tea.',
  'Do you enjoy spending time in nature?': 'Yes, I often go for walks in the park.',
  'Have you ever been on a cruise?': 'No, but I would love to go on one.',
  'What’s your favorite board game?': 'My favorite board game is Monopoly.',
  'Do you enjoy puzzles?': 'Yes, I like solving jigsaw puzzles.',
  'What’s the most delicious meal you’ve ever had?': 'I had an amazing seafood dish in Spain.',
  'Do you enjoy going to the beach?': 'Yes, I love spending time by the sea.',
  'What’s your favorite way to exercise?': 'I enjoy swimming for exercise.',
  'Do you like to travel by plane?': 'Yes, I enjoy flying and seeing new places.',
  'What’s your favorite outdoor activity?': 'I love going on long bike rides.',
  'Have you ever been horseback riding?': 'Yes, I went horseback riding last summer.',
  'Do you like going to amusement parks?': 'Yes, I enjoy the thrill of roller coasters.',
  'What’s your favorite holiday?': 'My favorite holiday is New Year’s Eve.',
  'Do you like eating out or cooking at home?': 'I prefer cooking at home, but I enjoy eating out sometimes.',
};

final List<String> sentencesQ9 = [
  'ما هي طريقتك المفضلة لقضاء يوم إجازة؟ أحب قضاءه على الشاطئ.',
  'هل تستمتع بالطهي؟ نعم، أحب تجربة وصفات جديدة.',
  'هل قابلت شخصًا مشهورًا من قبل؟ نعم، قابلت ممثلًا مشهورًا مرة.',
  'ما هو نوع الحلوى المفضل لديك؟ حلوى الشوكولاتة المفضلة لدي.',
  'ما هو أكثر شيء مثير قمت به مؤخرًا؟ قمت بالقفز بالمظلات الشهر الماضي.',
  'هل تفضل القطط أم الكلاب؟ أفضل الكلاب لأنها أكثر مرحًا.',
  'ما هو الفصل المفضل لديك في السنة؟ أحب الخريف بسبب الطقس البارد.',
  'هل جربت التزلج من قبل؟ نعم، جربته الشتاء الماضي وأحببته.',
  'ما هو أجمل مكان زرته؟ كانت جبال الألب السويسرية مذهلة.',
  'هل تحب لعب ألعاب الفيديو؟ نعم، أستمتع بلعب الألعاب الاستراتيجية.',
  'ما هي هوايتك المفضلة؟ أحب الرسم في وقت فراغي.',
  'هل تفضل قراءة الكتب أم مشاهدة الأفلام؟ أفضل قراءة الكتب.',
  'ما هو مكانك المفضل في العالم؟ مكاني المفضل هو الشاطئ عند غروب الشمس.',
  'ماذا تتناول عادة على الإفطار؟ أتناول عادة البيض والخبز المحمص.',
  'هل تحب الذهاب إلى صالة الألعاب الرياضية؟ نعم، أذهب إلى الصالة ثلاث مرات في الأسبوع.',
  'هل ذهبت إلى حفل موسيقي من قبل؟ نعم، ذهبت إلى حفل موسيقي روك العام الماضي.',
  'ما هي طريقتك المفضلة للاسترخاء بعد يوم طويل؟ أحب الاسترخاء بالاستماع إلى الموسيقى.',
  'هل تستمتع بالعمل في فريق؟ نعم، أجد أن العمل الجماعي محفز جدًا.',
  'ما هي رياضتك المفضلة للعب؟ أحب لعب كرة السلة مع الأصدقاء.',
  'ما هو نوع الطعام المفضل لديك؟ أستمتع بالطعام الإيطالي أكثر.',
  'هل تفضل السهر أم الاستيقاظ مبكرًا؟ أنا أكثر من يحب السهر، لذا أبقى مستيقظًا.',
  'ما هو نكهة الآيس كريم المفضلة لديك؟ نكهتي المفضلة هي الفانيليا.',
  'هل جربت ركوب الأمواج من قبل؟ نعم، جربته مرة وكان ممتعًا!',
  'هل تحب مشاهدة المسلسلات التلفزيونية؟ نعم، أشاهد المسلسلات في عطلات نهاية الأسبوع.',
  'ما هو نوع الموسيقى المفضل لديك للاستماع إليه؟ أحب الاستماع إلى موسيقى الجاز.',
  'هل جربت الغوص من قبل؟ لا، لكني أرغب في تجربته يومًا ما.',
  'هل تستمتع بالكتابة؟ نعم، أحب كتابة القصص القصيرة في وقت فراغي.',
  'ما هي طريقتك المفضلة لقضاء الوقت في الهواء الطلق؟ أحب التنزه في الطبيعة.',
  'ما هي وجهة عطلتك المفضلة؟ أرغب في زيارة جزر المالديف.',
  'هل تحب الرقص؟ نعم، أحب الرقص في الحفلات.',
  'هل سبق لك أن أخذت درسًا في الرسم؟ نعم، أخذت درسًا في العام الماضي.',
  'ما هو حيوانك المفضل؟ حيواني المفضل هو الفيل.',
  'هل تستمتع بتجربة الأطعمة الجديدة؟ نعم، أنا دائمًا منفتح على تذوق الأطباق الجديدة.',
  'ما هو وقتك المفضل في اليوم؟ أحب هدوء الصباح الباكر.',
  'هل تحب الذهاب إلى السينما؟ نعم، أذهب إلى السينما مرة في الشهر.',
  'ما هو مشروبك المفضل؟ أحب شرب الشاي المثلج.',
  'هل تستمتع بقضاء الوقت في الطبيعة؟ نعم، غالبًا ما أمشي في الحديقة.',
  'هل سبق لك أن ذهبت في رحلة بحرية؟ لا، لكني أرغب في الذهاب يومًا ما.',
  'ما هي لعبتك المفضلة على الطاولة؟ لعبتي المفضلة هي مونوبولي.',
  'هل تستمتع بالألغاز؟ نعم، أحب حل الألغاز.',
  'ما هي ألذ وجبة تناولتها؟ تناولت وجبة بحرية مذهلة في إسبانيا.',
  'هل تستمتع بالذهاب إلى الشاطئ؟ نعم، أحب قضاء الوقت بجانب البحر.',
  'ما هي طريقتك المفضلة لممارسة الرياضة؟ أستمتع بالسباحة كرياضة.',
  'هل تحب السفر بالطائرة؟ نعم، أحب الطيران واستكشاف أماكن جديدة.',
  'ما هو نشاطك المفضل في الهواء الطلق؟ أحب الذهاب في رحلات طويلة بالدراجة.',
  'هل سبق لك أن ركبت الخيل؟ نعم، ركبت الخيل الصيف الماضي.',
  'هل تحب الذهاب إلى مدن الملاهي؟ نعم، أستمتع بركوب الأفعوانيات.',
  'ما هي عطلتك المفضلة؟ عطلتي المفضلة هي ليلة رأس السنة.',
  'هل تحب تناول الطعام خارج المنزل أم الطهي في المنزل؟ أفضل الطهي في المنزل، لكنني أستمتع بتناول الطعام في الخارج أحيانًا.',
];


class SpeakingPage9 extends StatefulWidget {
  @override
  _SpeakingPage9State createState() => _SpeakingPage9State();
}

class _SpeakingPage9State extends State<SpeakingPage9> with SingleTickerProviderStateMixin {
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
      _currentSentence = sentences9.keys.elementAt(Random().nextInt(sentences9.length));
      _correctAnswer = sentences9[_currentSentence]!.trim(); // احصل على الجواب الصحيح
    });

    // حفظ البيانات المحدثة
    saveProgressDataToPreferences();
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
                    sentencesQ9[sentences9.keys.toList().indexOf(_currentSentence)] ?? '',
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
