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

final Map<String, String> sentences10 = {
  'What challenges have you faced in your career, and how did you overcome them?': 'One of the biggest challenges was managing a team, but I overcame it by improving my communication and leadership skills.',
  'How do you balance work and personal life?': 'I make sure to set boundaries and prioritize my time effectively.',
  'What is the most important lesson you’ve learned from failure?': 'Failure taught me resilience and the importance of adaptability in achieving success.',
  'How do you handle constructive criticism?': 'I view constructive criticism as an opportunity for growth and improvement.',
  'Can you describe a time when you had to make a difficult decision?': 'I had to choose between two job offers, and after careful consideration, I selected the one that aligned with my long-term goals.',
  'What role does innovation play in your field of work?': 'Innovation is key, as it drives progress and helps businesses stay competitive.',
  'How do you stay motivated during challenging projects?': 'I stay motivated by breaking down large tasks into manageable steps and celebrating small wins along the way.',
  'How has technology changed the way we communicate?': 'Technology has revolutionized communication by making it faster, more efficient, and accessible to a global audience.',
  'What strategies do you use to solve complex problems?': 'I approach complex problems by analyzing the issue, brainstorming potential solutions, and implementing the most viable option.',
  'How do you stay updated with industry trends?': 'I stay updated by reading relevant articles, attending conferences, and networking with professionals in my field.',
  'What is your approach to time management in a fast-paced environment?': 'I prioritize tasks based on urgency and importance and use tools like calendars to stay organized.',
  'How do you handle conflicts in the workplace?': 'I approach conflicts calmly, listen to all perspectives, and seek a solution that benefits everyone involved.',
  'How do you ensure continuous learning in your career?': 'I set learning goals, take online courses, and stay curious about new developments in my field.',
  'What’s your approach to leadership?': 'My leadership style is collaborative, empowering team members to take initiative and grow in their roles.',
  'Can you explain a situation where you had to think outside the box?': 'I had to create a marketing campaign with a limited budget, so I leveraged social media and influencer partnerships to maximize impact.',
  'What’s the most significant impact you’ve had in your current role?': 'I led a project that increased our efficiency by 30% through process optimization.',
  'How do you maintain a positive mindset during setbacks?': 'I focus on the lessons learned and look for alternative ways to achieve my goals.',
  'How do you approach ethical dilemmas in the workplace?': 'I follow company policies, consider the broader impact of my decisions, and strive to act with integrity.',
  'What’s the role of creativity in problem-solving?': 'Creativity allows for unconventional solutions that might not be immediately obvious, often leading to better results.',
  'How do you foster collaboration among team members?': 'I encourage open communication, establish clear goals, and create an environment of mutual respect.',
  'How do you approach career development and growth?': 'I actively seek out new challenges, set personal milestones, and invest in my professional development through education and networking.',
  'How has globalization affected your industry?': 'Globalization has expanded market opportunities but also increased competition and the need for cultural awareness.',
  'What steps do you take to ensure quality in your work?': 'I adhere to best practices, review my work thoroughly, and welcome feedback for continuous improvement.',
  'How do you manage stress in high-pressure situations?': 'I stay calm, prioritize tasks, and use stress management techniques like deep breathing and short breaks.',
  'What’s the most complex project you’ve worked on, and how did you handle it?': 'I managed a cross-functional project involving multiple stakeholders, and I handled it by maintaining clear communication and setting realistic expectations.',
  'How do you keep yourself adaptable in a constantly changing work environment?': 'I embrace change by staying open to new ideas, learning from others, and being proactive in upskilling myself.',
  'How do you ensure that your goals align with the company’s mission?': 'I regularly review the company’s mission and objectives and make sure my goals contribute to its long-term vision.',
  'What’s the importance of emotional intelligence in professional settings?': 'Emotional intelligence helps build better relationships, improves teamwork, and enhances conflict resolution.',
  'How do you balance creativity with practicality in your work?': 'I ensure creative ideas are grounded in realistic outcomes and align with project constraints.',
  'What’s your strategy for networking in your industry?': 'I attend industry events, participate in online communities, and maintain relationships with key contacts.',
  'How do you approach learning from your peers?': 'I learn from my peers by actively listening, asking for feedback, and observing their approaches to problem-solving.',
  'What’s your perspective on work-life balance in the modern workplace?': 'Work-life balance is essential for long-term productivity and well-being, and it requires both individual effort and supportive workplace policies.',
};

