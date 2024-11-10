import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'The following instructions will help you complete the task.', 'translation': 'التعليمات التالية ستساعدك على إكمال المهمة.'},
  {'sentence': 'She showed me a beautiful image of the sunset.', 'translation': 'أرتني صورة جميلة لغروب الشمس.'},
  {'sentence': 'They completed the project quickly to meet the deadline.', 'translation': 'أكملوا المشروع بسرعة للالتزام بالموعد النهائي.'},
  {'sentence': 'The special offer was only available for a limited time.', 'translation': 'كان العرض الخاص متاحاً فقط لفترة محدودة.'},
  {'sentence': 'He has been working on this project for months.', 'translation': 'كان يعمل على هذا المشروع لعدة أشهر.'},
  {'sentence': 'The case was reviewed by the judge this morning.', 'translation': 'تمت مراجعة القضية من قبل القاضي هذا الصباح.'},
  {'sentence': 'The main cause of the issue was a lack of communication.', 'translation': 'كان السبب الرئيسي للمشكلة هو نقص التواصل.'},
  {'sentence': 'The coast of the island is known for its stunning beauty.', 'translation': 'يشتهر ساحل الجزيرة بجماله الخلاب.'},
  {'sentence': 'It will probably rain later this afternoon.', 'translation': 'من المحتمل أن تمطر في وقت لاحق من هذا اليوم.'},
  {'sentence': 'The security system was upgraded to ensure safety.', 'translation': 'تمت ترقية نظام الأمان لضمان السلامة.'},
  {'sentence': 'The statement was confirmed to be TRUE by the expert.', 'translation': 'تم التأكيد من قبل الخبير أن التصريح صحيح.'},
  {'sentence': 'We need to consider the whole picture before making a decision.', 'translation': 'نحتاج إلى النظر إلى الصورة كاملة قبل اتخاذ القرار.'},
  {'sentence': 'His action was appreciated by everyone in the team.', 'translation': 'تم تقدير عمله من قبل الجميع في الفريق.'},
  {'sentence': 'She revealed her age during the interview.', 'translation': 'كشفت عن عمرها خلال المقابلة.'},
  {'sentence': 'There are many differences among the participants.', 'translation': 'هناك العديد من الاختلافات بين المشاركين.'},
  {'sentence': 'The movie was considered bad by most critics.', 'translation': 'تم اعتبار الفيلم سيئاً من قبل معظم النقاد.'},
  {'sentence': 'We rented a boat for the day to explore the lake.', 'translation': 'استأجرنا قارباً لليوم لاستكشاف البحيرة.'},
  {'sentence': 'The country is known for its rich cultural heritage.', 'translation': 'البلد معروف بتراثه الثقافي الغني.'},
  {'sentence': 'They love to dance at parties and social gatherings.', 'translation': 'يحبون الرقص في الحفلات والتجمعات الاجتماعية.'},
  {'sentence': 'The exam will cover all the material studied this semester.', 'translation': 'سيشمل الامتحان كل المواد التي دُرست هذا الفصل الدراسي.'},
];

class EnglishSentencesPage23 extends StatefulWidget {
  @override
  _EnglishSentencesPage23State createState() => _EnglishSentencesPage23State();
}

class _EnglishSentencesPage23State extends State<EnglishSentencesPage23>
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
