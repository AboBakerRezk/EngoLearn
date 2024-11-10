import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:mushaf25/Pages/profile.dart';

import '../settings/setting_2.dart';

class LanguageSelectionPage extends StatefulWidget {
  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  bool isLanguageSelected = false; // متغير للتحقق مما إذا تم اختيار لغة
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _animateText();
  }

  void _animateText() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLanguageSelected = true; // عند الضغط على الزر، يتم تغيير الحالة
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF13194E),
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    'عربي',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLanguageSelected = true; // عند الضغط على الزر، يتم تغيير الحالة
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF13194E),
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    'English',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
        Center(
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(seconds: 2),
            child: Text(
              "${AppLocale.S1.getString(context)}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),

            Spacer(),

            Center(
              child: TextButton(
                onPressed: isLanguageSelected
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfileForm()),
                  );                }
                    : null, // إذا لم يتم اختيار لغة، يبقى الزر معطل
                child: Text(
                  'next',
                  style: TextStyle(
                    fontSize: 25,
                    color: isLanguageSelected ? Colors.black : Colors.grey, // تغيير اللون بناءً على الحالة
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
