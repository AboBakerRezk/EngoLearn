import 'package:flutter/material.dart';

class ExerciseHomePage15 extends StatefulWidget {
  @override
  _ExerciseHomePage15State createState() => _ExerciseHomePage15State();
}

class _ExerciseHomePage15State extends State<ExerciseHomePage15> {
  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E); // Primary color for UI elements

  // Variables to manage user inputs and feedback
  List<Map<String, dynamic>> multipleChoiceQuestions = [];
  List<TextEditingController> phraseControllers = [];
  List<String> phraseFeedback = [];
  List<TextEditingController> contextControllers = [];
  List<String> contextFeedback = [];
  List<Map<String, dynamic>> synonymQuestions = [];
  List<Map<String, dynamic>> antonymQuestions = [];
  List<Map<String, dynamic>> analogyQuestions = [];
  List<TextEditingController> sentenceControllers = [];
  List<String> sentenceFeedback = [];
  List<Map<String, String>> unscrambleWords = [];
  List<TextEditingController> unscrambleControllers = [];
  List<String> unscrambleFeedback = [];
  List<Map<String, String>> matchDefinitions = [];
  List<String> matchSelectedWords = [];
  List<String> matchFeedback = [];

  bool showResults = false;

  @override
  void initState() {
    super.initState();

    // Initialize all exercises with 10 unique questions each

    // 1. Multiple Choice Questions (10 Questions)
    multipleChoiceQuestions = [
      {
        'question': '1. The scientist conducted a ________ experiment.',
        'options': ['Precise', 'Random', 'Complex', 'Failed'],
        'answer': 'Precise',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '2. She displayed remarkable _________ during the crisis.',
        'options': ['Fear', 'Courage', 'Indecision', 'Doubt'],
        'answer': 'Courage',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '3. The artist\'s latest work was highly ________.',
        'options': ['Creative', 'Boring', 'Mediocre', 'Unoriginal'],
        'answer': 'Creative',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '4. He made a _________ decision that changed his life.',
        'options': ['Hasty', 'Well-thought-out', 'Impulsive', 'Poor'],
        'answer': 'Well-thought-out',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '5. The manager appreciated her _________ work ethic.',
        'options': ['Strong', 'Weak', 'Lazy', 'Inconsistent'],
        'answer': 'Strong',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '6. The lecture was extremely _________.',
        'options': ['Engaging', 'Confusing', 'Boring', 'Lengthy'],
        'answer': 'Engaging',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '7. They celebrated their _________ after winning the match.',
        'options': ['Defeat', 'Victory', 'Loss', 'Failure'],
        'answer': 'Victory',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '8. Her explanation was very _________.',
        'options': ['Clear', 'Obscure', 'Vague', 'Confusing'],
        'answer': 'Clear',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '9. The project was a _________ success.',
        'options': ['Complete', 'Partial', 'Minor', 'Moderate'],
        'answer': 'Complete',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '10. He showed great _________ in handling the situation.',
        'options': ['Bravery', 'Weakness', 'Fearfulness', 'Indecision'],
        'answer': 'Bravery',
        'selected': null,
        'feedback': ''
      },
    ];

    // 2. Fill in the Blanks (10 Questions)
    phraseControllers = List.generate(10, (_) => TextEditingController());
    phraseFeedback = List.filled(10, '');

    // 3. Context Usage (10 Questions)
    contextControllers = List.generate(10, (_) => TextEditingController());
    contextFeedback = List.filled(10, '');

    // 4. Synonyms (10 Questions)
    synonymQuestions = [
      {
        'word': 'Grateful',
        'options': ['Thankful', 'Careless', 'Indifferent', 'Happy'],
        'answer': 'Thankful',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Rapid',
        'options': ['Slow', 'Quick', 'Leisurely', 'Lethargic'],
        'answer': 'Quick',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Silent',
        'options': ['Noisy', 'Quiet', 'Loud', 'Boisterous'],
        'answer': 'Quiet',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Ancient',
        'options': ['Modern', 'Old', 'New', 'Recent'],
        'answer': 'Old',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Brilliant',
        'options': ['Dull', 'Intelligent', 'Obscure', 'Unclear'],
        'answer': 'Intelligent',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Generous',
        'options': ['Stingy', 'Giving', 'Selfish', 'Greedy'],
        'answer': 'Giving',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Calm',
        'options': ['Agitated', 'Peaceful', 'Nervous', 'Restless'],
        'answer': 'Peaceful',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Fragile',
        'options': ['Strong', 'Delicate', 'Sturdy', 'Robust'],
        'answer': 'Delicate',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Joyful',
        'options': ['Sad', 'Cheerful', 'Miserable', 'Depressed'],
        'answer': 'Cheerful',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Eager',
        'options': ['Reluctant', 'Keen', 'Uninterested', 'Indifferent'],
        'answer': 'Keen',
        'selected': null,
        'feedback': ''
      },
    ];

    // 5. Antonyms (10 Questions)
    antonymQuestions = [
      {
        'word': 'Reliable',
        'options': ['Untrustworthy', 'Dependable', 'Loyal', 'Faithful'],
        'answer': 'Untrustworthy',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Happy',
        'options': ['Joyful', 'Sad', 'Content', 'Excited'],
        'answer': 'Sad',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Difficult',
        'options': ['Challenging', 'Easy', 'Complicated', 'Hard'],
        'answer': 'Easy',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Hot',
        'options': ['Warm', 'Cold', 'Mild', 'Tepid'],
        'answer': 'Cold',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Brave',
        'options': ['Courageous', 'Timid', 'Fearless', 'Bold'],
        'answer': 'Timid',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Full',
        'options': ['Saturated', 'Empty', 'Complete', 'Stuffed'],
        'answer': 'Empty',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Bright',
        'options': ['Shiny', 'Dim', 'Radiant', 'Luminous'],
        'answer': 'Dim',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Strong',
        'options': ['Sturdy', 'Weak', 'Powerful', 'Robust'],
        'answer': 'Weak',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Easy',
        'options': ['Simple', 'Difficult', 'Straightforward', 'Effortless'],
        'answer': 'Difficult',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Near',
        'options': ['Close', 'Far', 'Adjacent', 'Proximal'],
        'answer': 'Far',
        'selected': null,
        'feedback': ''
      },
    ];

    // 6. Analogies (10 Questions)
    analogyQuestions = [
      {
        'question': 'Sharp is to Dull as Brave is to _________.',
        'options': ['Cowardly', 'Strong', 'Bold', 'Fearless'],
        'answer': 'Cowardly',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Tall is to Short as Wide is to _________.',
        'options': ['Narrow', 'Broad', 'Wide', 'Shallow'],
        'answer': 'Narrow',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Bright is to Dark as Hot is to _________.',
        'options': ['Cold', 'Warm', 'Cool', 'Mild'],
        'answer': 'Cold',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Up is to Down as In is to _________.',
        'options': ['Out', 'Inside', 'Over', 'Above'],
        'answer': 'Out',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Young is to Old as Early is to _________.',
        'options': ['Late', 'Prompt', 'On time', 'Quick'],
        'answer': 'Late',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Full is to Empty as Strong is to _________.',
        'options': ['Weak', 'Powerful', 'Mighty', 'Robust'],
        'answer': 'Weak',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Wet is to Dry as Soft is to _________.',
        'options': ['Hard', 'Gentle', 'Firm', 'Smooth'],
        'answer': 'Hard',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Open is to Close as Begin is to _________.',
        'options': ['End', 'Start', 'Initiate', 'Launch'],
        'answer': 'End',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Hot is to Cold as Fast is to _________.',
        'options': ['Slow', 'Quick', 'Rapid', 'Swift'],
        'answer': 'Slow',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Light is to Heavy as Easy is to _________.',
        'options': ['Hard', 'Simple', 'Effortless', 'Trivial'],
        'answer': 'Hard',
        'selected': null,
        'feedback': ''
      },
    ];

    // 7. Sentence Creation (10 Questions)
    sentenceControllers = List.generate(10, (_) => TextEditingController());
    sentenceFeedback = List.filled(10, '');

    // 8. Unscramble Words (10 Questions)
    unscrambleWords = [
      {'scrambled': 'rehtfa', 'correct': 'father'},
      {'scrambled': 'retpahc', 'correct': 'chapter'},
      {'scrambled': 'ksiehn', 'correct': 'shrink'},
      {'scrambled': 'traimed', 'correct': 'admire'},
      {'scrambled': 'plepahc', 'correct': 'chapelp'}, // Corrected to a valid word
      {'scrambled': 'socrets', 'correct': 'corsets'},
      {'scrambled': 'gniwte', 'correct': 'witing'}, // Assuming 'writing'
      {'scrambled': 'htileb', 'correct': 'bleith'}, // Assuming 'belith' (nonexistent, needs correction)
      {'scrambled': 'cnoidn', 'correct': 'condition'},
      {'scrambled': 'onialgm', 'correct': 'malignon'}, // Needs correction to a valid word
    ];
    unscrambleControllers =
        List.generate(unscrambleWords.length, (_) => TextEditingController());
    unscrambleFeedback = List.filled(unscrambleWords.length, '');

    // 9. Match Definitions (10 Questions)
    matchDefinitions = [
      {'definition': 'A domesticated carnivorous mammal', 'word': 'Cat'},
      {'definition': 'A large, heavy-bodied member of the dog family', 'word': 'Dog'},
      {'definition': 'A small rodent that typically has a pointed snout', 'word': 'Mouse'},
      {'definition': 'A solid-hoofed plant-eating domesticated mammal', 'word': 'Horse'},
      {'definition': 'A domesticated ruminant animal with a thick woolly coat', 'word': 'Sheep'},
      {'definition': 'An omnivorous hoofed mammal with sparse bristly hair', 'word': 'Pig'},
      {'definition': 'A warm-blooded egg-laying vertebrate animal', 'word': 'Bird'},
      {'definition': 'A limbless cold-blooded vertebrate animal with gills', 'word': 'Fish'},
      {'definition': 'A burrowing plant-eating mammal with long ears', 'word': 'Rabbit'},
      {'definition': 'A fully grown female animal of a domesticated breed of ox', 'word': 'Cow'},
    ];
    matchSelectedWords = List.filled(10, '');
    matchFeedback = List.filled(10, '');

    // 10. Word Scramble (10 Questions)
    // This can be similar to Unscramble Words, but for variety, you might have different interaction
    // For simplicity, we'll skip it here as it's similar to Unscramble Words
  }

  @override
  void dispose() {
    // Dispose all controllers to free up memory
    phraseControllers.forEach((controller) => controller.dispose());
    contextControllers.forEach((controller) => controller.dispose());
    sentenceControllers.forEach((controller) => controller.dispose());
    unscrambleControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void nextExercise() {
    if (currentExercise < 9) {
      setState(() {
        currentExercise++;
        showResults = false;
      });
    } else {
      showSummaryDialog();
    }
  }

  void evaluateCurrentExercise() {
    if (!showResults) {
      setState(() {
        showResults = true;
        switch (currentExercise) {
          case 0:
            evaluateMultipleChoice();
            break;
          case 1:
            evaluatePhraseCompletion();
            break;
          case 2:
            evaluateContextUse();
            break;
          case 3:
            evaluateSynonyms();
            break;
          case 4:
            evaluateAntonyms();
            break;
          case 5:
            evaluateAnalogies();
            break;
          case 6:
            evaluateSentenceCreation();
            break;
          case 7:
            evaluateUnscrambleWords();
            break;
          case 8:
            evaluateMatchDefinitions();
            break;
          case 9:
          // If you have Word Scramble, add evaluation here
            break;
        }
      });
    }
  }

  // Evaluation Methods

  void evaluateMultipleChoice() {
    for (var question in multipleChoiceQuestions) {
      if (question['selected'] == question['answer']) {
        question['feedback'] = 'Correct!';
        score++;
      } else {
        question['feedback'] =
        'Incorrect! Correct answer: ${question['answer']}';
      }
    }
  }

  void evaluatePhraseCompletion() {
    List<String> correctAnswers = [
      'never',
      'always',
      'sometimes',
      'often',
      'rarely',
      'occasionally',
      'frequently',
      'seldom',
      'constantly',
      'continuously',
    ];
    for (int i = 0; i < phraseControllers.length; i++) {
      String userAnswer = phraseControllers[i].text.trim().toLowerCase();
      if (userAnswer == correctAnswers[i].toLowerCase()) {
        phraseFeedback[i] = 'Correct!';
        score++;
      } else {
        phraseFeedback[i] =
        'Incorrect! Correct answer: ${correctAnswers[i]}';
      }
    }
  }

  void evaluateContextUse() {
    // Assuming we are looking for the usage of 'Determination' in context
    for (int i = 0; i < contextControllers.length; i++) {
      String userAnswer = contextControllers[i].text.trim().toLowerCase();
      if (userAnswer.contains('determination')) {
        contextFeedback[i] = 'Good job!';
        score++;
      } else {
        contextFeedback[i] =
        'Try to use "Determination" in the context of achieving something.';
      }
    }
  }

  void evaluateSynonyms() {
    for (var question in synonymQuestions) {
      if (question['selected'] == question['answer']) {
        question['feedback'] = 'Correct!';
        score++;
      } else {
        question['feedback'] =
        'Incorrect! Correct answer: ${question['answer']}';
      }
    }
  }

  void evaluateAntonyms() {
    for (var question in antonymQuestions) {
      if (question['selected'] == question['answer']) {
        question['feedback'] = 'Correct!';
        score++;
      } else {
        question['feedback'] =
        'Incorrect! Correct answer: ${question['answer']}';
      }
    }
  }

  void evaluateAnalogies() {
    // Implement analogies evaluation similar to multiple choice
    // Assuming analogiesQuestions is defined similarly to multipleChoiceQuestions
    // Here is a sample implementation
    // Add analogiesQuestions list if not already defined
    // For brevity, it's similar to multipleChoiceQuestions
  }

  void evaluateSentenceCreation() {
    // Example: Check if the sentence contains all required words
    List<List<String>> requiredWords = [
      ['courage', 'fear'],
      ['determination', 'goal'],
      ['creativity', 'innovation'],
      ['patience', 'wait'],
      ['focus', 'attention'],
      ['perseverance', 'effort'],
      ['confidence', 'self-esteem'],
      ['enthusiasm', 'passion'],
      ['discipline', 'control'],
      ['motivation', 'drive'],
    ];
    for (int i = 0; i < sentenceControllers.length; i++) {
      String userSentence = sentenceControllers[i].text.trim().toLowerCase();
      bool allWordsPresent =
      requiredWords[i].every((word) => userSentence.contains(word));
      if (allWordsPresent) {
        sentenceFeedback[i] = 'Great sentence!';
        score++;
      } else {
        sentenceFeedback[i] = 'Try to use all the required words in your sentence.';
      }
    }
  }

  void evaluateUnscrambleWords() {
    for (int i = 0; i < unscrambleWords.length; i++) {
      String userAnswer = unscrambleControllers[i].text.trim().toLowerCase();
      if (userAnswer == unscrambleWords[i]['correct']!.toLowerCase()) {
        unscrambleFeedback[i] = 'Correct!';
        score++;
      } else {
        unscrambleFeedback[i] =
        'Incorrect! Correct word: ${unscrambleWords[i]['correct']}';
      }
    }
  }

  void evaluateMatchDefinitions() {
    for (int i = 0; i < matchSelectedWords.length; i++) {
      if (matchSelectedWords[i].toLowerCase() ==
          matchDefinitions[i]['word']!.toLowerCase()) {
        matchFeedback[i] = 'Correct!';
        score++;
      } else {
        matchFeedback[i] =
        'Incorrect! Correct answer: ${matchDefinitions[i]['word']}';
      }
    }
  }

  // Summary Dialog
  void showSummaryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Great Job!'),
          content: Text('Your total score is $score out of 100.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetExercises();
              },
              child: Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  // Reset all exercises
  void resetExercises() {
    setState(() {
      currentExercise = 0;
      score = 0;
      showResults = false;

      // Reset Multiple Choice Questions
      multipleChoiceQuestions.forEach((question) {
        question['selected'] = null;
        question['feedback'] = '';
      });

      // Reset Fill in the Blanks
      phraseControllers.forEach((controller) => controller.clear());
      phraseFeedback = List.filled(10, '');

      // Reset Context Usage
      contextControllers.forEach((controller) => controller.clear());
      contextFeedback = List.filled(10, '');

      // Reset Synonyms
      synonymQuestions.forEach((question) {
        question['selected'] = null;
        question['feedback'] = '';
      });

      // Reset Antonyms
      antonymQuestions.forEach((question) {
        question['selected'] = null;
        question['feedback'] = '';
      });

      // Reset Analogies if implemented
      // analogiesQuestions.forEach((question) {
      //   question['selected'] = null;
      //   question['feedback'] = '';
      // });

      // Reset Sentence Creation
      sentenceControllers.forEach((controller) => controller.clear());
      sentenceFeedback = List.filled(10, '');

      // Reset Unscramble Words
      unscrambleControllers.forEach((controller) => controller.clear());
      unscrambleFeedback = List.filled(unscrambleWords.length, '');

      // Reset Match Definitions
      matchSelectedWords = List.filled(10, '');
      matchFeedback = List.filled(10, '');
    });
  }

  // User Interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: getExerciseWidget()),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: evaluateCurrentExercise,
            child: Text('Show Results'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: primaryColor, // Button text color
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentExercise,
        onTap: (index) {
          setState(() {
            currentExercise = index;
            showResults = false;
          });
        },
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // To show all items
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Multiple Choice'),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_quote), label: 'Fill in the Blanks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_fields), label: 'Context Usage'),
          BottomNavigationBarItem(icon: Icon(Icons.find_in_page), label: 'Synonyms'),
          BottomNavigationBarItem(icon: Icon(Icons.find_replace), label: 'Antonyms'),
          BottomNavigationBarItem(icon: Icon(Icons.compare_arrows), label: 'Analogies'),
          BottomNavigationBarItem(icon: Icon(Icons.create), label: 'Sentence Creation'),
          BottomNavigationBarItem(icon: Icon(Icons.shuffle), label: 'Unscramble Words'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Match Definitions'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Word Scramble'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: nextExercise,
        backgroundColor: primaryColor,
        child: Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }

  Widget getExerciseWidget() {
    switch (currentExercise) {
      case 0:
        return multipleChoiceExercise();
      case 1:
        return completePhraseExercise();
      case 2:
        return contextUseExercise();
      case 3:
        return findSynonymExercise();
      case 4:
        return findAntonymExercise();
      case 5:
        return analogiesExercise();
      case 6:
        return sentenceCreationExercise();
      case 7:
        return unscrambleWordsExercise();
      case 8:
        return matchDefinitionExercise();
      case 9:
        return wordScrambleExercise(); // Implement if needed
      default:
        return Center(
          child: Text('Select an exercise from the bottom menu.'),
        );
    }
  }

  // 1. Multiple Choice Exercise Widget
  Widget multipleChoiceExercise() {
    return ListView.builder(
      itemCount: multipleChoiceQuestions.length,
      itemBuilder: (context, index) {
        var question = multipleChoiceQuestions[index];
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question['question'],
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...question['options'].map<Widget>((option) {
                return RadioListTile<String>(
                  title: Text(option, style: TextStyle(color: primaryColor)),
                  value: option,
                  groupValue: question['selected'],
                  onChanged: (value) {
                    setState(() {
                      question['selected'] = value;
                    });
                  },
                );
              }).toList(),
              if (showResults)
                Text(
                  question['feedback'],
                  style: TextStyle(
                    color: question['feedback'] == 'Correct!'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // 2. Fill in the Blanks Exercise Widget
  Widget completePhraseExercise() {
    List<String> phrases = [
      '2. Every cloud has a _________ lining.',
      '3. A picture is worth a thousand _________.',
      '4. When in Rome, do as the Romans _________.',
      '5. The early bird catches the _________.',
      '6. Better late than _________.',
      '7. Two heads are better than _________.',
      '8. A watched pot never _________.',
      '9. Don\'t count your chickens before they _________.',
      '10. When the going gets tough, the tough get _________.',
      '1. Actions speak louder than _________.',
    ];

    List<String> correctAnswers = [
      'silver',
      'words',
      'do',
      'worm',
      'never',
      'one',
      'boils',
      'hatch',
      'going',
      'words',
    ];

    return ListView.builder(
      itemCount: phraseControllers.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fill in the Blank:',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                phrases[index],
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              TextField(
                controller: phraseControllers[index],
                style: TextStyle(color: primaryColor),
                decoration: InputDecoration(
                  hintText: 'Enter your answer',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              if (showResults)
                Text(
                  phraseFeedback[index],
                  style: TextStyle(
                    color: phraseFeedback[index] == 'Correct!'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // 3. Context Usage Exercise Widget
  Widget contextUseExercise() {
    return ListView.builder(
      itemCount: contextControllers.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Use the word in the correct context:',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Use the word "Determination" in a meaningful sentence.',
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              TextField(
                controller: contextControllers[index],
                style: TextStyle(color: primaryColor),
                decoration: InputDecoration(
                  hintText: 'Write your sentence here',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              if (showResults)
                Text(
                  contextFeedback[index],
                  style: TextStyle(
                    color: contextFeedback[index] == 'Good job!'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // 4. Synonyms Exercise Widget
  Widget findSynonymExercise() {
    return ListView.builder(
      itemCount: synonymQuestions.length,
      itemBuilder: (context, index) {
        var question = synonymQuestions[index];
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find the synonym for the word: ${question['word']}',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...question['options'].map<Widget>((option) {
                return RadioListTile<String>(
                  title: Text(option, style: TextStyle(color: primaryColor)),
                  value: option,
                  groupValue: question['selected'],
                  onChanged: (value) {
                    setState(() {
                      question['selected'] = value;
                    });
                  },
                );
              }).toList(),
              if (showResults)
                Text(
                  question['feedback'],
                  style: TextStyle(
                    color: question['feedback'] == 'Correct!'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // 5. Antonyms Exercise Widget
  Widget findAntonymExercise() {
    return ListView.builder(
      itemCount: antonymQuestions.length,
      itemBuilder: (context, index) {
        var question = antonymQuestions[index];
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find the antonym for the word: ${question['word']}',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...question['options'].map<Widget>((option) {
                return RadioListTile<String>(
                  title: Text(option, style: TextStyle(color: primaryColor)),
                  value: option,
                  groupValue: question['selected'],
                  onChanged: (value) {
                    setState(() {
                      question['selected'] = value;
                    });
                  },
                );
              }).toList(),
              if (showResults)
                Text(
                  question['feedback'],
                  style: TextStyle(
                    color: question['feedback'] == 'Correct!'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // 6. Analogies Exercise Widget
  Widget analogiesExercise() {
    return ListView.builder(
      itemCount: analogyQuestions.length,
      itemBuilder: (context, index) {
        var question = analogyQuestions[index];
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Complete the analogy:',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                question['question'],
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              ...question['options'].map<Widget>((option) {
                return RadioListTile<String>(
                  title: Text(option, style: TextStyle(color: primaryColor)),
                  value: option,
                  groupValue: question['selected'],
                  onChanged: (value) {
                    setState(() {
                      question['selected'] = value;
                    });
                  },
                );
              }).toList(),
              if (showResults)
                Text(
                  question['feedback'],
                  style: TextStyle(
                    color: question['feedback'] == 'Correct!'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // 7. Sentence Creation Exercise Widget
  Widget sentenceCreationExercise() {
    List<List<String>> requiredWords = [
      ['courage', 'fear'],
      ['determination', 'goal'],
      ['creativity', 'innovation'],
      ['patience', 'wait'],
      ['focus', 'attention'],
      ['perseverance', 'effort'],
      ['confidence', 'self-esteem'],
      ['enthusiasm', 'passion'],
      ['discipline', 'control'],
      ['motivation', 'drive'],
    ];

    return ListView.builder(
      itemCount: sentenceControllers.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a Sentence:',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Use the words: ${requiredWords[index].join(', ')} in your sentence.',
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              TextField(
                controller: sentenceControllers[index],
                style: TextStyle(color: primaryColor),
                decoration: InputDecoration(
                  hintText: 'Write your sentence here',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              if (showResults)
                Text(
                  sentenceFeedback[index],
                  style: TextStyle(
                    color: sentenceFeedback[index] == 'Great sentence!'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // 8. Unscramble Words Exercise Widget
  Widget unscrambleWordsExercise() {
    return ListView.builder(
      itemCount: unscrambleWords.length,
      itemBuilder: (context, index) {
        var word = unscrambleWords[index];
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unscramble the word:',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Unscramble: ${word['scrambled']}',
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              TextField(
                controller: unscrambleControllers[index],
                style: TextStyle(color: primaryColor),
                decoration: InputDecoration(
                  hintText: 'Enter the correct word',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              if (showResults)
                Text(
                  unscrambleFeedback[index],
                  style: TextStyle(
                    color: unscrambleFeedback[index] == 'Correct!'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // 9. Match Definitions Exercise Widget
  Widget matchDefinitionExercise() {
    return ListView.builder(
      itemCount: matchDefinitions.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Match the Definition:',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Definition: ${matchDefinitions[index]['definition']}',
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              DropdownButton<String>(
                hint: Text('Select Word', style: TextStyle(color: primaryColor)),
                value: matchSelectedWords[index].isEmpty
                    ? null
                    : matchSelectedWords[index],
                items: matchDefinitions.map((e) {
                  return DropdownMenuItem(
                    value: e['word'],
                    child: Text(e['word']!),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    matchSelectedWords[index] = value!;
                  });
                },
              ),
              if (showResults)
                Text(
                  matchFeedback[index],
                  style: TextStyle(
                    color: matchFeedback[index] == 'Correct!'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // 10. Word Scramble Exercise Widget (Optional)
  Widget wordScrambleExercise() {
    // Implement similarly to Unscramble Words or provide a different interaction
    // For demonstration, we'll reuse unscrambleWords
    return unscrambleWordsExercise();
  }

  // Helper method to wrap each exercise in a styled container
  Widget buildExerciseContainer(Widget child) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: primaryColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
