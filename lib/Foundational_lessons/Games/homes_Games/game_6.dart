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
import '../Correction/Correction_6.dart';
import '../Difficult_translation/Difficult_translation_6.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_6.dart';
import '../Guess/Guess_6.dart';
import '../Listening/Listening_6.dart';
import '../Matching/Matching_6.dart';
import '../Memory/Memory_6.dart';
import '../Translation/Translation_6.dart';
import '../the order of letters/the order of letters_6.dart';

final List<List<List<String>>> allWords = [
  [
    ['over', 'على'],
    ['world', 'العالم'],
    ['information', 'معلومات'],
    ['map', 'خريطة'],
    ['find', 'جد'],
  ],
  [
    ['where', 'أين'],
    ['much', 'كثير'],
    ['take', 'خذ'],
    ['two', 'اثنان'],
    ['want', 'تريد'],
  ],
  [
    ['important', 'مهم'],
    ['family', 'أسرة'],
    ['those', 'أولئك'],
    ['example', 'مثال'],
    ['while', 'بينما'],
  ],
  [
    ['he', 'هو'],
    ['look', 'ينظر'],
    ['government', 'حكومة'],
    ['before', 'قبل'],
    ['help', 'مساعدة'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
// ملف منفصل لإدارة الكلمات والصور (مثلاً: words_data.dart)

final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'good', 'translation': 'جيد', 'image': '👍'}, // علامة الإعجاب
  {'word': 'water', 'translation': 'ماء', 'image': '💧'}, // قطرة ماء
  {'word': 'been', 'translation': 'كان', 'image': '🕰️'}, // ساعة تشير للماضي
  {'word': 'need', 'translation': 'يحتاج', 'image': '🔧'}, // مفتاح ربط للدلالة على الحاجة
  {'word': 'should', 'translation': 'ينبغي', 'image': '✅'}, // علامة صح للدلالة على الواجب

  // المجموعة الثانية
  {'word': 'very', 'translation': 'جداً', 'image': '✨'}, // نجمة للدلالة على الشدة
  {'word': 'any', 'translation': 'أي', 'image': '❓'}, // علامة استفهام للدلالة على أي شيء
  {'word': 'history', 'translation': 'تاريخ', 'image': '📜'}, // لفافة تاريخ
  {'word': 'often', 'translation': 'غالباً', 'image': '🔄'}, // سهم دائري للدلالة على التكرار
  {'word': 'way', 'translation': 'طريق', 'image': '🛣️'}, // طريق سريع

  // المجموعة الثالثة
  {'word': 'well', 'translation': 'حسناً', 'image': '👌'}, // إشارة حسناً
  {'word': 'art', 'translation': 'فن', 'image': '🎨'}, // لوحة ألوان
  {'word': 'know', 'translation': 'يعرف', 'image': '🧠'}, // دماغ للدلالة على المعرفة
  {'word': 'were', 'translation': 'كانوا', 'image': '👥'}, // شخصين للدلالة على الجمع
  {'word': 'then', 'translation': 'ثم', 'image': '➡️'}, // سهم يشير للأمام

  // المجموعة الرابعة
  {'word': 'my', 'translation': 'لي', 'image': '👤'}, // أيقونة شخصية
  {'word': 'first', 'translation': 'أول', 'image': '1️⃣'}, // الرقم واحد
  {'word': 'would', 'translation': 'سوف', 'image': '🔮'}, // كرة بلورية للدلالة على المستقبل
  {'word': 'money', 'translation': 'مال', 'image': '💰'}, // كيس نقود
  {'word': 'each', 'translation': 'كل', 'image': '🔢'}, // أرقام للدلالة على الكل
];









class HomeGame6 extends StatefulWidget {
  @override
  _HomeGame6State createState() => _HomeGame6State();
}

class _HomeGame6State extends State<HomeGame6>
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
                  MaterialPageRoute(builder: (context) => translation6()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd6()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage6()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage6()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage6()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage6()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame6()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame6()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame6()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}














