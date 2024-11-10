import 'package:flutter/material.dart';

class StoryPage10 extends StatefulWidget {
  @override
  _StoryPage10State createState() => _StoryPage10State();
}

class _StoryPage10State extends State<StoryPage10> with SingleTickerProviderStateMixin {
  String storyText =
      'Sam was a little farmer who loved growing vegetables. One day, he wanted to plant something new. '
      'He found two kinds of seeds: carrot seeds and tomato seeds. '
      'Which seeds should Sam plant?';

  String option1 = 'Option 1: Plant carrot seeds.';
  String option2 = 'Option 2: Plant tomato seeds.';

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
        'Sam decided to plant carrot seeds. He watered them every day and watched them grow. '
            'After a few weeks, he saw green tops poking through the soil. '
            'Should he pick the carrots now or wait a bit longer?';

        option1 = 'Option 1: Pick the carrots now.';
        option2 = 'Option 2: Wait a bit longer.';
      } else if (choice == option2) {
        storyText =
        'Sam chose to plant tomato seeds. He cared for them every day, and soon he saw small tomatoes growing. '
            'Should he pick the tomatoes when they are green or wait until they are red?';

        option1 = 'Option 1: Pick them when they are green.';
        option2 = 'Option 2: Wait until they are red.';
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
