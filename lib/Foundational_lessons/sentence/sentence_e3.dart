import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة الصوت
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'All people are welcome here.', 'translation': 'الجميع مرحب بهم هنا.'},
  {'sentence': 'She is also coming with us.', 'translation': 'هي أيضاً ستأتي معنا.'},
  {'sentence': 'How do you do this?', 'translation': 'كيف تفعل ذلك؟'},
  {'sentence': 'There are many options to choose from.', 'translation': 'هناك العديد من الخيارات للاختيار من بينها.'},
  {'sentence': 'He has a big car.', 'translation': 'لديه سيارة كبيرة.'},
  {'sentence': 'Most students like this teacher.', 'translation': 'معظم الطلاب يحبون هذا المعلم.'},
  {'sentence': 'People are enjoying the concert.', 'translation': 'الناس يستمتعون بالحفل.'},
  {'sentence': 'We saw other friends at the park.', 'translation': 'رأينا أصدقاء آخرين في الحديقة.'},
  {'sentence': 'The time is now.', 'translation': 'الوقت الآن.'},
  {'sentence': 'He was happy to see us.', 'translation': 'كان سعيداً برؤيتنا.'},
  {'sentence': 'We are learning new things.', 'translation': 'نحن نتعلم أشياء جديدة.'},
  {'sentence': 'These are my favorite books.', 'translation': 'هذه هي كتبي المفضلة.'},
  {'sentence': 'May I have some water?', 'translation': 'هل يمكنني الحصول على بعض الماء؟'},
  {'sentence': 'She sings like an angel.', 'translation': 'تغني كالملاك.'},
  {'sentence': 'Use this tool for the job.', 'translation': 'استخدم هذه الأداة للعمل.'},
  {'sentence': 'Put the files into the folder.', 'translation': 'ضع الملفات في المجلد.'},
  {'sentence': 'She is taller than him.', 'translation': 'هي أطول منه.'},
  {'sentence': 'Climb up to the top.', 'translation': 'تسلق إلى الأعلى.'},
  {'sentence': 'He has most of the information.', 'translation': 'لديه معظم المعلومات.'},
  {'sentence': 'Do it now, please.', 'translation': 'افعل ذلك الآن، من فضلك.'},
];

class EnglishSentencesPage3 extends StatefulWidget {
  @override
  _EnglishSentencesPage3State createState() => _EnglishSentencesPage3State();
}

class _EnglishSentencesPage3State extends State<EnglishSentencesPage3>
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
