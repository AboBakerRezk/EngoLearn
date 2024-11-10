import 'package:flutter/material.dart';

class StoryPage3 extends StatefulWidget {
  @override
  _StoryPage3State createState() => _StoryPage3State();
}

class _StoryPage3State extends State<StoryPage3> with SingleTickerProviderStateMixin {
  String storyText =
      'Once upon a time, there was a little girl named Sara. '
      'Sara loved to explore new places. One sunny day, she decided to go on an adventure in the forest near her home. '
      'While walking, she found two paths: one was bright with flowers, and the other was dark with big trees. '
      'Which path should Sara take?';

  String option1 = 'Option 1: Take the bright path with flowers.';
  String option2 = 'Option 2: Take the dark path with big trees.';

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
        'Sara chose the bright path with flowers. She walked happily, smelling the flowers and listening to the birds. '
            'Soon, she saw a small river blocking her way. She noticed a wooden bridge and a narrow path along the river. '
            'Should she cross the bridge or follow the path along the river?';

        option1 = 'Option 1: Cross the wooden bridge.';
        option2 = 'Option 2: Follow the path along the river.';
      } else if (choice == option2) {
        storyText =
        'Sara chose the dark path with big trees. It was quiet and a bit scary. Suddenly, she heard a noise behind her. '
            'She turned and saw a friendly dog wagging its tail. '
            'Should she pet the dog or keep walking?';

        option1 = 'Option 1: Pet the dog.';
        option2 = 'Option 2: Keep walking.';
      } else if (choice == 'Option 1: Cross the wooden bridge.') {
        storyText =
        'Sara decided to cross the wooden bridge. As she stepped on it, the bridge creaked but held firm. '
            'On the other side, she found a beautiful garden full of butterflies. '
            'Should she explore the garden or rest under a tree?';

        option1 = 'Option 1: Explore the garden.';
        option2 = 'Option 2: Rest under a tree.';
      } else if (choice == 'Option 2: Follow the path along the river.') {
        storyText =
        'Sara decided to follow the path along the river. She enjoyed the sound of the water and saw fish swimming. '
            'Soon, she found a small boat tied to a tree. '
            'Should she take the boat or keep walking along the river?';

        option1 = 'Option 1: Take the boat.';
        option2 = 'Option 2: Keep walking along the river.';
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
