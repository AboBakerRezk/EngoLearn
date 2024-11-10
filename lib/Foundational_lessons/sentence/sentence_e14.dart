import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // إضافة مكتبة الصوت
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'To control the device, you need a basic knowledge of its functions.', 'translation': 'للتحكم في الجهاز، تحتاج إلى معرفة أساسية بوظائفه.'},
  {'sentence': 'The company is known for its ability to provide high-quality products.', 'translation': 'الشركة معروفة بقدرتها على توفير منتجات عالية الجودة.'},
  {'sentence': 'The price of the new internet service is quite high compared to the past.', 'translation': 'سعر خدمة الإنترنت الجديدة مرتفع جداً مقارنة بالماضي.'},
  {'sentence': 'Love is a powerful force that can drive people to do extraordinary things.', 'translation': 'الحب قوة قوية يمكن أن تدفع الناس لفعل أشياء استثنائية.'},
  {'sentence': 'The size of the new radio is much smaller than the old one.', 'translation': 'حجم الراديو الجديد أصغر بكثير من القديم.'},
  {'sentence': 'Economics is a hard course, but it provides valuable knowledge.', 'translation': 'علم الاقتصاد مادة صعبة، لكنها توفر معرفة قيمة.'},
  {'sentence': 'You can add new features to the software to enhance its functionality.', 'translation': 'يمكنك إضافة ميزات جديدة للبرنامج لتحسين وظائفه.'},
  {'sentence': 'The internet has made it possible to connect with people from all over the world.', 'translation': 'الإنترنت جعل من الممكن التواصل مع الناس من جميع أنحاء العالم.'},
  {'sentence': 'The ability to manage resources effectively is crucial for any company.', 'translation': 'القدرة على إدارة الموارد بفعالية أمر حاسم لأي شركة.'},
  {'sentence': 'The basic principles of economics are essential for understanding market dynamics.', 'translation': 'المبادئ الأساسية للاقتصاد ضرورية لفهم ديناميات السوق.'},
  {'sentence': 'It is known that the company offers competitive prices for its products.', 'translation': 'من المعروف أن الشركة تقدم أسعارًا تنافسية لمنتجاتها.'},
  {'sentence': 'The power of modern technology is evident in the capabilities of the internet.', 'translation': 'قوة التكنولوجيا الحديثة واضحة في قدرات الإنترنت.'},
  {'sentence': 'The new model is bigger and better, but its price is higher.', 'translation': 'النموذج الجديد أكبر وأفضل، لكن سعره أعلى.'},
  {'sentence': 'It is possible to achieve great results with hard work and dedication.', 'translation': 'من الممكن تحقيق نتائج رائعة بالعمل الجاد والتفاني.'},
  {'sentence': 'The radio station provides a range of programs that cater to different interests.', 'translation': 'المحطة الإذاعية توفر مجموعة من البرامج التي تلبي اهتمامات مختلفة.'},
  {'sentence': 'Understanding the past can help us make better decisions in the future.', 'translation': 'فهم الماضي يمكن أن يساعدنا في اتخاذ قرارات أفضل في المستقبل.'},
  {'sentence': 'The course covers fundamental concepts in economics and finance.', 'translation': 'الدورة تغطي المفاهيم الأساسية في الاقتصاد والتمويل.'},
  {'sentence': 'The company has a strong presence on the internet, reaching a global audience.', 'translation': 'الشركة لها حضور قوي على الإنترنت، وتصل إلى جمهور عالمي.'},
  {'sentence': 'Sometimes, love and affection can overcome even the hardest challenges.', 'translation': 'أحياناً، يمكن للحب والمودة أن يتغلبا على أصعب التحديات.'},
  {'sentence': 'The price of the product is determined by its size and quality.', 'translation': 'يتم تحديد سعر المنتج بناءً على حجمه وجودته.'},
];

class EnglishSentencesPage14 extends StatefulWidget {
  @override
  _EnglishSentencesPage14State createState() => _EnglishSentencesPage14State();
}

class _EnglishSentencesPage14State extends State<EnglishSentencesPage14>
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
