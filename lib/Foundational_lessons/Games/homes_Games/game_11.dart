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
import '../Correction/Correction_11.dart';
import '../Difficult_translation/Difficult_translation_11.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_11.dart';
import '../Guess/Guess_11.dart';
import '../Listening/Listening_11.dart';
import '../Matching/Matching_11.dart';
import '../Memory/Memory_11.dart';
import '../Translation/Translation_11.dart';
import '../the order of letters/the order of letters_11.dart';

final List<List<List<String>>> allWords = [
  [
    ['data', 'بيانات'],
    ['feel', 'يشعر'],
    ['high', 'مرتفع'],
    ['off', 'إيقاف'],
    ['point', 'نقطة'],
  ],
  [
    ['type', 'نوع'],
    ['whether', 'سواء'],
    ['food', 'طعام'],
    ['understanding', 'فهم'],
    ['here', 'هنا'],
  ],
  [
    ['home', 'الصفحة الرئيسية'],
    ['certain', 'مؤكد'],
    ['economy', 'اقتصاد'],
    ['little', 'قليل'],
    ['theory', 'نظرية'],
  ],
  [
    ['tonight', 'هذه الليلة'],
    ['law', 'قانون'],
    ['put', 'وضع'],
    ['under', 'تحت'],
    ['value', 'قيمة'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'data', 'translation': 'بيانات', 'image': '📊'}, // رسم بياني للدلالة على "بيانات"
  {'word': 'feel', 'translation': 'يشعر', 'image': '😊'}, // وجه مبتسم للدلالة على الشعور
  {'word': 'high', 'translation': 'مرتفع', 'image': '🏔️'}, // جبل للدلالة على الارتفاع
  {'word': 'off', 'translation': 'إيقاف', 'image': '🔌'}, // قابس كهرباء للدلالة على "إيقاف"
  {'word': 'point', 'translation': 'نقطة', 'image': '📍'}, // دبوس للدلالة على "نقطة"

  // المجموعة الثانية
  {'word': 'type', 'translation': 'نوع', 'image': '🔤'}, // أحرف أبجدية للدلالة على "نوع"
  {'word': 'whether', 'translation': 'سواء', 'image': '🤔'}, // وجه يفكر للدلالة على الخيارات
  {'word': 'food', 'translation': 'طعام', 'image': '🍽️'}, // طبق طعام للدلالة على "طعام"
  {'word': 'understanding', 'translation': 'فهم', 'image': '🧠'}, // دماغ للدلالة على "فهم"
  {'word': 'here', 'translation': 'هنا', 'image': '📍'}, // دبوس موقع للدلالة على "هنا"

  // المجموعة الثالثة
  {'word': 'home', 'translation': 'الصفحة الرئيسية', 'image': '🏡'}, // منزل للدلالة على "الصفحة الرئيسية"
  {'word': 'certain', 'translation': 'مؤكد', 'image': '✔️'}, // علامة صح للدلالة على "مؤكد"
  {'word': 'economy', 'translation': 'اقتصاد', 'image': '💰'}, // كيس نقود للدلالة على "اقتصاد"
  {'word': 'little', 'translation': 'قليل', 'image': '🔹'}, // ماسة صغيرة للدلالة على "قليل"
  {'word': 'theory', 'translation': 'نظرية', 'image': '📖'}, // كتاب للدلالة على "نظرية"

  // المجموعة الرابعة
  {'word': 'tonight', 'translation': 'هذه الليلة', 'image': '🌙'}, // قمر للدلالة على "هذه الليلة"
  {'word': 'law', 'translation': 'قانون', 'image': '⚖️'}, // ميزان للدلالة على "قانون"
  {'word': 'put', 'translation': 'وضع', 'image': '📥'}, // صندوق واد للدلالة على "وضع"
  {'word': 'under', 'translation': 'تحت', 'image': '⬇️'}, // سهم يشير لأسفل للدلالة على "تحت"
  {'word': 'value', 'translation': 'قيمة', 'image': '💎'}, // ماسة للدلالة على "قيمة"
];






class HomeGame11 extends StatefulWidget {
  @override
  _HomeGame11State createState() => _HomeGame11State();
}

class _HomeGame11State extends State<HomeGame11>
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
                  MaterialPageRoute(builder: (context) => translation11()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd11()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage11()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage11()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage11()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage11()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame11()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame11()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame11()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}















