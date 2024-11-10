import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../hom.dart';
import '../../settings/setting_2.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _dropController;
  late Animation<double> _dropAnimation;

  late AnimationController _splashController;
  late Animation<double> _splashAnimation;

  late AnimationController _waterController;

  double _groundFillHeight = 0;
  final double _maxGroundFillHeight = 100;
  final double _groundIncrement = 10;

  Offset _splashPosition = Offset.zero;
  bool _showSplash = false;

  final List<String> _texts = [
    "مرحبًا بك في تطبيقنا لتعلم اللغة الإنجليزية! هنا، نهدف إلى تقديم تجربة تعليمية ممتعة وفعالة. بفضل أنشطتنا التفاعلية والمحتوى المتنوع، يمكنك تعزيز مهاراتك اللغوية بسهولة ويسر. انضم إلينا وابدأ رحلتك نحو إتقان اللغة الإنجليزية!",
    "هذه الألعاب تعزز الذاكرة اللغوية وتقوي الروابط العصبية اللازمة لتعلم الكلمات وتذكرها، مما يساعد في تفعيل منطقة الحُصين التي تلعب دورًا محوريًا في تشكيل الذاكرة طويلة المدى.",
    "على سبيل المثال، ألعاب الترجمة تعمل على سرعة الاسترجاع عبر تفعيل شبكة الدوائر العصبية الأمامية المسؤولة عن سرعة الاستجابة، بينما تعزز لعبة ملء الفراغات من تخزين الكلمات باستخدام الذاكرة العاملة.",
    "لعبة خمن تُنشّط قشرة الفص الجبهي للمساعدة في التحليل اللغوي، ولعبة ترتيب الحروف تحفز الذاكرة البصرية والدوائر العصبية البصرية.",
    "أما لعبة الذاكرة، فتعمل على تقوية المسارات بين الخلايا العصبية عبر اللدونة العصبية في الحصين. ألعاب التصويب والتوصيل تعزز التركيز عبر تحفيز قشرة الفص الجداري،",
    "وأخيراً، لعبة الاستماع تطور الفهم السمعي من خلال ربط الأصوات بالكلمات، مما يعزز تخزين واسترجاع المفردات بفعالية أكبر.",
    "في إطار رحلتك لتعلم اللغة الإنجليزية، نقدم لك 25 درسًا مصممًا بعناية لتغطية الأساسيات. كل درس يتضمن مجموعة متنوعة من الأنشطة التفاعلية التي تساعدك على تعزيز مهاراتك في الاستماع، القراءة، الكتابة، والمحادثة. من خلال استخدام تمارين ممتعة وتحديات متنوعة،",
    " نسعى لتوفير تجربة تعليمية شاملة وفعالة، تساعدك على بناء قاعدة قوية في اللغة الإنجليزية. انطلق في هذه المغامرة التعليمية واستمتع بتعلم الأساسيات بطريقة جديدة ومبتكرة!",
    "في تطبيقنا، نؤمن بأن تتبع تقدمك هو جزء أساسي من تجربة التعلم. لذلك، نقدم لك ميزة فريدة لمتابعة تقدمك بشكل دوري. ستحصل على تقارير مفصلة حول المهارات التي تحسنت بها، والتمارين التي أنجزتها، والدرجات التي حققتها في كل نشاط. من خلال هذه الميزة، يمكنك رؤية التطورات التي تحققها بمرور الوقت، مما يعزز من ثقتك بنفسك ويدفعك للاستمرار في التعلم. انضم إلينا وابدأ رحلتك نحو إتقان اللغة الإنجليزية بينما نساعدك في رصد إنجازاتك!",

  ];


  final List<IconData> _icons = [
    FontAwesomeIcons.rocket,            // أيقونة الانطلاق للترحيب ببدء التعلم
    FontAwesomeIcons.brain,             // أيقونة الدماغ لتعزيز الذاكرة
    FontAwesomeIcons.language,          // أيقونة اللغة لألعاب الترجمة
    FontAwesomeIcons.puzzlePiece,       // أيقونة اللغز لألعاب التحليل وترتيب الحروف
    FontAwesomeIcons.memory,            // أيقونة الذاكرة لتعزيز مسارات الذاكرة العصبية
    FontAwesomeIcons.headphones,        // أيقونة سماعات الرأس للعبة الاستماع
    FontAwesomeIcons.book,              // أيقونة الكتاب لتمثيل الدروس التفاعلية
    FontAwesomeIcons.solidStar,         // أيقونة النجمة للتجربة التعليمية الفعالة
    FontAwesomeIcons.chartLine,         // أيقونة تقدم متابعة التقدم في التعلم
  ];

  int _currentTextIndex = 0;
  bool _showText = true;

  @override
  void initState() {
    super.initState();

    _dropController = AnimationController(
      duration: Duration(milliseconds: 6000),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Size screenSize = MediaQuery.of(context).size;
      double waterTopLevel = screenSize.height * 0.15;

      _dropAnimation = Tween<double>(begin: waterTopLevel, end: screenSize.height - _groundFillHeight)
          .animate(CurvedAnimation(parent: _dropController, curve: Curves.linear))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _handleDropCompletion();
          }
        });

      _startDropAnimation();
    });

    _splashController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _splashAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _splashController, curve: Curves.decelerate),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showSplash = false;
        });
        _splashController.reset();
      }
    });

    _waterController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTextAnimation();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _dropController.dispose();
    _splashController.dispose();
    _waterController.dispose();
    super.dispose();
  }

  void _startDropAnimation() {
    _dropController.forward(from: 0);
  }

  void _handleDropCompletion() {
    setState(() {
      _groundFillHeight += _groundIncrement;
      if (_groundFillHeight > _maxGroundFillHeight) {
        _groundFillHeight = _maxGroundFillHeight;
      }
    });

    setState(() {
      _splashPosition = Offset(55, _groundFillHeight);
      _showSplash = true;
    });

    _splashController.forward(from: 0).then((_) {
      if (_groundFillHeight < _maxGroundFillHeight) {
        Future.delayed(Duration(milliseconds: 500), () {
          _startDropAnimation();
        });
      }
    });
  }

  void _startTextAnimation() {
    setState(() {
      _showText = true;
    });

    int typingDuration = 100 * _texts[_currentTextIndex].length;

    Future.delayed(Duration(milliseconds: typingDuration), () {
      Future.delayed(Duration(seconds: 5), () {
        _onTextFinished();
      });
    });
  }

  void _onTextFinished() {
    setState(() {
      _showText = false;
      _currentTextIndex++;
    });

    if (_currentTextIndex < _texts.length) {
      Future.delayed(Duration(milliseconds: 500), () {
        _startTextAnimation();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _waterController,
              builder: (context, child) {
                return CustomPaint(
                  painter: WaterPainter(_waterController.value),
                  child: Container(),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _waterController,
              builder: (context, child) {
                return CustomPaint(
                  painter: GroundWaterPainter(_waterController.value, _groundFillHeight),
                  child: Container(),
                );
              },
            ),
          ),
          _dropAnimation != null
              ? AnimatedBuilder(
            animation: _dropAnimation,
            builder: (context, child) {
              return Positioned(
                top: _dropAnimation.value,
                right: 30,
                child: Icon(
                  Icons.water_drop,
                  size: 50,
                  color: Colors.blueAccent,
                ),
              );
            },
          )
              : Container(),
          _showSplash
              ? AnimatedBuilder(
            animation: _splashAnimation,
            builder: (context, child) {
              return Positioned(
                bottom: _splashPosition.dy,
                right: _splashPosition.dx,
                child: CustomPaint(
                  painter: SplashPainter(_splashAnimation.value),
                  child: Container(),
                ),
              );
            },
          )
              : Container(),
          Center(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_showText && _currentTextIndex < _texts.length)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _icons[_currentTextIndex % _icons.length],
                          size: 80,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(height: 20),
                        TypeWriterText(
                          repeat: false,
                          text: Text(
                            _texts[_currentTextIndex],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          duration: Duration(milliseconds: 100),
                        ),
                      ],
                    )
                  else if (_currentTextIndex >= _texts.length)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsScreen()),
                        );                         },
                      child: Text(
                        "البداية",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),

                      ),
                    ),
                ],
              ),
            ),
          ),
          // زر الخروج في الأعلى
          Positioned(
            top: 10,
            right: 20,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );               },
            ),
          ),
        ],
      ),
    );
  }
}

