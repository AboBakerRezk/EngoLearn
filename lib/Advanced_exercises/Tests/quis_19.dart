import 'package:flutter/material.dart';

class ExerciseHomePage19 extends StatefulWidget {
  @override
  _ExerciseHomePage19State createState() => _ExerciseHomePage19State();
}

class _ExerciseHomePage19State extends State<ExerciseHomePage19> {
  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E);

  // Data for Multiple Choice Questions
  final List<Map<String, dynamic>> multipleChoiceQuestions = [
    {
      'question': 'He faced his greatest _________ without hesitation.',
      'options': ['Challenge', 'Curiosity', 'Wisdom', 'Courage'],
      'answer': 'Challenge',
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
    // Additional questions
    {
      'question': 'The antonym of "ancient" is _________.',
      'options': ['Modern', 'Old', 'Historic', 'Medieval'],
      'answer': 'Modern',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Select the synonym of "happy".',
      'options': ['Sad', 'Joyful', 'Angry', 'Upset'],
      'answer': 'Joyful',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Which word best completes: "She has a strong _________ to succeed."',
      'options': ['Desire', 'Fear', 'Hesitation', 'Dislike'],
      'answer': 'Desire',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Find the antonym of "increase".',
      'options': ['Decrease', 'Grow', 'Expand', 'Enlarge'],
      'answer': 'Decrease',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Choose the synonym for "quick".',
      'options': ['Fast', 'Slow', 'Delayed', 'Late'],
      'answer': 'Fast',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Complete the analogy: "Bird is to Fly as Fish is to _________.',
      'options': ['Swim', 'Walk', 'Run', 'Jump'],
      'answer': 'Swim',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Which word fits: "He showed great _________ during the crisis."',
      'options': ['Bravery', 'Fear', 'Cowardice', 'Anxiety'],
      'answer': 'Bravery',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Find the synonym of "difficult".',
      'options': ['Hard', 'Easy', 'Simple', 'Clear'],
      'answer': 'Hard',
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
    // Additional phrases
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

  // Data for Synonym Exercise
  final List<Map<String, dynamic>> synonymQuestions = [
    {
      'word': 'Resilient',
      'options': ['Flexible', 'Rigid', 'Fragile', 'Sensitive'],
      'answer': 'Flexible',
      'selected': null,
      'feedback': ''
    },
    // Additional words
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

  // Data for Antonym Exercise
  final List<Map<String, dynamic>> antonymQuestions = [
    {
      'word': 'Optimistic',
      'options': ['Pessimistic', 'Confident', 'Hopeful', 'Cheerful'],
      'answer': 'Pessimistic',
      'selected': null,
      'feedback': ''
    },
    // Additional words
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

  // Data for Context Use Exercise
  final List<Map<String, dynamic>> contextUseQuestions = [
    {
      'word': 'Ambition',
      'userSentence': '',
      'feedback': ''
    },
    // Additional words
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

  // Data for Sentence Creation Exercise
  final List<String> sentenceCreationWords = [
    'happy', 'joyful', 'excited', 'delighted', 'content', 'pleased', 'thrilled', 'elated', 'cheerful', 'glad'
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
  bool showCompletePhraseResults = false;
  bool showSynonymResults = false;
  bool showAntonymResults = false;
  bool showContextUseResults = false;

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
              icon: Icon(Icons.text_fields), label: 'Complete Phrase'),
          BottomNavigationBarItem(
              icon: Icon(Icons.find_in_page), label: 'Find Synonym'),
          BottomNavigationBarItem(
              icon: Icon(Icons.find_replace), label: 'Find Antonym'),
          BottomNavigationBarItem(
              icon: Icon(Icons.create), label: 'Context Use'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), label: 'Sentence Creation'),
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
        return !showCompletePhraseResults;
      case 2:
        return !showSynonymResults;
      case 3:
        return !showAntonymResults;
      case 4:
        return !showContextUseResults;
      case 5:
        return !showSentenceResults;
      case 6:
        return !showUnscrambleResults;
      case 7:
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
        if (!showCompletePhraseResults) {
          setState(() {
            showCompletePhraseResults = true;
            evaluateCompletePhrase();
          });
        }
        break;
      case 2:
        if (!showSynonymResults) {
          setState(() {
            showSynonymResults = true;
            evaluateSynonym();
          });
        }
        break;
      case 3:
        if (!showAntonymResults) {
          setState(() {
            showAntonymResults = true;
            evaluateAntonym();
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
        if (!showSentenceResults) {
          setState(() {
            showSentenceResults = true;
            evaluateSentenceCreation();
          });
        }
        break;
      case 6:
        if (!showUnscrambleResults) {
          setState(() {
            showUnscrambleResults = true;
            evaluateUnscramble();
          });
        }
        break;
      case 7:
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
    if (currentExercise < 7) {
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

      // Reset Complete Phrase Questions
      completePhraseQuestions.forEach((phrase) {
        phrase['userAnswer'] = '';
        phrase['feedback'] = '';
      });
      showCompletePhraseResults = false;

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

      // Reset Context Use Questions
      contextUseQuestions.forEach((question) {
        question['userSentence'] = '';
        question['feedback'] = '';
      });
      showContextUseResults = false;

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
        return completePhraseExercise();
      case 2:
        return findSynonymExercise();
      case 3:
        return findAntonymExercise();
      case 4:
        return contextUseExercise();
      case 5:
        return sentenceCreationExercise();
      case 6:
        return unscrambleWordsExercise();
      case 7:
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
