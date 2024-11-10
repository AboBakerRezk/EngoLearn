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
import '../Correction/Correction_17.dart';
import '../Difficult_translation/Difficult_translation_17.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_17.dart';
import '../Guess/Guess_17.dart';
import '../Listening/Listening_17.dart';
import '../Matching/Matching_17.dart';
import '../Memory/Memory_17.dart';
import '../Translation/Translation_17.dart';
import '../the order of letters/the order of letters_17.dart';

final List<List<List<String>>> allWords = [
  [
    ['name', 'اسم'],
    ['personal', 'شخصي'],
    ['school', 'مدرسة'],
    ['top', 'أعلى'],
    ['current', 'حالي'],
  ],
  [
    ['generally', 'عموماً'],
    ['historical', 'تاريخي'],
    ['investment', 'استثمار'],
    ['left', 'يسار'],
    ['national', 'وطني'],
  ],
  [
    ['amount', 'كمية'],
    ['level', 'مستوى'],
    ['order', 'طلب'],
    ['practice', 'ممارسة'],
    ['research', 'بحث'],
  ],
  [
    ['sense', 'إحساس'],
    ['service', 'خدمة'],
    ['area', 'منطقة'],
    ['cut', 'قطع'],
    ['hot', 'حار'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'name', 'translation': 'اسم', 'image': '📛'}, // بطاقة اسم للدلالة على "اسم"
  {'word': 'personal', 'translation': 'شخصي', 'image': '👤'}, // شخص للدلالة على "شخصي"
  {'word': 'school', 'translation': 'مدرسة', 'image': '🏫'}, // مدرسة للدلالة على "مدرسة"
  {'word': 'top', 'translation': 'أعلى', 'image': '🔝'}, // سهم يشير للأعلى للدلالة على "أعلى"
  {'word': 'current', 'translation': 'حالي', 'image': '📅'}, // تقويم للدلالة على "حالي"

  // المجموعة الثانية
  {'word': 'generally', 'translation': 'عموماً', 'image': '🌍'}, // كرة أرضية للدلالة على "عموماً"
  {'word': 'historical', 'translation': 'تاريخي', 'image': '🏛️'}, // مبنى تاريخي للدلالة على "تاريخي"
  {'word': 'investment', 'translation': 'استثمار', 'image': '💰'}, // كيس نقود للدلالة على "استثمار"
  {'word': 'left', 'translation': 'يسار', 'image': '⬅️'}, // سهم يشير لليسار للدلالة على "يسار"
  {'word': 'national', 'translation': 'وطني', 'image': '🏳️‍🌈'}, // علم للدلالة على "وطني"

  // المجموعة الثالثة
  {'word': 'amount', 'translation': 'كمية', 'image': '📊'}, // رسم بياني للدلالة على "كمية"
  {'word': 'level', 'translation': 'مستوى', 'image': '📈'}, // سهم بياني صاعد للدلالة على "مستوى"
  {'word': 'order', 'translation': 'طلب', 'image': '🛒'}, // عربة تسوق للدلالة على "طلب"
  {'word': 'practice', 'translation': 'ممارسة', 'image': '🏋️'}, // شخص يمارس التمرين للدلالة على "ممارسة"
  {'word': 'research', 'translation': 'بحث', 'image': '🔍'}, // عدسة مكبرة للدلالة على "بحث"

  // المجموعة الرابعة
  {'word': 'sense', 'translation': 'إحساس', 'image': '🤔'}, // وجه يفكر للدلالة على "إحساس"
  {'word': 'service', 'translation': 'خدمة', 'image': '🛎️'}, // جرس خدمة للدلالة على "خدمة"
  {'word': 'area', 'translation': 'منطقة', 'image': '📍'}, // دبوس موقع للدلالة على "منطقة"
  {'word': 'cut', 'translation': 'قطع', 'image': '✂️'}, // مقص للدلالة على "قطع"
  {'word': 'hot', 'translation': 'حار', 'image': '🔥'}, // نار للدلالة على "حار"
];







class HomeGame17 extends StatefulWidget {
  @override
  _HomeGame17State createState() => _HomeGame17State();
}

class _HomeGame17State extends State<HomeGame17>
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
                  MaterialPageRoute(builder: (context) => translation17()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd17()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage17()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage17()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage17()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage17()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame17()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame17()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame17()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}












