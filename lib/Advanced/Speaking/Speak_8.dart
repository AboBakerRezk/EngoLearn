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
final Map<String, String> sentences8 = {
  'What time does the movie start?': 'It starts at 7 PM.',
  'Do you have any siblings?': 'Yes, I have two brothers.',
  'Can you recommend a good restaurant?': 'Yes, there’s a great Italian place nearby.',
  'What do you usually do in the morning?': 'I usually go for a run.',
  'Have you ever been to a museum?': 'Yes, I love visiting museums.',
  'How do you spend your weekends?': 'I like to go hiking in the mountains.',
  'What’s your favorite subject?': 'I enjoy studying history.',
  'How do you stay healthy?': 'I eat balanced meals and exercise regularly.',
  'Do you like watching documentaries?': 'Yes, they are very informative.',
  'Do you enjoy gardening?': 'Yes, I grow my own vegetables.',
  'How do you keep yourself motivated?': 'I set small goals and reward myself.',
  'What is the best advice you’ve ever received?': 'Always believe in yourself.',
  'How do you usually celebrate your birthday?': 'I celebrate with family and friends.',
  'Do you have a favorite city to visit?': 'Yes, I love visiting Paris.',
  'What is your favorite animal?': 'My favorite animal is the dolphin.',
  'Do you like to volunteer?': 'Yes, I volunteer at the local shelter.',
  'What’s your dream job?': 'I would love to be a travel writer.',
  'Do you play any board games?': 'Yes, I enjoy playing chess.',
  'What do you do when you feel stressed?': 'I practice meditation to relax.',
  'Do you prefer summer or winter?': 'I prefer summer because I like the beach.',
  'What’s your favorite app?': 'I use a lot of productivity apps.',
  'Do you travel often?': 'Yes, I travel several times a year.',
  'Have you ever tried meditation?': 'Yes, it helps me stay calm and focused.',
  'Do you like baking?': 'Yes, I love baking cakes and cookies.',
  'Do you enjoy road trips?': 'Yes, I love exploring new places by car.',
  'How do you usually spend your evenings?': 'I like to read or watch a good movie.',
  'What’s the most interesting thing you’ve learned recently?': 'I learned about ancient Egyptian history.',
  'Do you enjoy solving puzzles?': 'Yes, I find them very challenging.',
  'What’s your favorite breakfast food?': 'I love eating pancakes for breakfast.',
  'What’s the last book you read?': 'The last book I read was a mystery novel.',
  'Do you like trying new foods?': 'Yes, I enjoy tasting different cuisines.',
  'What’s your favorite fruit?': 'My favorite fruit is mango.',
  'Do you like exercising in the morning or evening?': 'I prefer exercising in the morning.',
  'What do you think is the key to happiness?': 'I think the key is to appreciate the small things in life.',
  'How do you stay productive during the day?': 'I make a to-do list and stick to it.',
  'What’s your favorite sport to watch?': 'I love watching tennis matches.',
  'What do you usually do on holidays?': 'I spend time with family and friends.',
  'What’s your favorite snack?': 'I love eating popcorn while watching movies.',
  'Do you enjoy learning new skills?': 'Yes, I’m always looking to improve myself.',
  'How do you handle challenges?': 'I try to stay calm and find a solution step by step.',
  'What’s your favorite way to relax?': 'I love taking long walks in nature.',
  'Do you like going to the gym?': 'Yes, it’s a great way to stay fit.',
  'Have you ever been camping?': 'Yes, I went camping last summer.',
  'What’s your favorite outdoor activity?': 'I enjoy cycling in the park.',
  'Do you like reading the news?': 'Yes, I try to stay updated on current events.',
  'What’s your favorite type of weather?': 'I love warm, sunny days.',
  'Do you enjoy listening to podcasts?': 'Yes, I listen to them on my way to work.',
  'Have you ever taken a photography class?': 'No, but I would love to learn photography.',
};

