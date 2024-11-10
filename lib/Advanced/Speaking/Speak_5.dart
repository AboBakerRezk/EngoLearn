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

final List<String> sentences5 = [
  'Hello, how have you been since we last spoke? I have been doing quite well, thank you for asking! - مرحبًا، كيف كنت منذ آخر حديث لنا؟ أنا بخير جدًا، شكرًا لسؤالك!',
  'Could you please tell me your full name and a little about yourself? My name is John, and I am a passionate teacher who enjoys inspiring young minds. - هل يمكنك من فضلك إخباري باسمك الكامل وقليل عن نفسك؟ اسمي جون، وأنا معلم شغوف أستمتع بإلهام العقول الشابة.',
  'What is your age, if you don’t mind me asking? I am currently 25 years old, and I have big dreams for the future. - ما هو عمرك، إذا لم تمانع في سؤالي؟ أنا في الخامسة والعشرين من عمري، ولدي أحلام كبيرة للمستقبل.',
  'Where do you hail from, and what do you love most about your hometown? I am originally from the United States, and I love its diverse culture and vibrant atmosphere. - من أين أنت؟ وما الذي تحبه أكثر في مدينتك؟ أنا من الولايات المتحدة، وأحب ثقافتها المتنوعة وأجوائها النابضة بالحياة.',
  'What profession do you engage in, and what inspired you to choose that career? I work as a teacher because I find joy in shaping the future of my students. - ما هو عملك، وما الذي ألهمك لاختيار هذه المهنة؟ أعمل كمعلم لأنني أجد سعادة في تشكيل مستقبل طلابي.',
  'Are you proficient in English, and how did you learn the language? Yes, I can communicate effectively in English thanks to my years of study and practice. - هل تجيد اللغة الإنجليزية، وكيف تعلمت اللغة؟ نعم، أستطيع التواصل بشكل فعال باللغة الإنجليزية بفضل سنوات دراستي وممارستي.',
  'Would you be able to assist me with a few tasks? Certainly, I would be more than happy to lend a hand! - هل يمكنك مساعدتي في بعض المهام؟ بالتأكيد، سأكون سعيدًا جدًا بتقديم المساعدة!',
  'Could you please tell me the location of the nearest hospital, as I might need it in case of an emergency? It is just two blocks away from here, right past the park. - هل يمكنك من فضلك إخباري بموقع أقرب مستشفى، لأنني قد أحتاج إليه في حالة الطوارئ؟ يبعد هنا بمقدار مبنيين، بعد الحديقة مباشرة.',
  'What time does the clock read now, and do you have any plans for the evening? It shows 10 o\'clock, and I plan to relax at home. - كم الساعة الآن، وهل لديك أي خطط للمساء؟ الساعة العاشرة، وأخطط للاسترخاء في المنزل.',
  'How much is the price of this item, and is there any chance of a discount? It is priced at \$50, but I can ask if there are any ongoing promotions. - كم يكلف هذا؟ يكلف 50 دولارًا، ولكن يمكنني أن أسأل إذا كانت هناك أي عروض حالية.',
  'May I please have the bill when you have a moment? Of course, here it is, and thank you for your patience! - هل يمكنني الحصول على الفاتورة عندما تتاح لك الفرصة؟ بالطبع، ها هي، وشكرًا على صبرك!',
  'Do you possess a reservation, or would you like me to help you make one? Yes, I indeed have a reservation for two at 7 PM. - هل لديك حجز، أم تود أن أساعدك في القيام بذلك؟ نعم، لدي حجز لشخصين في الساعة السابعة مساءً.',
  'Where can I find the restroom in this establishment? The restroom is conveniently located down the hall on the left. - أين يمكنني العثور على الحمام في هذا المكان؟ الحمام موجود في نهاية الممر على اليسار.',
  'How would you describe the weather today, and are you planning to go outside? The weather is quite sunny and warm, perfect for a walk in the park. - كيف تصف الطقس اليوم، وهل تخطط للخروج؟ الجو مشمس ودافئ، مثالي للتنزه في الحديقة.',
  'Could you provide me with detailed directions to the nearest grocery store? Certainly, go straight, take a right at the traffic light, and it will be on your left. - هل يمكنك إعطائي اتجاهات مفصلة إلى أقرب متجر بقالة؟ بالتأكيد، اذهب مستقيمًا، ثم انعطف يمينًا عند الإشارة، وسيكون على يسارك.',
  'What activities did you engage in yesterday, and did you enjoy them? I spent my time at the park, enjoying nature and reading a good book. - ماذا فعلت بالأمس، وهل استمتعت بذلك؟ قضيت وقتي في الحديقة، أستمتع بالطبيعة وأقرأ كتابًا جيدًا.',
  'Are you currently occupied with work or any other commitments? No, I am free at the moment and looking forward to relaxing. - هل أنت مشغول حاليًا في العمل أو أي التزامات أخرى؟ لا، أنا متاح في هذه اللحظة وأتطلع للاسترخاء.',
  'Do you have a fondness for coffee, and how do you usually take it? Yes, I absolutely adore coffee, especially when it’s brewed with a hint of vanilla! - هل تحب القهوة، وكيف تفضل تناولها عادةً؟ نعم، أحب القهوة بشغف، خاصةً عندما تُعد برائحة الفانيليا!',
  'What cuisine do you enjoy the most, and what’s your favorite dish? My favorite cuisine is Italian, especially pizza, which I could eat every day! - ما هو طعامك المفضل؟ طعامي المفضل هو الإيطالي، خاصةً البيتزا، التي يمكنني تناولها كل يوم!',
  'In which city do you reside, and what do you love most about living there? I live in New York City, and I love its energy and the endless opportunities it offers. - أين تعيش؟ وما الذي تحبه أكثر في العيش هناك؟ أعيش في مدينة نيويورك، وأحب طاقتها والفرص اللانهائية التي تقدمها.',
  'What is the best way to reach the airport from here, and how long does it typically take? You can take either a taxi or the bus service; it usually takes about 30 minutes. - ما هي أفضل طريقة للوصول إلى المطار من هنا، وكم من الوقت يستغرق عادة؟ يمكنك أخذ سيارة أجرة أو خدمة الحافلات؛ عادةً ما يستغرق حوالي 30 دقيقة.',
  'At what time does the train depart from this station, and do you often travel by train? The train is scheduled to leave at 5 PM, and yes, I prefer train travel for its convenience. - متى يغادر القطار من هذه المحطة، وهل تسافر بالقطار كثيرًا؟ يغادر القطار في الساعة الخامسة مساءً، ونعم، أفضل السفر بالقطار لسهولة الوصول.',
  'What is the duration of the flight to your favorite destination? The flight lasts approximately 3 hours, which is quite manageable. - كم يستغرق وقت الرحلة إلى وجهتك المفضلة؟ تستغرق الرحلة حوالي 3 ساعات، وهو وقت معقول جدًا.',
  'What film do you hold in high regard, and why do you find it so captivating? My favorite film is "Inception" because of its intricate plot and stunning visuals. - ما هو فيلمك المفضل؟ ولماذا تجده رائعًا؟ فيلمي المفضل هو "Inception" بسبب حبكته المعقدة ومرئياته المذهلة.',
  'Are you fond of music, and what genres do you enjoy the most? Yes, I truly enjoy music, especially classical and jazz. - هل تحب الموسيقى، وما الأنواع التي تفضلها أكثر؟ نعم، أستمتع حقًا بالموسيقى، خاصةً الكلاسيكية والجاز.',
  'Can you play any musical instruments, and how long have you been playing? Yes, I am able to play the guitar, and I have been practicing for over five years. - هل يمكنك العزف على أي آلة موسيقية، وكم من الوقت كنت تعزف؟ نعم، أستطيع العزف على الجيتار، وقد تدربت لأكثر من خمس سنوات.',
  'Do you own any pets, and if so, what kind? Yes, I have a dog who is very playful and brings joy to my life. - هل لديك حيوانات أليفة، وإذا كان الأمر كذلك، فما نوعها؟ نعم، لدي كلب مرحه يجلب السعادة إلى حياتي.',
  'How many languages can you converse in, and which one is your favorite? I am fluent in two languages, but I find English the most enjoyable to speak. - كم عدد اللغات التي تتحدثها، وأيها تفضل؟ أستطيع التحدث بطلاقة لغتين، لكنني أجد الإنجليزية الأكثر متعة في التحدث.',
  'What hue do you favor the most, and does it have a special significance for you? My preferred color is blue, as it represents tranquility and peace for me. - ما هو لونك المفضل، وهل له دلالة خاصة بالنسبة لك؟ لوني المفضل هو الأزرق، لأنه يمثل الهدوء والسلام بالنسبة لي.',
  'At what time do you usually rise in the morning, and do you have a morning routine? I typically wake up at 6 AM and start my day with some exercise and a healthy breakfast. - في أي وقت تستيقظ عادةً في الصباح، وهل لديك روتين صباحي؟ أستيقظ عادةً في الساعة السادسة صباحًا وأبدأ يومي ببعض التمارين الرياضية وإفطار صحي.',
  'Do you take pleasure in sports, and which ones do you enjoy watching or playing? Yes, I have a keen interest in football, both watching and playing with friends. - هل تحب الرياضة، وما هي الرياضات التي تحب مشاهدتها أو ممارستها؟ نعم، لدي اهتمام كبير بكرة القدم، سواء بمشاهدتها أو اللعب مع الأصدقاء.',
  'Have you ever traveled to Europe, and which country did you find the most fascinating? Yes, I have had the opportunity to visit Europe, and I found Italy to be incredibly fascinating. - هل سبق لك أن سافرت إلى أوروبا، وأي بلد وجدته الأكثر إثارة؟ نعم، لقد سنحت لي الفرصة لزيارة أوروبا، ووجدت إيطاليا مثيرة بشكل لا يصدق.',
  'What is your current occupation, and how did you end up in that field? I am employed as a software engineer, a career I chose out of my passion for technology. - ما هو عملك الحالي، وكيف انتهى بك المطاف في هذا المجال؟ أنا موظف كمهندس برمجيات، وهو مجال اخترته بدافع شغفي بالتكنولوجيا.',
  'Are you capable of driving a vehicle, and what kind of car do you prefer? Yes, I am able to drive, and I prefer compact cars for their ease of maneuverability. - هل تستطيع قيادة السيارة، وما نوع السيارة التي تفضلها؟ نعم، أستطيع القيادة، وأفضل السيارات المدمجة لسهولة المناورة.',
  'What activities do you enjoy as hobbies, and how often do you engage in them? I take pleasure in reading and hiking, which I try to do every weekend. - ما هي هواياتك، وكم مرة تمارسها؟ أحب القراءة والمشي، وأحاول القيام بذلك كل عطلة نهاية أسبوع.',
  'What is the title of your favorite book, and what makes it special to you? My favorite book is "1984" by George Orwell because it challenges my perceptions of society. - ما هو كتابك المفضل، وما الذي يجعله مميزًا بالنسبة لك؟ كتابي المفضل هو "1984" لجورج أورويل لأنه يتحدى تصورات المجتمع لدي.',
  'What do you enjoy doing in your leisure time, and do you have a favorite pastime? I like to watch movies and explore new genres; it helps me unwind after a busy day. - ماذا تحب أن تفعل في وقت فراغك، وهل لديك نشاط مفضل؟ أحب مشاهدة الأفلام واستكشاف أنواع جديدة؛ يساعدني ذلك على الاسترخاء بعد يوم مزدحم.',
  'Do you have any siblings, and what’s your relationship like with them? Yes, I have one sister, and we share a very close bond filled with love and support. - هل لديك إخوة أو أخوات، وكيف هي علاقتك بهم؟ نعم، لدي أخت واحدة، ونحن نتشارك علاقة وثيقة مليئة بالحب والدعم.',
  'Which season do you prefer the most, and why do you favor it? My favorite season is spring because of the beautiful flowers and pleasant weather. - ما هو فصلك المفضل، ولماذا تفضله؟ فصلي المفضل هو الربيع بسبب الزهور الجميلة والطقس اللطيف.',
  'How frequently do you engage in exercise, and what is your preferred workout routine? I work out three times a week, focusing on a mix of cardio and strength training. - كم مرة تمارس الرياضة، وما هي روتينك المفضل في التمارين؟ أمارس الرياضة ثلاث مرات في الأسبوع، مع التركيز على مزيج من تمارين القلب وقوة التحمل.',
  'Are you passionate about traveling, and what destinations are on your bucket list? Yes, I absolutely love traveling, and I hope to visit Japan and Australia one day. - هل تحب السفر، وما هي الوجهات في قائمة أحلامك؟ نعم، أحب السفر بشغف، وآمل أن أزور اليابان وأستراليا يومًا ما.',
  'What country do you admire the most, and what interests you about it? My favorite country is Japan, particularly its unique culture and rich history. - ما هي دولتك المفضلة، وما الذي يثير اهتمامك بها؟ دولتي المفضلة هي اليابان، وخاصة ثقافتها الفريدة وتاريخها الغني.',
  'What genre of music do you prefer, and who is your favorite artist? I enjoy pop music, and my favorite artist is Adele for her powerful voice. - ما نوع الموسيقى التي تحبها، ومن هو فنانك المفضل؟ أحب موسيقى البوب، وفنانتي المفضلة هي أديل لصوتها القوي.',
  'Where is your workplace located, and what do you enjoy about it? I am employed at a tech company situated downtown, and I enjoy the collaborative environment. - أين يقع مكان عملك، وما الذي تحبه فيه؟ أعمل في شركة تقنية تقع في وسط المدينة، وأحب بيئة العمل التعاونية.',
  'What mode of transport do you use to commute to work, and how long does it take? I usually take the subway, which takes about 20 minutes. - كيف تصل إلى العمل، وكم من الوقت يستغرق؟ أستقل المترو عادةً، ويستغرق حوالي 20 دقيقة.',
  'Are you satisfied with your job, and what would you like to change if you could? Yes, I derive enjoyment from my work, but I wish for more opportunities for advancement. - هل تستمتع بعملك، وما الذي تود تغييره إذا كان بإمكانك؟ نعم، أستمتع بعملي، لكنني أود الحصول على المزيد من الفرص للتقدم.',
  'What plans do you have for this weekend, and are there any activities you look forward to? I intend to go hiking and enjoy the fall colors in the park. - ماذا ستفعل في عطلة نهاية الأسبوع، وهل هناك أي أنشطة تتطلع إليها؟ أنوي الذهاب في نزهة والاستمتاع بألوان الخريف في الحديقة.',
  'Do you prefer tea or coffee, and how do you take it? I lean more towards tea, especially when it’s brewed with fresh mint. - هل تفضل الشاي أم القهوة، وكيف تحب تناولها؟ أفضل الشاي، خاصةً عندما يُعد بالنعناع الطازج.',
  'What time do you usually retire for the night, and do you have a bedtime routine? I go to bed around 10 PM, and I enjoy reading before I sleep. - في أي وقت تذهب إلى السرير عادةً، وهل لديك روتين قبل النوم؟ أذهب إلى السرير حوالي الساعة العاشرة مساءً، وأحب القراءة قبل النوم.',
  'What holiday do you celebrate the most, and what traditions do you enjoy? My favorite holiday is Christmas, as I love spending time with family and decorating the tree. - ما هي عطلتك المفضلة، وما التقاليد التي تحبها؟ عطلتي المفضلة هي عيد الميلاد، حيث أحب قضاء الوقت مع العائلة وتزيين الشجرة.',
  'Could you share your phone number with me, and is it okay if I reach out later? My phone number is 123-456-7890, and feel free to contact me anytime! - هل يمكنك مشاركة رقم هاتفك معي، وهل يمكنني التواصل معك لاحقًا؟ رقم هاتفي هو 123-456-7890، ولا تتردد في الاتصال بي في أي وقت!'
];







class SpeakingPage5 extends StatefulWidget {
  @override
  _SpeakingPage5State createState() => _SpeakingPage5State();
}

class _SpeakingPage5State extends State<SpeakingPage5> with SingleTickerProviderStateMixin {
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
      _currentSentence = sentences5[Random().nextInt(sentences5.length)];
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

