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

final List<String> sentences13 = [
  'In a quaint village surrounded by mountains, there lived a kind-hearted baker named Fatima. - في قرية صغيرة محاطة بالجبال، كانت تعيش خبازة طيبة القلب تدعى فاطمة.',

  'Every morning, Fatima woke up before dawn to bake fresh bread and pastries, filling the air with delightful aromas. - كل صباح، كانت فاطمة تستيقظ قبل الفجر لتخبز الخبز والمعجنات الطازجة، مما يملأ الهواء بروائح لذيذة.',

  'The villagers loved her treats, and they often gathered at her bakery, sharing stories and laughter over cups of tea. - كان القرويون يحبون حلوياتها، وغالبًا ما كانوا يجتمعون في مخبزها، يتبادلون القصص والضحكات على أكواب الشاي.',

  'One day, a traveling merchant visited the village and tasted Fatima’s bread. He was so impressed that he offered to help her expand her business. - في يوم من الأيام، زار تاجر مسافر القرية وتذوق خبز فاطمة. كان معجبًا جدًا لدرجة أنه عرض عليها مساعدتها في توسيع عملها.',

  'Excited about the opportunity, Fatima agreed, and together they planned to open a larger bakery in the town center. - متحمسة لهذه الفرصة، وافقت فاطمة، ومعًا خططا لفتح مخبز أكبر في مركز المدينة.',

  'As the new bakery was being built, Fatima continued to bake in her small shop, but she dreamed of serving even more people. - بينما كان يتم بناء المخبز الجديد، استمرت فاطمة في الخبز في متجرها الصغير، لكنها حلمت بخدمة المزيد من الناس.',

  'When the new bakery opened, it quickly became a popular spot, attracting visitors from neighboring towns. - عندما افتتح المخبز الجديد، أصبح بسرعة مكانًا شهيرًا، يجذب الزوار من المدن المجاورة.',

  'Fatima’s signature pastries, especially her chocolate croissants, became famous, and her reputation grew. - أصبحت المعجنات المميزة لفاطمة، وخاصة الكرواسون بالشوكولاتة، مشهورة، ونمت سمعتها.',

  'With success came new challenges, and Fatima found herself working longer hours to meet the demand. - مع النجاح جاءت تحديات جديدة، ووجدت فاطمة نفسها تعمل لساعات أطول لتلبية الطلب.',

  'Despite the hard work, she never lost her passion for baking and continued to create new recipes to delight her customers. - على الرغم من العمل الشاق، لم تفقد شغفها بالخبز واستمرت في ابتكار وصفات جديدة لإسعاد زبائنها.',

  'One evening, after closing her bakery, Fatima received a visit from a local school principal who wanted to organize a baking class for children. - في إحدى الأمسيات، بعد إغلاق مخبزها، تلقت فاطمة زيارة من مديرة مدرسة محلية أرادت تنظيم فصل خبز للأطفال.',

  'Fatima was thrilled and agreed to teach the children how to bake, believing that sharing her knowledge was important. - كانت فاطمة متحمسة ووافقت على تعليم الأطفال كيفية الخبز، معتقدة أن مشاركة معرفتها أمر مهم.',

  'The first class was a huge success, with the children laughing and learning, and Fatima felt a sense of fulfillment in sharing her passion. - كانت الدرس الأول ناجحًا جدًا، مع ضحك الأطفال وتعلمهم، وشعرت فاطمة بشعور من الاكتفاء في مشاركة شغفها.',

  'As the baking classes continued, more children joined, and Fatima found joy in watching them create their own treats. - مع استمرار دروس الخبز، انضم المزيد من الأطفال، ووجدت فاطمة فرحًا في رؤية الأطفال يبتكرون حلوى خاصة بهم.',

  'The community started to recognize Fatima not only as a baker but also as a mentor who inspired the next generation. - بدأت المجتمع في التعرف على فاطمة ليس فقط كخبازة، بل أيضًا كمعلمة ألهمت الجيل القادم.',

  'One day, during a local festival, Fatima decided to host a baking competition for the children, encouraging them to showcase their skills. - في يوم من الأيام، خلال مهرجان محلي، قررت فاطمة تنظيم مسابقة خبز للأطفال، تشجعهم على عرض مهاراتهم.',

  'The competition was filled with excitement, and the children presented their delicious creations, earning applause and cheers from the crowd. - كانت المسابقة مليئة بالحماس، وعرض الأطفال إبداعاتهم اللذيذة، محققين تصفيق وهتافات من الحضور.',

  'At the end of the day, Fatima awarded prizes to all participants, emphasizing that the joy of baking was the true victory. - في نهاية اليوم، منحت فاطمة جوائز لجميع المشاركين، مؤكدًة أن فرحة الخبز كانت الانتصار الحقيقي.',

  'Through her bakery and classes, Fatima not only fulfilled her dreams but also inspired others to pursue their passions and share their talents. - من خلال مخبزها ودروسها، لم تحقق فاطمة أحلامها فحسب، بل ألهمت الآخرين أيضًا لمتابعة شغفهم ومشاركة مواهبهم.',

  'And so, the story of Fatima reminds us that with passion and a willingness to share, we can create a positive impact in our community. - وهكذا، تذكرنا قصة فاطمة أنه مع الشغف والاستعداد للمشاركة، يمكننا أن نحدث تأثيرًا إيجابيًا في مجتمعنا.'
];







class SpeakingPage13 extends StatefulWidget {
  @override
  _SpeakingPage13State createState() => _SpeakingPage13State();
}

class _SpeakingPage13State extends State<SpeakingPage13> with SingleTickerProviderStateMixin {
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
      _currentSentence = sentences13[Random().nextInt(sentences13.length)];
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

