import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة الصوت
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'There is a difference between right and wrong.', 'translation': 'هناك فرق بين الصواب والخطأ.'},
  {'sentence': 'Go ahead and make your choice.', 'translation': 'اتخذ قرارك الآن.'},
  {'sentence': 'He has his own car.', 'translation': 'لديه سيارته الخاصة.'},
  {'sentence': 'The weather was bad; however, we still went out.', 'translation': 'كان الطقس سيئاً، ومع ذلك خرجنا.'},
  {'sentence': 'He started his own business.', 'translation': 'بدأ عمله الخاص.'},
  {'sentence': 'Come with us, it will be fun.', 'translation': 'تعال معنا، سيكون الأمر ممتعاً.'},
  {'sentence': 'It was a great experience.', 'translation': 'كانت تجربة رائعة.'},
  {'sentence': 'His performance was outstanding.', 'translation': 'كان أداؤه مميزاً.'},
  {'sentence': 'Being honest is important.', 'translation': 'أن تكون صادقاً أمر مهم.'},
  {'sentence': 'He bought another book.', 'translation': 'اشترى كتاباً آخر.'},
  {'sentence': 'Health is wealth.', 'translation': 'الصحة هي الثروة.'},
  {'sentence': 'They are in the same class.', 'translation': 'هم في نفس الصف.'},
  {'sentence': 'He is going to study law.', 'translation': 'سوف يدرس القانون.'},
  {'sentence': 'Why did you leave so early?', 'translation': 'لماذا غادرت مبكراً؟'},
  {'sentence': 'There are a few apples left.', 'translation': 'هناك بعض التفاح المتبقي.'},
  {'sentence': 'This game is very exciting.', 'translation': 'هذه اللعبة مثيرة جداً.'},
  {'sentence': 'It might rain tomorrow.', 'translation': 'ربما تمطر غداً.'},
  {'sentence': 'I think you are right.', 'translation': 'أعتقد أنك على حق.'},
  {'sentence': 'Feel free to ask any questions.', 'translation': 'لا تتردد في طرح أي أسئلة.'},
  {'sentence': 'He is too tired to continue.', 'translation': 'هو متعب جداً للاستمرار.'},
];

class EnglishSentencesPage7 extends StatefulWidget {
  @override
  _EnglishSentencesPage7State createState() => _EnglishSentencesPage7State();
}

class _EnglishSentencesPage7State extends State<EnglishSentencesPage7>
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
