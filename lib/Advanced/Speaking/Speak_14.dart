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

final List<String> sentences14 = [
  'In a small coastal town, there was a wise old fisherman named Hassan who had spent his life at sea. - في بلدة ساحلية صغيرة، كان هناك صياد حكيم يدعى حسن قضى حياته في البحر.',

  'Every day, he would set sail before sunrise, his boat gliding over the calm waters as he cast his nets. - كل يوم، كان يبحر قبل شروق الشمس، قاربه ينزلق فوق المياه الهادئة بينما يلقي بشباكه.',

  'The townspeople often gathered at the docks to hear Hassan’s stories of the ocean, full of adventures and lessons learned. - غالبًا ما كان أهل المدينة يجتمعون في الموانئ للاستماع إلى قصص حسن عن المحيط، مليئة بالمغامرات والدروس المستفادة.',

  'One day, a young boy named Omar approached Hassan and expressed his desire to learn the ways of the sea. - في يوم من الأيام، اقترب فتى يدعى عمر من حسن وأبدى رغبته في تعلم طرق البحر.',

  'Hassan smiled and welcomed him aboard, teaching him the skills of fishing and the importance of respecting nature. - ابتسم حسن ورحب به على متن القارب، معلمًا إياه مهارات الصيد وأهمية احترام الطبيعة.',

  'As the days passed, Omar learned to navigate the waters, understanding the tides and the behavior of the fish. - مع مرور الأيام، تعلم عمر كيفية الإبحار في المياه، وفهم المد والجزر وسلوك الأسماك.',

  'One fateful morning, a storm brewed unexpectedly, and Hassan and Omar found themselves caught in turbulent waves. - في صباح مصيري، نشأت عاصفة بشكل غير متوقع، ووجد حسن وعمر نفسيهما عالقين في أمواج مضطربة.',

  'Hassan remained calm, guiding Omar on how to steer the boat and weather the storm, teaching him the value of courage. - ظل حسن هادئًا، موجهًا عمر حول كيفية توجيه القارب وتحمل العاصفة، معلمًا إياه قيمة الشجاعة.',

  'After what felt like hours, the storm finally subsided, and they emerged into the sunlight, relieved but exhausted. - بعد ما بدا وكأنه ساعات، أخيرًا هدأت العاصفة، وظهرا إلى ضوء الشمس، يشعران بالراحة ولكن منهكين.',

  'Hassan praised Omar for his bravery and quick thinking, reminding him that challenges often lead to growth. - أثنى حسن على عمر لشجاعته وسرعة تفكيره، مذكرًا إياه بأن التحديات غالبًا ما تؤدي إلى النمو.',

  'With newfound confidence, Omar became more determined than ever to master the art of fishing. - مع الثقة المتجددة، أصبح عمر أكثر إصرارًا من أي وقت مضى على إتقان فن الصيد.',

  'As the seasons changed, so did their bond, growing stronger with each shared experience on the water. - مع تغير الفصول، تغيرت أيضًا علاقتهما، حيث أصبحت أقوى مع كل تجربة مشتركة على الماء.',

  'One day, they discovered a hidden cove filled with vibrant coral reefs and exotic fish, a secret paradise beneath the waves. - في يوم من الأيام، اكتشفوا خليجًا مخفيًا مليئًا بالشعاب المرجانية النابضة بالألوان والأسماك الغريبة، جنة سرية تحت الأمواج.',

  'Omar suggested they share this treasure with the town, and together they organized a community event to promote ocean conservation. - اقترح عمر أن يشاركا هذه الجوهرة مع المدينة، ومعًا نظما حدثًا مجتمعيًا لتعزيز حماية المحيط.',

  'The event was a great success, bringing the townspeople together to learn about the beauty and fragility of marine life. - كانت الفعالية ناجحة جدًا، تجمع بين أهل المدينة لتعلم جمال وحساسية الحياة البحرية.',

  'Through their efforts, Hassan and Omar inspired the community to take better care of the ocean and its resources. - من خلال جهودهما، ألهم حسن وعمر المجتمع للعناية بشكل أفضل بالمحيط وموارده.',

  'As time went on, Omar grew into a skilled fisherman, carrying forward the lessons he learned from Hassan. - مع مرور الوقت، أصبح عمر صيادًا ماهرًا، يحمل الدروس التي تعلمها من حسن.',

  'Eventually, Hassan decided it was time to pass on his legacy, and he entrusted Omar with his boat, a symbol of their shared journey. - في النهاية، قرر حسن أنه حان الوقت لنقل إرثه، وعهد إلى عمر بقاربه، رمز رحلتهما المشتركة.',

  'Omar felt honored and vowed to continue Hassan’s teachings, ensuring that the wisdom of the sea would live on. - شعر عمر بالشرف وتعهد بمواصلة تعليمات حسن، ضامنًا أن حكمة البحر ستستمر.',

  'And so, the story of Hassan and Omar reminds us that through mentorship and respect for nature, we can create lasting connections and make a difference in our world. - وهكذا، تذكرنا قصة حسن وعمر أنه من خلال الإرشاد واحترام الطبيعة، يمكننا إنشاء روابط دائمة وإحداث فرق في عالمنا.'
];







class SpeakingPage14 extends StatefulWidget {
  @override
  _SpeakingPage14State createState() => _SpeakingPage14State();
}

class _SpeakingPage14State extends State<SpeakingPage14> with SingleTickerProviderStateMixin {
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
      _currentSentence = sentences14[Random().nextInt(sentences14.length)];
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

