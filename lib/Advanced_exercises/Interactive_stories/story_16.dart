import 'package:flutter/material.dart';

class StoryPage16 extends StatefulWidget {
  @override
  _StoryPage16State createState() => _StoryPage16State();
}

class _StoryPage16State extends State<StoryPage16> {
  String storyText =
      'Adam was on an expedition in the snowy mountains, enjoying the serene white landscape. However, a sudden blizzard began to rage, and he found himself in the middle of nowhere, surrounded by ice and snow. He quickly realized that he had lost his way and was completely alone in the frozen wilderness.';

  String option1 = 'Search for a nearby shelter.';
  String option2 = 'Try to start a fire to keep warm.';
  String option3 = 'Head downhill in search of any sign of life.';

  void _chooseOption(String choice) {
    setState(() {
      if (choice == option1) {
        storyText =
        'Adam decides to search for a nearby shelter. After walking for a while, he finds a small cave. Should he enter the cave or continue searching for another shelter?';

        option1 = 'Enter the cave.';
        option2 = 'Continue searching.';
        option3 = 'Build a temporary shelter outside.';
      } else if (choice == option2) {
        storyText =
        'Adam decides to try to start a fire to keep warm. He gathers some dry wood and uses a flint to spark a flame. However, the wind is strong and keeps blowing the flame out. Should he find a windbreak or try another method?';

        option1 = 'Find a windbreak.';
        option2 = 'Use some of his clothes to protect the flame.';
        option3 = 'Look for a more sheltered spot.';
      } else if (choice == option3) {
        storyText =
        'Adam heads downhill in search of any sign of life. As he walks, he spots a distant light flickering through the trees. Should he head towards the light or continue moving downhill?';

        option1 = 'Head towards the light.';
        option2 = 'Continue moving downhill.';
        option3 = 'Set up camp and wait until morning.';
      } else if (choice == 'Enter the cave.') {
        storyText =
        'Adam enters the cave. Inside, he finds old traces left by previous explorers. The cave goes deeper into the mountain. Should he explore the cave further or stay near the entrance?';

        option1 = 'Explore deeper into the cave.';
        option2 = 'Stay near the entrance.';
        option3 = 'Mark the entrance and exit to explore safely.';
      } else if (choice == 'Continue searching.') {
        storyText =
        'Adam decides to continue searching. He spots a large tree and decides to check if it can offer shelter. Should he check around the tree for safety or move towards the sound of water?';

        option1 = 'Check around the tree.';
        option2 = 'Move towards the sound of water.';
        option3 = 'Climb the tree to get a better view.';
      } else if (choice == 'Build a temporary shelter outside.') {
        storyText =
        'Adam begins building a temporary shelter using branches and snow. The temperature drops rapidly. Should he hurry up and finish the shelter or look for another way to stay warm?';

        option1 = 'Hurry and finish the shelter.';
        option2 = 'Find another way to stay warm.';
        option3 = 'Use some of his clothes to add insulation.';
      } else if (choice == 'Find a windbreak.') {
        storyText =
        'Adam finds a windbreak behind a large rock. He successfully lights the fire, but the smoke starts attracting animals. Should he extinguish the fire or stay ready to defend himself?';

        option1 = 'Extinguish the fire.';
        option2 = 'Stay ready to defend himself.';
        option3 = 'Move to a safer location.';
      } else if (choice == 'Use some of his clothes to protect the flame.') {
        storyText =
        'Adam sacrifices some of his clothes to keep the flame burning. The fire grows, but now he is colder. Should he keep the fire going or try another method to stay warm?';

        option1 = 'Keep the fire going.';
        option2 = 'Try another method to stay warm.';
        option3 = 'Look for shelter nearby.';
      } else if (choice == 'Head towards the light.') {
        storyText =
        'Adam heads towards the light. As he approaches, he realizes it’s coming from an old cabin. Should he knock on the door or peek through the window?';

        option1 = 'Knock on the door.';
        option2 = 'Peek through the window.';
        option3 = 'Check around the cabin for signs of life.';
      } else if (choice == 'Continue moving downhill.') {
        storyText =
        'Adam continues moving downhill. The snow becomes deeper and harder to walk through. Should he keep going or try to find a safer path?';

        option1 = 'Keep going.';
        option2 = 'Find a safer path.';
        option3 = 'Rest and regain strength.';
      } else if (choice == 'Set up camp and wait until morning.') {
        storyText =
        'Adam decides to set up camp and wait until morning. He finds a sheltered spot and tries to make himself comfortable. Should he try to sleep or stay awake and keep watch?';

        option1 = 'Try to sleep.';
        option2 = 'Stay awake and keep watch.';
        option3 = 'Start a fire to stay warm.';
      } else if (choice == 'Explore deeper into the cave.') {
        storyText =
        'Adam decides to explore deeper into the cave. As he ventures further, he hears strange noises echoing from the darkness. Should he continue or turn back?';

        option1 = 'Continue exploring.';
        option2 = 'Turn back to the entrance.';
        option3 = 'Mark his path as he goes.';
      } else if (choice == 'Stay near the entrance.') {
        storyText =
        'Adam stays near the entrance of the cave. The wind outside howls loudly, and he starts to feel cold. Should he try to build a fire or use his remaining energy to block the wind?';

        option1 = 'Build a fire.';
        option2 = 'Block the wind.';
        option3 = 'Search for something to keep warm.';
      } else if (choice == 'Mark the entrance and exit to explore safely.') {
        storyText =
        'Adam decides to mark the entrance and exit before exploring deeper into the cave. This way, he can find his way back easily. As he ventures deeper, the cave starts to narrow. Should he squeeze through or turn back?';

        option1 = 'Squeeze through the narrow passage.';
        option2 = 'Turn back to the entrance.';
        option3 = 'Try to find another route.';
      } else if (choice == 'Check around the tree.') {
        storyText =
        'Adam checks around the tree for safety. He finds a small hollow at the base, which might offer some protection. Should he rest here or continue searching for better shelter?';

        option1 = 'Rest in the hollow.';
        option2 = 'Continue searching.';
        option3 = 'Use branches to reinforce the hollow.';
      } else if (choice == 'Move towards the sound of water.') {
        storyText =
        'Adam decides to move towards the sound of water. He finds a partially frozen stream. Should he follow the stream or try to use the water for hydration?';

        option1 = 'Follow the stream.';
        option2 = 'Use the water for hydration.';
        option3 = 'Set up camp near the stream.';
      } else if (choice == 'Climb the tree to get a better view.') {
        storyText =
        'Adam decides to climb the tree to get a better view. From the top, he sees a faint trail leading through the woods. Should he follow the trail or stay put?';

        option1 = 'Follow the trail.';
        option2 = 'Stay put.';
        option3 = 'Use the height to scout for more shelter.';
      }
      // Continue adding branches to expand the story further
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
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                onPressed: () => _chooseOption(option1),
                child: Text(
                  option1,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                onPressed: () => _chooseOption(option2),
                child: Text(
                  option2,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                onPressed: () => _chooseOption(option3),
                child: Text(
                  option3,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
