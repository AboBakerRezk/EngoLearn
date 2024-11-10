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
import '../Correction/Correction_24.dart';
import '../Difficult_translation/Difficult_translation_24.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_24.dart';
import '../Guess/Guess_24.dart';
import '../Listening/Listening_24.dart';
import '../Matching/Matching_24.dart';
import '../Memory/Memory_24.dart';
import '../Translation/Translation_24.dart';
import '../the order of letters/the order of letters_24.dart';

final List<List<List<String>>> allWords = [
  [
    ['excuse', 'عذر'],
    ['grow', 'ينمو'],
    ['movie', 'فيلم'],
    ['organization', 'منظمة'],
    ['record', 'سجل'],
  ],
  [
    ['result', 'نتيجة'],
    ['section', 'قسم'],
    ['across', 'عبر'],
    ['already', 'سابقاً'],
    ['below', 'أسفل'],
  ],
  [
    ['building', 'بناء'],
    ['mouse', 'فأر'],
    ['allow', 'يسمح'],
    ['cash', 'نقدي'],
    ['class', 'فصل دراسي'],
  ],
  [
    ['clear', 'واضح'],
    ['dry', 'جاف'],
    ['easy', 'سهل'],
    ['emotional', 'عاطفي'],
    ['equipment', 'معدات'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'excuse', 'translation': 'عذر', 'image': '🙇'}, // شخص يعتذر للدلالة على "عذر"
  {'word': 'grow', 'translation': 'ينمو', 'image': '🌱'}, // نبتة تنمو للدلالة على "ينمو"
  {'word': 'movie', 'translation': 'فيلم', 'image': '🎬'}, // لوحة تحكم الأفلام للدلالة على "فيلم"
  {'word': 'organization', 'translation': 'منظمة', 'image': '🏢'}, // مبنى للدلالة على "منظمة"
  {'word': 'record', 'translation': 'سجل', 'image': '📀'}, // قرص مضغوط للدلالة على "سجل"

  // المجموعة الثانية
  {'word': 'result', 'translation': 'نتيجة', 'image': '🎯'}, // هدف للدلالة على "نتيجة"
  {'word': 'section', 'translation': 'قسم', 'image': '📚'}, // مجموعة كتب للدلالة على "قسم"
  {'word': 'across', 'translation': 'عبر', 'image': '🌉'}, // جسر للدلالة على "عبر"
  {'word': 'already', 'translation': 'سابقاً', 'image': '⏳'}, // ساعة رملية للدلالة على "سابقاً"
  {'word': 'below', 'translation': 'أسفل', 'image': '⬇️'}, // سهم يشير للأسفل للدلالة على "أسفل"

  // المجموعة الثالثة
  {'word': 'building', 'translation': 'بناء', 'image': '🏗️'}, // مبنى قيد الإنشاء للدلالة على "بناء"
  {'word': 'mouse', 'translation': 'فأر', 'image': '🐭'}, // فأر للدلالة على "فأر"
  {'word': 'allow', 'translation': 'يسمح', 'image': '✔️'}, // علامة صح للدلالة على "يسمح"
  {'word': 'cash', 'translation': 'نقدي', 'image': '💵'}, // نقود ورقية للدلالة على "نقدي"
  {'word': 'class', 'translation': 'فصل دراسي', 'image': '🏫'}, // مدرسة للدلالة على "فصل دراسي"

  // المجموعة الرابعة
  {'word': 'clear', 'translation': 'واضح', 'image': '🔍'}, // عدسة مكبرة للدلالة على "واضح"
  {'word': 'dry', 'translation': 'جاف', 'image': '🌵'}, // صبار للدلالة على "جاف"
  {'word': 'easy', 'translation': 'سهل', 'image': '👌'}, // إشارة اليد "تمام" للدلالة على "سهل"
  {'word': 'emotional', 'translation': 'عاطفي', 'image': '💓'}, // قلب ينبض للدلالة على "عاطفي"
  {'word': 'equipment', 'translation': 'معدات', 'image': '🛠️'}, // أدوات للدلالة على "معدات"
];



class HomeGame24 extends StatefulWidget {
  @override
  _HomeGame24State createState() => _HomeGame24State();
}

class _HomeGame24State extends State<HomeGame24>
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
                  MaterialPageRoute(builder: (context) => translation24()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd24()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage24()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage24()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage24()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage24()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame24()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame24()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame24()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


















