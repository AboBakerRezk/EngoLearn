import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'You are in the house.', 'translation': 'أنت بالمنزل.'},
  {'sentence': 'The book is on the table.', 'translation': 'الكتاب موضوع على الطاولة.'},
  {'sentence': 'Can you go to the market?', 'translation': 'هل بإمكانك الذهاب إلى السوق؟'},
  {'sentence': 'I have a meeting with you.', 'translation': 'عندي موعد اجتماع معك.'},
  {'sentence': 'It is important to be on time.', 'translation': 'من الضروري الالتزام بالوقت.'},
  {'sentence': 'The project is for you.', 'translation': 'المشروع مخصص لك.'},
  {'sentence': 'This book is of great value.', 'translation': 'هذا الكتاب له قيمة كبيرة.'},
  {'sentence': 'She is at the park.', 'translation': 'هي موجودة في الحديقة.'},
  {'sentence': 'We are ready for the trip.', 'translation': 'نحن مستعدون للرحلة.'},
  {'sentence': 'He can be there on time.', 'translation': 'يمكنه الوصول في الوقت المناسب.'},
  {'sentence': 'The cat is on the chair.', 'translation': 'القطة تجلس على الكرسي.'},
  {'sentence': 'You can have it.', 'translation': 'يمكنك الحصول عليه.'},
  {'sentence': 'The lesson is for today.', 'translation': 'الدرس مخصص لليوم.'},
  {'sentence': 'It is a beautiful day.', 'translation': 'إنه يوم رائع.'},
  {'sentence': 'They are happy with the result.', 'translation': 'هم سعداء بالنتيجة.'},
  {'sentence': 'He is in the garden.', 'translation': 'هو موجود في الحديقة.'},
  {'sentence': 'She can sing very well.', 'translation': 'هي تستطيع الغناء بشكل ممتاز.'},
  {'sentence': 'You are the best friend.', 'translation': 'أنت أفضل صديق.'},
  {'sentence': 'The movie is interesting.', 'translation': 'الفيلم مشوق.'},
  {'sentence': 'We have a lot of work to do.', 'translation': 'لدينا الكثير من العمل لنقوم به.'},
];

class EnglishSentencesPage extends StatefulWidget {
  @override
  _EnglishSentencesPageState createState() => _EnglishSentencesPageState();
}

class _EnglishSentencesPageState extends State<EnglishSentencesPage>
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
