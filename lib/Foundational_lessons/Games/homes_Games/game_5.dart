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
import '../Correction/Correction_5.dart';
import '../Difficult_translation/Difficult_translation_5.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_5.dart';
import '../Guess/Guess_5.dart';
import '../Listening/Listening_5.dart';
import '../Matching/Matching_5.dart';
import '../Memory/Memory_5.dart';
import '../Translation/Translation_5.dart';
import '../the order of letters/the order of letters_5.dart';

final List<List<List<String>>> allWords = [
  [
    ['good', 'جيد'],
    ['water', 'ماء'],
    ['been', 'كان'],
    ['need', 'يحتاج'],
    ['should', 'ينبغي'],
  ],
  [
    ['very', 'جداً'],
    ['any', 'أي'],
    ['history', 'تاريخ'],
    ['often', 'غالباً'],
    ['way', 'طريق'],
  ],
  [
    ['well', 'حسناً'],
    ['art', 'فن'],
    ['know', 'يعرف'],
    ['were', 'كانوا'],
    ['then', 'ثم'],
  ],
  [
    ['my', 'لي'],
    ['first', 'أول'],
    ['would', 'سوف'],
    ['money', 'مال'],
    ['each', 'كل'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
// ملف منفصل لإدارة الكلمات والصور (مثلاً: words_data.dart)

final List<Map<String, String>> allWords2 = [
  // المجموعة الأولى
  {'word': 'the', 'translation': 'ال', 'image': '🔤'}, // أحرف الأبجدية
  {'word': 'of', 'translation': 'من', 'image': '🔗'}, // رابط أو سلسلة
  {'word': 'and', 'translation': 'و', 'image': '➕'}, // علامة الجمع
  {'word': 'to', 'translation': 'إلى', 'image': '➡️'}, // سهم يشير إلى الأمام
  {'word': 'a', 'translation': 'أ', 'image': '🅰️'}, // حرف A كبير
  {'word': 'in', 'translation': 'في', 'image': '📥'}, // صندوق الوارد
  {'word': 'is', 'translation': 'هو', 'image': '❓'}, // علامة استفهام
  {'word': 'you', 'translation': 'أنت', 'image': '👤'}, // أيقونة شخصية
  {'word': 'are', 'translation': 'تكون', 'image': '✅'}, // علامة صح
  {'word': 'for', 'translation': 'لـ', 'image': '🎁'}, // هدية
  {'word': 'that', 'translation': 'أن', 'image': '⚖️'}, // ميزان العدل
  {'word': 'or', 'translation': 'أو', 'image': '🔀'}, // علامة التبديل
  {'word': 'it', 'translation': 'هو', 'image': '💡'}, // مصباح
  {'word': 'as', 'translation': 'مثل', 'image': '🔗'}, // رابط أو سلسلة
  {'word': 'be', 'translation': 'يكون', 'image': '🌟'}, // نجمة
  {'word': 'on', 'translation': 'على', 'image': '🔛'}, // رمز "ON"
  {'word': 'your', 'translation': 'لك', 'image': '🧑‍🦰'}, // شخصية بشعر أحمر
  {'word': 'with', 'translation': 'مع', 'image': '🤝'}, // مصافحة
  {'word': 'can', 'translation': 'يستطيع', 'image': '🛠️'}, // أدوات
  {'word': 'have', 'translation': 'لديك', 'image': '📦'}, // صندوق

  // المجموعة الثانية
  {'word': 'this', 'translation': 'هذا', 'image': '👆'}, // يد تشير إلى الشيء
  {'word': 'an', 'translation': 'أ', 'image': '🅰️'}, // حرف A كبير
  {'word': 'by', 'translation': 'بواسطة', 'image': '✍️'}, // كتابة بواسطة يد
  {'word': 'not', 'translation': 'ليس', 'image': '🚫'}, // علامة منع
  {'word': 'but', 'translation': 'لكن', 'image': '⚖️'}, // ميزان للتعبير عن التناقض

  // المجموعة الثالثة
  {'word': 'at', 'translation': 'في', 'image': '📍'}, // دبوس لتحديد المكان
  {'word': 'from', 'translation': 'من', 'image': '➡️'}, // سهم يشير للخروج
  {'word': 'I', 'translation': 'أنا', 'image': '👤'}, // أيقونة شخصية
  {'word': 'they', 'translation': 'هم', 'image': '👥'}, // شخصين
  {'word': 'more', 'translation': 'أكثر', 'image': '➕'}, // علامة زائد

  // المجموعة الرابعة
  {'word': 'will', 'translation': 'سوف', 'image': '⏳'}, // ساعة رملية تشير للمستقبل
  {'word': 'if', 'translation': 'إذا', 'image': '❓'}, // علامة استفهام
  {'word': 'some', 'translation': 'بعض', 'image': '📊'}, // رسم بياني
  {'word': 'there', 'translation': 'هناك', 'image': '📍'}, // دبوس موقع
  {'word': 'what', 'translation': 'ماذا', 'image': '❔'}, // علامة استفهام بيضاء

  // المجموعة الخامسة
  {'word': 'about', 'translation': 'حول', 'image': '🔄'}, // سهم دائري
  {'word': 'which', 'translation': 'التي', 'image': '❓'}, // علامة استفهام
  {'word': 'when', 'translation': 'متى', 'image': '⏰'}, // ساعة
  {'word': 'one', 'translation': 'واحد', 'image': '1️⃣'}, // الرقم واحد
  {'word': 'their', 'translation': 'لهم', 'image': '🧑‍🤝‍🧑'}, // شخصين للدلالة على الملكية

  // المجموعة السادسة
  {'word': 'all', 'translation': 'الكل', 'image': '💯'}, // كامل أو كل شيء
  {'word': 'also', 'translation': 'أيضاً', 'image': '➕'}, // إضافة أو أيضاً
  {'word': 'how', 'translation': 'كيف', 'image': '❓'}, // سؤال كيف
  {'word': 'many', 'translation': 'كثير', 'image': '🔢'}, // عدد كبير
  {'word': 'do', 'translation': 'افعل', 'image': '✔️'}, // فعل أو تنفيذ

  // المجموعة السابعة
  {'word': 'has', 'translation': 'لديه', 'image': '🛠️'}, // امتلاك أو أدوات
  {'word': 'most', 'translation': 'معظم', 'image': '🔝'}, // الأكثر
  {'word': 'people', 'translation': 'الناس', 'image': '👥'}, // الناس أو مجموعة
  {'word': 'other', 'translation': 'آخر', 'image': '🆚'}, // آخر أو مقارنة
  {'word': 'time', 'translation': 'وقت', 'image': '⏰'}, // الوقت

  // المجموعة الثامنة
  {'word': 'so', 'translation': 'لذلك', 'image': '➡️'}, // نتيجة أو اتجاه
  {'word': 'was', 'translation': 'كان', 'image': '🕰️'}, // الماضي أو الزمن
  {'word': 'we', 'translation': 'نحن', 'image': '👫'}, // نحن أو مجموعة
  {'word': 'these', 'translation': 'هؤلاء', 'image': '👀'}, // هؤلاء أو أشياء معينة
  {'word': 'may', 'translation': 'قد', 'image': '🌟'}, // إمكانية أو قدرة

  // المجموعة التاسعة
  {'word': 'like', 'translation': 'مثل', 'image': '❤️'}, // حب أو شبيهة
  {'word': 'use', 'translation': 'يستخدم', 'image': '🔧'}, // استخدام أو أدوات
  {'word': 'into', 'translation': 'إلى', 'image': '🔜'}, // اتجاه أو دخول
  {'word': 'than', 'translation': 'من', 'image': '➖'}, // مقارنة
  {'word': 'up', 'translation': 'أعلى', 'image': '⬆️'}, // أعلى أو اتجاه أعلى

  // المجموعة العاشرة
  {'word': 'good', 'translation': 'جيد', 'image': '👍'}, // إبهام لأعلى
  {'word': 'water', 'translation': 'ماء', 'image': '💧'}, // قطرة ماء
  {'word': 'been', 'translation': 'كان', 'image': '🕰️'}, // ساعة تشير للماضي
  {'word': 'need', 'translation': 'يحتاج', 'image': '🛠️'}, // أدوات
  {'word': 'should', 'translation': 'ينبغي', 'image': '✔️'}, // علامة صح

  {'word': 'very', 'translation': 'جداً', 'image': '🔥'}, // نار للدلالة على الشدة
  {'word': 'any', 'translation': 'أي', 'image': '❓'}, // علامة استفهام
  {'word': 'history', 'translation': 'تاريخ', 'image': '📜'}, // مخطوطة تاريخية
  {'word': 'often', 'translation': 'غالباً', 'image': '⏰'}, // ساعة
  {'word': 'way', 'translation': 'طريق', 'image': '🛤️'}, // سكة حديد

  {'word': 'well', 'translation': 'حسناً', 'image': '💧'}, // قطرة ماء للدلالة على الصحة
  {'word': 'art', 'translation': 'فن', 'image': '🎨'}, // لوحة فنية
  {'word': 'know', 'translation': 'يعرف', 'image': '🧠'}, // دماغ للدلالة على المعرفة
  {'word': 'were', 'translation': 'كانوا', 'image': '👥'}, // شخصين
  {'word': 'then', 'translation': 'ثم', 'image': '⏩'}, // سهم سريع

  {'word': 'my', 'translation': 'لي', 'image': '👤'}, // أيقونة شخصية
  {'word': 'first', 'translation': 'أول', 'image': '1️⃣'}, // الرقم واحد
  {'word': 'would', 'translation': 'سوف', 'image': '🔮'}, // كرة بلورية للدلالة على المستقبل
  {'word': 'money', 'translation': 'مال', 'image': '💰'}, // كيس المال
  {'word': 'each', 'translation': 'كل', 'image': '🔁'}, // سهم متكرر للدلالة على الكل
];







class HomeGame5 extends StatefulWidget {
  @override
  _HomeGame5State createState() => _HomeGame5State();
}

class _HomeGame5State extends State<HomeGame5>
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
                  MaterialPageRoute(builder: (context) => translation5()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd5()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage5()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage5()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage5()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage5()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame5()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame5()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame5()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}



























