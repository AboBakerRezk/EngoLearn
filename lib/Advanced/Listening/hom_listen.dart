import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:list_english_words/list_english_words.dart';
import 'package:mushaf25/Advanced/Listening/listen_e.dart';
import 'package:mushaf25/Advanced/Writing/writing_e1.dart';
import 'package:mushaf25/Advanced/Writing/writing_e10.dart';
import 'package:mushaf25/Advanced/Writing/writing_e11.dart';
import 'package:mushaf25/Advanced/Writing/writing_e12.dart';
import 'package:mushaf25/Advanced/Writing/writing_e13.dart';
import 'package:mushaf25/Advanced/Writing/writing_e14.dart';
import 'package:mushaf25/Advanced/Writing/writing_e15.dart';
import 'package:mushaf25/Advanced/Writing/writing_e16.dart';
import 'package:mushaf25/Advanced/Writing/writing_e17.dart';
import 'package:mushaf25/Advanced/Writing/writing_e18.dart';
import 'package:mushaf25/Advanced/Writing/writing_e19.dart';
import 'package:mushaf25/Advanced/Writing/writing_e2.dart';
import 'package:mushaf25/Advanced/Writing/writing_e20.dart';
import 'package:mushaf25/Advanced/Writing/writing_e21.dart';
import 'package:mushaf25/Advanced/Writing/writing_e22.dart';
import 'package:mushaf25/Advanced/Writing/writing_e23.dart';
import 'package:mushaf25/Advanced/Writing/writing_e24.dart';
import 'package:mushaf25/Advanced/Writing/writing_e25.dart';
import 'package:mushaf25/Advanced/Writing/writing_e26.dart';
import 'package:mushaf25/Advanced/Writing/writing_e27.dart';
import 'package:mushaf25/Advanced/Writing/writing_e28.dart';
import 'package:mushaf25/Advanced/Writing/writing_e29.dart';
import 'package:mushaf25/Advanced/Writing/writing_e3.dart';
import 'package:mushaf25/Advanced/Writing/writing_e30.dart';
import 'package:mushaf25/Advanced/Writing/writing_e31.dart';
import 'package:mushaf25/Advanced/Writing/writing_e32.dart';
import 'package:mushaf25/Advanced/Writing/writing_e33.dart';
import 'package:mushaf25/Advanced/Writing/writing_e34.dart';
import 'package:mushaf25/Advanced/Writing/writing_e35.dart';
import 'package:mushaf25/Advanced/Writing/writing_e36.dart';
import 'package:mushaf25/Advanced/Writing/writing_e37.dart';
import 'package:mushaf25/Advanced/Writing/writing_e38.dart';
import 'package:mushaf25/Advanced/Writing/writing_e39.dart';
import 'package:mushaf25/Advanced/Writing/writing_e4.dart';
import 'package:mushaf25/Advanced/Writing/writing_e40.dart';
import 'package:mushaf25/Advanced/Writing/writing_e41.dart';
import 'package:mushaf25/Advanced/Writing/writing_e42.dart';
import 'package:mushaf25/Advanced/Writing/writing_e43.dart';
import 'package:mushaf25/Advanced/Writing/writing_e44.dart';
import 'package:mushaf25/Advanced/Writing/writing_e45.dart';
import 'package:mushaf25/Advanced/Writing/writing_e46.dart';
import 'package:mushaf25/Advanced/Writing/writing_e47.dart';
import 'package:mushaf25/Advanced/Writing/writing_e48.dart';
import 'package:mushaf25/Advanced/Writing/writing_e49.dart';
import 'package:mushaf25/Advanced/Writing/writing_e5.dart';
import 'package:mushaf25/Advanced/Writing/writing_e50.dart';
import 'package:mushaf25/Advanced/Writing/writing_e6.dart';
import 'package:mushaf25/Advanced/Writing/writing_e7.dart';
import 'package:mushaf25/Advanced/Writing/writing_e8.dart';
import 'package:mushaf25/Advanced/Writing/writing_e9.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../settings/setting_2.dart';
import 'listen_e10.dart';
import 'listen_e11.dart';
import 'listen_e12.dart';
import 'listen_e13.dart';
import 'listen_e14.dart';
import 'listen_e15.dart';
import 'listen_e16.dart';
import 'listen_e17.dart';
import 'listen_e18.dart';
import 'listen_e19.dart';
import 'listen_e2.dart';
import 'listen_e20.dart';
import 'listen_e21.dart';
import 'listen_e22.dart';
import 'listen_e23.dart';
import 'listen_e24.dart';
import 'listen_e25.dart';
import 'listen_e3.dart';
import 'listen_e4.dart';
import 'listen_e5.dart';
import 'listen_e6.dart';
import 'listen_e7.dart';
import 'listen_e8.dart';
import 'listen_e9.dart';

