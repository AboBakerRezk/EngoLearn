import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../Games/homes_Games/game_26.dart';
import '../Review.dart';
import '../lessons/lessons_1.dart';
import '../lessons/lessons_10.dart';
import '../lessons/lessons_11.dart';
import '../lessons/lessons_12.dart';
import '../lessons/lessons_13.dart';
import '../lessons/lessons_14.dart';
import '../lessons/lessons_15.dart';
import '../lessons/lessons_16.dart';
import '../lessons/lessons_17.dart';
import '../lessons/lessons_18.dart';
import '../lessons/lessons_19.dart';
import '../lessons/lessons_2.dart';
import '../lessons/lessons_20.dart';
import '../lessons/lessons_21.dart';
import '../lessons/lessons_22.dart';
import '../lessons/lessons_23.dart';
import '../lessons/lessons_24.dart';
import '../lessons/lessons_25.dart';
import '../lessons/lessons_3.dart';
import '../lessons/lessons_4.dart';
import '../lessons/lessons_5.dart';
import '../lessons/lessons_6.dart';
import '../lessons/lessons_7.dart';
import '../lessons/lessons_8.dart';
import '../lessons/lessons_9.dart';
import '../../settings/setting_2.dart';

class ButtonScreen extends StatefulWidget {
  @override
  _ButtonScreenState createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
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
            itemCount: 26,
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
        return Lessons1();
      case 2:
        return Lessons2();
      case 3:
        return Lessons3();
      case 4:
        return Lessons4();
      case 5:
        return Lessons5();
      case 6:
        return Lessons6();
      case 7:
        return Lessons7();
      case 8:
        return Lessons8();
      case 9:
        return Lessons9();
      case 10:
        return Lessons10();
      case 11:
        return Lessons11();
      case 12:
        return Lessons12();
      case 13:
        return Lessons13();
      case 14:
        return Lessons14();
      case 15:
        return Lessons15();
      case 16:
        return Lessons16();
      case 17:
        return Lessons17();
      case 18:
        return Lessons18();
      case 19:
        return Lessons19();
      case 20:
        return Lessons20();
      case 21:
        return Lessons21();
      case 22:
        return Lessons22();
      case 23:
        return Lessons23();
      case 24:
        return Lessons24();
      case 25:
        return Lessons25();
      case 26:
        return HomeGame26();
      default:
        return Lessons1(); // الافتراضي إذا حدث خطأ
    }
  }
}
