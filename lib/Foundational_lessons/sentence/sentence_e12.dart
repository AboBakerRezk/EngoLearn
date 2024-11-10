import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة الصوت
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'The data we collected helps us understand the economy better.', 'translation': 'البيانات التي جمعناها تساعدنا على فهم الاقتصاد بشكل أفضل.'},
  {'sentence': 'Do you feel comfortable here, or do you need to change your location?', 'translation': 'هل تشعر بالراحة هنا، أم تحتاج لتغيير مكانك؟'},
  {'sentence': 'The theory you proposed is certain and relies on the latest data.', 'translation': 'النظرية التي اقترحتها مؤكدة وتعتمد على أحدث البيانات.'},
  {'sentence': 'The value of this product is high, but we think it is worth purchasing.', 'translation': 'قيمة هذا المنتج عالية، ولكننا نعتقد أنه يستحق الشراء.'},
  {'sentence': 'On the home page of the website, you can find delicious food.', 'translation': 'على الصفحة الرئيسية للموقع، يمكنك العثور على طعام لذيذ.'},
  {'sentence': 'The law states that the food must be safe and healthy.', 'translation': 'القانون ينص على أن الطعام يجب أن يكون آمناً وصحياً.'},
  {'sentence': 'We need to know the type of food each person in the group prefers.', 'translation': 'نحتاج لمعرفة نوع الطعام الذي يفضله كل شخص في المجموعة.'},
  {'sentence': 'Turning off the app might be necessary in some cases to avoid errors.', 'translation': 'قد يكون من الضروري إيقاف التطبيق في بعض الحالات لتجنب الأخطاء.'},
  {'sentence': 'The economy is suffering due to a little investment.', 'translation': 'الاقتصاد يعاني بسبب قلة الاستثمار.'},
  {'sentence': 'Under these types of conditions, there can be a high impact.', 'translation': 'في ظل هذه الظروف، يمكن أن يكون هناك تأثير كبير.'},
  {'sentence': 'Little is known about the true effect of the economy on daily life.', 'translation': 'القليل معروف عن التأثير الحقيقي للاقتصاد على الحياة اليومية.'},
  {'sentence': 'Tonight, we will discuss a new theory that changes our understanding.', 'translation': 'الليلة، سنناقش نظرية جديدة تغير من فهمنا.'},
  {'sentence': 'We should put this into consideration when determining the final point.', 'translation': 'يجب أن نضع هذا في الاعتبار عند تحديد النقطة النهائية.'},
  {'sentence': 'The high water level in the lake affects the environment.', 'translation': 'ارتفاع مستوى الماء في البحيرة يؤثر على البيئة.'},
  {'sentence': 'Understanding the law is crucial for making informed decisions.', 'translation': 'فهم القانون ضروري لاتخاذ قرارات مستنيرة.'},
  {'sentence': 'Certain types of food can be very beneficial for health.', 'translation': 'بعض أنواع الطعام يمكن أن تكون مفيدة جداً للصحة.'},
  {'sentence': 'The point of the discussion is to improve our understanding of the theory.', 'translation': 'الغرض من النقاش هو تحسين فهمنا للنظرية.'},
  {'sentence': 'Tonight’s meeting will focus on the latest data regarding the economy.', 'translation': 'اجتماع الليلة سيركز على أحدث البيانات المتعلقة بالاقتصاد.'},
  {'sentence': 'Under high pressure, the theory has proven to be correct.', 'translation': 'تحت ضغط عالٍ، أثبتت النظرية صحتها.'},
  {'sentence': 'If you put in the effort, you will see a high value in your work.', 'translation': 'إذا بذلت الجهد، ستجد قيمة كبيرة في عملك.'},
];

class EnglishSentencesPage12 extends StatefulWidget {
  @override
  _EnglishSentencesPage12State createState() => _EnglishSentencesPage12State();
}

class _EnglishSentencesPage12State extends State<EnglishSentencesPage12>
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
