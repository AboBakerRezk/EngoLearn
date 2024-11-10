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
import '../Correction/Correction_18.dart';
import '../Difficult_translation/Difficult_translation_18.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_18.dart';
import '../Guess/Guess_18.dart';
import '../Listening/Listening_18.dart';
import '../Matching/Matching_18.dart';
import '../Memory/Memory_18.dart';
import '../Translation/Translation_18.dart';
import '../the order of letters/the order of letters_18.dart';

final List<List<List<String>>> allWords = [
  [
    ['instead', 'بدلاً'],
    ['least', 'الأقل'],
    ['natural', 'طبيعي'],
    ['physical', 'بدني'],
    ['piece', 'قطعة'],
  ],
  [
    ['show', 'يظهر'],
    ['society', 'مجتمع'],
    ['try', 'محاولة'],
    ['check', 'تحقق'],
    ['choose', 'اختر'],
  ],
  [
    ['develop', 'طور'],
    ['second', 'ثاني'],
    ['useful', 'مفيد'],
    ['web', 'شبكة'],
    ['activity', 'نشاط'],
  ],
  [
    ['boss', 'رئيس'],
    ['short', 'قصير'],
    ['story', 'قصة'],
    ['call', 'مكالمة'],
    ['industry', 'صناعة'],
  ],
];
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'instead', 'translation': 'بدلاً', 'image': '🔄'}, // سهم دائري للدلالة على "بدلاً"
  {'word': 'least', 'translation': 'الأقل', 'image': '⬇️'}, // سهم يشير للأسفل للدلالة على "الأقل"
  {'word': 'natural', 'translation': 'طبيعي', 'image': '🌿'}, // نبات للدلالة على "طبيعي"
  {'word': 'physical', 'translation': 'بدني', 'image': '🏋️‍♂️'}, // شخص يمارس التمرين للدلالة على "بدني"
  {'word': 'piece', 'translation': 'قطعة', 'image': '🧩'}, // قطعة بازل للدلالة على "قطعة"

  // المجموعة الثانية
  {'word': 'show', 'translation': 'يظهر', 'image': '👁️'}, // عين للدلالة على "يظهر"
  {'word': 'society', 'translation': 'مجتمع', 'image': '👥'}, // مجموعة أشخاص للدلالة على "مجتمع"
  {'word': 'try', 'translation': 'محاولة', 'image': '💪'}, // عضلة للدلالة على "محاولة"
  {'word': 'check', 'translation': 'تحقق', 'image': '✅'}, // علامة صح للدلالة على "تحقق"
  {'word': 'choose', 'translation': 'اختر', 'image': '🟢'}, // دائرة خضراء للدلالة على "اختر"

  // المجموعة الثالثة
  {'word': 'develop', 'translation': 'طور', 'image': '⚙️'}, // ترس للدلالة على "طور"
  {'word': 'second', 'translation': 'ثاني', 'image': '2️⃣'}, // الرقم 2 للدلالة على "ثاني"
  {'word': 'useful', 'translation': 'مفيد', 'image': '🔧'}, // مفتاح للدلالة على "مفيد"
  {'word': 'web', 'translation': 'شبكة', 'image': '🌐'}, // كرة أرضية للدلالة على "شبكة"
  {'word': 'activity', 'translation': 'نشاط', 'image': '🏃‍♂️'}, // شخص يجري للدلالة على "نشاط"

  // المجموعة الرابعة
  {'word': 'boss', 'translation': 'رئيس', 'image': '💼'}, // حقيبة عمل للدلالة على "رئيس"
  {'word': 'short', 'translation': 'قصير', 'image': '📏'}, // مسطرة للدلالة على "قصير"
  {'word': 'story', 'translation': 'قصة', 'image': '📖'}, // كتاب للدلالة على "قصة"
  {'word': 'call', 'translation': 'مكالمة', 'image': '📞'}, // هاتف للدلالة على "مكالمة"
  {'word': 'industry', 'translation': 'صناعة', 'image': '🏭'}, // مصنع للدلالة على "صناعة"
];







class HomeGame18 extends StatefulWidget {
  @override
  _HomeGame18State createState() => _HomeGame18State();
}

class _HomeGame18State extends State<HomeGame18>
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
                  MaterialPageRoute(builder: (context) => translation18()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd18()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage18()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage18()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage18()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage18()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame18()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame18()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame18()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}















