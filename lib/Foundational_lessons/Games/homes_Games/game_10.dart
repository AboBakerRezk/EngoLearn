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
import '../Correction/Correction_10.dart';
import '../Difficult_translation/Difficult_translation_10.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_10.dart';
import '../Guess/Guess_10.dart';
import '../Listening/Listening_10.dart';
import '../Matching/Matching_10.dart';
import '../Memory/Memory_10.dart';
import '../Translation/Translation_10.dart';
import '../the order of letters/the order of letters_10.dart';

final List<List<List<String>>> allWords = [
  [
    ['human', 'بشري'],
    ['both', 'كلا'],
    ['local', 'محلي'],
    ['sure', 'بالتأكيد'],
    ['something', 'شيء ما'],
  ],
  [
    ['without', 'بدون'],
    ['come', 'يأتي'],
    ['me', 'أنا'],
    ['back', 'خلف'],
    ['better', 'أفضل'],
  ],
  [
    ['general', 'عام'],
    ['process', 'معالجة'],
    ['she', 'هي'],
    ['heat', 'حرارة'],
    ['thanks', 'شكراً'],
  ],
  [
    ['specific', 'محدد'],
    ['enough', 'كافٍ'],
    ['long', 'طويل'],
    ['lot', 'قطعة أرض'],
    ['hand', 'يد'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'human', 'translation': 'بشري', 'image': '🧑'}, // أيقونة شخص للدلالة على "بشري"
  {'word': 'both', 'translation': 'كلا', 'image': '✌️'}, // يد بها إصبعين مرفوعين للدلالة على "كلا"
  {'word': 'local', 'translation': 'محلي', 'image': '🏘️'}, // مبنى صغير أو مجموعة من المباني للدلالة على "محلي"
  {'word': 'sure', 'translation': 'بالتأكيد', 'image': '✅'}, // علامة صح للدلالة على التأكيد
  {'word': 'something', 'translation': 'شيء ما', 'image': '❓'}, // علامة استفهام للدلالة على "شيء ما"

  // المجموعة الثانية
  {'word': 'without', 'translation': 'بدون', 'image': '🚫'}, // علامة منع للدلالة على "بدون"
  {'word': 'come', 'translation': 'يأتي', 'image': '🏃'}, // شخص يجري للدلالة على "يأتي"
  {'word': 'me', 'translation': 'أنا', 'image': '👤'}, // أيقونة شخص للدلالة على "أنا"
  {'word': 'back', 'translation': 'خلف', 'image': '🔙'}, // سهم خلفي للدلالة على "خلف"
  {'word': 'better', 'translation': 'أفضل', 'image': '👍'}, // إبهام مرفوع للدلالة على "أفضل"

  // المجموعة الثالثة
  {'word': 'general', 'translation': 'عام', 'image': '🌐'}, // أيقونة كرة أرضية للدلالة على "عام"
  {'word': 'process', 'translation': 'معالجة', 'image': '⚙️'}, // ترس للدلالة على "معالجة"
  {'word': 'she', 'translation': 'هي', 'image': '👧'}, // فتاة للدلالة على "هي"
  {'word': 'heat', 'translation': 'حرارة', 'image': '🔥'}, // نار للدلالة على "حرارة"
  {'word': 'thanks', 'translation': 'شكراً', 'image': '🙏'}, // يدان مضمومتان للدلالة على "شكراً"

  // المجموعة الرابعة
  {'word': 'specific', 'translation': 'محدد', 'image': '🎯'}, // هدف للدلالة على "محدد"
  {'word': 'enough', 'translation': 'كافٍ', 'image': '👌'}, // إشارة اليد "تمام" للدلالة على "كافٍ"
  {'word': 'long', 'translation': 'طويل', 'image': '📏'}, // مسطرة للدلالة على "طويل"
  {'word': 'lot', 'translation': 'قطعة أرض', 'image': '🏞️'}, // منظر طبيعي للدلالة على "قطعة أرض"
  {'word': 'hand', 'translation': 'يد', 'image': '✋'}, // يد مفتوحة للدلالة على "يد"
];






class HomeGame10 extends StatefulWidget {
  @override
  _HomeGame10State createState() => _HomeGame10State();
}

class _HomeGame10State extends State<HomeGame10>
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
                  MaterialPageRoute(builder: (context) => translation10()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd10()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage10()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage10()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage10()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage10()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame10()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame10()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame10()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
















