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
import '../Correction/Correction_25.dart';
import '../Difficult_translation/Difficult_translation_25.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_25.dart';
import '../Guess/Guess_25.dart';
import '../Listening/Listening_25.dart';
import '../Matching/Matching_25.dart';
import '../Memory/Memory_25.dart';
import '../Translation/Translation_25.dart';
import '../the order of letters/the order of letters_25.dart';

final List<List<List<String>>> allWords = [
  [
    ['live', 'يعيش'],
    ['nothing', 'لا شيء'],
    ['period', 'فترة'],
    ['physics', 'فيزياء'],
    ['plan', 'خطة'],
  ],
  [
    ['store', 'متجر'],
    ['tax', 'ضريبة'],
    ['analysis', 'تحليل'],
    ['cold', 'بارد'],
    ['commercial', 'تجاري'],
  ],
  [
    ['directly', 'مباشرة'],
    ['full', 'ممتلئ'],
    ['involved', 'متورط'],
    ['itself', 'ذاته'],
    ['low', 'منخفض'],
  ],
  [
    ['old', 'قديم'],
    ['policy', 'سياسة'],
    ['political', 'سياسي'],
    ['purchase', 'شراء'],
    ['series', 'سلسلة'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'live', 'translation': 'يعيش', 'image': '🏠'}, // منزل للدلالة على "يعيش"
  {'word': 'nothing', 'translation': 'لا شيء', 'image': '⭕'}, // دائرة للدلالة على "لا شيء"
  {'word': 'period', 'translation': 'فترة', 'image': '⏳'}, // ساعة رملية للدلالة على "فترة"
  {'word': 'physics', 'translation': 'فيزياء', 'image': '🔬'}, // مجهر للدلالة على "فيزياء"
  {'word': 'plan', 'translation': 'خطة', 'image': '📝'}, // ورقة وقلم للدلالة على "خطة"

  // المجموعة الثانية
  {'word': 'store', 'translation': 'متجر', 'image': '🏬'}, // متجر للدلالة على "متجر"
  {'word': 'tax', 'translation': 'ضريبة', 'image': '💰'}, // كيس نقود للدلالة على "ضريبة"
  {'word': 'analysis', 'translation': 'تحليل', 'image': '📊'}, // رسم بياني للدلالة على "تحليل"
  {'word': 'cold', 'translation': 'بارد', 'image': '❄️'}, // ندفة ثلج للدلالة على "بارد"
  {'word': 'commercial', 'translation': 'تجاري', 'image': '📺'}, // تلفاز للدلالة على "تجاري"

  // المجموعة الثالثة
  {'word': 'directly', 'translation': 'مباشرة', 'image': '➡️'}, // سهم يمين للدلالة على "مباشرة"
  {'word': 'full', 'translation': 'ممتلئ', 'image': '🍲'}, // طبق ممتلئ للدلالة على "ممتلئ"
  {'word': 'involved', 'translation': 'متورط', 'image': '🌀'}, // دوامة للدلالة على "متورط"
  {'word': 'itself', 'translation': 'ذاته', 'image': '🧑‍🦰'}, // شخص للدلالة على "ذاته"
  {'word': 'low', 'translation': 'منخفض', 'image': '⬇️'}, // سهم لأسفل للدلالة على "منخفض"

  // المجموعة الرابعة
  {'word': 'old', 'translation': 'قديم', 'image': '👴'}, // رجل مسن للدلالة على "قديم"
  {'word': 'policy', 'translation': 'سياسة', 'image': '📜'}, // وثيقة للدلالة على "سياسة"
  {'word': 'political', 'translation': 'سياسي', 'image': '🏛️'}, // مبنى حكومي للدلالة على "سياسي"
  {'word': 'purchase', 'translation': 'شراء', 'image': '🛒'}, // عربة تسوق للدلالة على "شراء"
  {'word': 'series', 'translation': 'سلسلة', 'image': '📚'}, // مجموعة كتب للدلالة على "سلسلة"
];






class HomeGame25 extends StatefulWidget {
  @override
  _HomeGame25State createState() => _HomeGame25State();
}

class _HomeGame25State extends State<HomeGame25>
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
                  MaterialPageRoute(builder: (context) => translation25()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd25()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage25()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage25()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage25()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage25()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame25()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame25()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame25()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

















