import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة الصوت
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'Who is coming with us?', 'translation': 'من سيأتي معنا؟'},
  {'sentence': 'They make delicious cakes.', 'translation': 'هم يصنعون كعكات لذيذة.'},
  {'sentence': 'She went out to buy groceries.', 'translation': 'هي خرجت لشراء البقالة.'},
  {'sentence': 'We chose them because they are the best.', 'translation': 'اخترناهم لأنهم الأفضل.'},
  {'sentence': 'Such events are rare.', 'translation': 'مثل هذه الأحداث نادرة.'},
  {'sentence': 'He passed through the gate.', 'translation': 'مر عبر البوابة.'},
  {'sentence': 'Can you get me a glass of water?', 'translation': 'هل يمكنك أن تحضر لي كوب ماء؟'},
  {'sentence': 'I have a lot of work to do.', 'translation': 'لدي الكثير من العمل لأقوم به.'},
  {'sentence': 'She is different from her sister.', 'translation': 'هي مختلفة عن أختها.'},
  {'sentence': 'Even the smallest details matter.', 'translation': 'حتى أصغر التفاصيل مهمة.'},
  {'sentence': 'Its color is bright red.', 'translation': 'لونه أحمر فاتح.'},
  {'sentence': 'No, I don’t want any more coffee.', 'translation': 'لا، لا أريد المزيد من القهوة.'},
  {'sentence': 'Our team won the match.', 'translation': 'فريقنا فاز بالمباراة.'},
  {'sentence': 'This is a new beginning.', 'translation': 'هذه بداية جديدة.'},
  {'sentence': 'The film was amazing.', 'translation': 'كان الفيلم رائعاً.'},
  {'sentence': 'I just need a minute.', 'translation': 'أحتاج فقط إلى دقيقة.'},
  {'sentence': 'He sees everything clearly.', 'translation': 'هو يرى كل شيء بوضوح.'},
  {'sentence': 'This book is only for adults.', 'translation': 'هذا الكتاب مخصص فقط للبالغين.'},
  {'sentence': 'The tool is used for cutting wood.', 'translation': 'الأداة تستخدم لقطع الخشب.'},
  {'sentence': 'I will get there on time.', 'translation': 'سأصل هناك في الوقت المحدد.'},
];

class EnglishSentencesPage4 extends StatefulWidget {
  @override
  _EnglishSentencesPage4State createState() => _EnglishSentencesPage4State();
}

class _EnglishSentencesPage4State extends State<EnglishSentencesPage4>
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
