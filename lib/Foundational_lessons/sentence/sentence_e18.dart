import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'Instead of going to the park, we decided to stay home.', 'translation': 'بدلاً من الذهاب إلى الحديقة، قررنا البقاء في المنزل.'},
  {'sentence': 'The least amount of effort required is minimal.', 'translation': 'أقل قدر من الجهد المطلوب هو بسيط.'},
  {'sentence': 'Natural beauty can be seen in the countryside.', 'translation': 'يمكن رؤية الجمال الطبيعي في الريف.'},
  {'sentence': 'Physical activity is important for maintaining good health.', 'translation': 'النشاط البدني مهم للحفاظ على الصحة الجيدة.'},
  {'sentence': 'She handed me a piece of paper with the instructions on it.', 'translation': 'أعطتني ورقة تحتوي على التعليمات.'},
  {'sentence': 'The presentation will show the benefits of the new product.', 'translation': 'ستعرض العرض التقديمي فوائد المنتج الجديد.'},
  {'sentence': 'In modern society, technology plays a major role.', 'translation': 'في المجتمع الحديث، تلعب التكنولوجيا دورًا رئيسياً.'},
  {'sentence': 'Try to complete the project before the deadline.', 'translation': 'حاول إكمال المشروع قبل الموعد النهائي.'},
  {'sentence': 'Make sure to check your work for any errors.', 'translation': 'تأكد من مراجعة عملك بحثاً عن أي أخطاء.'},
  {'sentence': 'Choose the best option from the list provided.', 'translation': 'اختر الخيار الأفضل من القائمة المتاحة.'},
  {'sentence': 'We need to develop a new strategy for marketing.', 'translation': 'نحتاج إلى تطوير استراتيجية جديدة للتسويق.'},
  {'sentence': 'The second chapter of the book is very interesting.', 'translation': 'الفصل الثاني من الكتاب مثير جداً.'},
  {'sentence': 'Learning new skills is useful for career advancement.', 'translation': 'تعلم مهارات جديدة مفيد لتطوير المسار المهني.'},
  {'sentence': 'The web provides a vast amount of information.', 'translation': 'الإنترنت يوفر كمية كبيرة من المعلومات.'},
  {'sentence': 'Engaging in a variety of activities can be beneficial.', 'translation': 'المشاركة في أنشطة متنوعة يمكن أن تكون مفيدة.'},
  {'sentence': 'The boss will review the project next week.', 'translation': 'سيقوم المدير بمراجعة المشروع الأسبوع القادم.'},
  {'sentence': 'The movie was too short for my liking.', 'translation': 'كان الفيلم قصيراً جداً بالنسبة لي.'},
  {'sentence': 'She told an inspiring story about overcoming obstacles.', 'translation': 'حكت قصة ملهمة عن التغلب على العقبات.'},
  {'sentence': 'We had a phone call to discuss the details.', 'translation': 'أجرينا مكالمة هاتفية لمناقشة التفاصيل.'},
  {'sentence': 'The automotive industry is rapidly evolving with new technologies.', 'translation': 'صناعة السيارات تتطور بسرعة مع التقنيات الجديدة.'},
];

class EnglishSentencesPage18 extends StatefulWidget {
  @override
  _EnglishSentencesPage18State createState() => _EnglishSentencesPage18State();
}

class _EnglishSentencesPage18State extends State<EnglishSentencesPage18>
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
