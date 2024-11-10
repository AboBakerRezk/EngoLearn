import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'The product line has several new items available today.', 'translation': 'خط الإنتاج يحتوي على عدة منتجات جديدة متاحة اليوم.'},
  {'sentence': 'Careful consideration is required when assessing risk factors for new projects.', 'translation': 'يتطلب تقييم عوامل المخاطر للمشاريع الجديدة دراسة متأنية.'},
  {'sentence': 'Someone from the group should take the key and make sure to keep it safe.', 'translation': 'يجب أن يأخذ شخص من المجموعة المفتاح ويتأكد من الحفاظ عليه بأمان.'},
  {'sentence': 'The temperature was high, but the training continued until late in the evening.', 'translation': 'كانت درجة الحرارة مرتفعة، لكن التدريب استمر حتى وقت متأخر من المساء.'},
  {'sentence': 'The idea of uniting different teams to work on a major project is beneficial.', 'translation': 'فكرة توحيد الفرق المختلفة للعمل على مشروع كبير هي فكرة مفيدة.'},
  {'sentence': 'Fat content should be monitored carefully in dietary products.', 'translation': 'يجب مراقبة محتوى الدهون بعناية في المنتجات الغذائية.'},
  {'sentence': 'Simply put, the success of the product depends on effective marketing strategies.', 'translation': 'ببساطة، يعتمد نجاح المنتج على استراتيجيات تسويقية فعالة.'},
  {'sentence': 'The word "care" is crucial in customer service and product management.', 'translation': 'كلمة "الرعاية" مهمة جداً في خدمة العملاء وإدارة المنتجات.'},
  {'sentence': 'The light from the lamp provided just enough illumination for the task.', 'translation': 'الضوء من المصباح وفر إضاءة كافية للقيام بالمهمة.'},
  {'sentence': 'Risk management involves assessing potential dangers and finding ways to mitigate them.', 'translation': 'إدارة المخاطر تتضمن تقييم المخاطر المحتملة وإيجاد طرق لتقليلها.'},
  {'sentence': 'A key aspect of the new training program is to ensure that all members understand the guidelines.', 'translation': 'جانب مهم من البرنامج التدريبي الجديد هو ضمان أن جميع الأعضاء يفهمون الإرشادات.'},
  {'sentence': 'Until today, no one had thought of this particular idea for improving the product.', 'translation': 'حتى اليوم، لم يفكر أحد في هذه الفكرة المحددة لتحسين المنتج.'},
  {'sentence': 'The force applied to the machinery needs to be calibrated correctly to avoid malfunction.', 'translation': 'يجب معايرة القوة المطبقة على الآلات بشكل صحيح لتجنب الأعطال.'},
  {'sentence': 'A group of engineers is working on the new major project to improve product efficiency.', 'translation': 'مجموعة من المهندسين يعملون على المشروع الكبير الجديد لتحسين كفاءة المنتج.'},
  {'sentence': 'Careful monitoring of temperature is essential in maintaining the quality of the product.', 'translation': 'المراقبة الدقيقة لدرجة الحرارة ضرورية للحفاظ على جودة المنتج.'},
  {'sentence': 'Several factors can affect the outcome of a project, including the force applied and the group dynamics.', 'translation': 'عدة عوامل يمكن أن تؤثر على نتائج المشروع، بما في ذلك القوة المطبقة وديناميكيات المجموعة.'},
  {'sentence': 'The product\'s success depends on how well the training aligns with the team’s skills.', 'translation': 'نجاح المنتج يعتمد على مدى توافق التدريب مع مهارات الفريق.'},
  {'sentence': 'Someone needs to update the product line with the latest features to stay competitive.', 'translation': 'يحتاج شخص ما إلى تحديث خط الإنتاج بأحدث الميزات للبقاء في المنافسة.'},
  {'sentence': 'The training program will continue until all team members are proficient in the new technology.', 'translation': 'سيستمر البرنامج التدريبي حتى يصبح جميع أعضاء الفريق ماهرين في التكنولوجيا الجديدة.'},
  {'sentence': 'The idea of using light to enhance visibility in the product was a major breakthrough.', 'translation': 'كانت فكرة استخدام الضوء لتحسين الرؤية في المنتج اختراقاً كبيراً.'},
];

class EnglishSentencesPage16 extends StatefulWidget {
  @override
  _EnglishSentencesPage16State createState() => _EnglishSentencesPage16State();
}

class _EnglishSentencesPage16State extends State<EnglishSentencesPage16>
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