class HomListen extends StatefulWidget {
  @override
  _HomListenState createState() => _HomListenState();
}

class _HomListenState extends State<HomListen> {
  List<bool> _isButtonEnabled = List.generate(25, (index) => true); // جميع الأزرار مفعلة

  @override
  void initState() {
    super.initState();
    // تمكين جميع الأزرار دون الحاجة إلى تحميل الحالة
    _enableAllButtons();
  }

  void _enableAllButtons() {
    for (int i = 0; i < _isButtonEnabled.length; i++) {
      _isButtonEnabled[i] = true; // تفعيل كل الأزرار
    }
    setState(() {});
  }

  Future<void> _openLesson(int index) async {
    // التنقل إلى الصفحة المناسبة عند الضغط على الزر
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
            colors: [Colors.blueAccent, Colors.black87], // لون الخلفية التدرجية
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: GridView.builder(
            padding: EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // عدد الأزرار في كل صف
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 35,
            itemBuilder: (context, index) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // لون النص
                  backgroundColor: Colors.blue,  // لون الخلفية الأزرق
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  elevation: 5, // إضافة ظل للزر
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // زوايا مستديرة للزر
                    side: BorderSide(color: Colors.blueAccent, width: 2), // حدود الزر بلون أزرق فاتح
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // حجم الزر
                ),
                onPressed: () => _openLesson(index), // فتح الدرس المناسب عند الضغط
                child: Text('${AppLocale.S30.getString(context)} ${index + 1}'), // النص داخل الزر
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getPage(int pageNumber) {
    // هنا يتم تحديد أي صفحة يتم فتحها حسب رقم الدرس
    switch (pageNumber) {
      case 1:
        return ListeningGames1();
      case 2:
        return ListeningGames2();
      case 3:
        return ListeningGames3();
      case 4:
        return ListeningGames4();
      case 5:
        return ListeningGames5();
      case 6:
        return ListeningGames6();
      case 7:
        return ListeningGames7();
      case 8:
        return ListeningGames8();
      case 9:
        return ListeningGames9();
      case 10:
        return ListeningGames10();
      case 11:
        return TechnologyArticleQuizPage();
      case 12:
        return TechnologyArticleQuizPage2();
      case 13:
        return TechnologyArticleQuizPage3();
      case 14:
        return TechnologyArticleQuizPage4();
      case 15:
        return TechnologyArticleQuizPage5();
      case 16:
        return TechnologyArticleQuizPage6();
      case 17:
        return TechnologyArticleQuizPage7();
      case 18:
        return TechnologyArticleQuizPage8();
      case 19:
        return TechnologyArticleQuizPage9();
      case 20:
        return TechnologyArticleQuizPage10();
      case 21:
        return TechnologyArticleQuizPage11();
      case 22:
        return TechnologyArticleQuizPage12();
      case 23:
        return TechnologyArticleQuizPage13();
      case 24:
        return TechnologyArticleQuizPage14();
      case 25:
        return TechnologyArticleQuizPage15();
      case 26:
        return TechnologyArticleQuizPage16();
      case 27:
        return TechnologyArticleQuizPage17();
      case 28:
        return TechnologyArticleQuizPage18();
      case 29:
        return TechnologyArticleQuizPage19();
      case 30:
        return TechnologyArticleQuizPage20();
      case 31:
        return TechnologyArticleQuizPage21();
      case 32:
        return TechnologyArticleQuizPage22();
      case 33:
        return TechnologyArticleQuizPage23();
      case 34:
        return TechnologyArticleQuizPage24();
      case 35:
        return TechnologyArticleQuizPage25();
      default:
        return ListeningGames1(); // الافتراضي إذا حدث خطأ
    }
  }
}

