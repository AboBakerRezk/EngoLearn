import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة الصوت
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'He traveled all over the world.', 'translation': 'هو سافر حول العالم.'},
  {'sentence': 'I need more information about this topic.', 'translation': 'أحتاج إلى مزيد من المعلومات حول هذا الموضوع.'},
  {'sentence': 'We looked at the map to find the way.', 'translation': 'نظرنا إلى الخريطة للعثور على الطريق.'},
  {'sentence': 'Where did you find this book?', 'translation': 'أين وجدت هذا الكتاب؟'},
  {'sentence': 'There is much to learn in life.', 'translation': 'هناك الكثير لنتعلمه في الحياة.'},
  {'sentence': 'Take this as a gift from me.', 'translation': 'خذ هذا كهدية مني.'},
  {'sentence': 'I want two cups of coffee, please.', 'translation': 'أريد كوبين من القهوة، من فضلك.'},
  {'sentence': 'It is important to be honest.', 'translation': 'من المهم أن تكون صادقاً.'},
  {'sentence': 'Family comes first.', 'translation': 'الأسرة تأتي أولاً.'},
  {'sentence': 'Those shoes are mine.', 'translation': 'تلك الأحذية لي.'},
  {'sentence': 'This is an example of good behavior.', 'translation': 'هذا مثال على السلوك الجيد.'},
  {'sentence': 'He studied while she cooked.', 'translation': 'هو درس بينما هي طهت.'},
  {'sentence': 'He is a great singer.', 'translation': 'هو مغني رائع.'},
  {'sentence': 'Look at the sky, it’s beautiful.', 'translation': 'انظر إلى السماء، إنها جميلة.'},
  {'sentence': 'The government announced new policies.', 'translation': 'أعلنت الحكومة سياسات جديدة.'},
  {'sentence': 'She arrived before the meeting started.', 'translation': 'وصلت قبل أن يبدأ الاجتماع.'},
  {'sentence': 'Can you help me with this task?', 'translation': 'هل يمكنك مساعدتي في هذه المهمة؟'},
  {'sentence': 'The project is over.', 'translation': 'انتهى المشروع.'},
  {'sentence': 'We have to take care of our family.', 'translation': 'يجب أن نهتم بأسرتنا.'},
  {'sentence': 'He is looking for a new job.', 'translation': 'هو يبحث عن وظيفة جديدة.'},
];

class EnglishSentencesPage6 extends StatefulWidget {
  @override
  _EnglishSentencesPage6State createState() => _EnglishSentencesPage6State();
}

class _EnglishSentencesPage6State extends State<EnglishSentencesPage6>
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
