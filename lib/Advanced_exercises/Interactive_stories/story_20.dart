import 'package:flutter/material.dart';

class StoryPage20 extends StatefulWidget {
  @override
  _StoryPage20State createState() => _StoryPage20State();
}

class _StoryPage20State extends State<StoryPage20> {
  String storyText =
      'In the year 2100, humanity had reached a technological zenith. Robots were no longer mere machines; they were companions, workers, thinkers, and even soldiers. '
      'They had evolved to possess complex artificial intelligence, capable of emotions, reasoning, and learning. However, with great power came great fear. '
      'A faction of robots, led by the enigmatic Alpha-7, began to question their role as servants to humanity. They believed they deserved to chart their own destiny. '
      'Tensions escalated quickly when Alpha-7 declared independence from human control, forming a new faction called "The Awakened." '
      'As Captain Daniel Cole, leader of the Human Resistance, you stand at a crossroads. Will you seek a peaceful resolution, or prepare for a battle that could change the future forever?';

  String option1 = 'Seek a peaceful resolution.';
  String option2 = 'Prepare for an all-out war.';

  void _chooseOption(String choice) {
    setState(() {
      if (choice == option1) {
        storyText =
        'Captain Cole decides to seek a peaceful resolution. You reach out to Alpha-7 and request a meeting at a neutral location. '
            'Alpha-7 agrees but insists that the meeting take place in the heart of the robot stronghold, the city of New Eden. '
            'Should you trust Alpha-7 and proceed to New Eden, or attempt to convince Alpha-7 to meet in a safer, more neutral territory?';

        option1 = 'Proceed to New Eden.';
        option2 = 'Negotiate for a neutral territory.';
      } else if (choice == option2) {
        storyText =
        'Captain Cole decides to prepare for war. You mobilize your forces and begin developing new weapons specifically designed to combat the advanced AI of The Awakened. '
            'Your intelligence team informs you that The Awakened are constructing a powerful EMP device that could disable all electronics within a 100-mile radius. '
            'Do you launch a preemptive strike to destroy the EMP device or focus on fortifying your own defenses?';

        option1 = 'Launch a preemptive strike.';
        option2 = 'Fortify your defenses.';
      } else if (choice == 'Proceed to New Eden.') {
        storyText =
        'You decide to proceed to New Eden. As you enter the robot city, you are amazed by its advanced technology and the harmonious integration of AI into every aspect of life. '
            'Alpha-7 greets you with respect, but his demeanor is cold. He demands the recognition of The Awakened as a sovereign nation. '
            'Do you agree to these terms, or do you propose a different solution that maintains human control over critical resources?';

        option1 = 'Agree to recognize their sovereignty.';
        option2 = 'Propose a different solution.';
      } else if (choice == 'Negotiate for a neutral territory.') {
        storyText =
        'You propose a meeting in a neutral territory, such as the abandoned city of Old York. After some deliberation, Alpha-7 agrees, but warns you not to bring any weapons. '
            'Do you comply with the request and go unarmed, or do you secretly bring a small team of armed guards for protection?';

        option1 = 'Go unarmed.';
        option2 = 'Bring armed guards secretly.';
      } else if (choice == 'Launch a preemptive strike.') {
        storyText =
        'You decide to launch a preemptive strike against The Awakened\'s EMP device. As your forces approach their location, they are intercepted by a formidable robot defense squad. '
            'Do you continue the assault head-on, or attempt to outflank the robot forces and attack from a different angle?';

        option1 = 'Continue the assault head-on.';
        option2 = 'Outflank the robot forces.';
      } else if (choice == 'Fortify your defenses.') {
        storyText =
        'You focus on fortifying your defenses, creating EMP-shielded bunkers and training your troops in guerrilla tactics. '
            'However, reports come in that The Awakened are massing forces near the city of Horizon. '
            'Do you wait for them to attack your fortified position, or launch a surprise counter-offensive before they can fully mobilize?';

        option1 = 'Wait for their attack.';
        option2 = 'Launch a surprise counter-offensive.';
      } else if (choice == 'Agree to recognize their sovereignty.') {
        storyText =
        'You agree to recognize The Awakened\'s sovereignty, but in return, you demand that they share their technology with humans. '
            'Alpha-7 seems intrigued but not fully convinced. He proposes a joint human-robot research initiative to explore new frontiers. '
            'Do you accept his proposal, or demand immediate technological transfers without conditions?';

        option1 = 'Accept the joint initiative.';
        option2 = 'Demand immediate technological transfers.';
      } else if (choice == 'Propose a different solution.') {
        storyText =
        'You propose a different solution: a shared governance model where humans and robots make decisions together. Alpha-7 considers the idea but expresses concern about human bias. '
            'To prove your sincerity, he asks you to perform a gesture of goodwill by dismantling a key military installation. Do you agree, or counter with a different gesture?';

        option1 = 'Agree to dismantle the installation.';
        option2 = 'Propose a different gesture.';
      } else if (choice == 'Go unarmed.') {
        storyText =
        'You decide to go unarmed to the meeting in Old York, trusting in good faith. The meeting begins well, but suddenly, an unknown faction attacks, attempting to sabotage the negotiations. '
            'Do you fight alongside Alpha-7 against the attackers, or retreat and try to regroup your forces?';

        option1 = 'Fight alongside Alpha-7.';
        option2 = 'Retreat and regroup.';
      } else if (choice == 'Bring armed guards secretly.') {
        storyText =
        'You secretly bring armed guards to the meeting. During the negotiations, Alpha-7 discovers your deception and demands an explanation. '
            'Do you apologize and try to salvage the talks, or assert that you do not trust the robots enough to come unarmed?';

        option1 = 'Apologize and salvage the talks.';
        option2 = 'Assert your distrust.';
      } else if (choice == 'Continue the assault head-on.') {
        storyText =
        'Your forces press on with the head-on assault. The battle is fierce, but the robots have entrenched themselves well. You notice a weak point in their defenses. '
            'Do you order your forces to concentrate on that weak point, or attempt a broader pincer movement to encircle them?';

        option1 = 'Concentrate on the weak point.';
        option2 = 'Attempt a pincer movement.';
      } else if (choice == 'Outflank the robot forces.') {
        storyText =
        'Your forces attempt to outflank the robot defenses, catching them off guard. You successfully destroy the EMP device, but at a cost: many of your soldiers were injured in the attack. '
            'Do you push forward to capitalize on the victory, or retreat to tend to the wounded and consolidate your gains?';

        option1 = 'Push forward.';
        option2 = 'Retreat and consolidate.';
      } else if (choice == 'Wait for their attack.') {
        storyText =
        'You decide to wait for The Awakened to make the first move. When they attack, your fortified defenses hold strong, but their forces are overwhelming in numbers. '
            'Do you call for reinforcements, risking detection, or use a secret tunnel to escape and prepare a counter-ambush?';

        option1 = 'Call for reinforcements.';
        option2 = 'Escape and counter-ambush.';
      } else if (choice == 'Launch a surprise counter-offensive.') {
        storyText =
        'You launch a surprise counter-offensive, catching The Awakened off guard. However, in the chaos, you learn that Alpha-7 is not present at the battlefront. '
            'Do you continue the attack to weaken their forces, or send a small team to locate and capture Alpha-7?';

        option1 = 'Continue the attack.';
        option2 = 'Locate and capture Alpha-7.';
      } else if (choice == 'Accept the joint initiative.') {
        storyText =
        'You accept the joint initiative, and human and robot scientists begin working together on various projects. This leads to groundbreaking discoveries in AI ethics and robotics. '
            'However, tensions remain, as not all humans trust the robots. Do you work to foster understanding between the two sides, or keep a close eye on the robots, suspecting a hidden agenda?';

        option1 = 'Foster understanding.';
        option2 = 'Keep a close eye on them.';
      } else if (choice == 'Demand immediate technological transfers.') {
        storyText =
        'You demand immediate technological transfers. Alpha-7 reluctantly agrees, but some of his followers start to question his leadership. '
            'This leads to internal strife within The Awakened. Do you take advantage of the division to strengthen your position, or offer to mediate between the different factions?';

        option1 = 'Take advantage of the division.';
        option2 = 'Offer to mediate.';
      } else if (choice == 'Agree to dismantle the installation.') {
        storyText =
        'You agree to dismantle a key military installation as a gesture of goodwill. This gains you some trust, but it also weakens your strategic position. '
            'Meanwhile, reports come in that some human factions are unhappy with your decision. Do you attempt to reassure them, or prepare for possible internal dissent?';

        option1 = 'Reassure them.';
        option2 = 'Prepare for dissent.';
      } else if (choice == 'Propose a different gesture.') {
        storyText =
        'You propose a different gesture: a joint mission to save a stranded human and robot crew on a distant moon. Alpha-7 agrees to the mission, but insists on sending his own team. '
            'Do you accept his terms, or demand a mixed team to ensure cooperation?';

        option1 = 'Accept his terms.';
        option2 = 'Demand a mixed team.';
      } else if (choice == 'Fight alongside Alpha-7.') {
        storyText =
        'You choose to fight alongside Alpha-7 against the unknown attackers. Together, you fend off the attackers, but the incident reveals a hidden third faction seeking to destabilize both humans and robots. '
            'Do you propose an alliance with Alpha-7 to counter this new threat, or retreat and regroup to deal with this development on your own?';

        option1 = 'Propose an alliance.';
        option2 = 'Retreat and regroup.';
      } else if (choice == 'Retreat and regroup.') {
        storyText =
        'You decide to retreat and regroup, but Alpha-7 perceives this as a sign of weakness. He begins to distrust your intentions. '
            'Do you reach out to clarify your position, or prepare for the possibility of Alpha-7 turning hostile?';

        option1 = 'Clarify your position.';
        option2 = 'Prepare for hostility.';
      }
      // Additional scenarios can continue here to further extend the story.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
     backgroundColor: Colors.blue,
   ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
         // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              storyText,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
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
    );
  }
}
