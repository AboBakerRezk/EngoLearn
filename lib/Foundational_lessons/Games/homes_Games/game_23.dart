// الكلمات المستخدمة في الألعاب
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mushaf25/Foundational_lessons/Games/Memory/Memory_23.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../Correction/Correction_23.dart';


import '../../../settings/setting_2.dart';
import '../Difficult_translation/Difficult_translation_23.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_23.dart';
import '../Guess/Guess_23.dart';
import '../Listening/Listening_23.dart';
import '../Matching/Matching_23.dart';
import '../Translation/Translation_23.dart';
import '../the order of letters/the order of letters_23.dart';

final List<List<List<String>>> allWords = [
  [
    ['following', 'التالي'],
    ['image', 'صورة'],
    ['quickly', 'بسرعة'],
    ['special', 'خاص'],
    ['working', 'عمل'],
  ],
  [
    ['case', 'قضية'],
    ['cause', 'سبب'],
    ['coast', 'ساحل'],
    ['probably', 'محتمل'],
    ['security', 'أمن'],
  ],
  [
    ['TRUE', 'صحيح'],
    ['whole', 'كامل'],
    ['action', 'عمل'],
    ['age', 'عمر'],
    ['among', 'بين'],
  ],
  [
    ['bad', 'سيئ'],
    ['boat', 'قارب'],
    ['country', 'بلد'],
    ['dance', 'رقص'],
    ['exam', 'امتحان'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'following', 'translation': 'التالي', 'image': '➡️'}, // سهم يمين للدلالة على "التالي"
  {'word': 'image', 'translation': 'صورة', 'image': '🖼️'}, // إطار صورة للدلالة على "صورة"
  {'word': 'quickly', 'translation': 'بسرعة', 'image': '⚡'}, // برق للدلالة على "بسرعة"
  {'word': 'special', 'translation': 'خاص', 'image': '🔒'}, // قفل للدلالة على "خاص"
  {'word': 'working', 'translation': 'عمل', 'image': '💼'}, // حقيبة عمل للدلالة على "عمل"

  // المجموعة الثانية
  {'word': 'case', 'translation': 'قضية', 'image': '📂'}, // مجلد للدلالة على "قضية"
  {'word': 'cause', 'translation': 'سبب', 'image': '🔧'}, // مفتاح للدلالة على "سبب"
  {'word': 'coast', 'translation': 'ساحل', 'image': '🏖️'}, // شاطئ للدلالة على "ساحل"
  {'word': 'probably', 'translation': 'محتمل', 'image': '🤔'}, // وجه يفكر للدلالة على "محتمل"
  {'word': 'security', 'translation': 'أمن', 'image': '🛡️'}, // درع للدلالة على "أمن"

  // المجموعة الثالثة
  {'word': 'TRUE', 'translation': 'صحيح', 'image': '✅'}, // علامة صح للدلالة على "صحيح"
  {'word': 'whole', 'translation': 'كامل', 'image': '🔄'}, // سهم دائري للدلالة على "كامل"
  {'word': 'action', 'translation': 'عمل', 'image': '🎬'}, // لوحة تحكم الأفلام للدلالة على "عمل"
  {'word': 'age', 'translation': 'عمر', 'image': '🎂'}, // كعكة عيد ميلاد للدلالة على "عمر"
  {'word': 'among', 'translation': 'بين', 'image': '↔️'}, // سهم بين نقطتين للدلالة على "بين"

  // المجموعة الرابعة
  {'word': 'bad', 'translation': 'سيئ', 'image': '👎'}, // إشارة "إبهام لأسفل" للدلالة على "سيئ"
  {'word': 'boat', 'translation': 'قارب', 'image': '🚤'}, // قارب للدلالة على "قارب"
  {'word': 'country', 'translation': 'بلد', 'image': '🌍'}, // كرة أرضية للدلالة على "بلد"
  {'word': 'dance', 'translation': 'رقص', 'image': '💃'}, // راقصة للدلالة على "رقص"
  {'word': 'exam', 'translation': 'امتحان', 'image': '✍️'}, // يد تكتب للدلالة على "امتحان"
];





class HomeGame23 extends StatefulWidget {
  @override
  _HomeGame23State createState() => _HomeGame23State();
}

class _HomeGame23State extends State<HomeGame23>
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
                  MaterialPageRoute(builder: (context) => translation23()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd23()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage23()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage23()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage23()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage23()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame23()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame23()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame23()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
















