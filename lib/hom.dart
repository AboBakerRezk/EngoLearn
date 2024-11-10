import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mushaf25/Advanced/Listening/listen_e14.dart';
import 'package:mushaf25/Pages/plan.dart';
import 'package:mushaf25/Pages/profile.dart';
import 'package:mushaf25/settings/setting_2.dart';
import 'dart:math';

import 'package:mushaf25/Foundational_lessons/home_sady.dart';

import 'Advanced/Listening/hom_listen.dart';
import 'Advanced/Listening/listen_e.dart';
import 'Advanced/Listening/listen_e15.dart';
import 'Advanced/Listening/listen_e16.dart';
import 'Advanced/Reading/read_home.dart';
import 'Advanced/Writing/home_writing.dart';
import 'Foundational_lessons/Explanation_of_words/Explanation_of_words_3.dart';
import 'Foundational_lessons/lessons/lessons_1.dart';
import 'Robot_chat.dart';
import 'control/AI/Ropot_2.dart';
import 'control/control_level.dart';
import 'control/control_profile.dart';
import 'Advanced/tamarin.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';


import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import 'home_pay.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterBottleTask extends StatefulWidget {


  @override
  _WaterBottleTaskState createState() => _WaterBottleTaskState();
}

class _WaterBottleTaskState extends State<WaterBottleTask> with SingleTickerProviderStateMixin {

  List<bool> taskCompletion = List.generate(1500, (_) => false);

  late AnimationController _animationController;
  late Animation<double> _animation;

  int progressReading = 0;
  int progressListening = 0;
  int progressWriting = 0;
  int progressGrammar = 0;
  int progressSpeaking = 0; // New variable for Speaking progress
  int bottleLevel = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed || status == AnimationStatus.completed) {
        if (mounted) {
          setState(() {});
        }
      }
    });

    _animation = Tween<double>(begin: 0, end: pi * 2).animate(_animationController);

    loadProgressIndicators();
  }

  Future<void> saveProgressIndicators(
      int reading, int listening, int writing, int grammar, int speaking, int bottleLevel) async { // Added speaking parameter
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('progressReading', reading);
    await prefs.setInt('progressListening', listening);
    await prefs.setInt('progressWriting', writing);
    await prefs.setInt('progressGrammar', grammar);
    await prefs.setInt('progressSpeaking', speaking); // Save speaking progress
    await prefs.setInt('bottleLevel', bottleLevel);
  }

  Future<void> loadProgressIndicators() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      progressReading = prefs.getInt('progressReading') ?? 0;
      progressListening = prefs.getInt('progressListening') ?? 0;
      progressWriting = prefs.getInt('progressWriting') ?? 0;
      progressGrammar = prefs.getInt('progressGrammar') ?? 0;
      progressSpeaking = prefs.getInt('progressSpeaking') ?? 0; // Load speaking progress
      bottleLevel = prefs.getInt('bottleLevel') ?? 0;
    });
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 2.8),
        child: ClipPath(
          clipper: AppBarClipper(),
          child: AppBar(
            backgroundColor: Colors.indigo,
            flexibleSpace: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Spacer(),
                      Row(
                        children: [
                          buildProgressIndicator(Colors.green, progressGrammar, 500),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                          Text(
                            "${AppLocale.S55.getString(context)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        children: [
                          buildProgressIndicator(Colors.blue, progressReading, 500),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                          Text(
                            "${AppLocale.S120.getString(context)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        children: [
                          buildProgressIndicator(Colors.red, progressListening, 500),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                          Text(
                            "${AppLocale.S121.getString(context)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        children: [
                          buildProgressIndicator(Colors.orange, progressWriting, 500),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                          Text(
                            "${AppLocale.S35.getString(context)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        children: [
                          buildProgressIndicator(Colors.purple, progressSpeaking, 500), // Added Speaking progress
                          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                          Text(
                            "${AppLocale.S125.getString(context)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                  Spacer(),
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Stack(
                            children: [
                              ClipPath(
                                clipper: BottleClipper(),
                                child: CustomPaint(
                                  painter: WaterPainter(bottleLevel, 6000, _animation.value),
                                  child: Container(),
                                ),
                              ),
                              CustomPaint(
                                painter: BottlePainter(),
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w), // إضافة هامش جانبي
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch, // تمدد الأزرار عبر العرض
            children: [
              // أول زر
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    int tenPercent = (taskCompletion.length * 0.1).ceil();
                    Random random = Random();

                    int count = 0;
                    while (count < tenPercent) {
                      int index = random.nextInt(taskCompletion.length);
                      if (!taskCompletion[index]) {
                        taskCompletion[index] = true;
                        count++;
                      }
                    }
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ButtonScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF13194E),
                  padding: EdgeInsets.symmetric(vertical: 20.h), // ضبط الارتفاع النسبي
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    side: BorderSide(color: Colors.white, width: 2.w),
                  ),
                ),
                child: Text(
                  '${AppLocale.S26.getString(context)}',
                  style: TextStyle(fontSize: 28.sp, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h), // مسافة بين الأزرار

              // ثاني زر
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Tamarin()),
                  );

                  setState(() {
                    bottleLevel = (bottleLevel + 2).clamp(0, 10);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF13194E),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    side: BorderSide(color: Colors.white, width: 2.w),
                  ),
                ),
                child: Text(
                  '${AppLocale.S27.getString(context)}',
                  style: TextStyle(fontSize: 28.sp, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),

              // ثالث زر
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePay()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF13194E),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    side: BorderSide(color: Colors.white, width: 2.w),
                  ),
                ),
                child: Text(
                  '${AppLocale.S52.getString(context)}',
                  style: TextStyle(fontSize: 24.sp, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
// خامس زر
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen22()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF13194E),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    side: BorderSide(color: Colors.white, width: 2.w),
                  ),
                ),
                child: Text(
                  '${AppLocale.S128.getString(context)}',
                  style: TextStyle(fontSize: 28.sp, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),

              // رابع زر
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfileDisplay()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF13194E),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    side: BorderSide(color: Colors.white, width: 2.w),
                  ),
                ),
                child: Text(
                  '${AppLocale.S29.getString(context)}',
                  style: TextStyle(fontSize: 28.sp, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),


            ],
          ),
        ),
      ),   );
  }

  Widget buildProgressIndicator(Color color, int progress, int maxProgress) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5), // تعيين نصف قطر الحواف ليصبح نصف دائري
      child: Container(
        width: 200,  // ضبط عرض المؤشر
        height: 10,  // ضبط ارتفاع المؤشر
        child: LinearProgressIndicator(
          value: progress / maxProgress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 10, // تعيين ارتفاع المؤشر
        ),
      ),
    );
  }



}

class BottlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint bottlePaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    Path bottlePath = Path();
    bottlePath.moveTo(size.width * 0.25, 0);
    bottlePath.quadraticBezierTo(size.width * 0.15, size.height * 0.2,
        size.width * 0.15, size.height * 0.5);
    bottlePath.lineTo(size.width * 0.15, size.height * 0.85);
    bottlePath.quadraticBezierTo(size.width * 0.15, size.height, size.width * 0.3, size.height);
    bottlePath.lineTo(size.width * 0.7, size.height);
    bottlePath.quadraticBezierTo(size.width * 0.85, size.height, size.width * 0.85, size.height * 0.85);
    bottlePath.lineTo(size.width * 0.85, size.height * 0.5);
    bottlePath.quadraticBezierTo(size.width * 0.85, size.height * 0.2, size.width * 0.75, 0);
    bottlePath.close();

    canvas.drawShadow(bottlePath, Colors.black, 4, false);
    canvas.drawPath(bottlePath, bottlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class WaterPainter extends CustomPainter {
  final int completedTasks;
  final int totalTasks;
  final double waveAnimation;

  WaterPainter(this.completedTasks, this.totalTasks, this.waveAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colors = [
      Colors.red.withOpacity(0.7),
      Colors.orange.withOpacity(0.7),
      Colors.yellow.withOpacity(0.7),
      Colors.green.withOpacity(0.7),
      Colors.blue.withOpacity(0.7),
    ];

    double completionRatio = completedTasks / totalTasks;
    double totalHeight = size.height * completionRatio;
    Paint waterPaint = Paint()
      ..shader = LinearGradient(
        colors: colors,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).createShader(Rect.fromLTWH(0, size.height - totalHeight, size.width, totalHeight));

    Path waterPath = Path();
    for (double x = 0; x <= size.width; x++) {
      double waveHeight = sin((x / size.width * 2 * pi) + waveAnimation) * 6;
      if (x == 0) {
        waterPath.moveTo(x, size.height - totalHeight + waveHeight);
      } else {
        waterPath.lineTo(x, size.height - totalHeight + waveHeight);
      }
    }

    waterPath.lineTo(size.width, size.height);
    waterPath.lineTo(0, size.height);
    waterPath.close();

    canvas.drawPath(waterPath, waterPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BottleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.25, 0);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.2, size.width * 0.15, size.height * 0.5);
    path.lineTo(size.width * 0.15, size.height * 0.85);
    path.quadraticBezierTo(size.width * 0.15, size.height, size.width * 0.3, size.height);
    path.lineTo(size.width * 0.7, size.height);
    path.quadraticBezierTo(size.width * 0.85, size.height, size.width * 0.85, size.height * 0.85);
    path.lineTo(size.width * 0.85, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.85, size.height * 0.2, size.width * 0.75, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height - 10);
    path.quadraticBezierTo(size.width / 8, size.height, size.width / 4, size.height);
    path.lineTo(size.width * 3 / 4, size.height);
    path.quadraticBezierTo(size.width * 7 / 8, size.height, size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}




// import 'dart:math';
// import 'package:flutter/material.dart';
//
// class WaterBottleTask2 extends StatefulWidget {
//   @override
//   _WaterBottleTask2State createState() => _WaterBottleTask2State();
// }
//
// class _WaterBottleTask2State extends State<WaterBottleTask2>
//     with SingleTickerProviderStateMixin {
//   List<bool> taskCompletion = List.generate(40, (_) => false);
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     )..repeat(reverse: true);
//
//     _animationController.addStatusListener((status) {
//       if (status == AnimationStatus.dismissed || status == AnimationStatus.completed) {
//         if (mounted) {
//           setState(() {});
//         }
//       }
//     });
//
//     _animation = Tween<double>(begin: 0, end: pi * 2).animate(_animationController);
//   }
//
//   @override
//   void dispose() {
//     _animationController.stop();
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     int completedTasks = taskCompletion.where((task) => task).length;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Water Bottle Task Tracker"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 if (!mounted) return Container();
//                 return Center(
//                   child: Stack(
//                     children: [
//                       ClipPath(
//                         clipper: BottleClipper(),
//                         child: CustomPaint(
//                           painter: WaterPainter(completedTasks, taskCompletion.length, _animation.value),
//                           child: Container(
//                             width: 150,
//                             height: 400,
//                           ),
//                         ),
//                       ),
//                       CustomPaint(
//                         painter: BottlePainter(),
//                         child: Container(
//                           width: 150,
//                           height: 400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: taskCompletion.length,
//               itemBuilder: (context, index) {
//                 return CheckboxListTile(
//                   title: Text('Task ${index + 1}'),
//                   value: taskCompletion[index],
//                   onChanged: (bool? value) {
//                     if (mounted) {
//                       setState(() {
//                         taskCompletion[index] = value ?? false;
//                       });
//                     }
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class BottlePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint bottlePaint = Paint()
//       ..color = Colors.grey[300]!
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;
//
//     Path bottlePath = Path();
//     bottlePath.moveTo(size.width * 0.3, 0);
//     bottlePath.quadraticBezierTo(size.width * 0.2, size.height * 0.2, size.width * 0.2, size.height * 0.5);
//     bottlePath.lineTo(size.width * 0.2, size.height * 0.85);
//     bottlePath.quadraticBezierTo(size.width * 0.2, size.height, size.width * 0.35, size.height);
//     bottlePath.lineTo(size.width * 0.65, size.height);
//     bottlePath.quadraticBezierTo(size.width * 0.8, size.height, size.width * 0.8, size.height * 0.85);
//     bottlePath.lineTo(size.width * 0.8, size.height * 0.5);
//     bottlePath.quadraticBezierTo(size.width * 0.8, size.height * 0.2, size.width * 0.7, 0);
//     bottlePath.close();
//
//     canvas.drawShadow(bottlePath, Colors.black, 4, false);
//     canvas.drawPath(bottlePath, bottlePaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
//
// class WaterPainter extends CustomPainter {
//   final int completedTasks;
//   final int totalTasks;
//   final double waveAnimation;
//
//   WaterPainter(this.completedTasks, this.totalTasks, this.waveAnimation);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     List<Color> colors = [
//       Colors.red.withOpacity(0.7),
//       Colors.orange.withOpacity(0.7),
//       Colors.yellow.withOpacity(0.7),
//       Colors.green.withOpacity(0.7),
//       Colors.blue.withOpacity(0.7),
//     ];
//
//     double completionRatio = completedTasks / totalTasks;
//     double totalHeight = size.height * completionRatio;
//     Paint waterPaint = Paint()
//       ..shader = LinearGradient(
//         colors: colors,
//         begin: Alignment.bottomCenter,
//         end: Alignment.topCenter,
//       ).createShader(Rect.fromLTWH(0, size.height - totalHeight, size.width, totalHeight));
//
//     Path waterPath = Path();
//     for (double x = 0; x <= size.width; x++) {
//       double waveHeight = sin((x / size.width * 2 * pi) + waveAnimation) * 6;
//       if (x == 0) {
//         waterPath.moveTo(x, size.height - totalHeight + waveHeight);
//       } else {
//         waterPath.lineTo(x, size.height - totalHeight + waveHeight);
//       }
//     }
//
//     waterPath.lineTo(size.width, size.height);
//     waterPath.lineTo(0, size.height);
//     waterPath.close();
//
//     canvas.drawPath(waterPath, waterPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
//
// class BottleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(size.width * 0.3, 0);
//     path.quadraticBezierTo(size.width * 0.2, size.height * 0.2, size.width * 0.2, size.height * 0.5);
//     path.lineTo(size.width * 0.2, size.height * 0.85);
//     path.quadraticBezierTo(size.width * 0.2, size.height, size.width * 0.35, size.height);
//     path.lineTo(size.width * 0.65, size.height);
//     path.quadraticBezierTo(size.width * 0.8, size.height, size.width * 0.8, size.height * 0.85);
//     path.lineTo(size.width * 0.8, size.height * 0.5);
//     path.quadraticBezierTo(size.width * 0.8, size.height * 0.2, size.width * 0.7, 0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
