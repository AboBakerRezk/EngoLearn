import 'package:flutter/material.dart';

class StoryPage12 extends StatefulWidget {
  @override
  _StoryPage12State createState() => _StoryPage12State();
}

class _StoryPage12State extends State<StoryPage12> with SingleTickerProviderStateMixin {
  String storyText =
      'Once upon a time, in an ancient city by the sea, there was a young boy named Ali. '
      'Ali had always heard tales of a hidden treasure deep within the ocean, guarded by a giant whale. One day, he decided to embark on an adventure to find it himself. '
      'As he walked along the shore, he found a small boat resting on the sand, and not far away, he saw an old, rusty submarine that looked quite unsafe. '
      'What should Ali do?';

  String option1 = 'Option 1: Use the small boat to sail.';
  String option2 = 'Option 2: Enter the old submarine and explore.';

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
        'Ali chose to use the small boat to sail. As he rowed further into the sea, the waves began to grow stronger. '
            'Soon, he saw a dolphin swimming alongside his boat, guiding him toward a mysterious island. '
            'Should he follow the dolphin or continue sailing in the open sea?';

        option1 = 'Option 1: Follow the dolphin.';
        option2 = 'Option 2: Continue sailing in the open sea.';
      } else if (choice == option2) {
        storyText =
        'Ali decided to enter the old submarine. As he descended into the dark depths, he heard strange creaking noises and water dripping from the ceiling. '
            'Suddenly, he noticed a map on the control panel that seemed to lead to an underwater cave. '
            'Should he follow the map or try to surface and leave the submarine?';

        option1 = 'Option 1: Follow the map to the underwater cave.';
        option2 = 'Option 2: Surface and leave the submarine.';
      }
      // يمكن إضافة المزيد من الفروع والمسارات حسب الحاجة هنا لتطويل القصة
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
