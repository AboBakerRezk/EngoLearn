import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class AnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A237E),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            painter: CurvedLinePainter(),
            child: Container(),
          ),
          ConfettiWidget(
            confettiController: ConfettiController(duration: const Duration(seconds: 1)),
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [Colors.red, Colors.blue, Colors.green, Colors.yellow],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width - 250,
            top: 150,
            child: ElevatedButton(
              onPressed: () {
                // تشغيل الزينة عند الضغط
                print('تم الضغط على زر مبتدئ');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 100),
                backgroundColor: Color(0xFF0D47A1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'مبتدئ',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
          ),
          Positioned(
            left: 70,
            top: 400,
            child: ElevatedButton(
              onPressed: () {
                // تشغيل الزينة عند الضغط
                print('تم الضغط على زر متوسط');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 100),
                backgroundColor: Color(0xFF0D47A1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'متوسط',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width - 250,
            top: 650,
            child: ElevatedButton(
              onPressed: () {
                // تشغيل الزينة عند الضغط
                print('تم الضغط على زر محترف');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 100),
                backgroundColor: Color(0xFF0D47A1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'محترف',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(size.width - 175, 200);
    path.quadraticBezierTo(size.width - 300, 300, 150, 450);
    path.quadraticBezierTo(0, 550, size.width - 175, 700);

    double dashWidth = 12, dashSpace = 12;
    double distance = 0.0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        canvas.drawPath(
            pathMetric.extractPath(distance, distance + dashWidth), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
