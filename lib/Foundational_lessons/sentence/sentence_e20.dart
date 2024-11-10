import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'We need to increase our efforts to achieve better results.', 'translation': 'نحتاج إلى زيادة جهودنا لتحقيق نتائج أفضل.'},
  {'sentence': 'The cake was baked in the oven for 30 minutes.', 'translation': 'تم خبز الكعكة في الفرن لمدة 30 دقيقة.'},
  {'sentence': 'The event was quite successful and well-attended.', 'translation': 'كان الحدث ناجحاً للغاية وحضره عدد كبير من الناس.'},
  {'sentence': 'She felt scared during the storm last night.', 'translation': 'شعرت بالخوف أثناء العاصفة الليلة الماضية.'},
  {'sentence': 'He is single and enjoys his freedom.', 'translation': 'هو أعزب ويستمتع بحريته.'},
  {'sentence': 'The sound of the ocean is very calming.', 'translation': 'صوت المحيط مهدئ جداً.'},
  {'sentence': 'Let’s try this experiment again to make sure we get accurate results.', 'translation': 'دعونا نجرب هذا التجربة مرة أخرى للتأكد من الحصول على نتائج دقيقة.'},
  {'sentence': 'The community came together to support the local charity.', 'translation': 'اجتمع المجتمع لدعم الجمعية الخيرية المحلية.'},
  {'sentence': 'The definition of the term is important for understanding the concept.', 'translation': 'تعريف المصطلح مهم لفهم المفهوم.'},
  {'sentence': 'Focus on your goals and work towards them every day.', 'translation': 'ركز على أهدافك واعمل نحوها كل يوم.'},
  {'sentence': 'Each individual has unique strengths and weaknesses.', 'translation': 'كل فرد لديه نقاط قوة وضعف فريدة.'},
  {'sentence': 'It doesn’t matter what others think; focus on your own happiness.', 'translation': 'لا يهم ما يعتقده الآخرون؛ ركز على سعادتك الشخصية.'},
  {'sentence': 'Safety should always be a top priority in the workplace.', 'translation': 'يجب أن تكون السلامة دائماً على رأس الأولويات في مكان العمل.'},
  {'sentence': 'It’s your turn to present your project to the class.', 'translation': 'حان دورك لتقديم مشروعك إلى الفصل.'},
  {'sentence': 'Everything went according to plan during the event.', 'translation': 'كل شيء سار وفق الخطة أثناء الحدث.'},
  {'sentence': 'He is known for being a kind and generous person.', 'translation': 'يعرف بأنه شخص طيب وكريم.'},
  {'sentence': 'The quality of the product is excellent and worth the price.', 'translation': 'جودة المنتج ممتازة وتستحق السعر.'},
  {'sentence': 'The soil in this area is very fertile for growing crops.', 'translation': 'التربة في هذه المنطقة خصبة جداً لزراعة المحاصيل.'},
  {'sentence': 'Please ask if you need any assistance with the project.', 'translation': 'يرجى السؤال إذا كنت بحاجة إلى أي مساعدة في المشروع.'},
  {'sentence': 'The board will meet next week to discuss the new policies.', 'translation': 'سوف يجتمع المجلس الأسبوع القادم لمناقشة السياسات الجديدة.'},
];

class EnglishSentencesPage20 extends StatefulWidget {
  @override
  _EnglishSentencesPage20State createState() => _EnglishSentencesPage20State();
}

class _EnglishSentencesPage20State extends State<EnglishSentencesPage20>
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
