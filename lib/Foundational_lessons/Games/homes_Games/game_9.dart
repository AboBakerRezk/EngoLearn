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
import '../Correction/Correction_9.dart';
import '../Difficult_translation/Difficult_translation_9.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_9.dart';
import '../Guess/Guess_9.dart';
import '../Listening/Listening_9.dart';
import '../Matching/Matching_9.dart';
import '../Memory/Memory_9.dart';
import '../Translation/Translation_9.dart';
import '../the order of letters/the order of letters_9.dart';

final List<List<List<String>>> allWords = [
  [
    ['meat', 'لحم'],
    ['air', 'هواء'],
    ['day', 'يوم'],
    ['place', 'مكان'],
    ['become', 'يصبح'],
  ],
  [
    ['number', 'رقم'],
    ['public', 'عام'],
    ['read', 'قرأ'],
    ['keep', 'احتفظ'],
    ['part', 'جزء'],
  ],
  [
    ['start', 'بداية'],
    ['year', 'عام'],
    ['every', 'كل'],
    ['field', 'حقل'],
    ['large', 'كبير'],
  ],
  [
    ['once', 'مرة واحدة'],
    ['available', 'متاح'],
    ['down', 'أسفل'],
    ['give', 'يعطي'],
    ['fish', 'سمك'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'meat', 'translation': 'لحم', 'image': '🍖'}, // لحم للدلالة على "لحم"
  {'word': 'air', 'translation': 'هواء', 'image': '🌬️'}, // ريح للدلالة على "هواء"
  {'word': 'day', 'translation': 'يوم', 'image': '📅'}, // تقويم للدلالة على "يوم"
  {'word': 'place', 'translation': 'مكان', 'image': '📍'}, // دبوس موقع للدلالة على "مكان"
  {'word': 'become', 'translation': 'يصبح', 'image': '🔄'}, // سهم دائري للدلالة على التغيير "يصبح"

  // المجموعة الثانية
  {'word': 'number', 'translation': 'رقم', 'image': '🔢'}, // أرقام للدلالة على "رقم"
  {'word': 'public', 'translation': 'عام', 'image': '🏢'}, // مبنى عام للدلالة على "عام"
  {'word': 'read', 'translation': 'قرأ', 'image': '📖'}, // كتاب مفتوح للدلالة على "قرأ"
  {'word': 'keep', 'translation': 'احتفظ', 'image': '📦'}, // صندوق للدلالة على "احتفظ"
  {'word': 'part', 'translation': 'جزء', 'image': '🧩'}, // قطعة بازل للدلالة على "جزء"

  // المجموعة الثالثة
  {'word': 'start', 'translation': 'بداية', 'image': '🚦'}, // إشارة مرور للدلالة على "بداية"
  {'word': 'year', 'translation': 'عام', 'image': '📆'}, // تقويم للدلالة على "عام"
  {'word': 'every', 'translation': 'كل', 'image': '🔁'}, // رمز التكرار للدلالة على "كل"
  {'word': 'field', 'translation': 'حقل', 'image': '🌾'}, // نباتات للدلالة على "حقل"
  {'word': 'large', 'translation': 'كبير', 'image': '🗻'}, // جبل كبير للدلالة على "كبير"

  // المجموعة الرابعة
  {'word': 'once', 'translation': 'مرة واحدة', 'image': '1️⃣'}, // الرقم واحد للدلالة على "مرة واحدة"
  {'word': 'available', 'translation': 'متاح', 'image': '🟢'}, // دائرة خضراء للدلالة على "متاح"
  {'word': 'down', 'translation': 'أسفل', 'image': '⬇️'}, // سهم للأسفل للدلالة على "أسفل"
  {'word': 'give', 'translation': 'يعطي', 'image': '🎁'}, // هدية للدلالة على "يعطي"
  {'word': 'fish', 'translation': 'سمك', 'image': '🐟'}, // سمكة للدلالة على "سمك"
];







class HomeGame9 extends StatefulWidget {
  @override
  _HomeGame9State createState() => _HomeGame9State();
}

class _HomeGame9State extends State<HomeGame9>
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
                  MaterialPageRoute(builder: (context) => translation9()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd9()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage9()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage9()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage9()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage9()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame9()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame9()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame9()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
















