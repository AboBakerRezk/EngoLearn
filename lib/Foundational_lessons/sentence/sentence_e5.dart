import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة الصوت
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'This is a good idea.', 'translation': 'هذه فكرة جيدة.'},
  {'sentence': 'Please drink some water.', 'translation': 'من فضلك اشرب بعض الماء.'},
  {'sentence': 'She has been here before.', 'translation': 'هي كانت هنا من قبل.'},
  {'sentence': 'I need to finish my homework.', 'translation': 'أحتاج أن أنهي واجبي المنزلي.'},
  {'sentence': 'You should see this movie.', 'translation': 'يجب أن تشاهد هذا الفيلم.'},
  {'sentence': 'The weather is very nice today.', 'translation': 'الطقس جميل جداً اليوم.'},
  {'sentence': 'Do you have any questions?', 'translation': 'هل لديك أي أسئلة؟'},
  {'sentence': 'He loves to study history.', 'translation': 'هو يحب دراسة التاريخ.'},
  {'sentence': 'They often visit their grandparents.', 'translation': 'هم غالباً ما يزورون أجدادهم.'},
  {'sentence': 'This is the way to the station.', 'translation': 'هذا هو الطريق إلى المحطة.'},
  {'sentence': 'She sings very well.', 'translation': 'هي تغني بشكل جيد جداً.'},
  {'sentence': 'Art is a form of expression.', 'translation': 'الفن هو شكل من أشكال التعبير.'},
  {'sentence': 'I know what you mean.', 'translation': 'أعرف ما تعنيه.'},
  {'sentence': 'They were happy to see us.', 'translation': 'كانوا سعداء لرؤيتنا.'},
  {'sentence': 'We had lunch, then we went to the park.', 'translation': 'تناولنا الغداء، ثم ذهبنا إلى الحديقة.'},
  {'sentence': 'My favorite color is blue.', 'translation': 'لوني المفضل هو الأزرق.'},
  {'sentence': 'The first step is always the hardest.', 'translation': 'الخطوة الأولى دائماً هي الأصعب.'},
  {'sentence': 'He would like to travel next year.', 'translation': 'يرغب في السفر العام القادم.'},
  {'sentence': 'They are saving money for a new car.', 'translation': 'هم يوفرون المال لشراء سيارة جديدة.'},
  {'sentence': 'Each of us has a unique talent.', 'translation': 'كل واحد منا لديه موهبة فريدة.'},
];

class EnglishSentencesPage5 extends StatefulWidget {
  @override
  _EnglishSentencesPage5State createState() => _EnglishSentencesPage5State();
}

class _EnglishSentencesPage5State extends State<EnglishSentencesPage5>
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
