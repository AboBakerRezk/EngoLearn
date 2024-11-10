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

final Map<String, String> sentences7 = {
  'Hello, how are you?': 'I am fine, thank you!',
  'What is your name?': 'My name is John.',
  'How old are you?': 'I am 25 years old.',
  'Where are you from?': 'I am from the United States.',
  'What do you do?': 'I am a teacher.',
  'Do you speak English?': 'Yes, I speak English.',
  'Can you help me?': 'Yes, of course!',
  'Where is the nearest hospital?': 'It is two blocks away.',
  'What time is it?': 'It is 10 o\'clock.',
  'How much does this cost?': 'It costs \$50.', // Fixed by escaping the $
  'Can I have the bill, please?': 'Sure, here it is.',
  'Do you have a reservation?': 'Yes, I have a reservation.',
  'Where is the bathroom?': 'The bathroom is down the hall.',
  'How is the weather today?': 'It is sunny and warm.',
  'Can you give me directions?': 'Yes, go straight and turn left.',
  'What did you do yesterday?': 'I went to the park.',
  'Are you busy right now?': 'No, I am free.',
  'Do you like coffee?': 'Yes, I love coffee!',
  'What is your favorite food?': 'My favorite food is pizza.',
  'Where do you live?': 'I live in New York.',
  'How can I get to the airport?': 'You can take a taxi or the bus.',
  'What time does the train leave?': 'The train leaves at 5 PM.',
  'How long does the flight take?': 'The flight takes about 3 hours.',
  'What is your favorite movie?': 'My favorite movie is Inception.',
  'Do you like music?': 'Yes, I love music.',
  'Can you play any instruments?': 'Yes, I play the guitar.',
  'Do you have any pets?': 'Yes, I have a dog.',
  'How many languages do you speak?': 'I speak two languages.',
  'What is your favorite color?': 'My favorite color is blue.',
  'What time do you usually wake up?': 'I usually wake up at 6 AM.',
  'Do you like sports?': 'Yes, I like football.',
  'Have you ever been to Europe?': 'Yes, I have been to Europe.',
  'What is your job?': 'I am a software engineer.',
  'Can you drive a car?': 'Yes, I can drive.',
  'What are your hobbies?': 'I like reading and hiking.',
  'What is your favorite book?': 'My favorite book is 1984 by George Orwell.',
  'What do you like to do in your free time?': 'I like to watch movies.',
  'Do you have any brothers or sisters?': 'Yes, I have one sister.',
  'What is your favorite season?': 'My favorite season is spring.',
  'How often do you exercise?': 'I exercise three times a week.',
  'Do you like traveling?': 'Yes, I love traveling.',
  'What is your favorite country?': 'My favorite country is Japan.',
  'What kind of music do you like?': 'I like pop music.',
  'Where do you work?': 'I work at a tech company.',
  'How do you get to work?': 'I take the subway.',
  'Do you enjoy your job?': 'Yes, I enjoy my job.',
  'What are you doing this weekend?': 'I am going hiking.',
  'Do you prefer tea or coffee?': 'I prefer tea.',
  'What time do you go to bed?': 'I go to bed at 10 PM.',
  'What is your favorite holiday?': 'My favorite holiday is Christmas.',
  'What is your phone number?': 'My phone number is 123-456-7890.'
};
final List<String> sentencesQ7 = [
  'مرحبًا، كيف حالك؟ أنا بخير، شكرًا!',
  'ما اسمك؟ اسمي جون.',
  'كم عمرك؟ عمري 25 عامًا.',
  'من أين أنت؟ أنا من الولايات المتحدة.',
  'ماذا تعمل؟ أنا معلم.',
  'هل تتحدث الإنجليزية؟ نعم، أتكلم الإنجليزية.',
  'هل يمكنك مساعدتي؟ نعم، بالطبع!',
  'أين أقرب مستشفى؟ إنه على بعد مبنيين.',
  'كم الساعة؟ الساعة 10.',
  'كم يكلف هذا؟ يكلف 50 دولارًا.',
  'هل يمكنني الحصول على الفاتورة، من فضلك؟ بالطبع، ها هي.',
  'هل لديك حجز؟ نعم، لدي حجز.',
  'أين الحمام؟ الحمام في نهاية الممر.',
  'كيف هو الطقس اليوم؟ إنه مشمس ودافئ.',
  'هل يمكنك إعطائي الاتجاهات؟ نعم، اذهب straight واذهب لليسار.',
  'ماذا فعلت البارحة؟ ذهبت إلى الحديقة.',
  'هل أنت مشغول الآن؟ لا، أنا حر.',
  'هل تحب القهوة؟ نعم، أحب القهوة!',
  'ما هو طعامك المفضل؟ طعامي المفضل هو البيتزا.',
  'أين تعيش؟ أعيش في نيويورك.',
  'كيف يمكنني الوصول إلى المطار؟ يمكنك أخذ تاكسي أو الحافلة.',
  'متى يغادر القطار؟ يغادر القطار في الساعة 5 مساءً.',
  'كم تستغرق الرحلة بالطائرة؟ تستغرق الرحلة حوالي 3 ساعات.',
  'ما هو فيلمك المفضل؟ فيلمي المفضل هو إنception.',
  'هل تحب الموسيقى؟ نعم، أحب الموسيقى.',
  'هل يمكنك العزف على أي آلات موسيقية؟ نعم، أعزف على الجيتار.',
  'هل لديك حيوانات أليفة؟ نعم، لدي كلب.',
  'كم لغة تتحدث؟ أتحدث لغتين.',
  'ما هو لونك المفضل؟ لونى المفضل هو الأزرق.',
  'متى تستيقظ عادةً؟ أستيقظ عادةً في الساعة 6 صباحًا.',
  'هل تحب الرياضة؟ نعم، أحب كرة القدم.',
  'هل زرت أوروبا من قبل؟ نعم، زرت أوروبا.',
  'ما هو عملك؟ أنا مهندس برمجيات.',
  'هل يمكنك قيادة السيارة؟ نعم، أستطيع القيادة.',
  'ما هي هواياتك؟ أحب القراءة والتسلق.',
  'ما هو كتابك المفضل؟ كتابي المفضل هو 1984 لجورج أورويل.',
  'ماذا تحب أن تفعل في وقت فراغك؟ أحب مشاهدة الأفلام.',
  'هل لديك إخوة أو أخوات؟ نعم، لدي أخت واحدة.',
  'ما هو فصل السنة المفضل لديك؟ فصل السنة المفضل لدي هو الربيع.',
  'كم مرة تمارس الرياضة؟ أمارس الرياضة ثلاث مرات في الأسبوع.',
  'هل تحب السفر؟ نعم، أحب السفر.',
  'ما هي دولتك المفضلة؟ دولتي المفضلة هي اليابان.',
  'ما نوع الموسيقى التي تحبها؟ أحب موسيقى البوب.',
  'أين تعمل؟ أعمل في شركة تقنية.',
  'كيف تصل إلى عملك؟ أخذ المترو.',
  'هل تستمتع بعملك؟ نعم، أستمتع بعملي.',
  'ماذا ستفعل في عطلة نهاية الأسبوع؟ سأذهب للتسلق.',
  'هل تفضل الشاي أم القهوة؟ أحب الشاي.',
  'متى تذهب إلى السرير؟ أذهب إلى السرير في الساعة 10 مساءً.',
  'ما هي عطلتك المفضلة؟ عطلتي المفضلة هي عيد الميلاد.',
  'ما هو رقم هاتفك؟ رقم هاتفي هو 123-456-7890.'
];


class SpeakingPage7 extends StatefulWidget {
  @override
  _SpeakingPage7State createState() => _SpeakingPage7State();
}

class _SpeakingPage7State extends State<SpeakingPage7> with SingleTickerProviderStateMixin {
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
      _currentSentence = sentences7.keys.elementAt(Random().nextInt(sentences7.length));
      _correctAnswer = sentences7[_currentSentence]!.trim(); // احصل على الجواب الصحيح
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
                    sentencesQ7[sentences7.keys.toList().indexOf(_currentSentence)] ?? '',
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
