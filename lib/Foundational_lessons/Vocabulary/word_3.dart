import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
final List<List<List<String>>> allWords = [
  [
    ['all', 'الكل'],
    ['also', 'أيضاً'],
    ['how', 'كيف'],
    ['many', 'كثير'],
    ['do', 'افعل'],
  ],
  [
    ['has', 'لديه'],
    ['most', 'معظم'],
    ['people', 'الناس'],
    ['other', 'آخر'],
    ['time', 'وقت'],
  ],
  [
    ['so', 'لذلك'],
    ['was', 'كان'],
    ['we', 'نحن'],
    ['these', 'هؤلاء'],
    ['may', 'قد'],
  ],
  [
    ['like', 'مثل'],
    ['use', 'يستخدم'],
    ['into', 'إلى'],
    ['than', 'من'],
    ['up', 'أعلى'],
  ],
];

class Word3 extends StatefulWidget {
  @override
  _Word3State createState() => _Word3State();
}

class _Word3State extends State<Word3>  {
  int _currentWordIndex = 0; // مؤشر الكلمة الحالية
  int currentPage = 0; // مؤشر الصفحة الحالية من الكلمات
  FlutterTts flutterTts = FlutterTts(); // إنشاء كائن TTS

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("en-US"); // تعيين اللغة الإنجليزية كلغة افتراضية
  }

  // دالة للحصول على الكلمات الحالية
  List<List<String>> getWords() {
    return allWords[currentPage];
  }

  // دالة لتشغيل النطق باستخدام flutter_tts
  void playPronunciation(String word) async {
    await flutterTts.speak(word); // تشغيل نطق الكلمة
  }

  // دالة لحساب لون شريط التقدم بناءً على التقدم الحالي
  Color getProgressColor() {
    double progress = (_currentWordIndex + 1) / getWords().length;
    if (progress < 0.33) {
      return Colors.red;
    } else if (progress < 0.66) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> words = getWords();

    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                // الكلمة باللغة الإنجليزية
                Text(
                  words[_currentWordIndex][0],
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                // الترجمة باللغة العربية
                Text(
                  words[_currentWordIndex][1],
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                // زر الاستماع للنطق
                IconButton(
                  icon: Icon(Icons.volume_up, color: Colors.blue, size: 40),
                  onPressed: () {
                    playPronunciation(words[_currentWordIndex][0]);
                  },
                ),
                Spacer(),
                // زر الانتقال للكلمة التالية
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // تحديث الكلمة الحالية
                      if (_currentWordIndex < words.length - 1) {
                        _currentWordIndex++;
                      } else {
                        _currentWordIndex = 0;
                        // تحديث الصفحة التالية
                        if (currentPage < allWords.length - 1) {
                          currentPage++;
                        } else {
                          // إعادة تعيين كل شيء عند الانتهاء من كل المجموعات
                          currentPage = 0;
                        }
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF13194E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text('التالي',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
