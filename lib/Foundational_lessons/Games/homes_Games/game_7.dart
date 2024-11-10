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
import '../Correction/Correction_7.dart';
import '../Difficult_translation/Difficult_translation_7.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_7.dart';
import '../Guess/Guess_7.dart';
import '../Listening/Listening_7.dart';
import '../Matching/Matching_7.dart';
import '../Memory/Memory_7.dart';
import '../Translation/Translation_7.dart';
import '../the order of letters/the order of letters_7.dart';

final List<List<List<String>>> allWords = [
  [
    ['between', 'بين'],
    ['go', 'اذهب'],
    ['own', 'خاص'],
    ['however', 'ومع ذلك'],
    ['business', 'عمل'],
  ],
  [
    ['us', 'لنا'],
    ['great', 'عظيم'],
    ['his', 'له'],
    ['being', 'يجري'],
    ['another', 'آخر'],
  ],
  [
    ['health', 'صحة'],
    ['same', 'نفس'],
    ['study', 'دراسة'],
    ['why', 'لماذا'],
    ['few', 'قليل'],
  ],
  [
    ['game', 'لعبة'],
    ['might', 'ربما'],
    ['think', 'يفكر'],
    ['free', 'حر'],
    ['too', 'جداً'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'between', 'translation': 'بين', 'image': '↔️'}, // سهم يشير بين نقطتين
  {'word': 'go', 'translation': 'اذهب', 'image': '➡️'}, // سهم يشير إلى الأمام
  {'word': 'own', 'translation': 'خاص', 'image': '🏠'}, // منزل للدلالة على الملكية
  {'word': 'however', 'translation': 'ومع ذلك', 'image': '⚖️'}, // ميزان للدلالة على التوازن
  {'word': 'business', 'translation': 'عمل', 'image': '💼'}, // حقيبة عمل

  // المجموعة الثانية
  {'word': 'us', 'translation': 'لنا', 'image': '👥'}, // شخصان للدلالة على المجموعة
  {'word': 'great', 'translation': 'عظيم', 'image': '🌟'}, // نجمة للدلالة على العظمة
  {'word': 'his', 'translation': 'له', 'image': '👤'}, // أيقونة شخصية
  {'word': 'being', 'translation': 'يجري', 'image': '💬'}, // فقاعة كلام
  {'word': 'another', 'translation': 'آخر', 'image': '🔄'}, // سهم دائري للدلالة على التغيير

  // المجموعة الثالثة
  {'word': 'health', 'translation': 'صحة', 'image': '🏥'}, // مستشفى للدلالة على الصحة
  {'word': 'same', 'translation': 'نفس', 'image': '🔁'}, // رمز التكرار للدلالة على الشيء نفسه
  {'word': 'study', 'translation': 'دراسة', 'image': '📚'}, // كتب للدلالة على الدراسة
  {'word': 'why', 'translation': 'لماذا', 'image': '❓'}, // علامة استفهام
  {'word': 'few', 'translation': 'قليل', 'image': '🔢'}, // عدد قليل

  // المجموعة الرابعة
  {'word': 'game', 'translation': 'لعبة', 'image': '🎮'}, // وحدة تحكم ألعاب
  {'word': 'might', 'translation': 'ربما', 'image': '🌟'}, // نجمة للدلالة على الاحتمال
  {'word': 'think', 'translation': 'يفكر', 'image': '💭'}, // فقاعة فكرية
  {'word': 'free', 'translation': 'حر', 'image': '🕊️'}, // حمامة للدلالة على الحرية
  {'word': 'too', 'translation': 'جداً', 'image': '🔼'}, // سهم يشير لأعلى
];





class HomeGame7 extends StatefulWidget {
  @override
  _HomeGame7State createState() => _HomeGame7State();
}

class _HomeGame7State extends State<HomeGame7>
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
                  MaterialPageRoute(builder: (context) => translation7()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd7()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage7()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage7()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage7()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage7()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame7()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame7()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame7()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}















