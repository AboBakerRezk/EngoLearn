import 'package:flutter/material.dart';

class ExerciseHomePages3 extends StatefulWidget {
  @override
  _ExerciseHomePages3State createState() => _ExerciseHomePages3State();
}

class _ExerciseHomePages3State extends State<ExerciseHomePages3>
    with SingleTickerProviderStateMixin {
  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E);

  final List<Map<String, String>> matchDefinitions = [
    {
      'word': 'Empathy',
      'definition': 'The ability to understand and share feelings.'
    },
    {
      'word': 'Gratitude',
      'definition': 'The quality of being thankful.'
    },
    {'word': 'Innovation', 'definition': 'A new method or idea.'},
    {
      'word': 'Resilience',
      'definition': 'The capacity to recover quickly from difficulties.'
    },
    {
      'word': 'Curiosity',
      'definition': 'A strong desire to know or learn something.'
    },
  ];

  final List<Map<String, dynamic>> multipleChoiceQuestions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'Berlin', 'Madrid', 'Rome'],
      'answer': 'Paris',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      'answer': 'Mars',
      'selected': null,
      'feedback': ''
    },
  ];

  List<String> fillBlankFeedback = List.filled(6, '');
  List<String> unscrambleFeedback = List.filled(3, '');
  List<TextEditingController> fillBlankControllers =
  List.generate(6, (_) => TextEditingController());
  List<TextEditingController> unscrambleControllers =
  List.generate(3, (_) => TextEditingController());
  List<String> matchSelectedWords = List.filled(5, '');
  List<String> matchFeedback = List.filled(5, '');

  bool showFillBlankResults = false;
  bool showUnscrambleResults = false;
  bool showMatchResults = false;
  bool showMCQResults = false;

  @override
  void initState() {
    super.initState();
  }

  void nextExercise() {
    if (currentExercise < 3) {
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
          content: Text('Your total score is $score.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentExercise = 0;
                  score = 0;
                  // Reset all feedback and controllers
                  fillBlankFeedback = List.filled(6, '');
                  unscrambleFeedback = List.filled(3, '');
                  fillBlankControllers =
                      List.generate(6, (_) => TextEditingController());
                  unscrambleControllers =
                      List.generate(3, (_) => TextEditingController());
                  matchSelectedWords = List.filled(5, '');
                  matchFeedback = List.filled(5, '');
                  showFillBlankResults = false;
                  showUnscrambleResults = false;
                  showMatchResults = false;
                  showMCQResults = false;
                  multipleChoiceQuestions.forEach((question) {
                    question['selected'] = null;
                    question['feedback'] = '';
                  });
                });
              },
              child: Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  void evaluateCurrentExercise() {
    switch (currentExercise) {
      case 0:
        if (!showFillBlankResults) {
          setState(() {
            showFillBlankResults = true;
            evaluateFillBlanks();
          });
        }
        break;
      case 1:
        if (!showUnscrambleResults) {
          setState(() {
            showUnscrambleResults = true;
            evaluateUnscramble();
          });
        }
        break;
      case 2:
        if (!showMatchResults) {
          setState(() {
            showMatchResults = true;
            evaluateMatch();
          });
        }
        break;
      case 3:
        if (!showMCQResults) {
          setState(() {
            showMCQResults = true;
            evaluateMCQ();
          });
        }
        break;
    }
  }

  void evaluateFillBlanks() {
    List<String> correctAnswers = [
      'brave',
      'adventure',
      'moon',
      'journey',
      'perseverance',
      'treasure'
    ];

    for (int i = 0; i < fillBlankControllers.length; i++) {
      String userAnswer = fillBlankControllers[i].text.trim().toLowerCase();
      if (userAnswer == correctAnswers[i].toLowerCase()) {
        fillBlankFeedback[i] = 'Correct!';
        score++;
      } else {
        fillBlankFeedback[i] =
        'Incorrect! Correct answer: ${correctAnswers[i]}';
      }
    }
  }

  void evaluateUnscramble() {
    List<Map<String, String>> words = [
      {'scrambled': 'vretAdeun', 'correct': 'Adventure'},
      {'scrambled': 'Cuargeo', 'correct': 'Courage'},
      {'scrambled': 'ytsreMy', 'correct': 'Mystery'},
    ];

    for (int i = 0; i < unscrambleControllers.length; i++) {
      String userAnswer = unscrambleControllers[i].text.trim().toLowerCase();
      if (userAnswer == words[i]['correct']!.toLowerCase()) {
        unscrambleFeedback[i] = 'Correct!';
        score++;
      } else {
        unscrambleFeedback[i] =
        'Incorrect! Correct answer: ${words[i]['correct']}';
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

  void evaluateMCQ() {
    for (int i = 0; i < multipleChoiceQuestions.length; i++) {
      var question = multipleChoiceQuestions[i];
      if (question['selected'] == question['answer']) {
        question['feedback'] = 'Correct!';
        score++;
      } else {
        question['feedback'] =
        'Incorrect! Correct answer: ${question['answer']}';
      }
    }
  }

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
              icon: Icon(Icons.edit), label: 'Fill Blanks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shuffle), label: 'Unscramble'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Match'),
          BottomNavigationBarItem(
              icon: Icon(Icons.quiz), label: 'Multiple Choice'),
        ],
      ),
    );
  }

  Widget getExerciseWidget() {
    switch (currentExercise) {
      case 0:
        return fillInTheBlanksExercise();
      case 1:
        return unscrambleWordsExercise();
      case 2:
        return matchDefinitionExercise();
      case 3:
        return multipleChoiceExercise();
      default:
        return Center(child: Text('Select an exercise.'));
    }
  }

  Widget fillInTheBlanksExercise() {
    List<String> sentences = [
      'She is very _________.',
      'He loves to go on _________.',
      'The _________ was big and bright.',
      'They embarked on a challenging _________.',
      'His _________ helped him succeed.',
      'They found a hidden _________ in the cave.'
    ];

    return ListView.builder(
      itemCount: sentences.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(sentences[index]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: fillBlankControllers[index],
                ),
                if (showFillBlankResults)
                  Text(
                    fillBlankFeedback[index],
                    style: TextStyle(
                      color: fillBlankFeedback[index] == 'Correct!'
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
    List<Map<String, String>> words = [
      {'scrambled': 'vretAdeun', 'correct': 'Adventure'},
      {'scrambled': 'Cuargeo', 'correct': 'Courage'},
      {'scrambled': 'ytsreMy', 'correct': 'Mystery'},
    ];

    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('Unscramble: ${words[index]['scrambled']}'),
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

  Widget multipleChoiceExercise() {
    return ListView.builder(
      itemCount: multipleChoiceQuestions.length,
      itemBuilder: (context, index) {
        var question = multipleChoiceQuestions[index];
        return Card(
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
}
