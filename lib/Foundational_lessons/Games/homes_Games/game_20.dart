// الكلمات المستخدمة في الألعاب
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


import '../../../settings/setting_2.dart';
import '../Correction/Correction_20.dart';
import '../Difficult_translation/Difficult_translation_20.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_20.dart';
import '../Guess/Guess_20.dart';
import '../Listening/Listening_20.dart';
import '../Matching/Matching_20.dart';
import '../Memory/Memory_20.dart';
import '../Translation/Translation_20.dart';
import '../the order of letters/the order of letters_20.dart';

final List<List<List<String>>> allWords = [
  [
    ['increase', 'زيادة'],
    ['oven', 'فرن'],
    ['quite', 'إلى حد كبير'],
    ['scared', 'خائف'],
    ['single', 'غير مرتبط'],
  ],
  [
    ['sound', 'صوت'],
    ['again', 'مرة أخرى'],
    ['community', 'مجتمع'],
    ['definition', 'تعريف'],
    ['focus', 'تركيز'],
  ],
  [
    ['individual', 'فرد'],
    ['matter', 'شيء'],
    ['safety', 'سلامة'],
    ['turn', 'دور'],
    ['everything', 'كل شيء'],
  ],
  [
    ['kind', 'طيب'],
    ['quality', 'جودة'],
    ['soil', 'تربة'],
    ['ask', 'يطلب'],
    ['board', 'مجلس'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'increase', 'translation': 'زيادة', 'image': '📈'}, // سهم بياني صاعد للدلالة على "زيادة"
  {'word': 'oven', 'translation': 'فرن', 'image': '🍞'}, // خبز للدلالة على "فرن"
  {'word': 'quite', 'translation': 'إلى حد كبير', 'image': '🔔'}, // جرس منخفض الصوت للدلالة على "إلى حد كبير"
  {'word': 'scared', 'translation': 'خائف', 'image': '😱'}, // وجه خائف للدلالة على "خائف"
  {'word': 'single', 'translation': 'غير مرتبط', 'image': '1️⃣'}, // الرقم واحد للدلالة على "غير مرتبط"

  // المجموعة الثانية
  {'word': 'sound', 'translation': 'صوت', 'image': '🔊'}, // مكبر صوت للدلالة على "صوت"
  {'word': 'again', 'translation': 'مرة أخرى', 'image': '🔄'}, // سهم دائري للدلالة على "مرة أخرى"
  {'word': 'community', 'translation': 'مجتمع', 'image': '👥'}, // مجموعة أشخاص للدلالة على "مجتمع"
  {'word': 'definition', 'translation': 'تعريف', 'image': '📖'}, // كتاب للدلالة على "تعريف"
  {'word': 'focus', 'translation': 'تركيز', 'image': '🎯'}, // هدف للدلالة على "تركيز"

  // المجموعة الثالثة
  {'word': 'individual', 'translation': 'فرد', 'image': '👤'}, // شخص واحد للدلالة على "فرد"
  {'word': 'matter', 'translation': 'شيء', 'image': '🛠️'}, // أدوات للدلالة على "شيء"
  {'word': 'safety', 'translation': 'سلامة', 'image': '🦺'}, // سترة أمان للدلالة على "سلامة"
  {'word': 'turn', 'translation': 'دور', 'image': '🔁'}, // سهم دائري للدلالة على "دور"
  {'word': 'everything', 'translation': 'كل شيء', 'image': '🌍'}, // كرة أرضية للدلالة على "كل شيء"

  // المجموعة الرابعة
  {'word': 'kind', 'translation': 'طيب', 'image': '❤️'}, // قلب للدلالة على "طيب"
  {'word': 'quality', 'translation': 'جودة', 'image': '✅'}, // علامة صح للدلالة على "جودة"
  {'word': 'soil', 'translation': 'تربة', 'image': '🌱'}, // نبات ينبت من التربة للدلالة على "تربة"
  {'word': 'ask', 'translation': 'يطلب', 'image': '❓'}, // علامة استفهام للدلالة على "يطلب"
  {'word': 'board', 'translation': 'مجلس', 'image': '📝'}, // ورقة للدلالة على "مجلس"
];





class HomeGame20 extends StatefulWidget {
  @override
  _HomeGame20State createState() => _HomeGame20State();
}

class _HomeGame20State extends State<HomeGame20>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return FadeTransition(
      opacity: _animation,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // خلفية سوداء
      appBar: AppBar(
        title: Text("وَحَارِبْ لِحُلْمٍ مَا يَزَالُ عَالِقًا بَيْنَ النَّجَاحِ أَوْ أَنْ يَبُوءَ بِالفَشَلِ.", style: TextStyle(fontSize:18, color: Colors.white)),
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
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildButton('${AppLocale.S80.getString(context)}', () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translation20()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd20()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage20()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage20()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage20()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage20()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame20()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame20()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame20()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}












