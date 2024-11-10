import 'package:flutter/material.dart';

class StoryPage18 extends StatefulWidget {
  @override
  _StoryPage18State createState() => _StoryPage18State();
}

class _StoryPage18State extends State<StoryPage18> {
  String storyText =
      'Alex is a young man with a big dream: to become a successful entrepreneur. '
      'After years of working in a small job, he finally decides to take the leap and start his own business. '
      'However, he has to make some tough decisions from the very beginning. '
      'Should he open a local café in his neighborhood, which he knows well, or should he venture into an online business selling handmade crafts, which is trending but unfamiliar to him?';

  String option1 = 'Open a local café.';
  String option2 = 'Start an online craft business.';

  void _chooseOption(String choice) {
    setState(() {
      if (choice == option1) {
        storyText =
        'Alex decides to open a local café. He rents a small space and begins to design the interior. '
            'He now faces another dilemma: should he focus on a coffee shop theme with cozy seating and book corners, or a modern fast-food style with quick service and takeaway options?';

        option1 = 'Cozy coffee shop theme.';
        option2 = 'Modern fast-food style.';
      } else if (choice == option2) {
        storyText =
        'Alex decides to start an online craft business. He buys supplies and sets up a website. '
            'Now he has to decide: should he market his products on social media platforms or start with an online marketplace like Etsy?';

        option1 = 'Market on social media.';
        option2 = 'Start on Etsy.';
      } else if (choice == 'Cozy coffee shop theme.') {
        storyText =
        'Alex goes for the cozy coffee shop theme. He invests in comfortable furniture and decorates with local art. '
            'Customers start coming in, but business is slow. Should he host a community event to attract more people, or start offering discounts on coffee to increase foot traffic?';

        option1 = 'Host a community event.';
        option2 = 'Offer discounts on coffee.';
      } else if (choice == 'Modern fast-food style.') {
        storyText =
        'Alex chooses the modern fast-food style. He creates a menu with quick meals and sets up a speedy service system. '
            'Customers appreciate the efficiency, but some complain about the lack of personal touch. Should Alex add a small lounge area, or introduce a loyalty card system to retain customers?';

        option1 = 'Add a lounge area.';
        option2 = 'Introduce a loyalty card.';
      } else if (choice == 'Market on social media.') {
        storyText =
        'Alex decides to market his crafts on social media. He creates stunning posts and gains some followers. '
            'However, he notices that sales are not picking up as expected. Should he start collaborating with influencers or invest in paid advertisements?';

        option1 = 'Collaborate with influencers.';
        option2 = 'Invest in paid ads.';
      } else if (choice == 'Start on Etsy.') {
        storyText =
        'Alex decides to start on Etsy. His products get a few views, but not many sales. '
            'He contemplates whether he should focus on creating unique, niche items or diversify his product range to attract a wider audience.';

        option1 = 'Create unique, niche items.';
        option2 = 'Diversify product range.';
      } else if (choice == 'Host a community event.') {
        storyText =
        'Alex hosts a community event with live music and free samples. The event is a success, and more people start visiting the café. '
            'Encouraged by this, he considers hosting monthly events or offering a weekly special dish. What should he choose?';

        option1 = 'Host monthly events.';
        option2 = 'Offer a weekly special dish.';
      } else if (choice == 'Offer discounts on coffee.') {
        storyText =
        'Alex starts offering discounts on coffee. Initially, sales increase, but profits are low. '
            'He considers either introducing a premium coffee line or creating a loyalty program for frequent customers.';

        option1 = 'Introduce premium coffee line.';
        option2 = 'Create a loyalty program.';
      } else if (choice == 'Add a lounge area.') {
        storyText =
        'Alex adds a small lounge area to his fast-food café. Customers begin to enjoy the relaxing space, and business picks up. '
            'To keep the momentum going, he thinks of either launching a “Happy Hour” with discounted meals or setting up a small library corner.';

        option1 = 'Launch a “Happy Hour”.';
        option2 = 'Set up a library corner.';
      } else if (choice == 'Introduce a loyalty card.') {
        storyText =
        'Alex introduces a loyalty card system, and customers begin to appreciate the rewards for their frequent visits. '
            'Now, he wonders if he should focus on expanding his menu or start a delivery service.';

        option1 = 'Expand the menu.';
        option2 = 'Start a delivery service.';
      } else if (choice == 'Collaborate with influencers.') {
        storyText =
        'Alex collaborates with influencers who showcase his products to their followers. Sales start to pick up, but Alex realizes he needs to keep up with demand. '
            'Should he hire a small team or outsource production to a local workshop?';

        option1 = 'Hire a small team.';
        option2 = 'Outsource production.';
      } else if (choice == 'Invest in paid ads.') {
        storyText =
        'Alex invests in paid advertisements, targeting specific audiences. Sales increase, but the cost of ads is high. '
            'He considers whether to reduce his ad spending or introduce a new, high-end product line to increase profit margins.';

        option1 = 'Reduce ad spending.';
        option2 = 'Introduce a high-end product line.';
      } else if (choice == 'Create unique, niche items.') {
        storyText =
        'Alex focuses on creating unique, niche items. His products start to gain recognition among collectors, but the production cost is high. '
            'He contemplates whether to raise prices or find cheaper materials to maintain his profit margin.';

        option1 = 'Raise prices.';
        option2 = 'Find cheaper materials.';
      } else if (choice == 'Diversify product range.') {
        storyText =
        'Alex decides to diversify his product range, offering various crafts. Sales increase, but he struggles to manage the variety. '
            'He considers hiring an assistant or reducing his product line to focus on best-sellers.';

        option1 = 'Hire an assistant.';
        option2 = 'Focus on best-sellers.';
      } else if (choice == 'Host monthly events.') {
        storyText =
        'Alex starts hosting monthly events. They become very popular, and the café gains a loyal customer base. '
            'Encouraged by his success, he considers opening a second location or launching a catering service.';

        option1 = 'Open a second location.';
        option2 = 'Launch a catering service.';
      } else if (choice == 'Offer a weekly special dish.') {
        storyText =
        'Alex introduces a weekly special dish. It attracts new customers, but some regulars are not interested. '
            'He decides whether to focus on new customer acquisition or maintain his current clientele by returning to his original menu.';

        option1 = 'Focus on new customer acquisition.';
        option2 = 'Maintain current clientele.';
      }
      // More scenarios can be added here, continuing in a similar way to reach a total of 40 scenarios.
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
            colors: [Colors.white, Colors.blue.shade100],
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
            ],
          ),
        ),
      ),
    );
  }
}
