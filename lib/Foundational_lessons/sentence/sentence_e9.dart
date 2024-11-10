import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة الصوت
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'I like to eat meat with vegetables.', 'translation': 'أحب أن أكل اللحم مع الخضار.'},
  {'sentence': 'The air is fresh in the morning.', 'translation': 'الهواء منعش في الصباح.'},
  {'sentence': 'It was a beautiful day.', 'translation': 'كان يوماً جميلاً.'},
  {'sentence': 'This place is very peaceful.', 'translation': 'هذا المكان هادئ جداً.'},
  {'sentence': 'He wants to become a doctor.', 'translation': 'هو يريد أن يصبح طبيباً.'},
  {'sentence': 'Please write down your phone number.', 'translation': 'من فضلك اكتب رقم هاتفك.'},
  {'sentence': 'The park is open to the public.', 'translation': 'الحديقة مفتوحة للجمهور.'},
  {'sentence': 'I read a fascinating book yesterday.', 'translation': 'قرأت كتاباً مشوقاً أمس.'},
  {'sentence': 'You should keep this secret.', 'translation': 'يجب أن تحتفظ بهذا السر.'},
  {'sentence': 'This part of the city is very busy.', 'translation': 'هذا الجزء من المدينة مزدحم جداً.'},
  {'sentence': 'Let’s start the meeting now.', 'translation': 'لنبدأ الاجتماع الآن.'},
  {'sentence': 'This year has been challenging.', 'translation': 'كان هذا العام مليئاً بالتحديات.'},
  {'sentence': 'He visits the gym every day.', 'translation': 'هو يزور الصالة الرياضية كل يوم.'},
  {'sentence': 'The field is full of flowers.', 'translation': 'الحقل مليء بالزهور.'},
  {'sentence': 'He owns a large house.', 'translation': 'هو يمتلك بيتاً كبيراً.'},
  {'sentence': 'I only saw him once.', 'translation': 'رأيته مرة واحدة فقط.'},
  {'sentence': 'This service is available 24/7.', 'translation': 'هذه الخدمة متاحة على مدار الساعة.'},
  {'sentence': 'The elevator is going down.', 'translation': 'المصعد ينزل إلى أسفل.'},
  {'sentence': 'Please give me a hand with this.', 'translation': 'من فضلك ساعدني في هذا.'},
  {'sentence': 'We caught a big fish today.', 'translation': 'اصطدنا سمكة كبيرة اليوم.'},
];

class EnglishSentencesPage9 extends StatefulWidget {
  @override
  _EnglishSentencesPage9State createState() => _EnglishSentencesPage9State();
}

class _EnglishSentencesPage9State extends State<EnglishSentencesPage9>
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
