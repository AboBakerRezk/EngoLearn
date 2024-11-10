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
import '../Correction/Correction_14.dart';
import '../Difficult_translation/Difficult_translation_14.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_14.dart';
import '../Guess/Guess_14.dart';
import '../Listening/Listening_14.dart';
import '../Matching/Matching_14.dart';
import '../Memory/Memory_14.dart';
import '../Translation/Translation_14.dart';
import '../the order of letters/the order of letters_14.dart';

final List<List<List<String>>> allWords = [
  [
    ['control', 'مراقبة'],
    ['knowledge', 'معرفة'],
    ['power', 'قوة'],
    ['radio', 'راديو'],
    ['ability', 'قدرة'],
  ],
  [
    ['basic', 'أساسي'],
    ['course', 'دورة'],
    ['economics', 'اقتصاديات'],
    ['hard', 'صعب'],
    ['add', 'إضافة'],
  ],
  [
    ['company', 'شركة'],
    ['known', 'معروف'],
    ['love', 'حب'],
    ['past', 'الماضي'],
    ['price', 'سعر'],
  ],
  [
    ['size', 'حجم'],
    ['away', 'بعيد'],
    ['big', 'كبير'],
    ['internet', 'إنترنت'],
    ['possible', 'ممكن'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'control', 'translation': 'مراقبة', 'image': '🎛️'}, // لوحة تحكم للدلالة على "مراقبة"
  {'word': 'knowledge', 'translation': 'معرفة', 'image': '📘'}, // كتاب للدلالة على "معرفة"
  {'word': 'power', 'translation': 'قوة', 'image': '💪'}, // عضلة للدلالة على "قوة"
  {'word': 'radio', 'translation': 'راديو', 'image': '📻'}, // راديو للدلالة على "راديو"
  {'word': 'ability', 'translation': 'قدرة', 'image': '⚡'}, // برق للدلالة على "قدرة"

  // المجموعة الثانية
  {'word': 'basic', 'translation': 'أساسي', 'image': '🔧'}, // مفتاح للدلالة على "أساسي"
  {'word': 'course', 'translation': 'دورة', 'image': '🎓'}, // قبعة تخرج للدلالة على "دورة"
  {'word': 'economics', 'translation': 'اقتصاديات', 'image': '💼'}, // حقيبة عمل للدلالة على "اقتصاديات"
  {'word': 'hard', 'translation': 'صعب', 'image': '🪨'}, // صخرة للدلالة على "صعب"
  {'word': 'add', 'translation': 'إضافة', 'image': '➕'}, // علامة الزائد للدلالة على "إضافة"

  // المجموعة الثالثة
  {'word': 'company', 'translation': 'شركة', 'image': '🏢'}, // مبنى شركة للدلالة على "شركة"
  {'word': 'known', 'translation': 'معروف', 'image': '📜'}, // وثيقة للدلالة على "معروف"
  {'word': 'love', 'translation': 'حب', 'image': '❤️'}, // قلب للدلالة على "حب"
  {'word': 'past', 'translation': 'الماضي', 'image': '🕰️'}, // ساعة للدلالة على "الماضي"
  {'word': 'price', 'translation': 'سعر', 'image': '💵'}, // عملة للدلالة على "سعر"

  // المجموعة الرابعة
  {'word': 'size', 'translation': 'حجم', 'image': '📏'}, // مسطرة للدلالة على "حجم"
  {'word': 'away', 'translation': 'بعيد', 'image': '🏃‍♂️'}, // شخص يجري للدلالة على "بعيد"
  {'word': 'big', 'translation': 'كبير', 'image': '🗻'}, // جبل للدلالة على "كبير"
  {'word': 'internet', 'translation': 'إنترنت', 'image': '🌐'}, // كرة أرضية للدلالة على "إنترنت"
  {'word': 'possible', 'translation': 'ممكن', 'image': '✅'}, // علامة صح للدلالة على "ممكن"
];






class HomeGame14 extends StatefulWidget {
  @override
  _HomeGame14State createState() => _HomeGame14State();
}

class _HomeGame14State extends State<HomeGame14>
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
                  MaterialPageRoute(builder: (context) => translation14()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd14()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage14()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage14()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage14()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage14()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame14()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame14()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame14()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}










