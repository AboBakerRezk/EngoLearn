
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemorizationPage33 extends StatefulWidget {
  @override
  _MemorizationPage33State createState() => _MemorizationPage33State();
}

class _MemorizationPage33State extends State<MemorizationPage33> {
  int _currentWordIndex = 0; // مؤشر الكلمة الحالية
  int currentPage = 0; // مؤشر الصفحة الحالية من الكلمات

  // الكلمات مقسمة إلى 4 مجموعات، كل مجموعة تحتوي على 5 كلمات
  final List<List<List<String>>> allWords = [
    [
      ['the', 'ال'],
      ['of', 'من'],
      ['and', 'و'],
      ['to', 'إلى'],
      ['a', 'أ'],
    ],
    [
      ['in', 'في'],
      ['is', 'هو'],
      ['you', 'أنت'],
      ['are', 'تكون'],
      ['for', 'لـ'],
    ],
    [
      ['that', 'أن'],
      ['or', 'أو'],
      ['it', 'هو'],
      ['as', 'مثل'],
      ['be', 'يكون'],
    ],
    [
      ['on', 'على'],
      ['your', 'لك'],
      ['with', 'مع'],
      ['can', 'يستطيع'],
      ['have', 'لديك'],
    ],
  ];

  // دالة للحصول على الكلمات الحالية
  List<List<String>> getWords() {
    return allWords[currentPage];
  }

  // دالة لتشغيل الصوت باستخدام Google Translate TTS
  void playPronunciation(String word) async {
    final player = AudioPlayer();
    final url =
        'https://translate.google.com/translate_tts?ie=UTF-8&tl=en&client=tw-ob&q=$word';
    await player.play(UrlSource(url));
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
