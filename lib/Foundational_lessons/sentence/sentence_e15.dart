import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../settings/setting_2.dart';
final List<Map<String, String>> sentences = [
  {'sentence': 'To understand the science behind the television, you need to study the real facts.', 'translation': 'لفهم العلم وراء التلفزيون، تحتاج إلى دراسة الحقائق الحقيقية.'},
  {'sentence': 'You should consider various aspects when deciding on a trade or career path.', 'translation': 'يجب أن تأخذ في الاعتبار مختلف الجوانب عند اختيار تجارة أو مسار مهني.'},
  {'sentence': 'In the library, you can find a list of books that include various subjects.', 'translation': 'في المكتبة، يمكنك العثور على قائمة من الكتب التي تشمل مواضيع متنوعة.'},
  {'sentence': 'Either you study difficult topics or focus on the basic concepts to succeed.', 'translation': 'إما أن تدرس المواضيع الصعبة أو تركز على المفاهيم الأساسية لتحقيق النجاح.'},
  {'sentence': 'The nature of science is to explore and understand the real world around us.', 'translation': 'طبيعة العلم هي استكشاف وفهم العالم الحقيقي من حولنا.'},
  {'sentence': 'If you find it difficult to understand something, ask for help or use a card with tips.', 'translation': 'إذا وجدت صعوبة في فهم شيء ما، اطلب المساعدة أو استخدم بطاقة تحتوي على نصائح.'},
  {'sentence': 'The particular trade you choose can have a significant impact on your career.', 'translation': 'التجارة المحددة التي تختارها يمكن أن تؤثر بشكل كبير على مسارك المهني.'},
  {'sentence': 'A television program on science can help expand your knowledge about nature.', 'translation': 'برنامج تلفزيوني عن العلم يمكن أن يساعد في توسيع معرفتك بالطبيعة.'},
  {'sentence': 'It is likely that you will need to understand various concepts to grasp the subject fully.', 'translation': 'من المحتمل أن تحتاج إلى فهم مفاهيم متنوعة لاستيعاب الموضوع بشكل كامل.'},
  {'sentence': 'Make a list of the important topics you need to study, including the difficult ones.', 'translation': 'قم بإعداد قائمة بالمواضيع المهمة التي تحتاج لدراستها، بما في ذلك الصعبة منها.'},
  {'sentence': 'The mind can be trained to understand complex ideas with practice and patience.', 'translation': 'يمكن تدريب العقل على فهم الأفكار المعقدة من خلال الممارسة والصبر.'},
  {'sentence': 'In a library, you can access various resources to improve your understanding of different subjects.', 'translation': 'في المكتبة، يمكنك الوصول إلى موارد متنوعة لتحسين فهمك للمواضيع المختلفة.'},
  {'sentence': 'A card with study tips can be a useful tool in difficult subjects.', 'translation': 'بطاقة تحتوي على نصائح دراسية يمكن أن تكون أداة مفيدة في المواضيع الصعبة.'},
  {'sentence': 'The fact that you are studying hard indicates your commitment to learning.', 'translation': 'حقيقة أنك تدرس بجد تشير إلى التزامك بالتعلم.'},
  {'sentence': 'Science often deals with real-world problems and their solutions.', 'translation': 'العلم غالباً ما يتعامل مع مشاكل العالم الحقيقي وحلولها.'},
  {'sentence': 'Yourself, as a learner, must be open to understanding both simple and complex ideas.', 'translation': 'يجب أن تكون منفتحاً، كمتعلم، لفهم الأفكار البسيطة والمعقدة على حد سواء.'},
  {'sentence': 'Consider how different fields of science are interconnected and how they impact real life.', 'translation': 'فكر في كيفية ترابط مجالات العلوم المختلفة وكيف تؤثر على الحياة الحقيقية.'},
  {'sentence': 'Including a variety of study methods can help you understand difficult concepts better.', 'translation': 'يشمل استخدام طرق دراسية متنوعة يمكن أن يساعدك على فهم المفاهيم الصعبة بشكل أفضل.'},
  {'sentence': 'The trade you choose should align with your interests and abilities.', 'translation': 'يجب أن تتماشى التجارة التي تختارها مع اهتماماتك وقدراتك.'},
  {'sentence': 'A television show about the nature of various trades can be both educational and entertaining.', 'translation': 'عرض تلفزيوني عن طبيعة مختلف المهن يمكن أن يكون تعليميًا وممتعاً في نفس الوقت.'},
];

class EnglishSentencesPage15 extends StatefulWidget {
  @override
  _EnglishSentencesPage15State createState() => _EnglishSentencesPage15State();
}

class _EnglishSentencesPage15State extends State<EnglishSentencesPage15>
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
