import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'I need to buy some groceries for the weekend.', 'translation': 'أحتاج إلى شراء بعض البقالة لعطلة نهاية الأسبوع.'},
  {'sentence': 'The development of new technologies is crucial for progress.', 'translation': 'تطوير التقنيات الجديدة أمر حيوي لتحقيق التقدم.'},
  {'sentence': 'The guard was vigilant and noticed everything happening around him.', 'translation': 'كان الحارس يقظاً ولاحظ كل ما يحدث حوله.'},
  {'sentence': 'Please hold the door open while I bring in the boxes.', 'translation': 'يرجى إبقاء الباب مفتوحاً بينما أحضر الصناديق.'},
  {'sentence': 'Learning a new language can be a rewarding experience.', 'translation': 'تعلم لغة جديدة يمكن أن يكون تجربة مجزية.'},
  {'sentence': 'We will discuss the details later in the meeting.', 'translation': 'سنناقش التفاصيل لاحقاً في الاجتماع.'},
  {'sentence': 'The main goal of the project is to improve user experience.', 'translation': 'الهدف الرئيسي من المشروع هو تحسين تجربة المستخدم.'},
  {'sentence': 'The company is offering a special discount for the holiday season.', 'translation': 'تقدم الشركة خصماً خاصاً بمناسبة موسم العطلات.'},
  {'sentence': 'Oil prices have been fluctuating over the past few months.', 'translation': 'أسعار النفط كانت تتقلب خلال الأشهر القليلة الماضية.'},
  {'sentence': 'She took a picture of the beautiful sunset on the beach.', 'translation': 'التقطت صورة لغروب الشمس الجميل على الشاطئ.'},
  {'sentence': 'The potential benefits of this investment are significant.', 'translation': 'الفوائد المحتملة لهذا الاستثمار كبيرة.'},
  {'sentence': 'He is a professional in his field and knows his work well.', 'translation': 'هو محترف في مجاله ويعرف عمله جيداً.'},
  {'sentence': 'I would rather stay at home than go out tonight.', 'translation': 'أفضل البقاء في المنزل على الخروج الليلة.'},
  {'sentence': 'You need special access to enter the restricted area.', 'translation': 'تحتاج إلى إذن خاص لدخول المنطقة المحظورة.'},
  {'sentence': 'The additional information provided was very helpful.', 'translation': 'كانت المعلومات الإضافية المقدمة مفيدة للغاية.'},
  {'sentence': 'The project is almost complete and ready for review.', 'translation': 'المشروع على وشك الانتهاء وجاهز للمراجعة.'},
  {'sentence': 'The event was especially interesting due to the guest speaker.', 'translation': 'كان الحدث مثيراً للاهتمام بشكل خاص بسبب المتحدث الضيف.'},
  {'sentence': 'They spent the afternoon working in the garden.', 'translation': 'قضوا فترة ما بعد الظهر يعملون في الحديقة.'},
  {'sentence': 'The conference attracted international participants from various countries.', 'translation': 'استقطب المؤتمر مشاركين دوليين من دول مختلفة.'},
  {'sentence': 'The company plans to lower the prices of its products next year.', 'translation': 'تخطط الشركة لخفض أسعار منتجاتها العام المقبل.'},
];

class EnglishSentencesPage21 extends StatefulWidget {
  @override
  _EnglishSentencesPage21State createState() => _EnglishSentencesPage21State();
}

class _EnglishSentencesPage21State extends State<EnglishSentencesPage21>
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
