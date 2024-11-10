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

final List<String> sentences11 = [
  'Once upon a time, in a quaint village surrounded by lush forests, there lived a curious girl named Sara who dreamed of adventure beyond her home. - ذات مرة، في قرية صغيرة محاطة بالغابات المورقة، كانت تعيش فتاة فضولية تدعى سارة التي حلمت بمغامرات تتجاوز موطنها.',

  'One day, while exploring the woods, she stumbled upon a hidden path that shimmered in the sunlight, leading her to a magical kingdom filled with vibrant colors and whimsical creatures. - في يوم من الأيام، بينما كانت تستكشف الغابة، صادفت طريقًا مخفيًا يتلألأ في ضوء الشمس، مما قادها إلى مملكة سحرية مليئة بالألوان الزاهية والمخلوقات الغريبة.',

  'In this enchanting kingdom, she met a wise old owl who wore tiny glasses and spoke in riddles, offering to guide her on an extraordinary journey filled with secrets waiting to be discovered. - في هذه المملكة الساحرة، قابلت بومة حكيمة ترتدي نظارات صغيرة وتتحدث بالألغاز، وعرضت أن تكون دليلها في رحلة استثنائية مليئة بالأسرار التي تنتظر الاكتشاف.',

  'Sara eagerly accepted the owl’s invitation, and together they traveled through enchanted forests where trees whispered ancient tales and flowers sang sweet melodies. - وافقت سارة بشغف على دعوة البومة، وسافروا معًا عبر غابات ساحرة حيث كانت الأشجار تهمس بحكايات قديمة والزهور تغني لحنًا عذبًا.',

  'As they ventured deeper into the kingdom, they encountered a friendly dragon named Ember, who was searching for his lost treasure, a beautiful gem that glowed with a magical light. - بينما كانوا يتعمقون في المملكة، واجهوا تنينًا ودودًا يدعى إمبر، الذي كان يبحث عن كنزه المفقود، جوهرة جميلة تتلألأ بضوء سحري.',

  'Sara, with her brave heart, decided to help Ember on his quest, and together they faced treacherous paths and tricky puzzles that tested their courage and wit. - قررت سارة، بقلبها الشجاع، مساعدة إمبر في مهمته، ومعًا واجهوا طرقًا وعرة وألغازًا معقدة اختبرت شجاعتهم وذكائهم.',

  'Along their journey, they came across a sparkling river that was said to grant wishes to those who truly believed, and Sara made a wish for her adventure to last forever. - خلال رحلتهم، صادفوا نهرًا متلألئًا يُقال إنه يحقق الأمنيات لأولئك الذين يؤمنون حقًا، وتمنت سارة أن تستمر مغامرتها إلى الأبد.',

  'They finally arrived at a hidden cave where the gem was said to be guarded by a fierce guardian, but with clever thinking and teamwork, they managed to outsmart the guardian and retrieve the treasure. - وصلوا أخيرًا إلى كهف مخفي يُقال إن الجوهرة guarded by a fierce guardian، ولكن بفضل التفكير الذكي والعمل الجماعي، تمكنوا من التغلب على الحارس واستعادة الكنز.',

  'With the treasure in hand, Ember was overjoyed and invited Sara to his home, where they celebrated their victory with a feast of fruits and laughter under the starlit sky. - مع الكنز في اليد، كان إمبر في غاية السعادة ودعا سارة إلى منزله، حيث احتفلوا بانتصارهم بوجبة من الفواكه والضحك تحت سماء مرصعة بالنجوم.',

  'As the night wore on, Sara realized that the real treasure was not the gem but the friendships she had forged along the way, and she felt grateful for every moment spent in the magical kingdom. - مع مرور الليل، أدركت سارة أن الكنز الحقيقي لم يكن الجوهرة، بل الصداقات التي بنتها على طول الطريق، وشعرت بالامتنان لكل لحظة قضتها في المملكة السحرية.',

  'When it was time for Sara to return home, Ember and the wise owl gifted her a small crystal that would always remind her of her adventures and the friends she made. - عندما حان وقت عودة سارة إلى منزلها، قدم لها إمبر والبومة الحكيمة كريستالًا صغيرًا سيتذكرها دائمًا بمغامراتها والأصدقاء الذين صنعتهم.',

  'Sara promised to return to the magical kingdom one day and share her stories with others, inspiring them to seek their own adventures and embrace the beauty of friendship. - تعهدت سارة بالعودة إلى المملكة السحرية يومًا ما ومشاركة قصصها مع الآخرين، ملهمة إياهم للبحث عن مغامراتهم الخاصة واحتضان جمال الصداقة.',

  'Years passed, and Sara grew into a wise woman, sharing her tales of adventure with children in her village, who listened with wide eyes and eager hearts. - مرت السنوات، ونمت سارة لتصبح امرأة حكيمة، تشارك حكايات مغامرتها مع الأطفال في قريتها، الذين استمعوا بعيون واسعة وقلوب متحمسة.',

  'One day, a group of children asked her if magic was real, and she smiled, knowing that magic lived in every adventure and in every friendship formed along the way. - في يوم من الأيام، سألها مجموعة من الأطفال إذا كانت السحر حقيقيًا، ابتسمت وهي تعرف أن السحر يعيش في كل مغامرة وفي كل صداقة تتشكل على طول الطريق.',

  'With a twinkle in her eye, she told them about the enchanted forest, the wise owl, and the friendly dragon, encouraging them to explore the world around them. - مع لمعة في عينيها، أخبرت الأطفال عن الغابة المسحورة، والبومة الحكيمة، والتنين الودود، مشجعة إياهم على استكشاف العالم من حولهم.',

  'As the sun set, painting the sky in shades of orange and pink, Sara felt a warm glow in her heart, knowing that she had passed on the magic of her adventures to the next generation. - مع غروب الشمس، وطلاء السماء بألوان برتقالية وزهرية، شعرت سارة بتوهج دافئ في قلبها، وهي تعلم أنها نقلت سحر مغامراتها إلى الجيل القادم.',

  'And so, the story of Sara and her magical adventures lived on, inspiring countless others to dream big and seek out the extraordinary in their own lives. - وهكذا، استمرت قصة سارة ومغامراتها السحرية في العيش، ملهمة العديد من الآخرين للحلم الكبير والبحث عن الأمور الاستثنائية في حياتهم الخاصة.'
];







class SpeakingPage11 extends StatefulWidget {
  @override
  _SpeakingPage11State createState() => _SpeakingPage11State();
}

class _SpeakingPage11State extends State<SpeakingPage11> with SingleTickerProviderStateMixin {
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
      _currentSentence = sentences11[Random().nextInt(sentences11.length)];
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

