import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';





import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../Grammar/rules_16.dart';
import '../Speech/SpeechPage_16.dart';
import '../review.dart';
import '../sentence/sentence_e.dart';
import '../sentence/sentence_e16.dart';
import '../../settings/setting_2.dart';
import '../Difficult_translation/Tutorial_16.dart';
import '../Exercises/quis_e.dart';
import '../Exercises/quis_e16.dart';
import '../Games/homes_Games/game_1.dart';
import '../Games/homes_Games/game_16.dart';
import '../Review.dart';
import '../Vocabulary/word_1.dart';
import '../Vocabulary/word_16.dart';




class Lessons16 extends StatefulWidget {
  @override
  _Lessons16State createState() => _Lessons16State();
}

class _Lessons16State extends State<Lessons16>
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black, // خلفية سوداء
      appBar: AppBar(
        title: Text(
          "وَحَارِبْ لِحُلْمٍ مَا يَزَالُ عَالِقًا بَيْنَ النَّجَاحِ أَوْ أَنْ يَبُوءَ بِالفَشَلِ.",
          style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.white), // ضبط حجم الخط
          textAlign: TextAlign.center, // محاذاة النص في الوسط
        ),
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
              _buildButton('${AppLocale.S54.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Word16()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.Ss54.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemorizationPage16()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S32.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LearningPage16()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S56.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EnglishSentencesPage16()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S27.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen16()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S79.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeGame16()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S125.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpeechPage16()),
                );               }),
            ],
          ),
        ),
      ),
    );
  }
}
