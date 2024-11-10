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

final List<String> sentences12 = [
  'In a bustling town filled with colorful markets and lively people, there lived a boy named Amir who had a passion for painting. - في بلدة صاخبة مليئة بالأسواق الملونة والأشخاص النشيطين، كان هناك فتى يدعى أمير لديه شغف بالرسم.',

  'Every day after school, he would set up his easel in the park, capturing the beauty of nature and the joy of life on his canvas. - كل يوم بعد المدرسة، كان ينصب حامل اللوحات في الحديقة، يلتقط جمال الطبيعة وفرحة الحياة على لوحته.',

  'One sunny afternoon, as he was painting a vibrant sunset, an old artist approached him and admired his work, offering to teach him the secrets of art. - في إحدى الأمسيات المشمسة، بينما كان يرسم غروب الشمس المتألق، اقترب منه فنان قديم وأعجب بعمله، وعرض عليه أن يعلمه أسرار الفن.',

  'Amir was thrilled and accepted the offer, beginning a journey that would change his life forever. - كان أمير متحمسًا وقبل العرض، وبدأ رحلة ستغير حياته إلى الأبد.',

  'Under the old artist’s guidance, Amir learned about color theory, composition, and the power of expression, pouring his heart and soul into every brushstroke. - تحت إشراف الفنان القديم، تعلم أمير عن نظرية الألوان والتركيب وقوة التعبير، مضيفًا قلبه وروحه في كل ضربة فرشاة.',

  'As months passed, Amir’s skills blossomed, and he decided to hold his first art exhibition in the town square, showcasing his journey and growth as an artist. - مع مرور الأشهر، ازدهرت مهارات أمير، وقرر أن يقيم معرضه الفني الأول في ساحة المدينة، مع عرض رحلته ونموه كفنان.',

  'On the day of the exhibition, people from all over the town gathered to admire his artwork, and Amir felt a sense of pride as he shared his passion with others. - في يوم المعرض، اجتمع الناس من جميع أنحاء المدينة للإعجاب بأعماله الفنية، وشعر أمير بفخر وهو يشارك شغفه مع الآخرين.',

  'One particular painting, depicting a colorful market scene, caught the eye of a famous art collector who offered to buy it for a large sum. - أحد الأعمال الفنية، التي تصور مشهد سوق ملون، لفتت انتباه جامع فنون مشهور عرض عليه شرائها مقابل مبلغ كبير.',

  'Overwhelmed with excitement, Amir realized that his dream of becoming a professional artist was within reach, and he accepted the offer with gratitude. - مع غمره بالإثارة، أدرك أمير أن حلمه في أن يصبح فنانًا محترفًا أصبح في متناول اليد، وقبل العرض بامتنان.',

  'As he continued to paint and share his art, Amir became an inspiration for young artists in the town, encouraging them to follow their dreams and express themselves through creativity. - بينما استمر في الرسم ومشاركة فنه، أصبح أمير مصدر إلهام للفنانين الشباب في المدينة، مشجعًا إياهم على متابعة أحلامهم والتعبير عن أنفسهم من خلال الإبداع.',

  'One day, a shy girl named Layla approached Amir, asking for his guidance to improve her own painting skills, and he gladly took her under his wing. - في يوم من الأيام، اقتربت منه فتاة خجولة تدعى ليلى، تسأله عن إرشاده لتحسين مهاراتها في الرسم، وأخذها تحت جناحيه بكل سرور.',

  'As they painted together, Amir discovered Layla’s unique talent for capturing emotions, and he encouraged her to embrace her style. - بينما كانوا يرسمون معًا، اكتشف أمير موهبة ليلى الفريدة في التقاط المشاعر، وشجعها على احتضان أسلوبها.',

  'Their bond grew stronger, and soon they decided to hold a joint exhibition, showcasing both of their works and celebrating their artistic journey. - أصبحت روابطهم أقوى، وسرعان ما قرروا إقامة معرض مشترك، مع عرض أعمالهم والاحتفال برحلتهم الفنية.',

  'On the day of the joint exhibition, the town buzzed with excitement as people flocked to see the beautiful creations by Amir and Layla. - في يوم المعرض المشترك، كانت المدينة تعج بالحماس حيث تجمع الناس لرؤية الإبداعات الجميلة لأمير وليلى.',

  'Amir felt immense joy watching Layla’s confidence shine as she shared her artwork, knowing he played a part in helping her find her voice as an artist. - شعر أمير بسعادة كبيرة وهو يشاهد ثقة ليلى تتألق بينما كانت تشارك أعمالها الفنية، عارفًا أنه كان له دور في مساعدتها في العثور على صوتها كفنانة.',

  'As the night progressed, their exhibition received praise from art critics, and they both realized the importance of supporting one another in their creative journeys. - مع تقدم الليل، تلقت معارضتهم الثناء من النقاد الفنيين، وأدركوا كلاهما أهمية دعم بعضهم البعض في رحلاتهم الإبداعية.',

  'From that day forward, Amir and Layla continued to collaborate, inspiring each other to explore new styles and techniques, and their friendship deepened through their shared love for art. - من ذلك اليوم فصاعدًا، استمر أمير وليلى في التعاون، ملهمين بعضهم البعض لاستكشاف أنماط وتقنيات جديدة، وعمق صداقتهما من خلال حبهما المشترك للفن.',

  'Years later, Amir and Layla became renowned artists, holding exhibitions around the world and using their success to inspire young talents everywhere. - بعد سنوات، أصبح أمير وليلى فنانين مشهورين، يقيمون معارض حول العالم ويستخدمون نجاحهم لإلهام المواهب الشابة في كل مكان.',

  'And so, the story of Amir and Layla reminds us that with passion, dedication, and support from others, we can turn our dreams into reality. - وهكذا، تذكرنا قصة أمير وليلى أنه مع الشغف والتفاني ودعم الآخرين، يمكننا تحويل أحلامنا إلى واقع.'
];







class SpeakingPage12 extends StatefulWidget {
  @override
  _SpeakingPage12State createState() => _SpeakingPage12State();
}

class _SpeakingPage12State extends State<SpeakingPage12> with SingleTickerProviderStateMixin {
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
      _currentSentence = sentences12[Random().nextInt(sentences12.length)];
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