final List<String> sentencesQ10 = [
  'ما هي التحديات التي واجهتها في حياتك المهنية، وكيف تغلبت عليها؟ واحدة من أكبر التحديات كانت إدارة فريق، لكني تغلبت عليها من خلال تحسين مهاراتي في التواصل والقيادة.',
  'كيف توازن بين العمل والحياة الشخصية؟ أحرص على وضع حدود واضحة وأولويات زمنية فعّالة.',
  'ما هو الدرس الأكثر أهمية الذي تعلمته من الفشل؟ علمني الفشل الصمود وأهمية التكيف لتحقيق النجاح.',
  'كيف تتعامل مع النقد البناء؟ أعتبر النقد البناء فرصة للنمو والتحسن.',
  'هل يمكنك وصف موقف كان عليك فيه اتخاذ قرار صعب؟ كان عليّ الاختيار بين عرضي عمل وبعد التفكير الجيد اخترت الذي يتماشى مع أهدافي الطويلة الأمد.',
  'ما هو دور الابتكار في مجال عملك؟ الابتكار أساسي لأنه يدفع بالتقدم ويساعد الشركات على المنافسة.',
  'كيف تحافظ على تحفيزك أثناء المشاريع الصعبة؟ أبقى محفزًا عن طريق تقسيم المهام الكبيرة إلى خطوات صغيرة والاحتفال بالإنجازات الصغيرة.',
  'كيف غيرت التكنولوجيا طريقة تواصلنا؟ أحدثت التكنولوجيا ثورة في التواصل، حيث أصبح أسرع وأكثر فعالية ومتاحًا لجمهور عالمي.',
  'ما هي الاستراتيجيات التي تستخدمها لحل المشاكل المعقدة؟ أبدأ بتحليل المشكلة، ثم العصف الذهني للحلول الممكنة، وأختار أفضل خيار للتنفيذ.',
  'كيف تواكب اتجاهات الصناعة؟ أواكبها من خلال قراءة المقالات ذات الصلة، وحضور المؤتمرات، والتواصل مع المحترفين في مجالي.',
  'ما هو نهجك في إدارة الوقت في بيئة عمل سريعة الإيقاع؟ أُعطي الأولوية للمهام بناءً على أهميتها واستخدام الأدوات التنظيمية مثل الجداول الزمنية.',
  'كيف تتعامل مع النزاعات في مكان العمل؟ أتعامل مع النزاعات بهدوء، وأستمع إلى جميع وجهات النظر، وأبحث عن حل يناسب الجميع.',
  'كيف تضمن التعلم المستمر في حياتك المهنية؟ أضع أهدافًا تعليمية، وألتحق بالدورات التعليمية عبر الإنترنت، وأبقى فضوليًا تجاه التطورات الجديدة في مجالي.',
  'ما هو نهجك في القيادة؟ أسلوبي في القيادة يعتمد على التعاون وتمكين أعضاء الفريق لاتخاذ المبادرات والنمو في أدوارهم.',
  'هل يمكنك شرح موقف كان عليك فيه التفكير خارج الصندوق؟ كان عليّ إنشاء حملة تسويقية بميزانية محدودة، لذا استغليت وسائل التواصل الاجتماعي وشراكات المؤثرين لتعظيم الأثر.',
  'ما هو الأثر الأكبر الذي تركته في دورك الحالي؟ قدت مشروعًا زاد من كفاءتنا بنسبة 30٪ من خلال تحسين العمليات.',
  'كيف تحافظ على تفكير إيجابي أثناء النكسات؟ أركز على الدروس المستفادة وأبحث عن طرق بديلة لتحقيق أهدافي.',
  'كيف تتعامل مع المعضلات الأخلاقية في مكان العمل؟ أتبع سياسات الشركة، وأفكر في التأثير الأوسع لقراراتي، وأحرص على التصرف بنزاهة.',
  'ما هو دور الإبداع في حل المشكلات؟ الإبداع يسمح بحلول غير تقليدية قد لا تكون واضحة على الفور، مما يؤدي غالبًا إلى نتائج أفضل.',
  'كيف تعزز التعاون بين أعضاء الفريق؟ أشجع التواصل المفتوح، وأضع أهدافًا واضحة، وأخلق بيئة احترام متبادل.',
  'ما هو نهجك في تطوير حياتك المهنية والنمو؟ أسعى دائمًا إلى التحديات الجديدة، وأضع معالم شخصية، وأستثمر في تطويري المهني من خلال التعليم والشبكات.',
  'كيف أثرت العولمة على صناعتك؟ العولمة وسعت الفرص السوقية ولكنها زادت أيضًا من المنافسة والحاجة إلى الوعي الثقافي.',
  'ما هي الخطوات التي تتخذها لضمان الجودة في عملك؟ ألتزم بأفضل الممارسات، وأراجع عملي بدقة، وأرحب بالملاحظات للتحسين المستمر.',
  'كيف تدير الضغط في المواقف عالية الضغط؟ أبقى هادئًا، وأحدد الأولويات، وأستخدم تقنيات إدارة الضغط مثل التنفس العميق وأخذ فترات راحة قصيرة.',
  'ما هو أكثر مشروع معقد عملت عليه، وكيف تعاملت معه؟ أدرت مشروعًا متعدد الأقسام يتضمن العديد من الأطراف المعنية، وتعاملت معه من خلال الحفاظ على التواصل الواضح وتحديد التوقعات الواقعية.',
  'كيف تحافظ على قابليتك للتكيف في بيئة عمل دائمة التغيير؟ أرحب بالتغيير من خلال البقاء منفتحًا على الأفكار الجديدة، والتعلم من الآخرين، والمبادرة في تحسين مهاراتي.',
  'كيف تضمن أن أهدافك تتماشى مع مهمة الشركة؟ أراجع بانتظام مهمة الشركة وأهدافها وأتأكد من أن أهدافي تساهم في رؤيتها على المدى الطويل.',
  'ما هو دور الذكاء العاطفي في البيئات المهنية؟ الذكاء العاطفي يساعد على بناء علاقات أفضل، ويعزز العمل الجماعي، ويحسن حل النزاعات.',
  'كيف توازن بين الإبداع والعملية في عملك؟ أضمن أن الأفكار الإبداعية تكون قائمة على نتائج واقعية وتتماشى مع قيود المشروع.',
  'ما هي استراتيجيتك للتواصل في مجال عملك؟ أحضر الفعاليات الصناعية، وأشارك في المجتمعات عبر الإنترنت، وأحافظ على العلاقات مع جهات الاتصال الرئيسية.',
  'كيف تتعامل مع التعلم من زملائك؟ أتعلم من زملائي من خلال الاستماع الفعّال، وطلب التعليقات، ومراقبة أساليبهم في حل المشكلات.',
  'ما هو رأيك في توازن الحياة العملية في مكان العمل الحديث؟ توازن الحياة العملية أساسي للإنتاجية على المدى الطويل وللرفاهية، ويتطلب جهدًا فرديًا ودعمًا من سياسات مكان العمل.',
];



class SpeakingPage10 extends StatefulWidget {
  @override
  _SpeakingPage10State createState() => _SpeakingPage10State();
}

class _SpeakingPage10State extends State<SpeakingPage10> with SingleTickerProviderStateMixin {
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
      _currentSentence = sentences10.keys.elementAt(Random().nextInt(sentences10.length));
      _correctAnswer = sentences10[_currentSentence]!.trim(); // احصل على الجواب الصحيح
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
                    sentencesQ10[sentences10.keys.toList().indexOf(_currentSentence)] ?? '',
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
