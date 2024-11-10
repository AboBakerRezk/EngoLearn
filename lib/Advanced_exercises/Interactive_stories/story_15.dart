import 'package:flutter/material.dart';

class StoryPage15 extends StatefulWidget {
  @override
  _StoryPage15State createState() => _StoryPage15State();
}

class _StoryPage15State extends State<StoryPage15> with SingleTickerProviderStateMixin {
  String storyText =
      'Liam loves snow more than anything else in the world. When he sees the first snowflakes falling from the sky, his heart fills with joy. '
      'Today is a special day; the ground is covered with a thick blanket of snow, perfect for playing outside. '
      'As he looks out of his window, he imagines all the fun he can have. He knows that he has two options: he could build a magnificent snow fort, '
      'or he could make a cheerful snowman that will greet everyone who passes by. What should Liam do first?';

  String option1 = 'Build a snow fort.';
  String option2 = 'Make a snowman.';

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
        'Liam decides to build a snow fort. He gathers snow and starts piling it up to create the walls of his fort. '
            'He carefully shapes the snow, making sure each wall is thick and strong. As he works, he imagines all the adventures he could have inside his fort. '
            'He thinks about adding different rooms, like a kitchen for making snow treats, and a living room for snowball fights with his friends. '
            'Liam decides to take a break and think about what to do next. Should he make the walls taller or start decorating the fort with sticks and stones?';

