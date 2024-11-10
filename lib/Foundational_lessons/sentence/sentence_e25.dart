import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة الصوت
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'I live in a beautiful house by the sea.', 'translation': 'أعيش في بيت جميل بجانب البحر.'},
  {'sentence': 'There is nothing more important than family.', 'translation': 'لا يوجد شيء أهم من العائلة.'},
  {'sentence': 'The project will take a period of six months to complete.', 'translation': 'سيستغرق المشروع مدة ستة أشهر لإكماله.'},
  {'sentence': 'She is studying physics at the university.', 'translation': 'هي تدرس الفيزياء في الجامعة.'},
  {'sentence': 'We need to create a plan to improve our sales.', 'translation': 'نحتاج إلى وضع خطة لتحسين مبيعاتنا.'},
  {'sentence': 'The store offers a wide variety of products.', 'translation': 'يقدم المتجر مجموعة واسعة من المنتجات.'},
  {'sentence': 'You have to pay tax on your income.', 'translation': 'يجب أن تدفع ضريبة على دخلك.'},
  {'sentence': 'The analysis showed significant improvements in performance.', 'translation': 'أظهرت التحليلات تحسينات كبيرة في الأداء.'},
  {'sentence': 'The weather is very cold today.', 'translation': 'الطقس بارد جداً اليوم.'},
  {'sentence': 'The company is involved in commercial activities worldwide.', 'translation': 'الشركة تشارك في أنشطة تجارية حول العالم.'},
  {'sentence': 'We need to contact the supplier directly.', 'translation': 'نحتاج إلى الاتصال بالمورد مباشرة.'},
  {'sentence': 'The bottle is full of water.', 'translation': 'الزجاجة مليئة بالماء.'},
  {'sentence': 'He was involved in the decision-making process.', 'translation': 'كان مشاركاً في عملية اتخاذ القرار.'},
  {'sentence': 'The book itself is very interesting.', 'translation': 'الكتاب بحد ذاته مثير جداً للاهتمام.'},
  {'sentence': 'The price is too low for such a high-quality product.', 'translation': 'السعر منخفض جداً لمنتج عالي الجودة.'},
  {'sentence': 'The old building is being renovated.', 'translation': 'المبنى القديم يخضع للتجديد.'},
  {'sentence': 'The company has a new policy on remote work.', 'translation': 'لدى الشركة سياسة جديدة بشأن العمل عن بُعد.'},
  {'sentence': 'The political situation in the country is tense.', 'translation': 'الوضع السياسي في البلد متوتر.'},
  {'sentence': 'We need to purchase more supplies for the event.', 'translation': 'نحتاج لشراء المزيد من اللوازم للحدث.'},
  {'sentence': 'The series of lectures covered various topics in science.', 'translation': 'سلسلة المحاضرات غطت مواضيع متنوعة في العلم.'},
];

class EnglishSentencesPage25 extends StatefulWidget {
  @override
  _EnglishSentencesPage25State createState() => _EnglishSentencesPage25State();
}

class _EnglishSentencesPage25State extends State<EnglishSentencesPage25>
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
