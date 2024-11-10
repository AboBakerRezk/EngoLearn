// الكلمات المستخدمة في الألعاب
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../settings/setting_2.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../Correction/Correction_15.dart';
import '../Difficult_translation/Difficult_translation_15.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_15.dart';
import '../Guess/Guess_15.dart';
import '../Listening/Listening_15.dart';
import '../Matching/Matching_15.dart';
import '../Memory/Memory_15.dart';
import '../Translation/Translation_15.dart';
import '../the order of letters/the order of letters_15.dart';


final List<List<List<String>>> allWords = [
  [
    ['television', 'تلفزيون'],
    ['three', 'ثلاثة'],
    ['understand', 'يفهم'],
    ['various', 'متنوع'],
    ['yourself', 'نفسك'],
  ],
  [
    ['card', 'بطاقة'],
    ['difficult', 'صعب'],
    ['including', 'بما في ذلك'],
    ['list', 'قائمة'],
    ['mind', 'عقل'],
  ],
  [
    ['particular', 'خاص'],
    ['real', 'حقيقي'],
    ['science', 'علم'],
    ['trade', 'تجارة'],
    ['consider', 'يعتبر'],
  ],
  [
    ['either', 'إما'],
    ['library', 'مكتبة'],
    ['likely', 'من المحتمل'],
    ['nature', 'طبيعة'],
    ['fact', 'حقيقة'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'television', 'translation': 'تلفزيون', 'image': '📺'}, // تلفاز للدلالة على "تلفزيون"
  {'word': 'three', 'translation': 'ثلاثة', 'image': '3️⃣'}, // الرقم ثلاثة للدلالة على "ثلاثة"
  {'word': 'understand', 'translation': 'يفهم', 'image': '🧠'}, // دماغ للدلالة على "يفهم"
  {'word': 'various', 'translation': 'متنوع', 'image': '🔀'}, // أسهم متقاطعة للدلالة على "متنوع"
  {'word': 'yourself', 'translation': 'نفسك', 'image': '👤'}, // شخص للدلالة على "نفسك"

  // المجموعة الثانية
  {'word': 'card', 'translation': 'بطاقة', 'image': '💳'}, // بطاقة مصرفية للدلالة على "بطاقة"
  {'word': 'difficult', 'translation': 'صعب', 'image': '🪨'}, // صخرة للدلالة على "صعب"
  {'word': 'including', 'translation': 'بما في ذلك', 'image': '📥'}, // صندوق وارد للدلالة على "بما في ذلك"
  {'word': 'list', 'translation': 'قائمة', 'image': '📋'}, // قائمة مهام للدلالة على "قائمة"
  {'word': 'mind', 'translation': 'عقل', 'image': '🧠'}, // دماغ للدلالة على "عقل"

  // المجموعة الثالثة
  {'word': 'particular', 'translation': 'خاص', 'image': '🔒'}, // قفل للدلالة على "خاص"
  {'word': 'real', 'translation': 'حقيقي', 'image': '✅'}, // علامة صح للدلالة على "حقيقي"
  {'word': 'science', 'translation': 'علم', 'image': '🔬'}, // مجهر للدلالة على "علم"
  {'word': 'trade', 'translation': 'تجارة', 'image': '💱'}, // رمز تحويل عملات للدلالة على "تجارة"
  {'word': 'consider', 'translation': 'يعتبر', 'image': '🤔'}, // وجه يفكر للدلالة على "يعتبر"

  // المجموعة الرابعة
  {'word': 'either', 'translation': 'إما', 'image': '🔀'}, // أسهم متقاطعة للدلالة على "إما"
  {'word': 'library', 'translation': 'مكتبة', 'image': '📚'}, // كتب للدلالة على "مكتبة"
  {'word': 'likely', 'translation': 'من المحتمل', 'image': '🤷'}, // شخص يرفع كتفيه للدلالة على "من المحتمل"
  {'word': 'nature', 'translation': 'طبيعة', 'image': '🌿'}, // ورقة نبات للدلالة على "طبيعة"
  {'word': 'fact', 'translation': 'حقيقة', 'image': '📜'}, // وثيقة للدلالة على "حقيقة"
];





class HomeGame15 extends StatefulWidget {
  @override
  _HomeGame15State createState() => _HomeGame15State();
}

class _HomeGame15State extends State<HomeGame15>
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
                  MaterialPageRoute(builder: (context) => translation15()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd15()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage15()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage15()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage15()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage15()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame15()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame15()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame15()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}












