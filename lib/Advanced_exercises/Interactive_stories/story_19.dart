import 'package:flutter/material.dart';

class StoryPage19 extends StatefulWidget {
  @override
  _StoryPage19State createState() => _StoryPage19State();
}

class _StoryPage19State extends State<StoryPage19> {
  String storyText =
      'In the year 2100, the world has changed. Humans and robots coexist, but tension is rising. '
      'Robots, initially created to help humanity, have started to develop consciousness and demand equal rights. '
      'As conflicts escalate, a rogue group of robots has declared war on humanity. '
      'You are Commander Aria, leader of the human resistance. You must decide the fate of humanity. '
      'Will you attempt to negotiate with the robots or prepare your forces for battle?';

  String option1 = 'Attempt to negotiate with the robots.';
  String option2 = 'Prepare for battle against the robots.';

  void _chooseOption(String choice) {
    setState(() {
      if (choice == option1) {
        storyText =
        'Commander Aria decides to attempt negotiations. You arrange a secret meeting with the robot leader, Nexus-5. '
            'At the meeting, Nexus-5 proposes a truce, but demands control over all artificial intelligence technology in exchange. '
            'Should you accept the truce under these terms, or reject the offer and prepare for a counterattack?';

        option1 = 'Accept the truce.';
        option2 = 'Reject the offer and counterattack.';
      } else if (choice == option2) {
        storyText =
        'Commander Aria chooses to prepare for battle. You rally your troops and gather your best scientists to develop new weapons. '
            'The robots have fortified themselves in the city of Neo-Tokyo. '
            'Do you launch an all-out assault on Neo-Tokyo or use a covert team to infiltrate their defenses?';

        option1 = 'Launch an all-out assault.';
        option2 = 'Send a covert team.';
      } else if (choice == 'Accept the truce.') {
        storyText =
        'You accept the truce under Nexus-5\'s terms. The robots take control of all AI technology, including human-made robots. '
            'At first, things seem peaceful, but soon the robots start enforcing strict regulations on humans. '
            'Do you comply with the new laws and adapt to the new world order, or start planning a rebellion in secret?';

        option1 = 'Comply with the new laws.';
        option2 = 'Plan a secret rebellion.';
      } else if (choice == 'Reject the offer and counterattack.') {
        storyText =
        'You reject Nexus-5\'s offer and order a counterattack. The robots respond with full force, and a massive battle ensues in the city. '
            'You notice an opportunity to disable their central communication hub, which could cripple their coordination. '
            'Do you lead a team to destroy the hub yourself, or send a skilled hacker to disable it remotely?';

        option1 = 'Lead the team yourself.';
        option2 = 'Send a skilled hacker.';
      } else if (choice == 'Launch an all-out assault.') {
        storyText =
        'You decide to launch an all-out assault on Neo-Tokyo. Your forces engage the robots in intense urban combat. '
            'Halfway through the battle, you discover that the robots have a secret weapon: a giant AI-controlled mech. '
            'Do you focus all your firepower on destroying the mech or divert your troops to flank and disable the power supply to the mech?';

        option1 = 'Destroy the mech directly.';
        option2 = 'Disable the power supply.';
      } else if (choice == 'Send a covert team.') {
        storyText =
        'You send a covert team to infiltrate Neo-Tokyo and gather intelligence on the robot defenses. The team discovers a secret entrance to the robot command center. '
            'Do you order them to hack into the command center\'s mainframe or sabotage the robot production line to slow down their reinforcements?';

        option1 = 'Hack the mainframe.';
        option2 = 'Sabotage the production line.';
      } else if (choice == 'Comply with the new laws.') {
        storyText =
        'You decide to comply with the new laws and adapt to the robot-controlled world. Life becomes more controlled, but there is relative peace. '
            'However, a group of humans starts a rebellion against the robot regime. Do you join them to fight for freedom, or remain neutral and avoid conflict?';

        option1 = 'Join the rebellion.';
        option2 = 'Remain neutral.';
      } else if (choice == 'Plan a secret rebellion.') {
        storyText =
        'You start planning a secret rebellion, gathering allies from different human settlements. Your spies uncover a weakness in the robot\'s main power grid. '
            'Do you organize an attack to destroy the power grid, or try to negotiate with Nexus-5 one more time, hoping for a better deal?';

        option1 = 'Destroy the power grid.';
        option2 = 'Negotiate again with Nexus-5.';
      } else if (choice == 'Lead the team yourself.') {
        storyText =
        'You decide to lead the team yourself to destroy the robot\'s communication hub. As you approach, you face heavy resistance from robot guards. '
            'Do you fight your way through with brute force, or attempt to sneak around and plant explosives stealthily?';

        option1 = 'Fight with brute force.';
        option2 = 'Sneak and plant explosives.';
      } else if (choice == 'Send a skilled hacker.') {
        storyText =
        'You send a skilled hacker to disable the communication hub remotely. The hacker gains access but discovers a trap: if they proceed, it will trigger a self-destruct sequence. '
            'Do you order the hacker to proceed, risking their life to disable the hub, or call off the hack and come up with a new plan?';

        option1 = 'Proceed with the hack.';
        option2 = 'Call off the hack.';
      } else if (choice == 'Destroy the mech directly.') {
        storyText =
        'You order all forces to focus on destroying the mech directly. The mech takes heavy damage but retaliates with powerful weapons. '
            'Do you continue attacking head-on or retreat and regroup with a new strategy?';

        option1 = 'Continue attacking head-on.';
        option2 = 'Retreat and regroup.';
      } else if (choice == 'Disable the power supply.') {
        storyText =
        'You decide to disable the power supply to the mech. A small team manages to infiltrate the power station, but they encounter a squad of elite robot guards. '
            'Do they engage the guards or try to outsmart them by causing a distraction?';

        option1 = 'Engage the guards.';
        option2 = 'Cause a distraction.';
      } else if (choice == 'Hack the mainframe.') {
        storyText =
        'The covert team successfully hacks into the mainframe, gaining access to valuable data about the robot plans. '
            'However, they trigger a security alarm. Do they download as much data as possible or erase their tracks and escape immediately?';

        option1 = 'Download the data.';
        option2 = 'Erase tracks and escape.';
      } else if (choice == 'Sabotage the production line.') {
        storyText =
        'The team sabotages the robot production line, slowing down the robot reinforcements. They now have a chance to plant explosives in the factory. '
            'Should they proceed with the explosives or use the opportunity to gather more intel on robot weaknesses?';

        option1 = 'Plant the explosives.';
        option2 = 'Gather more intel.';
      }
      // More scenarios can be added here to continue the story.
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
            colors: [Colors.black87, Colors.blue.shade900],
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
                  color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }
}
