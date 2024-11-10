import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'This is an apple.', 'translation': 'هذه تفاحة.'},
  {'sentence': 'I am at the office.', 'translation': 'أنا في المكتب.'},
  {'sentence': 'They will come tomorrow.', 'translation': 'سوف يأتون غداً.'},
  {'sentence': 'What is your name?', 'translation': 'ما اسمك؟'},
  {'sentence': 'There is a cat in the garden.', 'translation': 'هناك قطة في الحديقة.'},
  {'sentence': 'She is not here.', 'translation': 'هي ليست هنا.'},
  {'sentence': 'I will wait for you.', 'translation': 'سأنتظرك.'},
  {'sentence': 'He is from Egypt.', 'translation': 'هو من مصر.'},
  {'sentence': 'When will you arrive?', 'translation': 'متى ستصل؟'},
  {'sentence': 'If you come, we will go.', 'translation': 'إذا أتيت، سنذهب.'},
  {'sentence': 'This book is by a famous author.', 'translation': 'هذا الكتاب من تأليف كاتب مشهور.'},
  {'sentence': 'Some people are kind.', 'translation': 'بعض الناس لطفاء.'},
  {'sentence': 'They are more experienced.', 'translation': 'هم أكثر خبرة.'},
  {'sentence': 'There is a problem with the device.', 'translation': 'هناك مشكلة في الجهاز.'},
  {'sentence': 'What do you think about it?', 'translation': 'ما رأيك في ذلك؟'},
  {'sentence': 'Which color do you like?', 'translation': 'أي لون تفضله؟'},
  {'sentence': 'I have one more question.', 'translation': 'لدي سؤال آخر.'},
  {'sentence': 'Their house is big.', 'translation': 'منزلهم كبير.'},
  {'sentence': 'It is not easy, but possible.', 'translation': 'ليس سهلاً، لكنه ممكن.'},
  {'sentence': 'He is at the restaurant now.', 'translation': 'هو في المطعم الآن.'},
];

class EnglishSentencesPage2 extends StatefulWidget {
  @override
  _EnglishSentencesPage2State createState() => _EnglishSentencesPage2State();
}

class _EnglishSentencesPage2State extends State<EnglishSentencesPage2>
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
