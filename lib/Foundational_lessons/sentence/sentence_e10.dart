import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة الصوت
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'Every human deserves respect.', 'translation': 'كل إنسان يستحق الاحترام.'},
  {'sentence': 'Both options are available.', 'translation': 'كلا الخيارين متاحان.'},
  {'sentence': 'This is a local business.', 'translation': 'هذا عمل تجاري محلي.'},
  {'sentence': 'I am sure you will succeed.', 'translation': 'أنا متأكد أنك ستنجح.'},
  {'sentence': 'There is something interesting to see.', 'translation': 'هناك شيء ممتع للرؤية.'},
  {'sentence': 'I can’t imagine life without music.', 'translation': 'لا أستطيع تخيل الحياة بدون موسيقى.'},
  {'sentence': 'He will come to the party later.', 'translation': 'سيأتي إلى الحفلة لاحقاً.'},
  {'sentence': 'Can you help me with this task?', 'translation': 'هل يمكنك مساعدتي في هذه المهمة؟'},
  {'sentence': 'The car is parked back there.', 'translation': 'السيارة متوقفة هناك في الخلف.'},
  {'sentence': 'This plan is better than the last one.', 'translation': 'هذه الخطة أفضل من السابقة.'},
  {'sentence': 'This is a general guideline.', 'translation': 'هذه إرشادات عامة.'},
  {'sentence': 'The process is quite complex.', 'translation': 'الإجراء معقد جداً.'},
  {'sentence': 'She loves to read books.', 'translation': 'هي تحب قراءة الكتب.'},
  {'sentence': 'The heat is unbearable today.', 'translation': 'الحرارة لا تطاق اليوم.'},
  {'sentence': 'Thanks for your help.', 'translation': 'شكراً لمساعدتك.'},
  {'sentence': 'We need specific details to proceed.', 'translation': 'نحتاج إلى تفاصيل محددة للمضي قدماً.'},
  {'sentence': 'There is enough food for everyone.', 'translation': 'هناك طعام كافٍ للجميع.'},
  {'sentence': 'The road is long and winding.', 'translation': 'الطريق طويل وملتوي.'},
  {'sentence': 'They bought a lot in the countryside.', 'translation': 'اشتروا قطعة أرض في الريف.'},
  {'sentence': 'She held his hand tightly.', 'translation': 'أمسكت يده بإحكام.'},
];

class EnglishSentencesPage10 extends StatefulWidget {
  @override
  _EnglishSentencesPage10State createState() => _EnglishSentencesPage10State();
}

class _EnglishSentencesPage10State extends State<EnglishSentencesPage10>
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
