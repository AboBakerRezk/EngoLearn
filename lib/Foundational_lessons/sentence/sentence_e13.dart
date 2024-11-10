import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة الصوت
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'It is common to find software that provides a simple guide for beginners.', 'translation': 'من الشائع العثور على برامج توفر دليلًا بسيطًا للمبتدئين.'},
  {'sentence': 'The market is always changing, so you need to stay updated.', 'translation': 'السوق دائم التغير، لذا تحتاج إلى البقاء على اطلاع.'},
  {'sentence': 'A bird in the garden can be a guide to understanding local wildlife.', 'translation': 'الطائر في الحديقة يمكن أن يكون دليلًا لفهم الحياة البرية المحلية.'},
  {'sentence': 'Sometimes, a problem in the software can be solved by creating a new update.', 'translation': 'أحياناً، يمكن حل مشكلة في البرنامج بإنشاء تحديث جديد.'},
  {'sentence': 'In literature, it is often said that simplicity is the key to beauty.', 'translation': 'في الأدب، يُقال غالباً إن البساطة هي مفتاح الجمال.'},
  {'sentence': 'We need to set a time to meet and discuss the next steps together.', 'translation': 'نحتاج لتحديد وقت للاجتماع ومناقشة الخطوات التالية معًا.'},
  {'sentence': 'The body needs time to adapt to changes in its routine.', 'translation': 'الجسم يحتاج إلى وقت للتكيف مع التغييرات في روتينه.'},
  {'sentence': 'A common interest in literature can bring people together.', 'translation': 'الاهتمام المشترك بالأدب يمكن أن يجمع الناس معاً.'},
  {'sentence': 'The state of the market can influence the types of software that are created.', 'translation': 'حالة السوق يمكن أن تؤثر على أنواع البرمجيات التي يتم إنشاؤها.'},
  {'sentence': 'He always says that the most interesting part of the software is its simplicity.', 'translation': 'هو دائماً يقول إن الجزء الأكثر إثارة في البرمجيات هو بساطتها.'},
  {'sentence': 'It is important to provide a clear guide to solve any common problems.', 'translation': 'من المهم توفير دليل واضح لحل أي مشاكل شائعة.'},
  {'sentence': 'A problem with the body might sometimes require a change in diet.', 'translation': 'المشكلة في الجسم قد تتطلب أحياناً تغييرًا في النظام الغذائي.'},
  {'sentence': 'The next step is to set up a meeting to provide more details.', 'translation': 'الخطوة التالية هي تحديد اجتماع لتقديم المزيد من التفاصيل.'},
  {'sentence': 'Create a plan to address the common issues in your project.', 'translation': 'أنشئ خطة لمعالجة المشكلات الشائعة في مشروعك.'},
  {'sentence': 'Sometimes, the simplest solutions are the most effective.', 'translation': 'أحياناً، تكون الحلول الأبسط هي الأكثر فعالية.'},
  {'sentence': 'The literature on software development provides valuable insights.', 'translation': 'الأدبيات حول تطوير البرمجيات توفر رؤى قيمة.'},
  {'sentence': 'Together, we can find a solution to this problem.', 'translation': 'معاً، يمكننا العثور على حل لهذه المشكلة.'},
  {'sentence': 'In the market, trends change rapidly, so stay informed.', 'translation': 'في السوق، تتغير الاتجاهات بسرعة، لذا ابقَ على اطلاع.'},
  {'sentence': 'The guide should be simple and provide clear instructions.', 'translation': 'يجب أن يكون الدليل بسيطاً ويوفر تعليمات واضحة.'},
];

class EnglishSentencesPage13 extends StatefulWidget {
  @override
  _EnglishSentencesPage13State createState() => _EnglishSentencesPage13State();
}

class _EnglishSentencesPage13State extends State<EnglishSentencesPage13>
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
