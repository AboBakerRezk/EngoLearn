import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'The last thing on my to-do list is to call my friend.', 'translation': 'آخر شيء في قائمة مهامي هو الاتصال بصديقي.'},
  {'sentence': 'The media has been reporting on the event all week.', 'translation': 'كانت وسائل الإعلام تغطي الحدث طوال الأسبوع.'},
  {'sentence': 'Mental health is just as important as physical health.', 'translation': 'الصحة العقلية لا تقل أهمية عن الصحة البدنية.'},
  {'sentence': 'We need to move quickly to finish the project on time.', 'translation': 'نحتاج إلى التحرك بسرعة لإنهاء المشروع في الوقت المحدد.'},
  {'sentence': 'He decided to pay for the dinner himself.', 'translation': 'قرر أن يدفع ثمن العشاء بنفسه.'},
  {'sentence': 'Sport is a great way to stay healthy and active.', 'translation': 'الرياضة طريقة رائعة للبقاء بصحة جيدة ونشاط.'},
  {'sentence': 'Is there a thing you would like to change about your daily routine?', 'translation': 'هل هناك شيء ترغب في تغييره في روتينك اليومي؟'},
  {'sentence': 'She was actually the one who solved the problem first.', 'translation': 'هي في الواقع كانت أول من حل المشكلة.'},
  {'sentence': 'The decision was made against all odds.', 'translation': 'تم اتخاذ القرار رغم كل الصعاب.'},
  {'sentence': 'The store is located far from my house.', 'translation': 'المتجر يقع بعيداً عن منزلي.'},
  {'sentence': 'We had so much fun at the amusement park yesterday.', 'translation': 'استمتعنا كثيراً في مدينة الملاهي أمس.'},
  {'sentence': 'My house is located near the park.', 'translation': 'منزلي يقع بالقرب من الحديقة.'},
  {'sentence': 'Let’s go for a walk in the park this evening.', 'translation': 'دعونا نذهب لنتمشى في الحديقة هذا المساء.'},
  {'sentence': 'I need to update the page with the latest information.', 'translation': 'أحتاج إلى تحديث الصفحة بأحدث المعلومات.'},
  {'sentence': 'Remember to bring your ID for the meeting.', 'translation': 'تذكر إحضار بطاقة هويتك للاجتماع.'},
  {'sentence': 'The term used in the article was unfamiliar to me.', 'translation': 'المصطلح المستخدم في المقال كان غير مألوف بالنسبة لي.'},
  {'sentence': 'We have a test scheduled for next Friday.', 'translation': 'لدينا اختبار مقرر يوم الجمعة القادم.'},
  {'sentence': 'The park is located within walking distance from the school.', 'translation': 'الحديقة تقع على مسافة قريبة من المدرسة.'},
  {'sentence': 'The road runs along the river for several miles.', 'translation': 'يمتد الطريق بمحاذاة النهر لعدة أميال.'},
  {'sentence': 'Can you answer this question for me?', 'translation': 'هل يمكنك الإجابة على هذا السؤال لي؟'},
];

class EnglishSentencesPage19 extends StatefulWidget {
  @override
  _EnglishSentencesPage19State createState() => _EnglishSentencesPage19State();
}

class _EnglishSentencesPage19State extends State<EnglishSentencesPage19>
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
