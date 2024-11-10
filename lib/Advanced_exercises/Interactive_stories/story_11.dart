import 'package:flutter/material.dart';

class StoryPage11 extends StatefulWidget {
  @override
  _StoryPage11State createState() => _StoryPage11State();
}

class _StoryPage11State extends State<StoryPage11> with SingleTickerProviderStateMixin {
  String storyText =
      'Once upon a time, in a small village at the edge of a mysterious forest, there was a young adventurer named Emily. '
      'Emily had always heard stories of a hidden treasure deep within the forest, guarded by an ancient dragon. One day, she decided to embark on a journey to find it. '
      'As she walked through the dense trees, she came across a fork in the road. One path seemed bright and inviting, with flowers lining its sides. The other was dark and covered in fog, with eerie noises echoing from within. '
      'What should Emily do?';

  String option1 = 'Option 1: Take the bright and inviting path.';
  String option2 = 'Option 2: Take the dark and foggy path.';

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

      // باقي الفروع المتعلقة بالقصة كما هو في الكود الأصلي
      if (choice == option1) {
        storyText =
        'Emily chose the bright and inviting path. As she walked, she felt a sense of calm and peace. '
            'Birds were singing, and the sun was shining. However, soon she reached a river with no bridge. '
            'On the other side, she could see a wise old man. Should she try to swim across or ask for the old man’s help?';

        option1 = 'Option 1: Try to swim across the river.';
        option2 = 'Option 2: Ask the old man for help.';
      } else if (choice == option2) {
        storyText =
        'Emily chose the dark and foggy path. The air was thick with mist, and strange shadows seemed to dance around her. '
            'Suddenly, she heard a growl behind her and turned to see a pair of glowing eyes staring back at her. '
            'Should she run back to the fork or confront the creature?';

        option1 = 'Option 1: Run back to the fork.';
        option2 = 'Option 2: Confront the creature.';
      }
      // بقية الخيارات والإجابات تتابع كما هي
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
