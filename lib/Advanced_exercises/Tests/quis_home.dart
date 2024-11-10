import 'package:flutter/material.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_1.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_10.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_11.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_12.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_13.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_14.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_15.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_16.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_17.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_18.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_19.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_2.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_20.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_3.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_4.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_5.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_6.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_7.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_8.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_9.dart';
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

import '../Interactive_stories/story_7.dart';


class QuisHome extends StatefulWidget {
  @override
  _QuisHomeState createState() => _QuisHomeState();
}

class _QuisHomeState extends State<QuisHome> {
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
      appBar: AppBar(
        title: Text(
          'تدرب',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
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
                child: Text('اختبار ${index + 1}'),
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
        return ExerciseHomePage();
      case 2:
        return ExerciseHomePage2();
      case 3:
        return ExerciseHomePages3();
      case 4:
        return ExerciseHomePage4();
      case 5:
        return ExerciseHomePage5();
      case 6:
        return ExerciseHomePage6();
      case 7:
        return ExerciseHomePage7();
      case 8:
        return ExerciseHomePage8();
      case 9:
        return ExerciseHomePage9();
      case 10:
        return ExerciseHomePage10();
      case 11:
        return ExerciseHomePage11();
      case 12:
        return ExerciseHomePage12();
      case 13:
        return ExerciseHomePage13();
      case 14:
        return ExerciseHomePage14();
      case 15:
        return ExerciseHomePage15();
      case 16:
        return ExerciseHomePage16();
      case 17:
        return ExerciseHomePage17();
      case 18:
        return ExerciseHomePage18();
      case 19:
        return ExerciseHomePage19();
      case 20:
        return ExerciseHomePage20();
      default:
        return ExerciseHomePage();
    }
  }
}
