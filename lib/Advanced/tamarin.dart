import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';





import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_22.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_home.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/storys_hom.dart';
import 'package:mushaf25/Advanced_exercises/tamarin120.dart';

import '../Foundational_lessons/sentence/sentence_e10.dart';

import '../Pages/profile.dart';
import '../settings/setting_2.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;





class Tamarin extends StatefulWidget {
  @override
  _TamarinState createState() => _TamarinState();
}

class _TamarinState extends State<Tamarin>
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
        title: Text('رِحْلَةُ الأَلْفِ مِيلٍ تَبْدَأُ بِخُطْوَةٍ', style: TextStyle(color: Colors.white)),
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
              _buildButton('${AppLocale.S122.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StorysHom()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S75_test.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuisHome()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S124.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SentenceConstructionExercise22()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S56.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksGamePage120()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S71.getString(context)}', () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ReadHome()),
                // );
              }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S72.getString(context)}', () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Listen_Home()),
                // );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
