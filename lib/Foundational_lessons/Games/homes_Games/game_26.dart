import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../settings/setting_2.dart';
import '../../Explanation_of_words/Explanation_of_words_1.dart';
import '../../Review.dart';

class HomeGame26 extends StatefulWidget {
  @override
  _HomeGame26State createState() => _HomeGame26State();
}

class _HomeGame26State extends State<HomeGame26>
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
                  MaterialPageRoute(builder: (context) => translation26()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd26()),
                );               }),
              SizedBox(height: 20),
////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage26()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage26()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage26()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage26()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame26()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame26()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame26()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S125.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpeechPage26s()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S126.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordsPage()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S127.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordsListPage()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