// الرسومات الخاصة بتأثيرات الماء والرذاذ
class WaterPainter extends CustomPainter {
  final double animationValue;

  WaterPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blueAccent.withOpacity(0.6);
    final path = Path();

    path.moveTo(0, size.height * 0.15);
    for (double i = 0; i <= size.width; i += 20) {
      path.quadraticBezierTo(
        i + 10,
        size.height * 0.15 + 10 * sin((i / size.width * 2 * pi) + (animationValue * 2 * pi)),
        i + 20,
        size.height * 0.15,
      );
    }
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class GroundWaterPainter extends CustomPainter {
  final double animationValue;
  final double groundFillHeight;

  GroundWaterPainter(this.animationValue, this.groundFillHeight);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blueAccent.withOpacity(0.6);
    final path = Path();

    path.moveTo(0, size.height - groundFillHeight);
    for (double i = 0; i <= size.width; i += 20) {
      path.quadraticBezierTo(
        i + 10,
        size.height - groundFillHeight + 5 * sin((i / size.width * 2 * pi) + (animationValue * 2 * pi)),
        i + 20,
        size.height - groundFillHeight,
      );
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class SplashPainter extends CustomPainter {
  final double animationValue;

  SplashPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blueAccent.withOpacity(1 - animationValue)
      ..style = PaintingStyle.fill;

    final double rippleRadius = 30 * animationValue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawCircle(Offset(0, 0), rippleRadius, paint);

    paint.style = PaintingStyle.fill;
    final List<double> yOffsets = [-20, -35, -50];

    for (double yOffset in yOffsets) {
      double gravityEffect = yOffset * animationValue - (0.5 * 9.8 * pow(animationValue, 2));
      canvas.drawCircle(Offset(0, gravityEffect), 5 * (1 - animationValue), paint);
    }
  }

  @override
  bool shouldRepaint(SplashPainter oldDelegate) => oldDelegate.animationValue != animationValue;
}


