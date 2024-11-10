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
import '../Correction/Correction_4.dart';
import '../Difficult_translation/Difficult_translation_4.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_4.dart';
import '../Guess/Guess_4.dart';
import '../Listening/Listening_4.dart';
import '../Matching/Matching_4.dart';
import '../Memory/Memory_4.dart';
import '../Translation/Translation_4.dart';
import '../the order of letters/the order of letters_4.dart';

final List<List<List<String>>> allWords = [
  [
    ['out', 'خارج'],
    ['who', 'من'],
    ['them', 'هم'],
    ['make', 'يصنع'],
    ['because', 'لأن'],
  ],
  [
    ['such', 'مثل'],
    ['through', 'عبر'],
    ['get', 'يحصل على'],
    ['work', 'عمل'],
    ['even', 'حتى'],
  ],
  [
    ['different', 'مختلف'],
    ['its', 'له'],
    ['no', 'لا'],
    ['our', 'لنا'],
    ['new', 'جديد'],
  ],
  [
    ['film', 'فيلم'],
    ['just', 'فقط'],
    ['only', 'فقط'],
    ['see', 'يرى'],
    ['used', 'مستخدم'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
// ملف منفصل لإدارة الكلمات والصور (مثلاً: words_data.dart)

final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'out', 'translation': 'خارج', 'image': '🚪'}, // باب أو خارج
  {'word': 'who', 'translation': 'من', 'image': '👤'}, // شخص
  {'word': 'them', 'translation': 'هم', 'image': '👥'}, // شخصين
  {'word': 'make', 'translation': 'يصنع', 'image': '🔨'}, // مطرقة أو صنع
  {'word': 'because', 'translation': 'لأن', 'image': '❗'}, // علامة تعجب للدلالة على السبب

  // المجموعة الثانية
  {'word': 'such', 'translation': 'مثل', 'image': '🔍'}, // عدسة أو بحث
  {'word': 'through', 'translation': 'عبر', 'image': '➡️'}, // سهم يشير للمرور
  {'word': 'get', 'translation': 'يحصل على', 'image': '📥'}, // صندوق وارد
  {'word': 'work', 'translation': 'عمل', 'image': '💼'}, // حقيبة عمل
  {'word': 'even', 'translation': 'حتى', 'image': '🔄'}, // سهم دائري

  // المجموعة الثالثة
  {'word': 'different', 'translation': 'مختلف', 'image': '⚙️'}, // تروس للدلالة على التنوع
  {'word': 'its', 'translation': 'له', 'image': '🔗'}, // رابط للدلالة على الملكية
  {'word': 'no', 'translation': 'لا', 'image': '🚫'}, // علامة منع
  {'word': 'our', 'translation': 'لنا', 'image': '🤝'}, // مصافحة للدلالة على الملكية المشتركة
  {'word': 'new', 'translation': 'جديد', 'image': '🆕'}, // علامة "جديد"

  // المجموعة الرابعة
  {'word': 'film', 'translation': 'فيلم', 'image': '🎬'}, // كاميرا تصوير فيلم
  {'word': 'just', 'translation': 'فقط', 'image': '⚖️'}, // ميزان للدلالة على العدل أو التوازن
  {'word': 'only', 'translation': 'فقط', 'image': '🔒'}, // قفل للدلالة على الحصرية
  {'word': 'see', 'translation': 'يرى', 'image': '👀'}, // عيون للدلالة على الرؤية
  {'word': 'used', 'translation': 'مستخدم', 'image': '🔧'}, // مفتاح ربط للدلالة على الاستخدام
];


class HomeGame4 extends StatefulWidget {
  @override
  _HomeGame4State createState() => _HomeGame4State();
}

class _HomeGame4State extends State<HomeGame4>
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
                  MaterialPageRoute(builder: (context) => translation4()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd4()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage4()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage4()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage4()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage4()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame4()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame4()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame4()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}











