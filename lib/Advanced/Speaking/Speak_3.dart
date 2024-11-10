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

final List<String> sentences3 = [
  'Greetings, how have you been lately? I have been doing exceptionally well, thank you for asking. - تحياتي، كيف كنت مؤخرًا؟ كنت على ما يرام بشكل استثنائي، شكرًا لسؤالك.',
  'Could you kindly introduce yourself? My name is John, but most people call me Jonathan. - هل يمكنك لطفًا أن تقدم نفسك؟ اسمي جون، لكن معظم الناس ينادونني جوناثان.',
  'At what age did you accomplish your first significant milestone? I achieved my first milestone at 25 years of age. - في أي عمر حققت أول إنجاز مهم في حياتك؟ حققت إنجازي الأول عندما كنت في الخامسة والعشرين.',
  'Which region or city do you originate from? I come from a small, picturesque town in the United States. - من أي منطقة أو مدينة أنت؟ أنا من بلدة صغيرة ذات مناظر خلابة في الولايات المتحدة.',
  'What is your occupation, and how did you get into it? I work as a teacher, and I have been passionate about education since childhood. - ما هي مهنتك وكيف دخلت هذا المجال؟ أعمل كمعلم، وقد كنت شغوفًا بالتعليم منذ الطفولة.',
  'Are you proficient in any other languages besides English? Yes, I am also fluent in Spanish and French. - هل تجيد أي لغات أخرى بجانب الإنجليزية؟ نعم، أنا أتحدث الإسبانية والفرنسية بطلاقة.',
  'Would you be willing to lend me a hand with this challenging task? Absolutely, I would be more than happy to assist you. - هل ستكون على استعداد لمساعدتي في هذه المهمة الصعبة؟ بالطبع، سأكون أكثر من سعيد بمساعدتك.',
  'Could you direct me to the nearest healthcare facility? It is just a short walk from here, about two blocks away. - هل يمكنك إرشادي إلى أقرب منشأة صحية؟ إنه على بعد مسافة قصيرة سيرًا على الأقدام، حوالي مبنيين.',
  'May I inquire what time it is exactly? It is currently 10 o\'clock sharp, no minute more or less. - هل يمكنني الاستفسار عن الوقت بالضبط؟ إنها تمامًا الساعة العاشرة، لا دقيقة أكثر ولا أقل.',
  'How much would it cost to purchase this particular item? The price of this item is a total of \$50, taxes included. - كم سيكلف شراء هذا العنصر بالذات؟ السعر الإجمالي لهذا العنصر هو 50 دولارًا، مع الضرائب.',
  'Could I please have the total bill for everything I ordered? Certainly, here is the complete bill with all the details. - هل يمكنني من فضلك الحصول على الفاتورة الإجمالية لكل ما طلبته؟ بالطبع، ها هي الفاتورة الكاملة مع كل التفاصيل.',
  'Do you have a confirmed reservation under your name? Yes, I have made a reservation for two at 7 PM. - هل لديك حجز مؤكد باسمك؟ نعم، لقد حجزت لشخصين في الساعة السابعة مساءً.',
  'Can you please show me where the restroom is located? The restroom is at the end of the hall, just past the elevators. - هل يمكنك أن تريني أين يقع الحمام؟ الحمام في نهاية الممر، بعد المصاعد مباشرةً.',
  'How has the weather been treating you today? The weather today has been quite unpredictable, alternating between sunny and rainy. - كيف كان الطقس معك اليوم؟ كان الطقس اليوم غير متوقع للغاية، يتراوح بين مشمس وممطر.',
  'Could you kindly provide me with detailed directions to the venue? Sure, follow the road straight ahead, then take the second left. - هل يمكنك لطفًا إعطائي توجيهات تفصيلية إلى المكان؟ بالتأكيد، اتبع الطريق مباشرة ثم خذ اليسار الثاني.',
  'What activities did you partake in yesterday? Yesterday, I spent the entire afternoon at the park, reading a book. - ما هي الأنشطة التي شاركت فيها بالأمس؟ قضيت بعد ظهر الأمس بأكمله في الحديقة، أقرأ كتابًا.',
  'Are you preoccupied with any urgent matters at the moment? No, I am currently free and can attend to anything. - هل أنت مشغول بأي أمور عاجلة في الوقت الحالي؟ لا، أنا متاح حاليًا ويمكنني التعامل مع أي شيء.',
  'Do you have a strong preference for coffee over other beverages? Yes, I absolutely prefer coffee, especially in the mornings. - هل لديك تفضيل قوي للقهوة على المشروبات الأخرى؟ نعم، أفضل القهوة تمامًا، خاصة في الصباح.',
  'What dish do you consider to be the pinnacle of your culinary experiences? My favorite dish of all time has to be pizza, specifically margherita. - ما هو الطبق الذي تعتبره قمة تجاربك الطهوية؟ طبقي المفضل على الإطلاق هو البيتزا، خاصة مارغريتا.',
  'Which city do you call home? I currently reside in the bustling metropolis of New York City. - أي مدينة تعتبرها موطنًا لك؟ أقيم حاليًا في المدينة الصاخبة نيويورك.',
  'What are the best transportation options to reach the airport? You can either take a direct taxi or opt for the express bus. - ما هي أفضل وسائل النقل للوصول إلى المطار؟ يمكنك إما أخذ سيارة أجرة مباشرة أو اختيار الحافلة السريعة.',
  'When exactly is the train scheduled to leave? The train is scheduled to depart precisely at 5 PM. - متى بالضبط من المقرر أن يغادر القطار؟ من المقرر أن يغادر القطار في الساعة الخامسة مساءً بالضبط.',
  'How long does the entire flight journey typically last? The entire flight usually takes around three hours, depending on the weather. - كم يستغرق إجمالي رحلة الطيران عادةً؟ تستغرق الرحلة بالكامل عادةً حوالي ثلاث ساعات، حسب الطقس.',
  'Which movie has had the greatest influence on you? My all-time favorite film is Inception due to its thought-provoking storyline. - ما هو الفيلم الذي كان له التأثير الأكبر عليك؟ فيلمي المفضل على الإطلاق هو Inception بسبب قصته المثيرة للتفكير.',
  'Are you deeply passionate about music? Yes, I am truly passionate about music, and I often spend hours listening to various genres. - هل لديك شغف عميق بالموسيقى؟ نعم، لدي شغف حقيقي بالموسيقى، وغالبًا ما أقضي ساعات في الاستماع إلى أنواع مختلفة.',
  'Do you have the ability to play any musical instruments? Yes, I have been playing the guitar for over ten years. - هل لديك القدرة على العزف على أي آلة موسيقية؟ نعم، أعزف على الجيتار منذ أكثر من عشر سنوات.',
  'Do you happen to have any pets at home? Yes, I have a dog that I consider part of the family. - هل لديك أي حيوانات أليفة في المنزل؟ نعم، لدي كلب أعتبره جزءًا من العائلة.',
  'How many languages can you communicate fluently in? I am fluent in two languages, English and Spanish, and learning a third. - كم عدد اللغات التي يمكنك التواصل بها بطلاقة؟ أجيد لغتين، الإنجليزية والإسبانية، وأتعلم الثالثة.',
  'What is your most cherished color and why? My favorite color is blue, as it evokes a sense of calm and serenity. - ما هو لونك المفضل ولماذا؟ لوني المفضل هو الأزرق، لأنه يبعث على الهدوء والسكينة.',
  'At what time do you usually rise from bed? I generally wake up at 6 AM to start my day early. - في أي وقت تستيقظ عادةً من السرير؟ أستيقظ عادةً في الساعة السادسة صباحًا لبدء يومي مبكرًا.',
  'Are you an avid sports enthusiast? Yes, I particularly enjoy playing and watching football. - هل أنت متحمس كبير للرياضة؟ نعم، أستمتع بشكل خاص بممارسة ومشاهدة كرة القدم.',
  'Have you ever embarked on a trip to Europe? Yes, I had the pleasure of visiting Europe during my vacation last year. - هل سبق لك أن ذهبت في رحلة إلى أوروبا؟ نعم، أتيحت لي فرصة زيارة أوروبا خلال إجازتي العام الماضي.',
  'What is your current line of work? I am currently employed as a software engineer at a tech company. - ما هو مجال عملك الحالي؟ أنا أعمل حاليًا كمهندس برمجيات في شركة تقنية.',
  'Can you skillfully operate a vehicle? Yes, I have been driving for many years now and consider myself a skilled driver. - هل تستطيع قيادة السيارة بمهارة؟ نعم، أقود منذ سنوات عديدة وأعتبر نفسي سائقًا ماهرًا.',
  'What hobbies do you dedicate your time to? I dedicate my free time to reading, hiking, and exploring new places. - ما هي الهوايات التي تكرس لها وقتك؟ أخصص وقت فراغي للقراءة والمشي واستكشاف أماكن جديدة.',
  'Which book has had a profound impact on your thinking? The book that influenced me the most is 1984 by George Orwell. - ما هو الكتاب الذي كان له تأثير عميق على تفكيرك؟ الكتاب الذي أثر في تفكيري أكثر هو 1984 لجورج أورويل.',
  'How do you prefer to spend your leisure time? In my free time, I enjoy watching critically acclaimed movies and reading novels. - كيف تفضل قضاء وقت فراغك؟ في وقت فراغي، أستمتع بمشاهدة الأفلام التي نالت استحسان النقاد وقراءة الروايات.',
  'Do you have any siblings, and what are they like? Yes, I have a sister who is a doctor and a brother who works as an engineer. - هل لديك إخوة وما هو مجال عملهم؟ نعم، لدي أخت تعمل كطبيبة وأخ يعمل كمهندس.',
  'Which season resonates with you the most and why? I love spring the most because it symbolizes renewal and new beginnings. - ما هو الفصل الذي تتفاعل معه أكثر ولماذا؟ أحب الربيع أكثر لأنه يرمز إلى التجديد والبدايات الجديدة.',
  'How frequently do you engage in physical activity? I make it a point to exercise at least three times a week to stay healthy. - كم مرة تمارس النشاط البدني؟ أحرص على ممارسة الرياضة ثلاث مرات على الأقل في الأسبوع للحفاظ على صحتي.',
  'Do you enjoy exploring new destinations and cultures? Yes, traveling and immersing myself in new cultures is something I truly cherish. - هل تستمتع باكتشاف وجهات وثقافات جديدة؟ نعم، السفر والانغماس في ثقافات جديدة هو شيء أعتز به كثيرًا.',
  'Which country has left the strongest impression on you during your travels? Japan left a profound impact on me due to its rich culture and history. - أي دولة تركت أقوى انطباع عليك خلال رحلاتك؟ تركت اليابان تأثيرًا عميقًا علي بسبب ثقافتها وتاريخها الغني.',
  'What genre of music moves you the most? I find myself deeply moved by classical music, especially symphonies. - ما هو نوع الموسيقى الذي يحرك مشاعرك أكثر؟ أجد نفسي متأثرًا بشدة بالموسيقى الكلاسيكية، خاصة السيمفونيات.',
  'Where exactly is your office or place of work located? My office is located in the downtown area, near the central business district. - أين يقع مكتبك أو مكان عملك بالضبط؟ يقع مكتبي في وسط المدينة، بالقرب من منطقة الأعمال المركزية.',
  'What is your preferred mode of transportation to commute? I usually prefer taking the subway to avoid traffic congestion. - ما هو وسيلة النقل المفضلة لديك للتنقل؟ أفضل عادةً أخذ المترو لتجنب الازدحام المروري.',
  'Are you satisfied with your current professional life? Yes, I find my career to be both rewarding and intellectually stimulating. - هل أنت راضٍ عن حياتك المهنية الحالية؟ نعم، أجد مسيرتي المهنية مُرضية ومحفزة فكريًا.',
  'What are your plans for the upcoming weekend? I am planning to go on a hiking trip to explore some scenic trails. - ما هي خططك لعطلة نهاية الأسبوع القادمة؟ أخطط للذهاب في رحلة مشي لاستكشاف بعض المسارات ذات المناظر الخلابة.',
  'Do you find greater relaxation in tea or coffee? I find tea to be more soothing, especially herbal teas. - هل تجد استرخاءً أكبر في الشاي أم القهوة؟ أجد الشاي أكثر تهدئة، خاصة الشاي العشبي.',
  'At what time do you typically go to bed? I usually go to bed around 10 PM, ensuring I get enough rest. - في أي وقت عادةً ما تذهب إلى الفراش؟ أذهب إلى الفراش عادةً حوالي الساعة العاشرة مساءً لضمان الحصول على قسط كافٍ من الراحة.',
  'Which holiday brings you the most joy, and why? Christmas is my favorite holiday because it brings families together. - أي عطلة تجلب لك أكبر قدر من الفرح ولماذا؟ عيد الميلاد هو عطلي المفضلة لأنه يجمع العائلات.',
  'Could you share your phone number for future contact? My phone number is 123-456-7890, feel free to reach out anytime. - هل يمكنك مشاركة رقم هاتفك للاتصال المستقبلي؟ رقمي هو 123-456-7890، لا تتردد في التواصل في أي وقت.'
];







class SpeakingPage3 extends StatefulWidget {
  @override
  _SpeakingPage3State createState() => _SpeakingPage3State();
}

class _SpeakingPage3State extends State<SpeakingPage3> with SingleTickerProviderStateMixin {
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
      _currentSentence = sentences3[Random().nextInt(sentences3.length)];
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

