import 'package:flutter/material.dart';

class StoryPage7 extends StatefulWidget {
  @override
  _StoryPage7State createState() => _StoryPage7State();
}

class _StoryPage7State extends State<StoryPage7> with SingleTickerProviderStateMixin {
  String storyText =
      'It was a snowy day, and Emma wanted to play outside. '
      'She could either build a snowman or go sledding down a hill. '
      'What should Emma do first?';

  String option1 = 'Option 1: Build a snowman.';
  String option2 = 'Option 2: Go sledding down the hill.';

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.5, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _chooseOption(String choice) {
    setState(() {
      _controller.reset();
      _controller.forward();

      if (choice == option1) {
        storyText =
        'Emma decided to build a snowman. She rolled big snowballs and made a funny snowman with a carrot nose. '
            'Should she give the snowman a hat or make another snowman?';

        option1 = 'Option 1: Give the snowman a hat.';
        option2 = 'Option 2: Make another snowman.';
      } else if (choice == option2) {
        storyText =
        'Emma chose to go sledding down the hill. The snow was perfect, and she went very fast! '
            'Should she go down the hill again or try to make a snow angel?';

        option1 = 'Option 1: Go down the hill again.';
        option2 = 'Option 2: Make a snow angel.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.lightBlue.shade50], // خلفية متدرجة من الأبيض إلى الأزرق الفاتح جداً
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SlideTransition(
              position: _offsetAnimation,
              child: Text(
                storyText,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black87, // لون النص الأسود الفاتح لتباين جيد
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30), // مسافة بين النص والأزرار
            GestureDetector(
              onTap: () => _chooseOption(option1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.blue, // لون خلفية الزر الأزرق
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    option1,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // لون النص الأبيض
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _chooseOption(option2),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.blue, // لون خلفية الزر الأزرق
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    option2,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // لون النص الأبيض
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
