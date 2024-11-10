import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:mushaf25/Advanced/Reading/read_1.dart';
import 'package:mushaf25/Advanced/Reading/read_11.dart';
import 'package:mushaf25/Advanced/Reading/read_12.dart';
import 'package:mushaf25/Advanced/Reading/read_15.dart';
import 'package:mushaf25/Advanced/Reading/read_17.dart';
import 'package:mushaf25/Advanced/Reading/read_18.dart';
import 'package:mushaf25/Advanced/Reading/read_2.dart';
import 'package:mushaf25/Advanced/Reading/read_22.dart';
import 'package:mushaf25/Advanced/Reading/read_26.dart';
import 'package:mushaf25/Advanced/Reading/read_27.dart';
import 'package:mushaf25/Advanced/Reading/read_29.dart';
import 'package:mushaf25/Advanced/Reading/read_3.dart';
import 'package:mushaf25/Advanced/Reading/read_30.dart';
import 'package:mushaf25/Advanced/Reading/read_31.dart';
import 'package:mushaf25/Advanced/Reading/read_32.dart';
import 'package:mushaf25/Advanced/Reading/read_33.dart';
import 'package:mushaf25/Advanced/Reading/read_37.dart';
import 'package:mushaf25/Advanced/Reading/read_38.dart';
import 'package:mushaf25/Advanced/Reading/read_39.dart';
import 'package:mushaf25/Advanced/Reading/read_4.dart';
import 'package:mushaf25/Advanced/Reading/read_40.dart';
import 'package:mushaf25/Advanced/Reading/read_45.dart';
import 'package:mushaf25/Advanced/Reading/read_46.dart';
import 'package:mushaf25/Advanced/Reading/read_5.dart';
import 'package:mushaf25/Advanced/Reading/read_6.dart';
import 'package:mushaf25/Advanced/Reading/read_7.dart';
import 'package:mushaf25/Advanced/Reading/read_8.dart';
import 'package:mushaf25/Advanced/Reading/read_9.dart';
import 'package:mushaf25/Advanced/Reading/read_10.dart';
import 'package:mushaf25/Advanced/Reading/read_13.dart';
import 'package:mushaf25/Advanced/Reading/read_14.dart';
import 'package:mushaf25/Advanced/Reading/read_16.dart';
import 'package:mushaf25/Advanced/Reading/read_19.dart';
import 'package:mushaf25/Advanced/Reading/read_20.dart';
import 'package:mushaf25/Advanced/Reading/read_21.dart';
import 'package:mushaf25/Advanced/Reading/read_23.dart';
import 'package:mushaf25/Advanced/Reading/read_24.dart';
import 'package:mushaf25/Advanced/Reading/read_25.dart';
import 'package:mushaf25/Advanced/Reading/read_28.dart';
import 'package:mushaf25/Advanced/Reading/read_34.dart';
import 'package:mushaf25/Advanced/Reading/read_35.dart';
import 'package:mushaf25/Advanced/Reading/read_36.dart';

import 'package:mushaf25/Advanced/Reading/read_41.dart';
import 'package:mushaf25/Advanced/Reading/read_42.dart';
import 'package:mushaf25/Advanced/Reading/read_43.dart';
import 'package:mushaf25/Advanced/Reading/read_44.dart';

import 'package:mushaf25/Advanced/Reading/read_47.dart';
import 'package:mushaf25/Advanced/Reading/read_48.dart';
import 'package:mushaf25/Advanced/Reading/read_49.dart';
import 'package:mushaf25/Advanced/Reading/read_50.dart';





import '../../settings/setting_2.dart';

class ReadHome extends StatefulWidget {
  @override
  _ReadHomeState createState() => _ReadHomeState();
}

class _ReadHomeState extends State<ReadHome> {
  List<bool> _isButtonEnabled = List.generate(50, (index) => true); // جميع الأزرار مفعلة

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
        return ReadingAssessmentPage1();
      case 2:
        return ReadingAssessmentPage2();
      case 3:
        return ReadingAssessmentPage3();
      case 4:
        return ReadingAssessmentPage4();
      case 5:
        return ReadingAssessmentPage5();
      case 6:
        return ReadingAssessmentPage6();
      case 7:
        return ReadingAssessmentPage7();
      case 8:
        return ReadingAssessmentPage8();
      case 9:
        return ReadingAssessmentPage9();
      case 10:
        return ReadingAssessmentPage10();
      case 11:
        return ReadingAssessmentPage11();
      case 12:
        return ReadingAssessmentPage12();
      case 13:
        return ReadingAssessmentPage13();
      case 14:
        return ReadingAssessmentPage14();
      case 15:
        return ReadingAssessmentPage15();
      case 16:
        return ReadingAssessmentPage16();
      case 17:
        return ReadingAssessmentPage17();
      case 18:
        return ReadingAssessmentPage18();
      case 19:
        return ReadingAssessmentPage19();
      case 20:
        return ReadingAssessmentPage20();
      case 21:
        return ReadingAssessmentPage21();
      case 22:
        return ReadingAssessmentPage22();
      case 23:
        return ReadingAssessmentPage23();
      case 24:
        return ReadingAssessmentPage24();
      case 25:
        return ReadingAssessmentPage25();
      case 26:
        return ReadingAssessmentPage26();
      case 27:
        return ReadingAssessmentPage27();
      case 28:
        return ReadingAssessmentPage28();
      case 29:
        return ReadingAssessmentPage29();
      case 30:
        return ReadingAssessmentPage30();
      case 31:
        return ReadingAssessmentPage31();
      case 32:
        return ReadingAssessmentPage32();
      case 33:
        return ReadingAssessmentPage33();
      case 34:
        return ReadingAssessmentPage34();
      case 35:
        return ReadingAssessmentPage35();
      case 36:
        return ReadingAssessmentPage36();
      case 37:
        return ReadingAssessmentPage37();
      case 38:
        return ReadingAssessmentPage38();
      case 39:
        return ReadingAssessmentPage39();
      case 40:
        return ReadingAssessmentPage40();
      case 41:
        return ReadingAssessmentPage41();
      case 42:
        return ReadingAssessmentPage42();
      case 43:
        return ReadingAssessmentPage43();
      case 44:
        return ReadingAssessmentPage44();
      case 45:
        return ReadingAssessmentPage45();
      case 46:
        return ReadingAssessmentPage46();
      case 47:
        return ReadingAssessmentPage47();
      case 48:
        return ReadingAssessmentPage48();
      case 49:
        return ReadingAssessmentPage49();
      case 50:
        return ReadingAssessmentPage50();
      default:
        return ReadingAssessmentPage1(); // الافتراضي إذا حدث خطأ
    }
  }
}

