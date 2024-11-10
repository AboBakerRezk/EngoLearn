import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة الصوت
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'Hi, how are you today?', 'translation': 'مرحباً، كيف حالك اليوم؟'},
  {'sentence': 'He had a great time at the party.', 'translation': 'استمتع كثيراً في الحفلة.'},
  {'sentence': 'You have the right to speak your mind.', 'translation': 'لديك الحق في التعبير عن رأيك.'},
  {'sentence': 'He is still working on his project.', 'translation': 'ما زال يعمل على مشروعه.'},
  {'sentence': 'The new system is very efficient.', 'translation': 'النظام الجديد فعال جداً.'},
  {'sentence': 'She went home after the meeting.', 'translation': 'ذهبت إلى المنزل بعد الاجتماع.'},
  {'sentence': 'I use my computer for work every day.', 'translation': 'أستخدم حاسوبي للعمل كل يوم.'},
  {'sentence': 'This is the best solution to the problem.', 'translation': 'هذا هو الحل الأمثل للمشكلة.'},
  {'sentence': 'You must finish your homework before going out.', 'translation': 'يجب أن تنهي واجبك قبل الخروج.'},
  {'sentence': 'Her ideas were innovative.', 'translation': 'كانت أفكارها مبتكرة.'},
  {'sentence': 'Life is full of surprises.', 'translation': 'الحياة مليئة بالمفاجآت.'},
  {'sentence': 'He has been here since morning.', 'translation': 'هو هنا منذ الصباح.'},
  {'sentence': 'She could not attend the class yesterday.', 'translation': 'لم تتمكن من حضور الحصة أمس.'},
  {'sentence': 'What does he do for a living?', 'translation': 'ماذا يعمل لكسب عيشه؟'},
  {'sentence': 'I need to talk to you now.', 'translation': 'أحتاج إلى التحدث معك الآن.'},
  {'sentence': 'He read a book during the flight.', 'translation': 'قرأ كتاباً أثناء الرحلة.'},
  {'sentence': 'It is important to learn new skills.', 'translation': 'من المهم تعلم مهارات جديدة.'},
  {'sentence': 'There are many restaurants around the area.', 'translation': 'هناك العديد من المطاعم في المنطقة.'},
  {'sentence': 'She usually goes to bed early.', 'translation': 'هي عادةً تذهب للنوم مبكراً.'},
  {'sentence': 'The form needs to be filled out correctly.', 'translation': 'يجب أن يُملأ النموذج بشكل صحيح.'},
];

class EnglishSentencesPage8 extends StatefulWidget {
  @override
  _EnglishSentencesPage8State createState() => _EnglishSentencesPage8State();
}

class _EnglishSentencesPage8State extends State<EnglishSentencesPage8>
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
