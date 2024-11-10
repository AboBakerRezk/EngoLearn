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

final List<String> sentences4 = [
'Good day! How have you been navigating the challenges of life lately? I’ve been thriving, thank you for your concern. - يوم جيد! كيف كنت تتعامل مع تحديات الحياة مؤخرًا؟ لقد كنت أزدهر، شكرًا لاهتمامك.',
'Would you kindly share your full name and background? My name is Johnathan Smith, and I hail from a diverse cultural heritage. - هل يمكنك لطفًا أن تشارك اسمك الكامل وخلفيتك؟ اسمي جوناثان سميث، وأنا أنتمي إلى تراث ثقافي متنوع.',
'What significant milestones have you achieved in your life thus far? I successfully completed my masters degree at 25, which was a great achievement. - ما هي الإنجازات المهمة التي حققتها في حياتك حتى الآن؟ أكملت بنجاح درجة الماجستير في الخامسة والعشرين، وكان ذلك إنجازًا عظيمًا.',
'From which region do your roots originate? I come from a vibrant city known for its rich history and cultural diversity. - من أي منطقة تأتي جذورك؟ أنا من مدينة نابضة بالحياة معروفة بتاريخها الغني وتنوعها الثقافي.',
'Could you elaborate on your professional journey and what led you to choose that career? I am a dedicated educator who has always been passionate about shaping young minds. - هل يمكنك التوسع في مسيرتك المهنية وما الذي دفعك لاختيار تلك المهنة؟ أنا معلم مكرس دائمًا ما كنت شغوفًا بتشكيل عقول الشباب.',
'Besides English, do you possess any additional language skills? Yes, I am proficient in Spanish and have a conversational level in French. - بجانب الإنجليزية، هل لديك مهارات لغوية إضافية؟ نعم، أنا متمكن في الإسبانية ولدي مستوى محادثة في الفرنسية.',
'Would you be willing to assist me with this intricate task? I would greatly appreciate your help in overcoming this challenge. - هل ستكون على استعداد لمساعدتي في هذه المهمة المعقدة؟ سأكون ممتنًا جدًا لمساعدتك في التغلب على هذا التحدي.',
'Could you point me in the direction of the nearest medical facility? It is conveniently located just a few blocks from here. - هل يمكنك إرشادي إلى أقرب مرفق طبي؟ إنه يقع بشكل ملائم على بعد بضعة شوارع من هنا.',
'May I inquire about the current time in a precise manner? The clock indicates it is exactly 10 o’clock, to the minute. - هل يمكنني الاستفسار عن الوقت الحالي بدقة؟ تشير الساعة إلى أنها تمامًا الساعة العاشرة، دقيقة واحدة.',
'What is the price tag for this specific item? The total cost for this item amounts to \$50, inclusive of all fees. - ما هو السعر لهذا العنصر المحدد؟ التكلفة الإجمالية لهذا العنصر تبلغ 50 دولارًا، بما في ذلك جميع الرسوم.',
'Could you please provide me with the complete invoice for my order? Certainly, here is the detailed invoice encompassing all items ordered. - هل يمكنك من فضلك تزويدي بالفاتورة الكاملة لطلبي؟ بالتأكيد، ها هي الفاتورة التفصيلية التي تشمل جميع العناصر المطلوبة.',
'Do you hold a reservation under your name for tonight? Yes, I’ve booked a table for two at 7 PM this evening. - هل لديك حجز باسمك لهذه الليلة؟ نعم، لقد حجزت طاولة لشخصين في الساعة السابعة مساءً.',
'Could you guide me to the restroom facilities, please? The restroom is located at the end of the corridor, adjacent to the elevators. - هل يمكنك إرشادي إلى مرافق الحمام من فضلك؟ الحمام يقع في نهاية الممر، بجوار المصاعد.',
'How is the weather treating you today? The weather has been quite unpredictable, oscillating between sunshine and rain. - كيف يعاملك الطقس اليوم؟ كان الطقس غير متوقع إلى حد كبير، يتأرجح بين الشمس والمطر.',
'Can you provide detailed directions to the venue we’re heading to? Certainly, proceed straight, then take the second left and you’ll find it. - هل يمكنك تقديم توجيهات تفصيلية إلى المكان الذي نتوجه إليه؟ بالتأكيد، تقدم مباشرة، ثم خذ اليسار الثاني وستجده.',
'What activities did you engage in yesterday? I spent a lovely afternoon at the park, enjoying a captivating book. - ما الأنشطة التي شاركت فيها بالأمس؟ قضيت فترة بعد ظهر رائعة في الحديقة، أستمتع بكتاب مشوق.',
'Are you currently preoccupied with any pressing commitments? No, I am fully available and can assist with anything you need. - هل أنت مشغول حاليًا بأي التزامات ملحة؟ لا، أنا متاح بالكامل ويمكنني المساعدة في أي شيء تحتاجه.',
'Do you have a preference for coffee, or do you enjoy other beverages? Yes, I have a strong affinity for coffee, particularly in the mornings. - هل لديك تفضيل للقهوة، أم أنك تستمتع بمشروبات أخرى؟ نعم، لدي ميول قوية للقهوة، وخاصة في الصباح.',
'What culinary creation brings you the greatest joy? My all-time favorite dish has to be pizza, especially with a variety of toppings. - ما هو الإبداع الطهوي الذي يجلب لك أكبر قدر من السعادة؟ طبق المفضل على الإطلاق هو البيتزا، خاصة مع مجموعة متنوعة من الإضافات.',
'In which city do you reside, and what makes it special to you? I currently call New York City home, as it is a melting pot of cultures. - في أي مدينة تعيش، وما الذي يجعلها مميزة بالنسبة لك؟ أعتبر نيويورك مسقط رأسي، حيث إنها بوتقة تنصهر فيها الثقافات.',
'What are the most efficient transportation options available to reach the airport? You may opt for a taxi or consider the express bus service. - ما هي أكثر خيارات النقل فعالية المتاحة للوصول إلى المطار؟ يمكنك اختيار سيارة أجرة أو النظر في خدمة الحافلة السريعة.',
'What is the scheduled departure time for the train today? The train is scheduled to leave at precisely 5 PM without any delays. - ما هو الوقت المحدد لمغادرة القطار اليوم؟ من المقرر أن يغادر القطار في الساعة الخامسة مساءً بالضبط دون أي تأخيرات.',
'How long does the typical flight duration last? The typical flight duration is approximately three hours, depending on various factors. - كم تستغرق مدة الرحلة الجوية عادةً؟ تستغرق مدة الرحلة الجوية حوالي ثلاث ساعات تقريبًا، اعتمادًا على عوامل مختلفة.',
'What film has had the most profound impact on your life? The film that left a lasting impression on me is Inception, due to its intricate plot. - ما هو الفيلم الذي كان له التأثير الأعمق على حياتك؟ الفيلم الذي ترك انطباعًا دائمًا علي هو Inception، بسبب حبكته المعقدة.',
'How passionate are you about music? Yes, I am incredibly passionate about music and spend hours exploring different genres. - ما مدى شغفك بالموسيقى؟ نعم، أنا شغوف جدًا بالموسيقى وأقضي ساعات في استكشاف أنواع مختلفة.',
'Are you able to play any musical instruments with skill? Yes, I have been playing the guitar for over a decade and thoroughly enjoy it. - هل يمكنك العزف على أي آلة موسيقية بمهارة؟ نعم، أعزف على الجيتار منذ أكثر من عقد وأستمتع بذلك.',
'Do you have any beloved pets at home? Yes, I have a dog that I adore and consider a member of my family. - هل لديك أي حيوانات أليفة محبوبة في المنزل؟ نعم، لدي كلب أحبّه وأعتبره فردًا من عائلتي.',
'How many languages can you fluently communicate in? I am fluent in two languages, English and Spanish, and I’m learning a third. - كم عدد اللغات التي يمكنك التواصل بها بطلاقة؟ أنا أتحدث بطلاقة لغتين، الإنجليزية والإسبانية، وأنا أتعلم الثالثة.',
'What color resonates with you the most, and what emotions does it evoke? My favorite color is blue, as it evokes feelings of tranquility and peace. - ما هو اللون الذي يتردد صداه لديك أكثر، وما المشاعر التي يثيرها؟ لوني المفضل هو الأزرق، لأنه يثير مشاعر الهدوء والسلام.',
'At what hour do you generally rise from bed? I typically wake up around 6 AM to seize the day ahead. - في أي ساعة تستيقظ عادةً من السرير؟ أستيقظ عادةً حوالي الساعة السادسة صباحًا لاغتنام اليوم.',
'Which holiday do you cherish the most, and what traditions do you celebrate? Christmas is my favorite holiday, filled with joyful traditions and family gatherings. - أي عطلة تعزّها أكثر، وما هي التقاليد التي تحتفل بها؟ عيد الميلاد هو عطلتك المفضلة، مليء بالتقاليد السعيدة والتجمعات العائلية.',
'Could you please share your contact number for future correspondence? My phone number is 123-456-7890; feel free to reach out at any time. - هل يمكنك مشاركة رقم اتصالك للاتصالات المستقبلية؟ رقمي هو 123-456-7890؛ لا تتردد في التواصل في أي وقت.'
];







class SpeakingPage4 extends StatefulWidget {
  @override
  _SpeakingPage4State createState() => _SpeakingPage4State();
}

class _SpeakingPage4State extends State<SpeakingPage4> with SingleTickerProviderStateMixin {
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
      _currentSentence = sentences4[Random().nextInt(sentences4.length)];
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

