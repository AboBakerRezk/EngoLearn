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
import '../Correction/Correction_16.dart';
import '../Difficult_translation/Difficult_translation_16.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_16.dart';
import '../Guess/Guess_16.dart';
import '../Listening/Listening_16.dart';
import '../Matching/Matching_16.dart';
import '../Memory/Memory_16.dart';
import '../Translation/Translation_16.dart';
import '../the order of letters/the order of letters_16.dart';

final List<List<List<String>>> allWords = [
  [
    ['line', 'خط'],
    ['product', 'منتج'],
    ['care', 'رعاية'],
    ['group', 'مجموعة'],
    ['idea', 'فكرة'],
  ],
  [
    ['risk', 'خطر'],
    ['several', 'عدة'],
    ['someone', 'شخص ما'],
    ['temperature', 'درجة الحرارة'],
    ['united', 'متحد'],
  ],
  [
    ['word', 'كلمة'],
    ['fat', 'دهون'],
    ['force', 'قوة'],
    ['key', 'مفتاح'],
    ['light', 'ضوء'],
  ],
  [
    ['simply', 'ببساطة'],
    ['today', 'اليوم'],
    ['training', 'تدريب'],
    ['until', 'حتى'],
    ['major', 'رائد'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'line', 'translation': 'خط', 'image': '📏'}, // مسطرة للدلالة على "خط"
  {'word': 'product', 'translation': 'منتج', 'image': '📦'}, // صندوق للدلالة على "منتج"
  {'word': 'care', 'translation': 'رعاية', 'image': '❤️'}, // قلب للدلالة على "رعاية"
  {'word': 'group', 'translation': 'مجموعة', 'image': '👥'}, // مجموعة أشخاص للدلالة على "مجموعة"
  {'word': 'idea', 'translation': 'فكرة', 'image': '💡'}, // مصباح للدلالة على "فكرة"

  // المجموعة الثانية
  {'word': 'risk', 'translation': 'خطر', 'image': '⚠️'}, // علامة تحذير للدلالة على "خطر"
  {'word': 'several', 'translation': 'عدة', 'image': '🔢'}, // أرقام للدلالة على "عدة"
  {'word': 'someone', 'translation': 'شخص ما', 'image': '👤'}, // شخص للدلالة على "شخص ما"
  {'word': 'temperature', 'translation': 'درجة الحرارة', 'image': '🌡️'}, // مقياس حرارة للدلالة على "درجة الحرارة"
  {'word': 'united', 'translation': 'متحد', 'image': '🤝'}, // مصافحة للدلالة على "متحد"

  // المجموعة الثالثة
  {'word': 'word', 'translation': 'كلمة', 'image': '📝'}, // ورقة للدلالة على "كلمة"
  {'word': 'fat', 'translation': 'دهون', 'image': '🍔'}, // برغر للدلالة على "دهون"
  {'word': 'force', 'translation': 'قوة', 'image': '💪'}, // عضلة للدلالة على "قوة"
  {'word': 'key', 'translation': 'مفتاح', 'image': '🔑'}, // مفتاح للدلالة على "مفتاح"
  {'word': 'light', 'translation': 'ضوء', 'image': '💡'}, // مصباح للدلالة على "ضوء"

  // المجموعة الرابعة
  {'word': 'simply', 'translation': 'ببساطة', 'image': '⚪'}, // دائرة بيضاء للدلالة على "ببساطة"
  {'word': 'today', 'translation': 'اليوم', 'image': '📅'}, // تقويم للدلالة على "اليوم"
  {'word': 'training', 'translation': 'تدريب', 'image': '🏋️‍♂️'}, // شخص يقوم بالتمرين للدلالة على "تدريب"
  {'word': 'until', 'translation': 'حتى', 'image': '⏳'}, // ساعة رملية للدلالة على "حتى"
  {'word': 'major', 'translation': 'رائد', 'image': '🎓'}, // قبعة تخرج للدلالة على "رائد"
];



class HomeGame16 extends StatefulWidget {
  @override
  _HomeGame16State createState() => _HomeGame16State();
}

class _HomeGame16State extends State<HomeGame16>
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
                  MaterialPageRoute(builder: (context) => translation16()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd16()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage16()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage16()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage16()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage16()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame16()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame16()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame16()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}













