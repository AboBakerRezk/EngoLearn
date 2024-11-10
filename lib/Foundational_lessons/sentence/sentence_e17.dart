import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'The school is located in the top area of the city.', 'translation': 'تقع المدرسة في المنطقة العليا من المدينة.'},
  {'sentence': 'The current investment in research is aimed at improving service quality.', 'translation': 'يهدف الاستثمار الحالي في البحث إلى تحسين جودة الخدمة.'},
  {'sentence': 'Generally, historical research involves examining past events.', 'translation': 'بشكل عام، يشمل البحث التاريخي فحص الأحداث الماضية.'},
  {'sentence': 'The personal practice of investing wisely can lead to financial stability.', 'translation': 'الممارسة الشخصية للاستثمار بحكمة يمكن أن تؤدي إلى الاستقرار المالي.'},
  {'sentence': 'The national level of investment in education has increased.', 'translation': 'ارتفع مستوى الاستثمار الوطني في التعليم.'},
  {'sentence': 'He felt a strong sense of achievement after completing the project.', 'translation': 'شعر بإحساس قوي بالإنجاز بعد إكمال المشروع.'},
  {'sentence': 'Cut the fabric carefully to ensure that each piece is the same amount.', 'translation': 'اقطع القماش بعناية لضمان أن تكون كل قطعة بنفس الحجم.'},
  {'sentence': 'The amount of funding available for the project is significant.', 'translation': 'كمية التمويل المتاحة للمشروع كبيرة.'},
  {'sentence': 'The left side of the building is undergoing renovation.', 'translation': 'الجانب الأيسر من المبنى يخضع للتجديد.'},
  {'sentence': 'The hot weather made the outdoor practice session quite challenging.', 'translation': 'جعل الطقس الحار جلسة التدريب الخارجية صعبة للغاية.'},
  {'sentence': 'Research in this area is essential for understanding historical trends.', 'translation': 'البحث في هذا المجال ضروري لفهم الاتجاهات التاريخية.'},
  {'sentence': 'You need to order the items before the end of the month.', 'translation': 'تحتاج إلى طلب العناصر قبل نهاية الشهر.'},
  {'sentence': 'At the top of the list, the most important items are highlighted.', 'translation': 'في أعلى القائمة، يتم تسليط الضوء على العناصر الأكثر أهمية.'},
  {'sentence': 'The service provided by the new company has been generally satisfactory.', 'translation': 'الخدمة المقدمة من الشركة الجديدة كانت بشكل عام مرضية.'},
  {'sentence': 'The investment was made to enhance the overall performance of the product.', 'translation': 'تم الاستثمار لتحسين الأداء العام للمنتج.'},
  {'sentence': 'She is working on a personal research project about local history.', 'translation': 'هي تعمل على مشروع بحث شخصي حول التاريخ المحلي.'},
  {'sentence': 'The historical documents were cut into smaller pieces for better preservation.', 'translation': 'تم تقطيع الوثائق التاريخية إلى قطع أصغر للحفاظ عليها بشكل أفضل.'},
  {'sentence': 'The level of expertise required for this job is quite high.', 'translation': 'مستوى الخبرة المطلوب لهذه الوظيفة مرتفع للغاية.'},
  {'sentence': 'The current trend is to focus more on personal development and skill practice.', 'translation': 'الاتجاه الحالي هو التركيز بشكل أكبر على التطوير الشخصي وممارسة المهارات.'},
];

class EnglishSentencesPage17 extends StatefulWidget {
  @override
  _EnglishSentencesPage17State createState() => _EnglishSentencesPage17State();
}

class _EnglishSentencesPage17State extends State<EnglishSentencesPage17>
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
