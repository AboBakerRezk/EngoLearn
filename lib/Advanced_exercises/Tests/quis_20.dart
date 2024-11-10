import 'package:flutter/material.dart';

class ExerciseHomePage20 extends StatefulWidget {
  @override
  _ExerciseHomePage20State createState() => _ExerciseHomePage20State();
}

class _ExerciseHomePage20State extends State<ExerciseHomePage20> {
  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E);

  // Data for Multiple Choice Exercise
  final List<Map<String, dynamic>> multipleChoiceQuestions = [
    {
      'question': 'He faced his greatest ________ without hesitation.',
      'options': ['Challenge', 'Curiosity', 'Wisdom', 'Courage'],
      'answer': 'Challenge',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Her _________ helped her overcome many challenges.',
      'options': ['Opportunity', 'Challenge', 'Curiosity', 'Achievement'],
      'answer': 'Opportunity',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'The _________ of the city was evident in its architecture.',
      'options': ['Beauty', 'Noise', 'Population', 'Complexity'],
      'answer': 'Beauty',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'He showed great _________ during the crisis.',
      'options': ['Fear', 'Bravery', 'Cowardice', 'Anxiety'],
      'answer': 'Bravery',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Choose the word that best fits: "She has a strong _________ to learn."',
      'options': ['Desire', 'Aversion', 'Disinterest', 'Indifference'],
      'answer': 'Desire',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'The _________ of the novel captivated the readers.',
      'options': ['Plot', 'Cover', 'Length', 'Price'],
      'answer': 'Plot',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Select the word that completes: "He is known for his _________ decisions."',
      'options': ['Quick', 'Hasty', 'Thoughtful', 'Reckless'],
      'answer': 'Thoughtful',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Her _________ in the subject made her excel.',
      'options': ['Ignorance', 'Expertise', 'Disinterest', 'Confusion'],
      'answer': 'Expertise',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'He took a _________ to relax and rejuvenate.',
      'options': ['Journey', 'Break', 'Burden', 'Challenge'],
      'answer': 'Break',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'She was praised for her _________ to detail.',
      'options': ['Neglect', 'Inattention', 'Attention', 'Carelessness'],
      'answer': 'Attention',
      'selected': null,
      'feedback': ''
    },
  ];

  // Data for Find Synonym Exercise
  final List<Map<String, dynamic>> synonymQuestions = [
    {
      'word': 'Resilient',
      'options': ['Flexible', 'Rigid', 'Fragile', 'Sensitive'],
      'answer': 'Flexible',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Rapid',
      'options': ['Slow', 'Fast', 'Steady', 'Gradual'],
      'answer': 'Fast',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Brilliant',
      'options': ['Dull', 'Bright', 'Dark', 'Dim'],
      'answer': 'Bright',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Gigantic',
      'options': ['Tiny', 'Huge', 'Small', 'Little'],
      'answer': 'Huge',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Wealthy',
      'options': ['Poor', 'Rich', 'Broke', 'Needy'],
      'answer': 'Rich',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Silent',
      'options': ['Loud', 'Quiet', 'Noisy', 'Boisterous'],
      'answer': 'Quiet',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Begin',
      'options': ['Start', 'End', 'Finish', 'Close'],
      'answer': 'Start',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Glad',
      'options': ['Sad', 'Happy', 'Angry', 'Upset'],
      'answer': 'Happy',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Trustworthy',
      'options': ['Reliable', 'Dishonest', 'False', 'Unreliable'],
      'answer': 'Reliable',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Ancient',
      'options': ['Old', 'Modern', 'New', 'Recent'],
      'answer': 'Old',
      'selected': null,
      'feedback': ''
    },
  ];

  // Data for Find Antonym Exercise
  final List<Map<String, dynamic>> antonymQuestions = [
    {
      'word': 'Optimistic',
      'options': ['Pessimistic', 'Confident', 'Hopeful', 'Cheerful'],
      'answer': 'Pessimistic',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Hot',
      'options': ['Warm', 'Cold', 'Mild', 'Cool'],
      'answer': 'Cold',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Appear',
      'options': ['Vanish', 'Emerge', 'Show', 'Reveal'],
      'answer': 'Vanish',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Accept',
      'options': ['Receive', 'Reject', 'Agree', 'Admit'],
      'answer': 'Reject',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Brave',
      'options': ['Courageous', 'Bold', 'Cowardly', 'Fearless'],
      'answer': 'Cowardly',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Complex',
      'options': ['Simple', 'Complicated', 'Intricate', 'Elaborate'],
      'answer': 'Simple',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Increase',
      'options': ['Grow', 'Expand', 'Decrease', 'Enlarge'],
      'answer': 'Decrease',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Permanent',
      'options': ['Temporary', 'Lasting', 'Enduring', 'Stable'],
      'answer': 'Temporary',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Rigid',
      'options': ['Flexible', 'Stiff', 'Solid', 'Hard'],
      'answer': 'Flexible',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Benevolent',
      'options': ['Kind', 'Cruel', 'Generous', 'Friendly'],
      'answer': 'Cruel',
      'selected': null,
      'feedback': ''
    },
  ];

  // Data for Complete Phrase Exercise
  final List<Map<String, dynamic>> completePhraseQuestions = [
    {
      'phrase': 'Actions speak louder than _________.',
      'answer': 'words',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'phrase': 'Better late than _________.',
      'answer': 'never',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'phrase': 'Every cloud has a silver _________.',
      'answer': 'lining',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'phrase': 'Honesty is the best _________.',
      'answer': 'policy',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'phrase': 'Practice makes _________.',
      'answer': 'perfect',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'phrase': 'The early bird catches the _________.',
      'answer': 'worm',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'phrase': 'When in Rome, do as the Romans _________.',
      'answer': 'do',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'phrase': 'A picture is worth a thousand _________.',
      'answer': 'words',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'phrase': 'Don’t judge a book by its _________.',
      'answer': 'cover',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'phrase': 'Time is _________.',
      'answer': 'money',
      'userAnswer': '',
      'feedback': ''
    },
  ];

  // Data for Context Use Exercise
  final List<Map<String, dynamic>> contextUseQuestions = [
    {
      'word': 'Ambition',
      'userSentence': '',
      'feedback': ''
    },
    {
      'word': 'Harmony',
      'userSentence': '',
      'feedback': ''
    },
    {
      'word': 'Resilience',
      'userSentence': '',
      'feedback': ''
    },
    {
      'word': 'Innovation',
      'userSentence': '',
      'feedback': ''
    },
    {
      'word': 'Integrity',
      'userSentence': '',
      'feedback': ''
    },
    {
      'word': 'Compassion',
      'userSentence': '',
      'feedback': ''
    },
    {
      'word': 'Courage',
      'userSentence': '',
      'feedback': ''
    },
    {
      'word': 'Determination',
      'userSentence': '',
      'feedback': ''
    },
    {
      'word': 'Gratitude',
      'userSentence': '',
      'feedback': ''
    },
    {
      'word': 'Optimism',
      'userSentence': '',
      'feedback': ''
    },
  ];

  // Data for Analogies Exercise
  final List<Map<String, dynamic>> analogiesQuestions = [
    {
      'analogy': 'Bright is to Dark as Hot is to _________.',
      'options': ['Cold', 'Warm', 'Cool', 'Mild'],
      'answer': 'Cold',
      'selected': null,
      'feedback': ''
    },
    {
      'analogy': 'Day is to Night as Happy is to _________.',
      'options': ['Joyful', 'Sad', 'Excited', 'Glad'],
      'answer': 'Sad',
      'selected': null,
      'feedback': ''
    },
    {
      'analogy': 'Bird is to Fly as Fish is to _________.',
      'options': ['Walk', 'Swim', 'Run', 'Jump'],
      'answer': 'Swim',
      'selected': null,
      'feedback': ''
    },
    {
      'analogy': 'Up is to Down as Left is to _________.',
      'options': ['Right', 'Straight', 'Back', 'Forward'],
      'answer': 'Right',
      'selected': null,
      'feedback': ''
    },
    {
      'analogy': 'Big is to Small as Tall is to _________.',
      'options': ['High', 'Low', 'Short', 'Wide'],
      'answer': 'Short',
      'selected': null,
      'feedback': ''
    },
    {
      'analogy': 'Fire is to Hot as Ice is to _________.',
      'options': ['Cold', 'Warm', 'Cool', 'Mild'],
      'answer': 'Cold',
      'selected': null,
      'feedback': ''
    },
    {
      'analogy': 'Smile is to Happy as Frown is to _________.',
      'options': ['Glad', 'Sad', 'Joyful', 'Excited'],
      'answer': 'Sad',
      'selected': null,
      'feedback': ''
    },
    {
      'analogy': 'Pen is to Write as Knife is to _________.',
      'options': ['Cut', 'Draw', 'Paint', 'Sing'],
      'answer': 'Cut',
      'selected': null,
      'feedback': ''
    },
    {
      'analogy': 'Car is to Road as Plane is to _________.',
      'options': ['Sky', 'Water', 'Track', 'Tunnel'],
      'answer': 'Sky',
      'selected': null,
      'feedback': ''
    },
    {
      'analogy': 'Tree is to Forest as Star is to _________.',
      'options': ['Galaxy', 'Planet', 'Moon', 'Sun'],
      'answer': 'Galaxy',
      'selected': null,
      'feedback': ''
    },
  ];

  // Data for Fill in the Blanks Exercise
  final List<Map<String, dynamic>> fillInBlanksQuestions = [
    {
      'sentence': 'He is known for his __________.',
      'answer': 'dedication',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'sentence': 'Her __________ was evident in her performance.',
      'answer': 'brilliance',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'sentence': 'They need to improve their __________.',
      'answer': 'communication',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'sentence': 'His __________ helped him succeed.',
      'answer': 'perseverance',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'sentence': 'She showed great __________ in her work.',
      'answer': 'creativity',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'sentence': 'Their __________ is unparalleled.',
      'answer': 'teamwork',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'sentence': 'He was awarded for his __________.',
      'answer': 'excellence',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'sentence': 'Her __________ was inspiring.',
      'answer': 'leadership',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'sentence': 'They appreciated his __________.',
      'answer': 'honesty',
      'userAnswer': '',
      'feedback': ''
    },
    {
      'sentence': 'The project requires a lot of __________.',
      'answer': 'planning',
      'userAnswer': '',
      'feedback': ''
    },
  ];

  // Data for Sentence Creation Exercise
  final List<String> sentenceCreationWords = [
    'happy',
    'joyful',
    'excited',
    'delighted',
    'content',
    'pleased',
    'thrilled',
    'elated',
    'cheerful',
    'glad'
  ];
  List<TextEditingController> sentenceControllers =
  List.generate(10, (_) => TextEditingController());
  String sentenceFeedback = '';
  bool showSentenceResults = false;

  // Data for Unscramble Words Exercise
  final List<Map<String, String>> unscrambleWords = [
    {'scrambled': 'tac', 'correct': 'cat'},
    {'scrambled': 'god', 'correct': 'dog'},
    {'scrambled': 'rca', 'correct': 'car'},
    {'scrambled': 'trees', 'correct': 'reset'},
    {'scrambled': 'tca', 'correct': 'act'},
    {'scrambled': 'stop', 'correct': 'post'},
    {'scrambled': 'dust', 'correct': 'stud'},
    {'scrambled': 'name', 'correct': 'mean'},
    {'scrambled': 'bored', 'correct': 'robed'},
    {'scrambled': 'silent', 'correct': 'listen'},
  ];
  List<TextEditingController> unscrambleControllers =
  List.generate(10, (_) => TextEditingController());
  List<String> unscrambleFeedback = List.filled(10, '');
  bool showUnscrambleResults = false;

  // Data for Match Definition Exercise
  final List<Map<String, String>> matchDefinitions = [
    {'definition': 'A domesticated carnivorous mammal', 'word': 'cat'},
    {'definition': 'A large, heavy-bodied member of the dog family', 'word': 'dog'},
    {'definition': 'A road vehicle, typically with four wheels', 'word': 'car'},
    {'definition': 'A plant with leaves, branches, and a trunk', 'word': 'tree'},
    {'definition': 'An action or process of moving or being moved', 'word': 'motion'},
    {'definition': 'A celestial body moving in an elliptical orbit', 'word': 'planet'},
    {'definition': 'A large natural stream of water', 'word': 'river'},
    {'definition': 'A piece of furniture with a flat top and legs', 'word': 'table'},
    {'definition': 'A building for human habitation', 'word': 'house'},
    {'definition': 'A tool with a heavy metal head', 'word': 'hammer'},
  ];
  List<String> matchSelectedWords = List.filled(10, '');
  List<String> matchFeedback = List.filled(10, '');
  bool showMatchResults = false;

  // Control variables for feedback
  bool showMCQResults = false;
  bool showSynonymResults = false;
  bool showAntonymResults = false;
  bool showCompletePhraseResults = false;
  bool showContextUseResults = false;
  bool showAnalogiesResults = false;
  bool showFillInBlanksResults = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: nextExercise,
        backgroundColor: primaryColor,
        child: Icon(Icons.arrow_forward, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentExercise,
        onTap: (index) {
          setState(() {
            currentExercise = index;
          });
        },
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.quiz), label: 'Multiple Choice'),
          BottomNavigationBarItem(
              icon: Icon(Icons.find_in_page), label: 'Find Synonym'),
          BottomNavigationBarItem(
              icon: Icon(Icons.find_replace), label: 'Find Antonym'),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_fields), label: 'Complete Phrase'),
          BottomNavigationBarItem(
              icon: Icon(Icons.create), label: 'Context Use'),
          BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows), label: 'Analogies'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), label: 'Fill Blanks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_snippet), label: 'Sentence Creation'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shuffle), label: 'Unscramble Words'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: 'Match Definitions'),
        ],
      ),
    );
  }
  // Function to check if the current exercise can be evaluated
  bool canEvaluateCurrentExercise() {
    switch (currentExercise) {
      case 0:
        return !showMCQResults;
      case 1:
        return !showSynonymResults;
      case 2:
        return !showAntonymResults;
      case 3:
        return !showCompletePhraseResults;
      case 4:
        return !showContextUseResults;
      case 5:
        return !showAnalogiesResults;
      case 6:
        return !showFillInBlanksResults;
      case 7:
        return !showSentenceResults;
      case 8:
        return !showUnscrambleResults;
      case 9:
        return !showMatchResults;
      default:
        return false;
    }
  }

  // Function to evaluate the current exercise
  void evaluateCurrentExercise() {
    switch (currentExercise) {
      case 0:
        if (!showMCQResults) {
          setState(() {
            showMCQResults = true;
            evaluateMCQ();
          });
        }
        break;
      case 1:
        if (!showSynonymResults) {
          setState(() {
            showSynonymResults = true;
            evaluateSynonym();
          });
        }
        break;
      case 2:
        if (!showAntonymResults) {
          setState(() {
            showAntonymResults = true;
            evaluateAntonym();
          });
        }
        break;
      case 3:
        if (!showCompletePhraseResults) {
          setState(() {
            showCompletePhraseResults = true;
            evaluateCompletePhrase();
          });
        }
        break;
      case 4:
        if (!showContextUseResults) {
          setState(() {
            showContextUseResults = true;
            evaluateContextUse();
          });
        }
        break;
      case 5:
        if (!showAnalogiesResults) {
          setState(() {
            showAnalogiesResults = true;
            evaluateAnalogies();
          });
        }
        break;
      case 6:
        if (!showFillInBlanksResults) {
          setState(() {
            showFillInBlanksResults = true;
            evaluateFillInBlanks();
          });
        }
        break;
      case 7:
        if (!showSentenceResults) {
          setState(() {
            showSentenceResults = true;
            evaluateSentenceCreation();
          });
        }
        break;
      case 8:
        if (!showUnscrambleResults) {
          setState(() {
            showUnscrambleResults = true;
            evaluateUnscramble();
          });
        }
        break;
      case 9:
        if (!showMatchResults) {
          setState(() {
            showMatchResults = true;
            evaluateMatchDefinitions();
          });
        }
        break;
    }
  }

  // Function to move to the next exercise
  void nextExercise() {
    if (currentExercise < 9) {
      setState(() {
        currentExercise++;
      });
    } else {
      showSummaryDialog();
    }
  }

  // Function to display the summary dialog
  void showSummaryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Great Job!'),
          content: Text('Your total score is $score.'),
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

  // Function to reset all exercises
  void resetExercises() {
    setState(() {
      currentExercise = 0;
      score = 0;

      // Reset Multiple Choice Questions
      multipleChoiceQuestions.forEach((question) {
        question['selected'] = null;
        question['feedback'] = '';
      });
      showMCQResults = false;

      // Reset Synonym Questions
      synonymQuestions.forEach((question) {
        question['selected'] = null;
        question['feedback'] = '';
      });
      showSynonymResults = false;

      // Reset Antonym Questions
      antonymQuestions.forEach((question) {
        question['selected'] = null;
        question['feedback'] = '';
      });
      showAntonymResults = false;

      // Reset Complete Phrase Questions
      completePhraseQuestions.forEach((phrase) {
        phrase['userAnswer'] = '';
        phrase['feedback'] = '';
      });
      showCompletePhraseResults = false;

      // Reset Context Use Questions
      contextUseQuestions.forEach((question) {
        question['userSentence'] = '';
        question['feedback'] = '';
      });
      showContextUseResults = false;

      // Reset Analogies Questions
      analogiesQuestions.forEach((question) {
        question['selected'] = null;
        question['feedback'] = '';
      });
      showAnalogiesResults = false;

      // Reset Fill in the Blanks Questions
      fillInBlanksQuestions.forEach((question) {
        question['userAnswer'] = '';
        question['feedback'] = '';
      });
      showFillInBlanksResults = false;

      // Reset Sentence Creation
      sentenceControllers =
          List.generate(1, (_) => TextEditingController());
      sentenceFeedback = '';
      showSentenceResults = false;

      // Reset Unscramble Words
      unscrambleControllers =
          List.generate(unscrambleWords.length, (_) => TextEditingController());
      unscrambleFeedback = List.filled(unscrambleWords.length, '');
      showUnscrambleResults = false;

      // Reset Match Definitions
      matchSelectedWords = List.filled(matchDefinitions.length, '');
      matchFeedback = List.filled(matchDefinitions.length, '');
      showMatchResults = false;
    });
  }

  // Function to get the current exercise widget
  Widget getExerciseWidget() {
    switch (currentExercise) {
      case 0:
        return multipleChoiceExercise();
      case 1:
        return findSynonymExercise();
      case 2:
        return findAntonymExercise();
      case 3:
        return completePhraseExercise();
      case 4:
        return contextUseExercise();
      case 5:
        return analogiesExercise();
      case 6:
        return fillInBlanksExercise();
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

  // Multiple Choice Exercise Widget
  Widget multipleChoiceExercise() {
    return ListView.builder(
      itemCount: multipleChoiceQuestions.length,
      itemBuilder: (context, index) {
        var question = multipleChoiceQuestions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(question['question']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...question['options'].map<Widget>((option) {
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: question['selected'],
                    onChanged: (value) {
                      setState(() {
                        question['selected'] = value;
                      });
                    },
                  );
                }).toList(),
                if (showMCQResults)
                  Text(
                    question['feedback'],
                    style: TextStyle(
                      color: question['feedback'] == 'Correct!'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Evaluation function for Multiple Choice
  void evaluateMCQ() {
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

  // Find Synonym Exercise Widget
  Widget findSynonymExercise() {
    return ListView.builder(
      itemCount: synonymQuestions.length,
      itemBuilder: (context, index) {
        var question = synonymQuestions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Find the synonym for the word: ${question['word']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...question['options'].map<Widget>((option) {
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: question['selected'],
                    onChanged: (value) {
                      setState(() {
                        question['selected'] = value;
                      });
                    },
                  );
                }).toList(),
                if (showSynonymResults)
                  Text(
                    question['feedback'],
                    style: TextStyle(
                      color: question['feedback'] == 'Correct!'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Evaluation function for Synonym Exercise
  void evaluateSynonym() {
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

  // Find Antonym Exercise Widget
  Widget findAntonymExercise() {
    return ListView.builder(
      itemCount: antonymQuestions.length,
      itemBuilder: (context, index) {
        var question = antonymQuestions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Find the antonym for the word: ${question['word']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...question['options'].map<Widget>((option) {
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: question['selected'],
                    onChanged: (value) {
                      setState(() {
                        question['selected'] = value;
                      });
                    },
                  );
                }).toList(),
                if (showAntonymResults)
                  Text(
                    question['feedback'],
                    style: TextStyle(
                      color: question['feedback'] == 'Correct!'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Evaluation function for Antonym Exercise
  void evaluateAntonym() {
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

  // Complete Phrase Exercise Widget
  Widget completePhraseExercise() {
    return ListView.builder(
      itemCount: completePhraseQuestions.length,
      itemBuilder: (context, index) {
        var phrase = completePhraseQuestions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(phrase['phrase']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) {
                    phrase['userAnswer'] = value.trim();
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your answer',
                  ),
                ),
                if (showCompletePhraseResults)
                  Text(
                    phrase['feedback'],
                    style: TextStyle(
                      color: phrase['feedback'] == 'Correct!'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Evaluation function for Complete Phrase
  void evaluateCompletePhrase() {
    for (var phrase in completePhraseQuestions) {
      if (phrase['userAnswer'].toLowerCase() ==
          phrase['answer'].toLowerCase()) {
        phrase['feedback'] = 'Correct!';
        score++;
      } else {
        phrase['feedback'] =
        'Incorrect! Correct answer: ${phrase['answer']}';
      }
    }
  }

  // Context Use Exercise Widget
  Widget contextUseExercise() {
    return ListView.builder(
      itemCount: contextUseQuestions.length,
      itemBuilder: (context, index) {
        var question = contextUseQuestions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Use the word "${question['word']}" in a sentence'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) {
                    question['userSentence'] = value.trim();
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your sentence',
                  ),
                ),
                if (showContextUseResults)
                  Text(
                    question['feedback'],
                    style: TextStyle(
                      color: question['feedback'] == 'Correct!'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Evaluation function for Context Use Exercise
  void evaluateContextUse() {
    for (var question in contextUseQuestions) {
      if (question['userSentence']
          .toLowerCase()
          .contains(question['word'].toLowerCase())) {
        question['feedback'] = 'Correct!';
        score++;
      } else {
        question['feedback'] =
        'Incorrect! Please include the word "${question['word']}" in your sentence.';
      }
    }
  }

  // Analogies Exercise Widget
  Widget analogiesExercise() {
    return ListView.builder(
      itemCount: analogiesQuestions.length,
      itemBuilder: (context, index) {
        var question = analogiesQuestions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(question['analogy']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...question['options'].map<Widget>((option) {
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: question['selected'],
                    onChanged: (value) {
                      setState(() {
                        question['selected'] = value;
                      });
                    },
                  );
                }).toList(),
                if (showAnalogiesResults)
                  Text(
                    question['feedback'],
                    style: TextStyle(
                      color: question['feedback'] == 'Correct!'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Evaluation function for Analogies Exercise
  void evaluateAnalogies() {
    for (var question in analogiesQuestions) {
      if (question['selected'] == question['answer']) {
        question['feedback'] = 'Correct!';
        score++;
      } else {
        question['feedback'] =
        'Incorrect! Correct answer: ${question['answer']}';
      }
    }
  }

  // Fill in the Blanks Exercise Widget
  Widget fillInBlanksExercise() {
    return ListView.builder(
      itemCount: fillInBlanksQuestions.length,
      itemBuilder: (context, index) {
        var question = fillInBlanksQuestions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(question['sentence']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) {
                    question['userAnswer'] = value.trim();
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your answer',
                  ),
                ),
                if (showFillInBlanksResults)
                  Text(
                    question['feedback'],
                    style: TextStyle(
                      color: question['feedback'] == 'Correct!'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Evaluation function for Fill in the Blanks Exercise
  void evaluateFillInBlanks() {
    for (var question in fillInBlanksQuestions) {
      if (question['userAnswer'].toLowerCase() ==
          question['answer'].toLowerCase()) {
        question['feedback'] = 'Correct!';
        score++;
      } else {
        question['feedback'] =
        'Incorrect! Correct answer: ${question['answer']}';
      }
    }
  }

  // Sentence Creation Exercise Widget
  Widget sentenceCreationExercise() {
    return ListView(
      children: [
        Text(
          'Create a sentence using these words:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(sentenceCreationWords.join(', ')),
        SizedBox(height: 10),
        TextField(
          controller: sentenceControllers[0],
          decoration: InputDecoration(
            hintText: 'Enter your sentence',
            border: OutlineInputBorder(),
          ),
        ),
        if (showSentenceResults)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              sentenceFeedback,
              style: TextStyle(
                color: sentenceFeedback == 'Correct!'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  // Evaluation function for Sentence Creation
  void evaluateSentenceCreation() {
    String userSentence = sentenceControllers[0].text.trim().toLowerCase();
    bool containsAllWords = sentenceCreationWords
        .every((word) => userSentence.contains(word.toLowerCase()));
    if (containsAllWords) {
      sentenceFeedback = 'Correct!';
      score++;
    } else {
      sentenceFeedback = 'Incorrect! Make sure to use all the words.';
    }
  }

  // Unscramble Words Exercise Widget
  Widget unscrambleWordsExercise() {
    return ListView.builder(
      itemCount: unscrambleWords.length,
      itemBuilder: (context, index) {
        var word = unscrambleWords[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Unscramble the word: ${word['scrambled']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: unscrambleControllers[index],
                  decoration: InputDecoration(
                    hintText: 'Enter the correct word',
                  ),
                ),
                if (showUnscrambleResults)
                  Text(
                    unscrambleFeedback[index],
                    style: TextStyle(
                      color: unscrambleFeedback[index] == 'Correct!'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Evaluation function for Unscramble Words
  void evaluateUnscramble() {
    for (int i = 0; i < unscrambleWords.length; i++) {
      String userAnswer = unscrambleControllers[i].text.trim().toLowerCase();
      String correctAnswer = unscrambleWords[i]['correct']!.toLowerCase();
      if (userAnswer == correctAnswer) {
        unscrambleFeedback[i] = 'Correct!';
        score++;
      } else {
        unscrambleFeedback[i] =
        'Incorrect! Correct answer: ${unscrambleWords[i]['correct']}';
      }
    }
  }

  // Match Definitions Exercise Widget
  Widget matchDefinitionExercise() {
    return ListView.builder(
      itemCount: matchDefinitions.length,
      itemBuilder: (context, index) {
        var item = matchDefinitions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Definition: ${item['definition']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<String>(
                  hint: Text('Select a word'),
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
                if (showMatchResults)
                  Text(
                    matchFeedback[index],
                    style: TextStyle(
                      color: matchFeedback[index] == 'Correct!'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Evaluation function for Match Definitions
  void evaluateMatchDefinitions() {
    for (int i = 0; i < matchDefinitions.length; i++) {
      if (matchSelectedWords[i] == matchDefinitions[i]['word']) {
        matchFeedback[i] = 'Correct!';
        score++;
      } else {
        matchFeedback[i] =
        'Incorrect! Correct answer: ${matchDefinitions[i]['word']}';
      }
    }
  }
}
