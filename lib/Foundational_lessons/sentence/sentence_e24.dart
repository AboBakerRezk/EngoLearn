import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'Please give me an excuse for my late arrival.', 'translation': 'من فضلك اعذرني على وصولي المتأخر.'},
  {'sentence': 'The plant will grow faster with proper care.', 'translation': 'ستنمو النبتة بسرعة أكبر مع الرعاية الجيدة.'},
  {'sentence': 'I watched a new movie last night.', 'translation': 'شاهدت فيلماً جديداً الليلة الماضية.'},
  {'sentence': 'The organization is dedicated to helping children in need.', 'translation': 'المنظمة مكرسة لمساعدة الأطفال المحتاجين.'},
  {'sentence': 'The record was broken during the championship.', 'translation': 'تم كسر الرقم القياسي خلال البطولة.'},
  {'sentence': 'The result of the experiment was surprising.', 'translation': 'كانت نتيجة التجربة مفاجئة.'},
  {'sentence': 'The section of the book we studied was about ancient history.', 'translation': 'كان الجزء الذي درسناه من الكتاب عن التاريخ القديم.'},
  {'sentence': 'We traveled across the country for the holidays.', 'translation': 'سافرنا عبر البلاد لقضاء العطلات.'},
  {'sentence': 'She has already finished her homework for the weekend.', 'translation': 'لقد أنهت واجبها المنزلي لعطلة نهاية الأسبوع بالفعل.'},
  {'sentence': 'The treasure was hidden below the old oak tree.', 'translation': 'كان الكنز مخبأً تحت شجرة البلوط القديمة.'},
  {'sentence': 'The building was designed to be eco-friendly.', 'translation': 'تم تصميم المبنى ليكون صديقاً للبيئة.'},
  {'sentence': 'The mouse ran across the floor quickly.', 'translation': 'ركض الفأر عبر الأرضية بسرعة.'},
  {'sentence': 'The company will allow flexible working hours.', 'translation': 'ستسمح الشركة بساعات عمل مرنة.'},
  {'sentence': 'I prefer to pay with cash rather than a credit card.', 'translation': 'أفضل الدفع نقداً بدلاً من بطاقة الائتمان.'},
  {'sentence': 'The class will start at 9 a.m. tomorrow.', 'translation': 'ستبدأ الحصة في الساعة 9 صباحاً غداً.'},
  {'sentence': 'The instructions were clear and easy to follow.', 'translation': 'كانت التعليمات واضحة وسهلة المتابعة.'},
  {'sentence': 'The clothes were left out in the sun until they were completely dry.', 'translation': 'تم ترك الملابس في الشمس حتى جفت تماماً.'},
  {'sentence': 'The task was simple and easy to complete.', 'translation': 'كانت المهمة بسيطة وسهلة الإنجاز.'},
  {'sentence': 'The movie had an emotional ending that left everyone in tears.', 'translation': 'كان للفيلم نهاية عاطفية تركت الجميع في الدموع.'},
  {'sentence': 'We need to buy new equipment for the gym.', 'translation': 'نحتاج إلى شراء معدات جديدة للجيم.'},
];

class EnglishSentencesPage24 extends StatefulWidget {
  @override
  _EnglishSentencesPage24State createState() => _EnglishSentencesPage24State();
}

class _EnglishSentencesPage24State extends State<EnglishSentencesPage24>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final FlutterTts _flutterTts = FlutterTts();

  final Color primaryColor = Color(0xFF13194E);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    _flutterTts.setLanguage('en-US');  // Set the default language to English
  }

  @override
  void dispose() {
    _controller.dispose();
    _flutterTts.stop();  // Ensure the TTS stops when the widget is disposed
    super.dispose();
  }

  // Function to play pronunciation using Flutter TTS
  Future<void> playPronunciation(String sentence) async {
    try {
      await _flutterTts.speak(sentence);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to play audio.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildSentenceCard(String sentence, String translation) {
    return FadeTransition(
      opacity: _animation,
      child: Card(
        color: primaryColor,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      sentence,
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.volume_up, color: Colors.blue, size: 30),
                    onPressed: () {
                      playPronunciation(sentence);
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                translation,
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('${AppLocale.S68.getString(context)}',
            style: TextStyle(color: Colors.white)),
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
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: sentences.length,
          itemBuilder: (context, index) {
            return _buildSentenceCard(
              sentences[index]['sentence']!,
              sentences[index]['translation']!,
            );
          },
        ),
      ),
    );
  }
}
