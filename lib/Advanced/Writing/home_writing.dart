import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:list_english_words/list_english_words.dart';
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

class Writing extends StatefulWidget {
  @override
  _WritingState createState() => _WritingState();
}

class _WritingState extends State<Writing> {
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
            itemCount: 50,
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
        return WritingSection1();
      case 2:
        return WritingSection2();
      case 3:
        return WritingSection3();
      case 4:
        return WritingSection4();
      case 5:
        return WritingSection5();
      case 6:
        return WritingSection6();
      case 7:
        return WritingSection7();
      case 8:
        return WritingSection8();
      case 9:
        return WritingSection9();
      case 10:
        return WritingSection10();
      case 11:
        return WritingSections11();
      case 12:
        return WritingSections12();
      case 13:
        return WritingSections13();
      case 14:
        return WritingSections14();
      case 15:
        return WritingSections15();
      case 16:
        return WritingSections16();
      case 17:
        return WritingSections17();
      case 18:
        return WritingSections18();
      case 19:
        return WritingSections19();
      case 20:
        return WritingSections20();
      case 21:
        return WritingSections21();
      case 22:
        return WritingSections22();
      case 23:
        return WritingSections23();
      case 24:
        return WritingSections24();
      case 25:
        return WritingSections25();
      case 26:
        return WritingSections26();
      case 27:
        return WritingSections27();
      case 28:
        return WritingSections28();
      case 29:
        return WritingSections29();
      case 30:
        return WritingSections30();
      case 31:
        return WritingSection31();
      case 32:
        return WritingSection32();
      case 33:
        return WritingSection33();
      case 34:
        return WritingSection34();
      case 35:
        return WritingSection35();
      case 36:
        return WritingSection36();
      case 37:
        return WritingSection37();
      case 38:
        return WritingSection38();
      case 39:
        return WritingSection39();
      case 40:
        return WritingSection40();
      case 41:
        return WritingSection41();
      case 42:
        return WritingSection42();
      case 43:
        return WritingSection43();
      case 44:
        return WritingSection44();
      case 45:
        return WritingSection45();
      case 46:
        return WritingSection46();
      case 47:
        return WritingSection47();
      case 48:
        return WritingSection48();
      case 49:
        return WritingSection49();
      case 50:
        return WritingSection50();
      default:
        return WritingSections1(); // الافتراضي إذا حدث خطأ
    }
  }
}

