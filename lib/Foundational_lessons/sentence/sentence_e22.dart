import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'Effective management is key to a successful business.', 'translation': 'الإدارة الفعّالة هي المفتاح لنجاح العمل.'},
  {'sentence': 'Please open the file and review the contents.', 'translation': 'يرجى فتح الملف ومراجعة المحتويات.'},
  {'sentence': 'The player showed excellent skills during the match.', 'translation': 'أظهر اللاعب مهارات ممتازة أثناء المباراة.'},
  {'sentence': 'The range of products available has expanded significantly.', 'translation': 'نطاق المنتجات المتاحة توسع بشكل كبير.'},
  {'sentence': 'The rate of inflation has increased this year.', 'translation': 'معدل التضخم ارتفع هذا العام.'},
  {'sentence': 'The main reason for the delay was the weather conditions.', 'translation': 'السبب الرئيسي للتأخير كان ظروف الطقس.'},
  {'sentence': 'They plan to travel to Europe next summer.', 'translation': 'يخططون للسفر إلى أوروبا الصيف المقبل.'},
  {'sentence': 'There is a great variety of fruits at the market.', 'translation': 'هناك تنوع كبير من الفواكه في السوق.'},
  {'sentence': 'The video tutorial was very informative.', 'translation': 'كان الدرس التعليمي بالفيديو مفيداً للغاية.'},
  {'sentence': 'The project is due in a week.', 'translation': 'المشروع مستحق في غضون أسبوع.'},
  {'sentence': 'The book is placed above the shelf.', 'translation': 'الكتاب موضوع فوق الرف.'},
  {'sentence': 'The recommendations were made according to customer feedback.', 'translation': 'تم تقديم التوصيات بناءً على ملاحظات العملاء.'},
  {'sentence': 'She loves to cook new recipes every weekend.', 'translation': 'تحب طهي وصفات جديدة كل عطلة نهاية أسبوع.'},
  {'sentence': 'We need to determine the cause of the problem.', 'translation': 'نحتاج إلى تحديد سبب المشكلة.'},
  {'sentence': 'They are saving for their future investments.', 'translation': 'هم يدخرون لاستثماراتهم المستقبلية.'},
  {'sentence': 'The site for the new park has been chosen.', 'translation': 'تم اختيار موقع الحديقة الجديدة.'},
  {'sentence': 'You might want to consider an alternative route to avoid traffic.', 'translation': 'قد ترغب في التفكير في طريق بديل لتجنب الزحام.'},
  {'sentence': 'There is a high demand for eco-friendly products.', 'translation': 'هناك طلب كبير على المنتجات الصديقة للبيئة.'},
  {'sentence': 'Have you ever visited the Grand Canyon?', 'translation': 'هل زرت غراند كانيون من قبل؟'},
  {'sentence': 'Regular exercise is important for maintaining good health.', 'translation': 'التمرين المنتظم مهم للحفاظ على صحة جيدة.'},
];

class EnglishSentencesPage22 extends StatefulWidget {
  @override
  _EnglishSentencesPage22State createState() => _EnglishSentencesPage22State();
}

class _EnglishSentencesPage22State extends State<EnglishSentencesPage22>
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
