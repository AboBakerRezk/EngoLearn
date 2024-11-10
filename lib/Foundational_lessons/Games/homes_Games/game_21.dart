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
import '../Correction/Correction_21.dart';
import '../Difficult_translation/Difficult_translation_21.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_21.dart';
import '../Guess/Guess_21.dart';
import '../Listening/Listening_21.dart';
import '../Matching/Matching_21.dart';
import '../Memory/Memory_21.dart';
import '../Translation/Translation_21.dart';
import '../the order of letters/the order of letters_21.dart';

final List<List<List<String>>> allWords = [
  [
    ['this', 'هذا'],
    ['an', 'أ'],
    ['by', 'بواسطة'],
    ['not', 'ليس'],
    ['but', 'لكن'],
  ],
  [
    ['at', 'في'],
    ['from', 'من'],
    ['I', 'أنا'],
    ['they', 'هم'],
    ['more', 'أكثر'],
  ],
  [
    ['will', 'سوف'],
    ['if', 'إذا'],
    ['some', 'بعض'],
    ['there', 'هناك'],
    ['what', 'ماذا'],
  ],
  [
    ['about', 'حول'],
    ['which', 'التي'],
    ['when', 'متى'],
    ['one', 'واحد'],
    ['their', 'لهم'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'this', 'translation': 'هذا', 'image': '👆'}, // إصبع يشير للدلالة على "هذا"
  {'word': 'an', 'translation': 'أ', 'image': '🔤'}, // أحرف أبجدية للدلالة على "أ"
  {'word': 'by', 'translation': 'بواسطة', 'image': '✍️'}, // يد تكتب للدلالة على "بواسطة"
  {'word': 'not', 'translation': 'ليس', 'image': '🚫'}, // علامة منع للدلالة على "ليس"
  {'word': 'but', 'translation': 'لكن', 'image': '🤷'}, // شخص يرفع كتفيه للدلالة على "لكن"

  // المجموعة الثانية
  {'word': 'at', 'translation': 'في', 'image': '📍'}, // دبوس موقع للدلالة على "في"
  {'word': 'from', 'translation': 'من', 'image': '➡️'}, // سهم يشير للاتجاه للدلالة على "من"
  {'word': 'I', 'translation': 'أنا', 'image': '👤'}, // شخص للدلالة على "أنا"
  {'word': 'they', 'translation': 'هم', 'image': '👥'}, // مجموعة أشخاص للدلالة على "هم"
  {'word': 'more', 'translation': 'أكثر', 'image': '➕'}, // علامة زائد للدلالة على "أكثر"

  // المجموعة الثالثة
  {'word': 'will', 'translation': 'سوف', 'image': '🕒'}, // ساعة للدلالة على "سوف" (مستقبل)
  {'word': 'if', 'translation': 'إذا', 'image': '❓'}, // علامة استفهام للدلالة على "إذا"
  {'word': 'some', 'translation': 'بعض', 'image': '🍪'}, // قطعة بسكويت للدلالة على "بعض"
  {'word': 'there', 'translation': 'هناك', 'image': '👉'}, // إصبع يشير للدلالة على "هناك"
  {'word': 'what', 'translation': 'ماذا', 'image': '❔'}, // علامة استفهام بيضاء للدلالة على "ماذا"

  // المجموعة الرابعة
  {'word': 'about', 'translation': 'حول', 'image': '🔄'}, // سهم دائري للدلالة على "حول"
  {'word': 'which', 'translation': 'التي', 'image': '❔'}, // علامة استفهام بيضاء للدلالة على "التي"
  {'word': 'when', 'translation': 'متى', 'image': '⏳'}, // ساعة رملية للدلالة على "متى"
  {'word': 'one', 'translation': 'واحد', 'image': '1️⃣'}, // الرقم واحد للدلالة على "واحد"
  {'word': 'their', 'translation': 'لهم', 'image': '👥'}, // مجموعة أشخاص للدلالة على "لهم"
];








class HomeGame21 extends StatefulWidget {
  @override
  _HomeGame21State createState() => _HomeGame21State();
}

class _HomeGame21State extends State<HomeGame21>
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
                  MaterialPageRoute(builder: (context) => translation21()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd21()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage21()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage21()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage21()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage21()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame21()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame21()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame21()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}















