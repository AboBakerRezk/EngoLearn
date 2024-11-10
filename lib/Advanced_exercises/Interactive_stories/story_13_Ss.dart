import 'package:flutter/material.dart';

class StoryPage13 extends StatefulWidget {
  @override
  _StoryPage13State createState() => _StoryPage13State();
}

class _StoryPage13State extends State<StoryPage13> with SingleTickerProviderStateMixin {
  String storyText =
      'Liam loves snow, and he is very excited about the fresh snow outside. He can either build a snow fort, which would be a lot of work but also a lot of fun, or he can make a snowman, which might not take as long but would still be enjoyable. What should Liam do first?';

  String option1 = 'Liam thinks carefully and decides to build a snow fort because it will last longer, and he can play in it for days.';
  String option2 = 'Liam decides to make a snowman because he loves seeing the final result, and it makes him happy to create something that looks like a person.';

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
        'Liam starts building the snow fort by gathering as much snow as he can, making sure each wall is thick and sturdy. As he works, he imagines what it would be like to hide inside the fort during a snowball fight with his friends. Should Liam continue making the fort bigger, or should he stop and start decorating it?';

        option1 = 'Liam decides to continue building the fort bigger because he wants it to be the best fort he has ever made.';
        option2 = 'Liam stops building and starts decorating the fort with sticks and stones, thinking that it will make the fort look more like a castle.';
      } else if (choice == option2) {
        storyText =
        'Liam starts rolling snowballs to make the snowman, ensuring that each ball is perfectly round and smooth. As he stacks them on top of each other, he thinks about how he wants the snowman to look. Should Liam add a hat and scarf to the snowman, or should he find some twigs to use as arms?';

        option1 = 'Liam adds a hat and scarf to the snowman, making it look warm and cozy. He is proud of how friendly the snowman looks now.';
        option2 = 'Liam finds some twigs and sticks them into the sides of the snowman, creating arms that look like they are ready to give someone a hug.';
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
