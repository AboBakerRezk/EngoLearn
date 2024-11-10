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
import '../Correction/Correction_13.dart';
import '../Difficult_translation/Difficult_translation_13.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_13.dart';
import '../Guess/Guess_13.dart';
import '../Listening/Listening_13.dart';
import '../Matching/Matching_13.dart';
import '../Memory/Memory_13.dart';
import '../Translation/Translation_13.dart';
import '../the order of letters/the order of letters_13.dart';

final List<List<List<String>>> allWords = [
  [
    ['always', 'دائماً'],
    ['body', 'جسم'],
    ['common', 'شائع'],
    ['market', 'سوق'],
    ['set', 'جلس'],
  ],
  [
    ['bird', 'طائر'],
    ['guide', 'مرشد'],
    ['provide', 'تزود'],
    ['change', 'تغيير'],
    ['interest', 'فائدة'],
  ],
  [
    ['literature', 'أدب'],
    ['sometimes', 'أحياناً'],
    ['problem', 'مشكلة'],
    ['say', 'يقول'],
    ['next', 'التالي'],
  ],
  [
    ['create', 'ينشئ'],
    ['simple', 'بسيط'],
    ['software', 'برمجيات'],
    ['state', 'حالة'],
    ['together', 'سوياً'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'always', 'translation': 'دائماً', 'image': '♾️'}, // علامة اللانهاية للدلالة على "دائماً"
  {'word': 'body', 'translation': 'جسم', 'image': '👤'}, // شخص للدلالة على "جسم"
  {'word': 'common', 'translation': 'شائع', 'image': '🌍'}, // كرة أرضية للدلالة على "شائع"
  {'word': 'market', 'translation': 'سوق', 'image': '🏪'}, // متجر للدلالة على "سوق"
  {'word': 'set', 'translation': 'جلس', 'image': '🪑'}, // كرسي للدلالة على "جلس"

  // المجموعة الثانية
  {'word': 'bird', 'translation': 'طائر', 'image': '🐦'}, // طائر للدلالة على "طائر"
  {'word': 'guide', 'translation': 'مرشد', 'image': '🧭'}, // بوصلة للدلالة على "مرشد"
  {'word': 'provide', 'translation': 'تزود', 'image': '📦'}, // صندوق إمداد للدلالة على "تزود"
  {'word': 'change', 'translation': 'تغيير', 'image': '🔄'}, // سهم دائري للدلالة على "تغيير"
  {'word': 'interest', 'translation': 'فائدة', 'image': '💡'}, // مصباح للدلالة على "فائدة"

  // المجموعة الثالثة
  {'word': 'literature', 'translation': 'أدب', 'image': '📚'}, // مجموعة كتب للدلالة على "أدب"
  {'word': 'sometimes', 'translation': 'أحياناً', 'image': '⏳'}, // ساعة رملية للدلالة على "أحياناً"
  {'word': 'problem', 'translation': 'مشكلة', 'image': '❗'}, // علامة تعجب للدلالة على "مشكلة"
  {'word': 'say', 'translation': 'يقول', 'image': '🗣️'}, // شخص يتحدث للدلالة على "يقول"
  {'word': 'next', 'translation': 'التالي', 'image': '➡️'}, // سهم يمين للدلالة على "التالي"

  // المجموعة الرابعة
  {'word': 'create', 'translation': 'ينشئ', 'image': '🛠️'}, // أدوات للدلالة على "ينشئ"
  {'word': 'simple', 'translation': 'بسيط', 'image': '⚪'}, // دائرة بيضاء للدلالة على "بسيط"
  {'word': 'software', 'translation': 'برمجيات', 'image': '💻'}, // حاسوب للدلالة على "برمجيات"
  {'word': 'state', 'translation': 'حالة', 'image': '📊'}, // رسم بياني للدلالة على "حالة"
  {'word': 'together', 'translation': 'سوياً', 'image': '🤝'}, // مصافحة للدلالة على "سوياً"
];









class HomeGame13 extends StatefulWidget {
  @override
  _HomeGame13State createState() => _HomeGame13State();
}

class _HomeGame13State extends State<HomeGame13>
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
                  MaterialPageRoute(builder: (context) => translation13()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd13()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage13()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage13()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage13()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage13()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame13()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame13()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame13()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}