        option1 = 'Make the walls taller.';
        option2 = 'Decorate the fort.';
      } else if (choice == option2) {
        storyText =
        'Liam chooses to make a snowman. He starts by rolling a small snowball, letting it pick up more snow as it grows bigger and bigger. '
            'He makes three snowballs of different sizes and stacks them to form the body. '
            'He finds some buttons for eyes, a carrot for a nose, and a scarf to keep the snowman warm. '
            'He stands back to admire his creation, but then he wonders if the snowman needs more decorations. '
            'Should he add a hat, or maybe build a small snow family around it?';

        option1 = 'Add a hat.';
        option2 = 'Build a snow family.';
      } else if (choice == 'Make the walls taller.') {
        storyText =
        'Liam decides to make the walls even taller. He piles more snow on top, building the walls higher and higher. '
            'He imagines his friends being amazed by how tall his fort is. As he works, he starts to feel tired but also very proud of his progress. '
            'Just as he is about to finish, he notices a strange footprint near his fort. It looks like it could be from an animal. '
            'Should he follow the footprints to see where they lead, or stay and finish his fort?';

        option1 = 'Follow the footprints.';
        option2 = 'Stay and finish the fort.';
      } else if (choice == 'Decorate the fort.') {
        storyText =
        'Liam starts decorating his fort with sticks and stones he finds nearby. He adds some icicles around the edges to make it look like a real castle. '
            'He even finds an old flag from his house and decides to place it at the top of his fort. As he is decorating, a group of children comes by and asks if they can help. '
            'Should Liam let them help and make the fort even bigger, or should he keep it as his own special project?';

        option1 = 'Let them help.';
        option2 = 'Keep it as his project.';
      } else if (choice == 'Add a hat.') {
        storyText =
        'Liam finds an old hat in his house and puts it on the snowman’s head. The hat is a bit too big, but it makes the snowman look funny and friendly. '
            'As he looks at his snowman, he thinks it might need something more to make it stand out. '
            'Should Liam add some lights around the snowman or build a little fence around it to protect it from the wind?';

        option1 = 'Add some lights.';
        option2 = 'Build a fence.';
      } else if (choice == 'Build a snow family.') {
        storyText =
        'Liam decides to build a snow family. He makes a smaller snowman to be the snowman’s child and another one to be its friend. '
            'He finds different accessories for each one to give them unique personalities. Soon, he has a whole snow family standing in his yard. '
            'He feels very proud of his work, but then he hears a noise coming from behind the snow family. '
            'Should he go to investigate the noise, or stay and continue adding more details to the snow family?';

        option1 = 'Investigate the noise.';
        option2 = 'Continue adding details.';
      } else if (choice == 'Follow the footprints.') {
        storyText =
        'Liam decides to follow the footprints. He walks carefully, making sure not to lose the trail. The footprints lead him to a small grove of trees where he sees a little rabbit. '
            'The rabbit looks at Liam curiously, and he wonders if it might be hungry. Should Liam try to get closer and offer the rabbit some food, or should he quietly watch it from a distance?';

        option1 = 'Offer the rabbit food.';
        option2 = 'Watch from a distance.';
      } else if (choice == 'Stay and finish the fort.') {
        storyText =
        'Liam decides to stay and finish his fort. He works harder than ever, building the walls as high as he can. When he finally finishes, he steps back to admire his work. '
            'Just then, his friend Mia arrives and is amazed by the fort. She suggests they have a snowball fight. '
            'Should Liam agree to the snowball fight or invite Mia to help him improve the fort even more?';

        option1 = 'Agree to the snowball fight.';
        option2 = 'Invite Mia to help improve the fort.';
      } else if (choice == 'Let them help.') {
        storyText =
        'Liam decides to let the children help. They bring lots of creative ideas, and together they make the fort even more impressive. They add towers, windows, and even a snow throne inside. '
            'Liam feels happy that he shared the fun. After a while, they start to feel hungry. Should they go inside for some hot chocolate or stay outside and play more games in the snow?';

        option1 = 'Go inside for hot chocolate.';
        option2 = 'Stay outside and play more games.';
      } else if (choice == 'Keep it as his project.') {
        storyText =
        'Liam thanks the children for their offer, but decides to keep the fort as his own project. He spends more time perfecting the details, making sure every part is just as he imagined. '
            'After a while, he sees his neighbor’s dog running around and looks like it wants to play. Should Liam play with the dog or continue working on the fort?';

        option1 = 'Play with the dog.';
        option2 = 'Continue working on the fort.';
      } else if (choice == 'Offer the rabbit food.') {
        storyText =
        'Liam carefully reaches into his pocket and pulls out a small piece of bread he had saved from breakfast. He slowly approaches the rabbit, holding out his hand. '
            'The rabbit sniffs the air and cautiously hops closer. After a moment, it nibbles the bread from Liam’s hand. Liam feels a warm sense of happiness knowing he helped the little animal. '
            'Should Liam try to pet the rabbit or sit quietly and watch it?';

        option1 = 'Try to pet the rabbit.';
        option2 = 'Sit quietly and watch it.';
      } else if (choice == 'Watch from a distance.') {
        storyText =
        'Liam decides to stay still and quietly observe the rabbit from a distance. The rabbit hops around, searching for food in the snow. '
            'Liam notices how beautiful and delicate the rabbit is, and he feels a sense of peace watching it. After a while, the rabbit hops away. '
            'Liam wonders if he should follow the rabbit to see where it goes or head back to his fort and continue playing.';

        option1 = 'Follow the rabbit.';
        option2 = 'Go back to the fort.';
      } else if (choice == 'Agree to the snowball fight.') {
        storyText =
        'Liam agrees to the snowball fight, and Mia quickly gathers some snowballs. They start throwing snowballs at each other, laughing and running around. '
            'Liam feels his heart racing with excitement as he dodges Mia’s throws. After a while, they both get tired and sit down in the snow, panting and smiling. '
            'Should they take a break and build a snow fort together, or keep playing and challenge each other to a snowman-building contest?';

        option1 = 'Build a snow fort together.';
        option2 = 'Snowman-building contest.';
      } else if (choice == 'Invite Mia to help improve the fort.') {
        storyText =
        'Liam invites Mia to help him improve the fort. Together, they come up with new ideas and start building. Mia suggests adding a tunnel, and Liam thinks of making a secret exit. '
            'They work together, laughing and sharing ideas. The fort looks better than ever. After a while, they feel tired but happy. Should they go inside for some hot chocolate, or build a snowman next to the fort?';

        option1 = 'Go inside for hot chocolate.';
        option2 = 'Build a snowman next to the fort.';
      } else if (choice == 'Add some lights.') {
        storyText =
        'Liam decides to add some lights around the snowman. He finds a string of fairy lights in his house and carefully wraps them around the snowman. '
            'As it starts getting dark, the lights twinkle beautifully, making the snowman look magical. The neighbors notice and compliment Liam on his creativity. '
            'Should he build another snowman or invite his neighbors to help him create more snow decorations?';

        option1 = 'Build another snowman.';
        option2 = 'Invite neighbors to help.';
      } else if (choice == 'Build a fence.') {
        storyText =
        'Liam decides to build a little fence around the snowman to protect it from the wind. He gathers sticks and snow to create a small barrier. As he works, he feels a strong gust of wind and hears a strange noise. '
            'Should Liam investigate the noise, or finish building the fence and head back inside?';

        option1 = 'Investigate the noise.';
        option2 = 'Finish building the fence.';
      } else if (choice == 'Investigate the noise.') {
        storyText =
        'Liam decides to investigate the noise. He carefully walks towards the sound, making sure not to slip on the ice. As he gets closer, he sees that the noise is coming from a group of birds gathered around a tree. '
            'The birds seem to be chattering excitedly. Should Liam try to feed the birds or just watch them quietly?';

        option1 = 'Feed the birds.';
        option2 = 'Watch them quietly.';
      } else if (choice == 'Continue adding details.') {
        storyText =
        'Liam decides to continue adding details to the snow family. He adds buttons, hats, and scarves, making each snow person unique. The snow family starts to look very lively, and Liam feels proud of his creativity. '
            'As he finishes, he sees his friend Emma coming towards him with a big smile. Should Liam invite Emma to help build more snow people or suggest they go sledding down the hill?';

        option1 = 'Invite Emma to help build more snow people.';
        option2 = 'Suggest going sledding.';
      } else if (choice == 'Follow the rabbit.') {
        storyText =
        'Liam decides to follow the rabbit to see where it goes. He carefully steps through the snow, following the small tracks. The rabbit leads him to a small clearing where there is a burrow under a tree. '
            'Liam wonders if he should explore the area more or head back to his fort.';

        option1 = 'Explore the area.';
        option2 = 'Head back to the fort.';
      } else if (choice == 'Go back to the fort.') {
        storyText =
        'Liam decides to go back to the fort and continue playing. When he returns, he finds that his friend Jack has arrived. Jack is eager to build a snow slide next to the fort. '
            'Should Liam agree to build the snow slide or suggest building an igloo together?';

        option1 = 'Build a snow slide.';
        option2 = 'Build an igloo.';
      }
      // يمكن إضافة المزيد من الفروع والمسارات هنا لتطويل القصة.
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
            colors: [Colors.white, Colors.lightBlue.shade50],
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
                  color: Colors.black87,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () => _chooseOption(option1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.blue,
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
                      color: Colors.white,
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
                  color: Colors.blue,
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
                      color: Colors.white,
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