final List<String> sentencesQ8 = [
  'متى يبدأ الفيلم؟ يبدأ في الساعة 7 مساءً.',
  'هل لديك إخوة؟ نعم، لدي شقيقان.',
  'هل يمكنك أن توصي بمطعم جيد؟ نعم، هناك مكان إيطالي رائع بالقرب من هنا.',
  'ماذا تفعل عادة في الصباح؟ عادة أذهب للجري.',
  'هل سبق أن ذهبت إلى متحف؟ نعم، أحب زيارة المتاحف.',
  'كيف تقضي عطلة نهاية الأسبوع؟ أحب المشي لمسافات طويلة في الجبال.',
  'ما هو موضوعك المفضل؟ أحب دراسة التاريخ.',
  'كيف تحافظ على صحتك؟ أتناول وجبات متوازنة وأمارس الرياضة بانتظام.',
  'هل تحب مشاهدة الأفلام الوثائقية؟ نعم، إنها مفيدة جدًا.',
  'هل تستمتع بالبستنة؟ نعم، أزرع خضرواتي بنفسي.',
  'كيف تبقي نفسك متحفزًا؟ أضع أهدافًا صغيرة وأكافئ نفسي.',
  'ما هي أفضل نصيحة تلقيتها؟ دائمًا ثق بنفسك.',
  'كيف تحتفل عادة بعيد ميلادك؟ أحتفل مع العائلة والأصدقاء.',
  'هل لديك مدينة مفضلة للزيارة؟ نعم، أحب زيارة باريس.',
  'ما هو حيوانك المفضل؟ حيواني المفضل هو الدلفين.',
  'هل تحب العمل التطوعي؟ نعم، أعمل تطوعًا في الملجأ المحلي.',
  'ما هو عمل أحلامك؟ أود أن أكون كاتبًا في السفر.',
  'هل تلعب ألعاب الطاولة؟ نعم، أستمتع بلعب الشطرنج.',
  'ماذا تفعل عندما تشعر بالتوتر؟ أمارس التأمل للاسترخاء.',
  'هل تفضل الصيف أم الشتاء؟ أفضل الصيف لأنني أحب الشاطئ.',
  'ما هو تطبيقك المفضل؟ أستخدم العديد من تطبيقات الإنتاجية.',
  'هل تسافر كثيرًا؟ نعم، أسافر عدة مرات في السنة.',
  'هل جربت التأمل من قبل؟ نعم، يساعدني في البقاء هادئًا ومركزًا.',
  'هل تحب الخبز؟ نعم، أحب خبز الكعك والبسكويت.',
  'هل تستمتع بالرحلات البرية؟ نعم، أحب استكشاف أماكن جديدة بالسيارة.',
  'كيف تقضي أمسياتك عادة؟ أحب القراءة أو مشاهدة فيلم جيد.',
  'ما هو أكثر شيء مثير تعلمته مؤخرًا؟ تعلمت عن تاريخ مصر القديمة.',
  'هل تستمتع بحل الألغاز؟ نعم، أجدها تحديًا ممتعًا.',
  'ما هو طعام الإفطار المفضل لديك؟ أحب تناول الفطائر في الإفطار.',
  'ما هو آخر كتاب قرأته؟ آخر كتاب قرأته كان رواية غامضة.',
  'هل تحب تجربة الأطعمة الجديدة؟ نعم، أستمتع بتذوق المأكولات المختلفة.',
  'ما هي فاكهتك المفضلة؟ فاكهتي المفضلة هي المانجو.',
  'هل تفضل ممارسة الرياضة في الصباح أم المساء؟ أفضل ممارسة الرياضة في الصباح.',
  'ما هو مفتاح السعادة في رأيك؟ أعتقد أن المفتاح هو تقدير الأشياء الصغيرة في الحياة.',
  'كيف تحافظ على إنتاجيتك خلال اليوم؟ أضع قائمة مهام وألتزم بها.',
  'ما هي الرياضة المفضلة لديك لمشاهدتها؟ أحب مشاهدة مباريات التنس.',
  'ماذا تفعل عادة في الإجازات؟ أقضي الوقت مع العائلة والأصدقاء.',
  'ما هو وجبتك الخفيفة المفضلة؟ أحب تناول الفشار أثناء مشاهدة الأفلام.',
  'هل تستمتع بتعلم مهارات جديدة؟ نعم، دائمًا أبحث عن تحسين نفسي.',
  'كيف تتعامل مع التحديات؟ أحاول البقاء هادئًا وأجد حلًا خطوة بخطوة.',
  'ما هي طريقتك المفضلة للاسترخاء؟ أحب المشي الطويل في الطبيعة.',
  'هل تحب الذهاب إلى صالة الألعاب الرياضية؟ نعم، إنها طريقة رائعة للبقاء نشيطًا.',
  'هل سبق لك أن ذهبت للتخييم؟ نعم، ذهبت للتخييم الصيف الماضي.',
  'ما هو نشاطك المفضل في الهواء الطلق؟ أستمتع بركوب الدراجة في الحديقة.',
  'هل تحب قراءة الأخبار؟ نعم، أحاول البقاء مطلعًا على الأحداث الجارية.',
  'ما هو نوع الطقس المفضل لديك؟ أحب الأيام الدافئة والمشمسة.',
  'هل تستمتع بالاستماع إلى البودكاست؟ نعم، أستمع إليها في طريقي إلى العمل.',
  'هل سبق لك أن أخذت دروسًا في التصوير؟ لا، لكنني أحب أن أتعلم التصوير الفوتوغرافي.'
];



class SpeakingPage8 extends StatefulWidget {
  @override
  _SpeakingPage8State createState() => _SpeakingPage8State();
}

class _SpeakingPage8State extends State<SpeakingPage8> with SingleTickerProviderStateMixin {
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
      _currentSentence = sentences8.keys.elementAt(Random().nextInt(sentences8.length));
      _correctAnswer = sentences8[_currentSentence]!.trim(); // احصل على الجواب الصحيح
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
                    sentencesQ8[sentences8.keys.toList().indexOf(_currentSentence)] ?? '',
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
