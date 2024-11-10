import 'package:flutter/material.dart';

class ExerciseHomePage16 extends StatefulWidget {
  @override
  _ExerciseHomePage16State createState() => _ExerciseHomePage16State();
}

class _ExerciseHomePage16State extends State<ExerciseHomePage16> {
  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E);

  // Updated lists with 10 questions each
  final List<Map<String, dynamic>> multipleChoiceQuestions = [
    {
      'question': 'The cat climbed up the _________.',
      'options': ['tree', 'dog', 'book', 'car'],
      'answer': 'tree',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'She _________ to the store.',
      'options': ['went', 'goes', 'gone', 'going'],
      'answer': 'went',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'He is as fast as a _________.',
      'options': ['snail', 'cheetah', 'turtle', 'sloth'],
      'answer': 'cheetah',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'The sun rises in the _________.',
      'options': ['north', 'south', 'east', 'west'],
      'answer': 'east',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Which color is a primary color?',
      'options': ['Green', 'Purple', 'Red', 'Orange'],
      'answer': 'Red',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Water freezes at _________ degrees Celsius.',
      'options': ['0', '100', '50', '25'],
      'answer': '0',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'A baby cat is called a _________.',
      'options': ['puppy', 'kitten', 'calf', 'cub'],
      'answer': 'kitten',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Which is the largest planet in our solar system?',
      'options': ['Earth', 'Mars', 'Jupiter', 'Venus'],
      'answer': 'Jupiter',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'An octagon has _________ sides.',
      'options': ['6', '7', '8', '9'],
      'answer': '8',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'What do bees collect from flowers?',
      'options': ['Honey', 'Nectar', 'Water', 'Pollen'],
      'answer': 'Nectar',
      'selected': null,
      'feedback': ''
    },
  ];

  final List<String> completePhraseQuestions = [
    'An apple a day keeps the ________ away.',
    'The early bird catches the ________.',
    'A picture is worth a thousand ________.',
    'Better late than ________.',
    'When in Rome, do as the Romans ________.',
    'The pen is mightier than the ________.',
    'Actions speak louder than ________.',
    'Don’t count your chickens before they ________.',
    'Honesty is the best ________.',
    'Practice makes ________.',
  ];

  final List<String> completePhraseAnswers = [
    'doctor',
    'worm',
    'words',
    'never',
    'do',
    'sword',
    'words',
    'hatch',
    'policy',
    'perfect',
  ];

  List<TextEditingController> completePhraseControllers =
  List.generate(10, (_) => TextEditingController());
  List<String> completePhraseFeedback = List.filled(10, '');
  bool showCompletePhraseResults = false;

  final List<String> contextUseWords = [
    'Happy',
    'Bright',
    'Calm',
    'Brave',
    'Gentle',
    'Loud',
    'Quick',
    'Quiet',
    'Strong',
    'Warm',
  ];

  List<TextEditingController> contextUseControllers =
  List.generate(10, (_) => TextEditingController());
  List<String> contextUseFeedback = List.filled(10, '');
  bool showContextUseResults = false;

  final List<List<String>> sentenceCreationWords = [
    ['happy', 'joyful', 'excited'],
    ['sad', 'down', 'blue'],
    ['fast', 'quick', 'swift'],
    ['slow', 'steady', 'calm'],
    ['bright', 'shiny', 'glow'],
    ['dark', 'dim', 'shadow'],
    ['strong', 'powerful', 'mighty'],
    ['weak', 'fragile', 'delicate'],
    ['hot', 'warm', 'heat'],
    ['cold', 'chilly', 'freeze'],
  ];

  List<TextEditingController> sentenceCreationControllers =
  List.generate(10, (_) => TextEditingController());
  List<String> sentenceCreationFeedback = List.filled(10, '');
  bool showSentenceCreationResults = false;

  final List<Map<String, String>> unscrambleWords = [
    {'scrambled': 'tac', 'correct': 'cat'},
    {'scrambled': 'god', 'correct': 'dog'},
    {'scrambled': 'esuom', 'correct': 'mouse'},
    {'scrambled': 'tihbrd', 'correct': 'bird'},
    {'scrambled': 'hsfi', 'correct': 'fish'},
    {'scrambled': 'fnoehlat', 'correct': 'elephant'},
    {'scrambled': 'erlgtu', 'correct': 'tiger'},
    {'scrambled': 'knilo', 'correct': 'lion'},
    {'scrambled': 'ezber', 'correct': 'zebra'},
    {'scrambled': 'ckdu', 'correct': 'duck'},
  ];

  List<TextEditingController> unscrambleControllers =
  List.generate(10, (_) => TextEditingController());
  List<String> unscrambleFeedback = List.filled(10, '');
  bool showUnscrambleResults = false;

  final List<Map<String, String>> matchDefinitions = [
    {'definition': 'A domesticated mammal', 'word': 'cat'},
    {'definition': 'A member of the dog family', 'word': 'dog'},
    {'definition': 'A small rodent', 'word': 'mouse'},
    {'definition': 'An animal that flies', 'word': 'bird'},
    {'definition': 'An aquatic creature', 'word': 'fish'},
    {'definition': 'Largest land animal', 'word': 'elephant'},
    {'definition': 'A big cat with stripes', 'word': 'tiger'},
    {'definition': 'King of the jungle', 'word': 'lion'},
    {'definition': 'An animal with black and white stripes', 'word': 'zebra'},
    {'definition': 'A waterbird with webbed feet', 'word': 'duck'},
  ];

  List<String> matchSelectedWords = List.filled(10, '');
  List<String> matchFeedback = List.filled(10, '');
  bool showMatchResults = false;

  bool showMCQResults = false;

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
              icon: Icon(Icons.edit), label: 'Complete Phrase'),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_fields), label: 'Context Use'),
          BottomNavigationBarItem(
              icon: Icon(Icons.create), label: 'Sentence Creation'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shuffle), label: 'Unscramble'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: 'Match Definitions'),
        ],
      ),
    );
  }

  bool isShowResultsDisabled() {
    return (currentExercise == 0 && showMCQResults) ||
        (currentExercise == 1 && showCompletePhraseResults) ||
        (currentExercise == 2 && showContextUseResults) ||
        (currentExercise == 3 && showSentenceCreationResults) ||
        (currentExercise == 4 && showUnscrambleResults) ||
        (currentExercise == 5 && showMatchResults);
  }

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
        if (!showContextUseResults) {
          setState(() {
            showContextUseResults = true;
            evaluateContextUse();
          });
        }
        break;
      case 3:
        if (!showSentenceCreationResults) {
          setState(() {
            showSentenceCreationResults = true;
            evaluateSentenceCreation();
          });
        }
        break;
      case 4:
        if (!showUnscrambleResults) {
          setState(() {
            showUnscrambleResults = true;
            evaluateUnscramble();
          });
        }
        break;
      case 5:
        if (!showMatchResults) {
          setState(() {
            showMatchResults = true;
            evaluateMatch();
          });
        }
        break;
    }
  }

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

  void evaluateCompletePhrase() {
    for (int i = 0; i < completePhraseControllers.length; i++) {
      String userAnswer = completePhraseControllers[i].text.trim().toLowerCase();
      if (userAnswer == completePhraseAnswers[i].toLowerCase()) {
        completePhraseFeedback[i] = 'Correct!';
        score++;
      } else {
        completePhraseFeedback[i] =
        'Incorrect! Correct answer: ${completePhraseAnswers[i]}';
      }
    }
  }

  void evaluateContextUse() {
    for (int i = 0; i < contextUseControllers.length; i++) {
      String userSentence = contextUseControllers[i].text.trim().toLowerCase();
      if (userSentence.contains(contextUseWords[i].toLowerCase())) {
        contextUseFeedback[i] = 'Correct usage!';
        score++;
      } else {
        contextUseFeedback[i] =
        'Please use the word "${contextUseWords[i]}" in your sentence.';
      }
    }
  }

  void evaluateSentenceCreation() {
    for (int i = 0; i < sentenceCreationControllers.length; i++) {
      String sentence = sentenceCreationControllers[i].text.trim().toLowerCase();
      List<String> words = sentenceCreationWords[i];
      if (words.every((word) => sentence.contains(word.toLowerCase()))) {
        sentenceCreationFeedback[i] = 'Great sentence!';
        score++;
      } else {
        sentenceCreationFeedback[i] =
        'Please include all the words: ${words.join(", ")}';
      }
    }
  }

  void evaluateUnscramble() {
    for (int i = 0; i < unscrambleControllers.length; i++) {
      String userAnswer = unscrambleControllers[i].text.trim().toLowerCase();
      if (userAnswer == unscrambleWords[i]['correct']) {
        unscrambleFeedback[i] = 'Correct!';
        score++;
      } else {
        unscrambleFeedback[i] =
        'Incorrect! Correct answer: ${unscrambleWords[i]['correct']}';
      }
    }
  }

  void evaluateMatch() {
    for (int i = 0; i < matchSelectedWords.length; i++) {
      if (matchSelectedWords[i] == matchDefinitions[i]['word']) {
        matchFeedback[i] = 'Correct!';
        score++;
      } else {
        matchFeedback[i] =
        'Incorrect! Correct answer: ${matchDefinitions[i]['word']}';
      }
    }
  }

  void nextExercise() {
    if (currentExercise < 5) {
      setState(() {
        currentExercise++;
      });
    } else {
      showSummaryDialog();
    }
  }

  void showSummaryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Great Job!'),
          content: Text('Your total score is $score out of 60.'),
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

  void resetExercises() {
    setState(() {
      currentExercise = 0;
      score = 0;

      // Reset multiple choice
      for (var question in multipleChoiceQuestions) {
        question['selected'] = null;
        question['feedback'] = '';
      }
      showMCQResults = false;

      // Reset complete phrase
      completePhraseControllers =
          List.generate(10, (_) => TextEditingController());
      completePhraseFeedback = List.filled(10, '');
      showCompletePhraseResults = false;

      // Reset context use
      contextUseControllers =
          List.generate(10, (_) => TextEditingController());
      contextUseFeedback = List.filled(10, '');
      showContextUseResults = false;

      // Reset sentence creation
      sentenceCreationControllers =
          List.generate(10, (_) => TextEditingController());
      sentenceCreationFeedback = List.filled(10, '');
      showSentenceCreationResults = false;

      // Reset unscramble words
      unscrambleControllers =
          List.generate(10, (_) => TextEditingController());
      unscrambleFeedback = List.filled(10, '');
      showUnscrambleResults = false;

      // Reset match definitions
      matchSelectedWords = List.filled(10, '');
      matchFeedback = List.filled(10, '');
      showMatchResults = false;
    });
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
        return sentenceCreationExercise();
      case 4:
        return unscrambleWordsExercise();
      case 5:
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

  Widget completePhraseExercise() {
    return ListView.builder(
      itemCount: completePhraseQuestions.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(completePhraseQuestions[index]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: completePhraseControllers[index],
                ),
                if (showCompletePhraseResults)
                  Text(
                    completePhraseFeedback[index],
                    style: TextStyle(
                      color: completePhraseFeedback[index] == 'Correct!'
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

  Widget contextUseExercise() {
    return ListView.builder(
      itemCount: contextUseWords.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Use the word "${contextUseWords[index]}" in a sentence:'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: contextUseControllers[index],
                ),
                if (showContextUseResults)
                  Text(
                    contextUseFeedback[index],
                    style: TextStyle(
                      color: contextUseFeedback[index] == 'Correct usage!'
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

  Widget sentenceCreationExercise() {
    return ListView.builder(
      itemCount: sentenceCreationWords.length,
      itemBuilder: (context, index) {
        List<String> words = sentenceCreationWords[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Create a sentence using these words: ${words.join(", ")}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: sentenceCreationControllers[index],
                ),
                if (showSentenceCreationResults)
                  Text(
                    sentenceCreationFeedback[index],
                    style: TextStyle(
                      color: sentenceCreationFeedback[index] == 'Great sentence!'
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

  Widget unscrambleWordsExercise() {
    return ListView.builder(
      itemCount: unscrambleWords.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text('Unscramble: ${unscrambleWords[index]['scrambled']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: unscrambleControllers[index],
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

  Widget matchDefinitionExercise() {
    return ListView.builder(
      itemCount: matchDefinitions.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(matchDefinitions[index]['definition']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<String>(
                  hint: Text('Select'),
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
}
