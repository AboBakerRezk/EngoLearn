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
import '../Correction/Correction_22.dart';
import '../Difficult_translation/Difficult_translation_22.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_22.dart';
import '../Guess/Guess_22.dart';
import '../Listening/Listening_22.dart';
import '../Matching/Matching_22.dart';
import '../Memory/Memory_22.dart';
import '../Translation/Translation_22.dart';
import '../the order of letters/the order of letters_22.dart';

final List<List<List<String>>> allWords = [
  [
    ['management', 'إدارة'],
    ['open', 'افتح'],
    ['player', 'لاعب'],
    ['range', 'نطاق'],
    ['rate', 'معدل'],
  ],
  [
    ['reason', 'سبب'],
    ['travel', 'سفر'],
    ['variety', 'تنوع'],
    ['video', 'فيديو'],
    ['week', 'أسبوع'],
  ],
  [
    ['above', 'أعلى'],
    ['according', 'وفقاً'],
    ['cook', 'يطبخ'],
    ['determine', 'تحديد'],
    ['future', 'مستقبل'],
  ],
  [
    ['site', 'موقع'],
    ['alternative', 'بديل'],
    ['demand', 'طلب'],
    ['ever', 'أبداً'],
    ['exercise', 'ممارسة الرياضة'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'management', 'translation': 'إدارة', 'image': '👔'}, // ربطة عنق للدلالة على "إدارة"
  {'word': 'open', 'translation': 'افتح', 'image': '🔓'}, // قفل مفتوح للدلالة على "افتح"
  {'word': 'player', 'translation': 'لاعب', 'image': '⚽'}, // كرة قدم للدلالة على "لاعب"
  {'word': 'range', 'translation': 'نطاق', 'image': '📏'}, // مسطرة للدلالة على "نطاق"
  {'word': 'rate', 'translation': 'معدل', 'image': '📊'}, // رسم بياني للدلالة على "معدل"

  // المجموعة الثانية
  {'word': 'reason', 'translation': 'سبب', 'image': '❓'}, // علامة استفهام للدلالة على "سبب"
  {'word': 'travel', 'translation': 'سفر', 'image': '✈️'}, // طائرة للدلالة على "سفر"
  {'word': 'variety', 'translation': 'تنوع', 'image': '🍽️'}, // أطباق متنوعة للدلالة على "تنوع"
  {'word': 'video', 'translation': 'فيديو', 'image': '🎥'}, // كاميرا فيديو للدلالة على "فيديو"
  {'word': 'week', 'translation': 'أسبوع', 'image': '📅'}, // تقويم للدلالة على "أسبوع"

  // المجموعة الثالثة
  {'word': 'above', 'translation': 'أعلى', 'image': '⬆️'}, // سهم يشير للأعلى للدلالة على "أعلى"
  {'word': 'according', 'translation': 'وفقاً', 'image': '📜'}, // وثيقة للدلالة على "وفقاً"
  {'word': 'cook', 'translation': 'يطبخ', 'image': '👨‍🍳'}, // طاهٍ للدلالة على "يطبخ"
  {'word': 'determine', 'translation': 'تحديد', 'image': '🔍'}, // عدسة مكبرة للدلالة على "تحديد"
  {'word': 'future', 'translation': 'مستقبل', 'image': '🔮'}, // كرة كريستال للدلالة على "مستقبل"

  // المجموعة الرابعة
  {'word': 'site', 'translation': 'موقع', 'image': '🌐'}, // كرة أرضية للدلالة على "موقع"
  {'word': 'alternative', 'translation': 'بديل', 'image': '🔄'}, // سهم دائري للدلالة على "بديل"
  {'word': 'demand', 'translation': 'طلب', 'image': '📈'}, // سهم بياني صاعد للدلالة على "طلب"
  {'word': 'ever', 'translation': 'أبداً', 'image': '♾️'}, // علامة اللانهاية للدلالة على "أبداً"
  {'word': 'exercise', 'translation': 'ممارسة الرياضة', 'image': '🏋️'}, // شخص يمارس التمرين للدلالة على "ممارسة الرياضة"
];

class HomeGame22 extends StatefulWidget {
  @override
  _HomeGame22State createState() => _HomeGame22State();
}

class _HomeGame22State extends State<HomeGame22>
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
                  MaterialPageRoute(builder: (context) => translation22()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd22()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage22()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage22()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage22()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage22()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame22()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame22()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame22()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}




















