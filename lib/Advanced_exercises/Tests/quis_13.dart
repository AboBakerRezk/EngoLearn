import 'package:flutter/material.dart';

class ExerciseHomePage13 extends StatefulWidget {
  @override
  _ExerciseHomePage13State createState() => _ExerciseHomePage13State();
}

class _ExerciseHomePage13State extends State<ExerciseHomePage13> {
  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E); // Desired text color

  // Variables to control inputs and feedback
  List<Map<String, dynamic>> multipleChoiceQuestions = [];
  List<Map<String, dynamic>> multipleChoiceAdvancedQuestions = [];
  List<Map<String, dynamic>> synonymQuestions = [];
  List<Map<String, dynamic>> antonymQuestions = [];
  List<TextEditingController> phraseControllers = [];
  List<String> phraseFeedback = [];
  List<TextEditingController> contextControllers = [];
  List<String> contextFeedback = [];
  List<Map<String, dynamic>> analogyQuestions = [];
  List<TextEditingController> sentenceControllers = [];
  List<String> sentenceFeedback = [];
  List<Map<String, String>> unscrambleWords = [];
  List<TextEditingController> unscrambleControllers = [];
  List<String> unscrambleFeedback = [];
  List<String> matchSelectedWords = [];
  List<String> matchFeedback = [];

  bool showResults = false;

  @override
  void initState() {
    super.initState();

    // Initialize questions and exercises

    // Multiple Choice Questions (10 questions)
    multipleChoiceQuestions = [
      {
        'question': '1. He faced his greatest _________ without hesitation.',
        'options': ['Challenge', 'Curiosity', 'Wisdom', 'Courage'],
        'answer': 'Challenge',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '2. She is known for her _________.',
        'options': ['Intelligence', 'Anger', 'Fear', 'Sadness'],
        'answer': 'Intelligence',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '3. The weather was extremely _________.',
        'options': ['Pleasant', 'Dull', 'Hot', 'Boring'],
        'answer': 'Pleasant',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '4. He showed great _________ during the competition.',
        'options': ['Bravery', 'Weakness', 'Fearfulness', 'Indecision'],
        'answer': 'Bravery',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '5. She has a very _________ personality.',
        'options': ['Charming', 'Annoying', 'Boring', 'Dull'],
        'answer': 'Charming',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '6. The lecture was very _________.',
        'options': ['Engaging', 'Confusing', 'Boring', 'Long'],
        'answer': 'Engaging',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '7. The team celebrated their _________.',
        'options': ['Victory', 'Defeat', 'Loss', 'Failure'],
        'answer': 'Victory',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '8. She gave a _________ performance.',
        'options': ['Stunning', 'Weak', 'Awful', 'Mediocre'],
        'answer': 'Stunning',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '9. His explanation was very _________.',
        'options': ['Clear', 'Obscure', 'Vague', 'Unclear'],
        'answer': 'Clear',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '10. They reached a _________ after long negotiations.',
        'options': ['Agreement', 'Disagreement', 'Conflict', 'Debate'],
        'answer': 'Agreement',
        'selected': null,
        'feedback': ''
      },
    ];

    // Advanced Multiple Choice Questions (10 questions)
    multipleChoiceAdvancedQuestions = [
      {
        'question': '1. Her _________ helped her overcome many challenges.',
        'options': ['Opportunity', 'Challenge', 'Curiosity', 'Achievement'],
        'answer': 'Opportunity',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '2. The scientist made a significant ________ in her field.',
        'options': ['Discovery', 'Mistake', 'Question', 'Theory'],
        'answer': 'Discovery',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '3. His _________ attitude inspired everyone around him.',
        'options': ['Positive', 'Negative', 'Indifferent', 'Apathetic'],
        'answer': 'Positive',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '4. The project was a _________ success.',
        'options': ['Complete', 'Partial', 'Minor', 'Moderate'],
        'answer': 'Complete',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '5. She has a _________ understanding of the subject.',
        'options': ['Superficial', 'In-depth', 'Basic', 'Limited'],
        'answer': 'In-depth',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '6. His _________ skills are exceptional.',
        'options': ['Communication', 'Technical', 'Artistic', 'Physical'],
        'answer': 'Communication',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '7. The manager appreciated her _________ work ethic.',
        'options': ['Strong', 'Weak', 'Lazy', 'Inconsistent'],
        'answer': 'Strong',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '8. The company aims to _________ its market presence.',
        'options': ['Expand', 'Reduce', 'Maintain', 'Ignore'],
        'answer': 'Expand',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '9. His _________ behavior caused many issues.',
        'options': ['Reckless', 'Careful', 'Thoughtful', 'Prudent'],
        'answer': 'Reckless',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '10. The artist\'s _________ was evident in every piece.',
        'options': ['Creativity', 'Boredom', 'Indifference', 'Stagnation'],
        'answer': 'Creativity',
        'selected': null,
        'feedback': ''
      },
    ];

    // Synonym Questions (10 questions)
    synonymQuestions = [
      {
        'word': 'Resilient',
        'options': ['Flexible', 'Rigid', 'Fragile', 'Sensitive'],
        'answer': 'Flexible',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Happy',
        'options': ['Joyful', 'Sad', 'Angry', 'Discontent'],
        'answer': 'Joyful',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Intelligent',
        'options': ['Smart', 'Foolish', 'Dull', 'Slow'],
        'answer': 'Smart',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Brave',
        'options': ['Courageous', 'Timid', 'Scared', 'Fearful'],
        'answer': 'Courageous',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Difficult',
        'options': ['Challenging', 'Easy', 'Simple', 'Clear'],
        'answer': 'Challenging',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Fast',
        'options': ['Quick', 'Slow', 'Leisurely', 'Lethargic'],
        'answer': 'Quick',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Generous',
        'options': ['Giving', 'Stingy', 'Selfish', 'Greedy'],
        'answer': 'Giving',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Calm',
        'options': ['Peaceful', 'Agitated', 'Nervous', 'Restless'],
        'answer': 'Peaceful',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Strong',
        'options': ['Powerful', 'Weak', 'Fragile', 'Delicate'],
        'answer': 'Powerful',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Beautiful',
        'options': ['Attractive', 'Ugly', 'Plain', 'Unpleasant'],
        'answer': 'Attractive',
        'selected': null,
        'feedback': ''
      },
    ];

    // Antonym Questions (10 questions)
    antonymQuestions = [
      {
        'word': 'Optimistic',
        'options': ['Pessimistic', 'Confident', 'Hopeful', 'Cheerful'],
        'answer': 'Pessimistic',
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

    // Fill in the phrase completion questions
    phraseControllers = List.generate(10, (_) => TextEditingController());
    phraseFeedback = List.filled(10, '');

    // Fill in the context usage questions
    contextControllers = List.generate(10, (_) => TextEditingController());
    contextFeedback = List.filled(10, '');

    // Analogy Questions (10 questions)
    analogyQuestions = [
      {
        'question': 'Bright is to Dark as Hot is to _________.',
        'options': ['Cold', 'Warm', 'Cool', 'Mild'],
        'answer': 'Cold',
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
        'question': 'Happy is to Sad as Love is to _________.',
        'options': ['Hate', 'Fear', 'Joy', 'Anger'],
        'answer': 'Hate',
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
    ];

    // Sentence Creation Questions (10 questions)
    sentenceControllers = List.generate(10, (_) => TextEditingController());
    sentenceFeedback = List.filled(10, '');

    // Unscramble Words Questions (10 questions)
    unscrambleWords = [
      {'scrambled': 'tac', 'correct': 'cat'},
      {'scrambled': 'god', 'correct': 'dog'},
      {'scrambled': 'emuos', 'correct': 'mouse'},
      {'scrambled': 'ohsre', 'correct': 'horse'},
      {'scrambled': 'eheps', 'correct': 'sheep'},
      {'scrambled': 'pig', 'correct': 'pig'},
      {'scrambled': 'ribb', 'correct': 'bird'},
      {'scrambled': 'fihs', 'correct': 'fish'},
      {'scrambled': 'tibbar', 'correct': 'rabbit'},
      {'scrambled': 'woc', 'correct': 'cow'},
    ];
    unscrambleControllers =
        List.generate(unscrambleWords.length, (_) => TextEditingController());
    unscrambleFeedback = List.filled(unscrambleWords.length, '');

    // Match Definitions Questions (10 questions)
    matchSelectedWords = List.filled(10, '');
    matchFeedback = List.filled(10, '');
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
            evaluateMultipleChoiceAdvanced();
            break;
          case 2:
            evaluateSynonyms();
            break;
          case 3:
            evaluateAntonyms();
            break;
          case 4:
            evaluatePhrases();
            break;
          case 5:
            evaluateContextUse();
            break;
          case 6:
            evaluateAnalogies();
            break;
          case 7:
            evaluateSentenceCreation();
            break;
          case 8:
            evaluateUnscrambleWords();
            break;
          case 9:
            evaluateMatchDefinitions();
            break;
        }
      });
    }
  }

  void evaluateMultipleChoice() {
    for (var question in multipleChoiceQuestions) {
      if (question['selected'] == question['answer']) {
        question['feedback'] = 'Correct!';
        score++;
      } else {
        question['feedback'] =
        'Incorrect! The correct answer is: ${question['answer']}';
      }
    }
  }

  void evaluateMultipleChoiceAdvanced() {
    for (var question in multipleChoiceAdvancedQuestions) {
      if (question['selected'] == question['answer']) {
        question['feedback'] = 'Correct!';
        score++;
      } else {
        question['feedback'] =
        'Incorrect! The correct answer is: ${question['answer']}';
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
        'Incorrect! The correct answer is: ${question['answer']}';
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
        'Incorrect! The correct answer is: ${question['answer']}';
      }
    }
  }

  void evaluatePhrases() {
    List<String> correctAnswers = [
      'words',
      'dedication',
      'courage',
      'wisdom',
      'strength',
      'perseverance',
      'talent',
      'determination',
      'grace',
      'brilliance',
    ];
    for (int i = 0; i < phraseControllers.length; i++) {
      String userAnswer = phraseControllers[i].text.trim().toLowerCase();
      if (userAnswer == correctAnswers[i].toLowerCase()) {
        phraseFeedback[i] = 'Correct!';
        score++;
      } else {
        phraseFeedback[i] =
        'Incorrect! The correct answer is: ${correctAnswers[i]}';
      }
    }
  }

  void evaluateContextUse() {
    List<String> correctKeywords = [
      'ambition',
      'goal',
      'ambition',
      'goal',
      'ambition',
      'goal',
      'ambition',
      'goal',
      'ambition',
      'goal',
    ];
    for (int i = 0; i < contextControllers.length; i++) {
      String userAnswer = contextControllers[i].text.trim().toLowerCase();
      if (userAnswer.contains('ambition') && userAnswer.contains('goal')) {
        contextFeedback[i] = 'Good job!';
        score++;
      } else {
        contextFeedback[i] =
        'Try using "ambition" in the context of "goal".';
      }
    }
  }

  void evaluateAnalogies() {
    for (var question in analogyQuestions) {
      if (question['selected'] == question['answer']) {
        question['feedback'] = 'Correct!';
        score++;
      } else {
        question['feedback'] =
        'Incorrect! The correct answer is: ${question['answer']}';
      }
    }
  }

  void evaluateSentenceCreation() {
    // List of words to be used in sentences
    List<List<String>> requiredWords = [
      ['happy', 'joyful', 'excited'],
      ['dedication', 'hard work', 'commitment'],
      ['courage', 'fear', 'strength'],
      ['wisdom', 'knowledge', 'experience'],
      ['strength', 'power', 'endurance'],
      ['perseverance', 'effort', 'determination'],
      ['talent', 'skill', 'ability'],
      ['determination', 'goal', 'ambition'],
      ['grace', 'elegance', 'poise'],
      ['brilliance', 'intelligence', 'clarity'],
    ];

    for (int i = 0; i < sentenceControllers.length; i++) {
      String userSentence = sentenceControllers[i].text.trim().toLowerCase();
      bool allWordsPresent =
      requiredWords[i].every((word) => userSentence.contains(word));
      if (allWordsPresent) {
        sentenceFeedback[i] = 'Excellent sentence!';
        score++;
      } else {
        sentenceFeedback[i] = 'Try using all the words in your sentence.';
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
        'Incorrect! The correct word is: ${unscrambleWords[i]['correct']}';
      }
    }
  }

  void evaluateMatchDefinitions() {
    List<Map<String, String>> definitions = [
      {'definition': 'A domesticated carnivorous mammal', 'word': 'cat'},
      {'definition': 'A large, heavy-bodied member of the dog family', 'word': 'dog'},
      {'definition': 'A small rodent that typically has a pointed snout', 'word': 'mouse'},
      {'definition': 'A solid-hoofed plant-eating domesticated mammal', 'word': 'horse'},
      {'definition': 'A domesticated ruminant animal with a thick woolly coat', 'word': 'sheep'},
      {'definition': 'An omnivorous hoofed mammal with sparse bristly hair', 'word': 'pig'},
      {'definition': 'A warm-blooded egg-laying vertebrate animal', 'word': 'bird'},
      {'definition': 'A limbless cold-blooded vertebrate animal with gills', 'word': 'fish'},
      {'definition': 'A burrowing plant-eating mammal with long ears', 'word': 'rabbit'},
      {'definition': 'A fully grown female animal of a domesticated breed of ox', 'word': 'cow'},
    ];

    for (int i = 0; i < matchSelectedWords.length; i++) {
      if (matchSelectedWords[i].toLowerCase() ==
          definitions[i]['word']!.toLowerCase()) {
        matchFeedback[i] = 'Correct!';
        score++;
      } else {
        matchFeedback[i] =
        'Incorrect! The correct word is: ${definitions[i]['word']}';
      }
    }
  }

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
                setState(() {
                  // Reset all variables
                  currentExercise = 0;
                  score = 0;
                  showResults = false;

                  multipleChoiceQuestions.forEach((question) {
                    question['selected'] = null;
                    question['feedback'] = '';
                  });

                  multipleChoiceAdvancedQuestions.forEach((question) {
                    question['selected'] = null;
                    question['feedback'] = '';
                  });

                  synonymQuestions.forEach((question) {
                    question['selected'] = null;
                    question['feedback'] = '';
                  });

                  antonymQuestions.forEach((question) {
                    question['selected'] = null;
                    question['feedback'] = '';
                  });

                  phraseControllers =
                      List.generate(10, (_) => TextEditingController());
                  phraseFeedback = List.filled(10, '');

                  contextControllers =
                      List.generate(10, (_) => TextEditingController());
                  contextFeedback = List.filled(10, '');

                  analogyQuestions.forEach((question) {
                    question['selected'] = null;
                    question['feedback'] = '';
                  });

                  sentenceControllers =
                      List.generate(10, (_) => TextEditingController());
                  sentenceFeedback = List.filled(10, '');

                  unscrambleControllers = List.generate(
                      unscrambleWords.length, (_) => TextEditingController());
                  unscrambleFeedback =
                      List.filled(unscrambleWords.length, '');

                  matchSelectedWords = List.filled(10, '');
                  matchFeedback = List.filled(10, '');
                });
              },
              child: Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  // User Interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change background color to white
      appBar: AppBar(
        title: Text('Word Exercises'),
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
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Multiple Choice'),
          BottomNavigationBarItem(
              icon: Icon(Icons.quiz_outlined), label: 'Advanced MCQ'),
          BottomNavigationBarItem(icon: Icon(Icons.find_in_page), label: 'Synonyms'),
          BottomNavigationBarItem(icon: Icon(Icons.find_replace), label: 'Antonyms'),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_quote), label: 'Complete Phrase'),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_fields), label: 'Context Usage'),
          BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows), label: 'Analogies'),
          BottomNavigationBarItem(
              icon: Icon(Icons.create), label: 'Create Sentences'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shuffle), label: 'Unscramble Words'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: 'Match Definitions'),
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
        return multipleChoiceExerciseAdvanced();
      case 2:
        return findSynonymExercise();
      case 3:
        return findAntonymExercise();
      case 4:
        return completePhraseExercise();
      case 5:
        return contextUseExercise();
      case 6:
        return analogiesExercise();
      case 7:
        return sentenceCreationExercise();
      case 8:
        return unscrambleWordsExercise();
      case 9:
        return matchDefinitionExercise();
      default:
        return Center(
          child: Text('Select an exercise from the bottom menu.'),
        );
    }
  }

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

  Widget multipleChoiceExerciseAdvanced() {
    return ListView.builder(
      itemCount: multipleChoiceAdvancedQuestions.length,
      itemBuilder: (context, index) {
        var question = multipleChoiceAdvancedQuestions[index];
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

  Widget completePhraseExercise() {
    List<String> phrases = [
      '1. Actions speak louder than _________.',
      '2. Every cloud has a _________ lining.',
      '3. A picture is worth a thousand _________.',
      '4. When in Rome, do as the Romans _________.',
      '5. The early bird catches the _________.',
      '6. Better late than _________.',
      '7. Two heads are better than _________.',
      '8. A watched pot never _________.',
      '9. Don\'t count your chickens before they _________.',
      '10. When the going gets tough, the tough get _________.',
    ];

    List<String> correctAnswers = [
      'words',
      'silver',
      'words',
      'do',
      'worm',
      'never',
      'one',
      'boils',
      'hatch',
      'going',
    ];

    return ListView.builder(
      itemCount: phraseControllers.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Complete the phrase:',
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
                  hintText: 'Enter your answer here',
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

  Widget contextUseExercise() {
    return ListView.builder(
      itemCount: contextControllers.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Use the word in context:',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Use the word "ambition" in a correct sentence.',
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

  Widget sentenceCreationExercise() {
    List<List<String>> requiredWords = [
      ['happy', 'joyful', 'excited'],
      ['dedication', 'hard work', 'commitment'],
      ['courage', 'fear', 'strength'],
      ['wisdom', 'knowledge', 'experience'],
      ['strength', 'power', 'endurance'],
      ['perseverance', 'effort', 'determination'],
      ['talent', 'skill', 'ability'],
      ['determination', 'goal', 'ambition'],
      ['grace', 'elegance', 'poise'],
      ['brilliance', 'intelligence', 'clarity'],
    ];

    return ListView.builder(
      itemCount: sentenceControllers.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a sentence:',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Use the following words in a sentence: ${requiredWords[index].join(', ')}',
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
                    color: sentenceFeedback[index] == 'Excellent sentence!'
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
                'Unscramble the following word: ${word['scrambled']}',
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              TextField(
                controller: unscrambleControllers[index],
                style: TextStyle(color: primaryColor),
                decoration: InputDecoration(
                  hintText: 'Enter the unscrambled word',
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

  Widget matchDefinitionExercise() {
    List<Map<String, String>> definitions = [
      {'definition': 'A domesticated carnivorous mammal', 'word': 'cat'},
      {'definition': 'A large, heavy-bodied member of the dog family', 'word': 'dog'},
      {'definition': 'A small rodent that typically has a pointed snout', 'word': 'mouse'},
      {'definition': 'A solid-hoofed plant-eating domesticated mammal', 'word': 'horse'},
      {'definition': 'A domesticated ruminant animal with a thick woolly coat', 'word': 'sheep'},
      {'definition': 'An omnivorous hoofed mammal with sparse bristly hair', 'word': 'pig'},
      {'definition': 'A warm-blooded egg-laying vertebrate animal', 'word': 'bird'},
      {'definition': 'A limbless cold-blooded vertebrate animal with gills', 'word': 'fish'},
      {'definition': 'A burrowing plant-eating mammal with long ears', 'word': 'rabbit'},
      {'definition': 'A fully grown female animal of a domesticated breed of ox', 'word': 'cow'},
    ];

    return ListView.builder(
      itemCount: definitions.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Match the definition:',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Definition: ${definitions[index]['definition']}',
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              DropdownButton<String>(
                hint: Text('Select the word', style: TextStyle(color: primaryColor)),
                value: matchSelectedWords[index].isEmpty
                    ? null
                    : matchSelectedWords[index],
                items: definitions.map((e) {
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

  // Helper function to style each exercise container
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
