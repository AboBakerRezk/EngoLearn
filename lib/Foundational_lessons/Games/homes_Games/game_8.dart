// الكلمات المستخدمة في الألعاب
import 'dart:async';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../settings/setting_2.dart';
import '../Correction/Correction_8.dart';
import '../Difficult_translation/Difficult_translation_8.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_8.dart';
import '../Guess/Guess_8.dart';
import '../Listening/Listening_8.dart';
import '../Matching/Matching_8.dart';
import '../Memory/Memory_8.dart';
import '../Translation/Translation_8.dart';
import '../the order of letters/the order of letters_8.dart';

final List<List<List<String>>> allWords = [
  [
    ['had', 'كان'],
    ['hi', 'مرحبا'],
    ['right', 'حق'],
    ['still', 'ما زال'],
    ['system', 'نظام'],
  ],
  [
    ['after', 'بعد'],
    ['computer', 'حاسوب'],
    ['best', 'الأفضل'],
    ['must', 'يجب'],
    ['her', 'لها'],
  ],
  [
    ['life', 'حياة'],
    ['since', 'منذ'],
    ['could', 'استطاع'],
    ['does', 'يفعل'],
    ['now', 'الآن'],
  ],
  [
    ['during', 'أثناء'],
    ['learn', 'تعلم'],
    ['around', 'حول'],
    ['usually', 'عادة'],
    ['form', 'شكل'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'had', 'translation': 'كان', 'image': '🕰️'}, // ساعة للدلالة على الماضي
  {'word': 'hi', 'translation': 'مرحبا', 'image': '👋'}, // يد تشير للتحية
  {'word': 'right', 'translation': 'حق', 'image': '✔️'}, // علامة صح للدلالة على الحق
  {'word': 'still', 'translation': 'ما زال', 'image': '⏳'}, // ساعة رملية للدلالة على الاستمرارية
  {'word': 'system', 'translation': 'نظام', 'image': '💻'}, // أيقونة نظام أو حاسوب

  // المجموعة الثانية
  {'word': 'after', 'translation': 'بعد', 'image': '⏩'}, // سهم يشير إلى "بعد"
  {'word': 'computer', 'translation': 'حاسوب', 'image': '💻'}, // أيقونة حاسوب
  {'word': 'best', 'translation': 'الأفضل', 'image': '🏆'}, // كأس للدلالة على الأفضلية
  {'word': 'must', 'translation': 'يجب', 'image': '⚠️'}, // علامة تحذير للدلالة على الوجوب
  {'word': 'her', 'translation': 'لها', 'image': '👧'}, // أيقونة فتاة للدلالة على "لها"

  // المجموعة الثالثة
  {'word': 'life', 'translation': 'حياة', 'image': '🌿'}, // ورقة شجر للدلالة على الحياة
  {'word': 'since', 'translation': 'منذ', 'image': '📅'}, // تقويم للدلالة على الزمن
  {'word': 'could', 'translation': 'استطاع', 'image': '💪'}, // عضلات للدلالة على القدرة
  {'word': 'does', 'translation': 'يفعل', 'image': '✅'}, // علامة صح للدلالة على الفعل
  {'word': 'now', 'translation': 'الآن', 'image': '⌚'}, // ساعة للدلالة على الوقت الحالي

  // المجموعة الرابعة
  {'word': 'during', 'translation': 'أثناء', 'image': '🕒'}, // ساعة للدلالة على الفترة الزمنية
  {'word': 'learn', 'translation': 'تعلم', 'image': '📘'}, // كتاب للدلالة على التعليم
  {'word': 'around', 'translation': 'حول', 'image': '🔄'}, // سهم دائري للدلالة على "حول"
  {'word': 'usually', 'translation': 'عادة', 'image': '📅'}, // تقويم للدلالة على العادة أو الجدول
  {'word': 'form', 'translation': 'شكل', 'image': '📝'}, // ورقة للدلالة على الشكل أو النموذج
];









class HomeGame8 extends StatefulWidget {
  @override
  _HomeGame8State createState() => _HomeGame8State();
}

class _HomeGame8State extends State<HomeGame8>
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
                  MaterialPageRoute(builder: (context) => translation8()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd8()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage8()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage8()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage8()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage8()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame8()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame8()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame8()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}












