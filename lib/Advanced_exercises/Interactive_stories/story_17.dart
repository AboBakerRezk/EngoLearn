import 'package:flutter/material.dart';

class StoryPage17 extends StatefulWidget {
  @override
  _StoryPage17State createState() => _StoryPage17State();
}

class _StoryPage17State extends State<StoryPage17> {
  String storyText =
      'Ethan wakes up in a mysterious forest, surrounded by tall, ancient trees. The air is filled with the scent of pine, and the sound of a distant waterfall can be heard. '
      'He can’t remember how he got here, but he knows he needs to find a way out. In front of him, there are three paths: one leads deeper into the forest, another heads towards the sound of the waterfall, and the third seems to lead to an abandoned cabin. '
      'What should Ethan do first?';

  String option1 = 'Walk deeper into the forest.';
  String option2 = 'Head towards the waterfall.';
  String option3 = 'Investigate the abandoned cabin.';

  void _chooseOption(String choice) {
    setState(() {
      if (choice == option1) {
        storyText =
        'Ethan decides to walk deeper into the forest. The trees grow denser, and the light becomes dimmer. Suddenly, he hears a rustling noise nearby. '
            'He can either hide behind a large tree or continue walking carefully to investigate the noise. What should he do?';

        option1 = 'Hide behind a tree.';
        option2 = 'Investigate the noise.';
        option3 = 'Climb a tree for a better view.';
      } else if (choice == option2) {
        storyText =
        'Ethan heads towards the sound of the waterfall. The sound grows louder, and the mist in the air makes it hard to see. '
            'As he approaches, he notices a small, glowing object near the water’s edge. Should he pick up the object or ignore it and continue following the river downstream?';

        option1 = 'Pick up the glowing object.';
        option2 = 'Ignore it and follow the river.';
        option3 = 'Take a drink from the waterfall.';
      } else if (choice == option3) {
        storyText =
        'Ethan decides to investigate the abandoned cabin. The door creaks open, and the inside is dark and musty. He notices an old book on a table, and a trapdoor partially covered by a rug. '
            'Should he read the book, open the trapdoor, or search the room for other clues?';

        option1 = 'Read the book.';
        option2 = 'Open the trapdoor.';
        option3 = 'Search the room for other clues.';
      } else if (choice == 'Hide behind a tree.') {
        storyText =
        'Ethan quickly hides behind a tree. He hears footsteps approaching and sees a shadow moving closer. It’s a fox, looking for food. Ethan decides to wait until the fox leaves. '
            'Once it’s safe, he must choose whether to follow the fox, continue his path, or try to find a way back to the waterfall.';

        option1 = 'Follow the fox.';
        option2 = 'Continue his path.';
        option3 = 'Return to the waterfall.';
      } else if (choice == 'Investigate the noise.') {
        storyText =
        'Ethan decides to carefully approach the source of the noise. He moves quietly, and soon he sees a small creature trapped in a net. It’s a forest spirit. '
            'The spirit pleads for his help. Should Ethan free the spirit, leave it, or ask for something in return?';

        option1 = 'Free the spirit.';
        option2 = 'Leave it.';
        option3 = 'Ask for something in return.';
      } else if (choice == 'Climb a tree for a better view.') {
        storyText =
        'Ethan decides to climb a tall tree to get a better view of his surroundings. From the top, he sees smoke rising in the distance, a clearing with a strange circle of stones, and a path that seems to lead to a village. '
            'Should he head towards the smoke, investigate the stone circle, or take the path to the village?';

        option1 = 'Head towards the smoke.';
        option2 = 'Investigate the stone circle.';
        option3 = 'Take the path to the village.';
      }
      // Add more scenarios and choices here to continue the story
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
        child: SingleChildScrollView(
          child: ListView(
            children: <Widget>[
              Text(
                storyText,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black87,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // لون النص الأبيض
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // زوايا مستديرة
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // حجم الزر
                  elevation: 5, // ظل الزر
                ),
                onPressed: () => _chooseOption(option1),
                child: Text(option1),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // لون النص الأبيض
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // زوايا مستديرة
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // حجم الزر
                  elevation: 5, // ظل الزر
                ),
                onPressed: () => _chooseOption(option2),
                child: Text(option2),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // لون النص الأبيض
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // زوايا مستديرة
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // حجم الزر
                  elevation: 5, // ظل الزر
                ),
                onPressed: () => _chooseOption(option3),
                child: Text(option3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
