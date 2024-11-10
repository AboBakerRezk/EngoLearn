import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة الصوت
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'This is a popular restaurant.', 'translation': 'هذا مطعم شعبي.'},
  {'sentence': 'She bought a small gift for her friend.', 'translation': 'اشترت هدية صغيرة لصديقتها.'},
  {'sentence': 'It was raining, though we still went out.', 'translation': 'كان الجو ممطراً، ومع ذلك خرجنا.'},
  {'sentence': 'I gained a lot of experience from this job.', 'translation': 'اكتسبت الكثير من الخبرة من هذه الوظيفة.'},
  {'sentence': 'The package includes all the necessary items.', 'translation': 'تتضمن الحزمة كل العناصر الضرورية.'},
  {'sentence': 'He is looking for a new job.', 'translation': 'هو يبحث عن وظيفة جديدة.'},
  {'sentence': 'Music is a universal language.', 'translation': 'الموسيقى هي لغة عالمية.'},
  {'sentence': 'Every person has a unique story.', 'translation': 'كل شخص لديه قصة فريدة.'},
  {'sentence': 'I really appreciate your help.', 'translation': 'أنا حقاً أقدر مساعدتك.'},
  {'sentence': 'Although he was tired, he kept working.', 'translation': 'رغم أنه كان متعباً، استمر في العمل.'},
  {'sentence': 'I want to thank you for your support.', 'translation': 'أريد أن أشكرك على دعمك.'},
  {'sentence': 'This book is a bestseller.', 'translation': 'هذا الكتاب هو الأكثر مبيعاً.'},
  {'sentence': 'She always wakes up early.', 'translation': 'هي دائماً تستيقظ مبكراً.'},
  {'sentence': 'Reading is a great way to learn.', 'translation': 'القراءة هي طريقة رائعة للتعلم.'},
  {'sentence': 'The movie reached its end.', 'translation': 'وصل الفيلم إلى نهايته.'},
  {'sentence': 'This method is very effective.', 'translation': 'هذه الطريقة فعالة جداً.'},
  {'sentence': 'He never gives up.', 'translation': 'هو لا يستسلم أبداً.'},
  {'sentence': 'I need less sugar in my coffee.', 'translation': 'أحتاج إلى سكر أقل في قهوتي.'},
  {'sentence': 'They like to play soccer on weekends.', 'translation': 'يحبون لعب كرة القدم في عطلة نهاية الأسبوع.'},
  {'sentence': 'She is able to solve complex problems.', 'translation': 'هي قادرة على حل المشكلات المعقدة.'},
];

class EnglishSentencesPage11 extends StatefulWidget {
  @override
  _EnglishSentencesPage11State createState() => _EnglishSentencesPage11State();
}

class _EnglishSentencesPage11State extends State<EnglishSentencesPage11>
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
