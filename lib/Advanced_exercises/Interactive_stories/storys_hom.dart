import 'package:flutter/material.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_1.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_10.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_11.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_12.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_13_Ss.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_14.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_15.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_16.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_17.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_18.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_19.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_2.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_20.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_3.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_4.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_5.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_6.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_8.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/story_9.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'story_7.dart';

class StorysHom extends StatefulWidget {
  @override
  _StorysHomState createState() => _StorysHomState();
}

class _StorysHomState extends State<StorysHom> {
  List<bool> _isButtonEnabled = List.generate(20, (index) => true); // جميع الأزرار مفتوحة
  int _lastCompletedButton = 0;

  @override
  void initState() {
    super.initState();
    _loadButtonState();
  }

  Future<void> _loadButtonState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // جعل جميع الأزرار قابلة للنقر
    for (int i = 0; i < _isButtonEnabled.length; i++) {
      _isButtonEnabled[i] = true;
    }

    setState(() {});
  }

  Future<void> _completeButton(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _lastCompletedButton = index;
    });

    await prefs.setInt('lastCompletedButton', _lastCompletedButton);
    await prefs.setInt('lastCompletedTime', DateTime.now().millisecondsSinceEpoch);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => getPage(index + 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: GridView.builder(
            padding: EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // عدد الأزرار في الصف الواحد
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // لون النص
                  backgroundColor: Colors.lightBlue, // درجة من درجات اللون الأزرق
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  elevation: 8,
                  shadowColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // تعديل درجة استدارة الحواف
                    side: BorderSide(color: Colors.blue, width: 2),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onPressed: () => _completeButton(index), // جميع الأزرار قابلة للنقر
                child: Text('قصة ${index + 1}'),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getPage(int pageNumber) {
    switch (pageNumber) {
      case 1:
        return StoryPage();
      case 2:
        return StoryPage2();
      case 3:
        return StoryPage3();
      case 4:
        return StoryPage4();
      case 5:
        return StoryPage5();
      case 6:
        return StoryPage6();
      case 7:
        return StoryPage7();
      case 8:
        return StoryPage8();
      case 9:
        return StoryPage9();
      case 10:
        return StoryPage10();
      case 11:
        return StoryPage11();
      case 12:
        return StoryPage12();
      case 13:
        return StoryPage13();
      case 14:
        return StoryPage14();
      case 15:
        return StoryPage15();
      case 16:
        return StoryPage15();
      case 17:
        return StoryPage17();
      case 18:
        return StoryPage18();
      case 19:
        return StoryPage19();
      case 20:
        return StoryPage20();
      default:
        return StoryPage();
    }
  }
}
