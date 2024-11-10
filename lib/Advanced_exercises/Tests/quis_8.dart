import 'package:flutter/material.dart';

class ExerciseHomePage8 extends StatefulWidget {
  @override
  _ExerciseHomePage8State createState() => _ExerciseHomePage8State();
}

class _ExerciseHomePage8State extends State<ExerciseHomePage8> {
  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E);

  // Variables for controlling inputs and feedback
  List<TextEditingController> fillBlankControllers = [];
  List<String> fillBlankFeedback = [];
  bool showFillBlankResults = false;

  List<TextEditingController> sentenceControllers = [];
  String sentenceFeedback = '';
  bool showSentenceResults = false;

  List<TextEditingController> unscrambleControllers = [];
  List<String> unscrambleFeedback = [];
  bool showUnscrambleResults = false;

  List<String> matchSelectedWords = [];
  List<String> matchFeedback = [];
  bool showMatchResults = false;

  List<Map<String, dynamic>> multipleChoiceQuestions = [];
  bool showMCQResults = false;

  @override
  void initState() {
    super.initState();

    // Initialize variables
    fillBlankControllers = List.generate(5, (_) => TextEditingController());
    fillBlankFeedback = List.filled(5, '');

    sentenceControllers = List.generate(5, (_) => TextEditingController());

    unscrambleControllers = List.generate(5, (_) => TextEditingController());
    unscrambleFeedback = List.filled(5, '');

    matchSelectedWords = List.filled(5, '');
    matchFeedback = List.filled(5, '');

    multipleChoiceQuestions = [
      {
        'question': 'The city known as the birthplace of Jesus is _________.',
        'options': ['Bethlehem', 'Jerusalem', 'Nazareth'],
        'answer': 'Bethlehem',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'The traditional Palestinian dance is called _________.',
        'options': ['Salsa', 'Dabke', 'Tango'],
        'answer': 'Dabke',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'The Dead Sea is located between Jordan and _________.',
        'options': ['Palestine', 'Egypt', 'Lebanon'],
        'answer': 'Palestine',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '_________ is a famous Palestinian dish made with rice and meat.',
        'options': ['Maqluba', 'Sushi', 'Pizza'],
        'answer': 'Maqluba',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'The city of Nablus is famous for its _________.',
        'options': ['Olive Oil Soap', 'Chocolate', 'Diamonds'],
        'answer': 'Olive Oil Soap',
        'selected': null,
        'feedback': ''
      },
    ];
  }

  void nextExercise() {
    if (currentExercise < 4) {
      setState(() {
        currentExercise++;
      });
    } else {
      showSummaryDialog();
    }
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
        if (!showSentenceResults) {
          setState(() {
            showSentenceResults = true;
            evaluateSentences();
          });
        }
        break;
      case 2:
        if (!showUnscrambleResults) {
          setState(() {
            showUnscrambleResults = true;
            evaluateUnscramble();
          });
        }
        break;
      case 3:
        if (!showMatchResults) {
          setState(() {
            showMatchResults = true;
            evaluateMatch();
          });
        }
        break;
      case 4:
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
    List<String> correctAnswers = ['Bethlehem', 'Dabke', 'Palestine', 'Maqluba', 'Olive Oil Soap'];

    for (int i = 0; i < fillBlankControllers.length; i++) {
      String userAnswer = fillBlankControllers[i].text.trim();
      if (userAnswer.toLowerCase() == correctAnswers[i].toLowerCase()) {
        fillBlankFeedback[i] = 'Correct!';
        score++;
      } else {
        fillBlankFeedback[i] = 'Incorrect! Correct answer: ${correctAnswers[i]}';
      }
    }
  }

  void evaluateSentences() {
    bool allFilled = sentenceControllers.every((controller) => controller.text.trim().isNotEmpty);

    setState(() {
      sentenceFeedback = allFilled ? 'All sentences are filled!' : 'Please fill all sentences.';
      if (allFilled) score++;
    });
  }

  void evaluateUnscramble() {
    List<Map<String, String>> scrambledWords = [
      {'scrambled': 'hBeetlhem', 'correct': 'Bethlehem'},
      {'scrambled': 'aDbke', 'correct': 'Dabke'},
      {'scrambled': 'Nlsuab', 'correct': 'Nablus'},
      {'scrambled': 'Muqaabl', 'correct': 'Maqluba'},
      {'scrambled': 'alipetnse', 'correct': 'Palestine'}
    ];

    for (int i = 0; i < unscrambleControllers.length; i++) {
      String userAnswer = unscrambleControllers[i].text.trim();
      if (userAnswer.toLowerCase() == scrambledWords[i]['correct']!.toLowerCase()) {
        unscrambleFeedback[i] = 'Correct!';
        score++;
      } else {
        unscrambleFeedback[i] = 'Incorrect! Correct answer: ${scrambledWords[i]['correct']}';
      }
    }
  }

  void evaluateMatch() {
    List<Map<String, String>> definitions = [
      {'word': 'Bethlehem', 'definition': 'City known as the birthplace of Jesus.'},
      {'word': 'Dabke', 'definition': 'Traditional Palestinian folk dance.'},
      {'word': 'Dead Sea', 'definition': 'Salt lake bordering Palestine and Jordan.'},
      {'word': 'Maqluba', 'definition': 'Traditional Palestinian dish of rice and meat.'},
      {'word': 'Nablus', 'definition': 'City famous for olive oil soap.'}
    ];

    for (int i = 0; i < matchSelectedWords.length; i++) {
      if (matchSelectedWords[i].toLowerCase() == definitions[i]['word']!.toLowerCase()) {
        matchFeedback[i] = 'Correct!';
        score++;
      } else {
        matchFeedback[i] = 'Incorrect! Correct answer: ${definitions[i]['word']}';
      }
    }
  }

  void evaluateMCQ() {
    for (var question in multipleChoiceQuestions) {
      if (question['selected'] == question['answer']) {
        question['feedback'] = 'Correct!';
        score++;
      } else {
        question['feedback'] = 'Incorrect! Correct answer: ${question['answer']}';
      }
    }
  }

  void showSummaryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Great Job!'),
          content: Text('Your total score is $score out of 16.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  // Reset all variables
                  currentExercise = 0;
                  score = 0;

                  fillBlankControllers = List.generate(5, (_) => TextEditingController());
                  fillBlankFeedback = List.filled(5, '');
                  showFillBlankResults = false;

                  sentenceControllers = List.generate(5, (_) => TextEditingController());
                  sentenceFeedback = '';
                  showSentenceResults = false;

                  unscrambleControllers = List.generate(5, (_) => TextEditingController());
                  unscrambleFeedback = List.filled(5, '');
                  showUnscrambleResults = false;

                  matchSelectedWords = List.filled(5, '');
                  matchFeedback = List.filled(5, '');
                  showMatchResults = false;

                  multipleChoiceQuestions.forEach((question) {
                    question['selected'] = null;
                    question['feedback'] = '';
                  });
                  showMCQResults = false;
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
        ],
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
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Fill Blanks'),
          BottomNavigationBarItem(icon: Icon(Icons.text_fields), label: 'Sentences'),
          BottomNavigationBarItem(icon: Icon(Icons.shuffle), label: 'Unscramble'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Match'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Multiple Choice'),
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
        return fillInTheBlanksExercise();
      case 1:
        return sentenceCreationExercise();
      case 2:
        return unscrambleWordsExercise();
      case 3:
        return matchDefinitionExercise();
      case 4:
        return multipleChoiceExercise();
      default:
        return Center(
          child: Text('Select an exercise from the bottom menu.'),
        );
    }
  }

  Widget fillInTheBlanksExercise() {
    List<String> sentences = [
      'The city known as the birthplace of Jesus is _________.',
      'The traditional Palestinian dance is called _________.',
      'The Dead Sea is located between Jordan and _________.',
      '_________ is a famous Palestinian dish made with rice and meat.',
      'The city of Nablus is famous for its _________.'
    ];
    List<String> correctAnswers = ['Bethlehem', 'Dabke', 'Palestine', 'Maqluba', 'Olive Oil Soap'];

    return ListView.builder(
      itemCount: sentences.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
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
                      color: fillBlankFeedback[index] == 'Correct!' ? Colors.green : Colors.red,
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
    List<String> wordsToUse = ['Jerusalem', 'Gaza', 'West Bank', 'Culture', 'Heritage'];

    return ListView(
      children: [
        Text(
          'Create sentences using these words:',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        for (String word in wordsToUse)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('- $word'),
          ),
        for (int i = 0; i < wordsToUse.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: sentenceControllers[i],
              decoration: InputDecoration(
                labelText: 'Sentence ${i + 1}',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        if (showSentenceResults)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              sentenceFeedback,
              style: TextStyle(
                color: sentenceFeedback == 'All sentences are filled!' ? Colors.green : Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  Widget unscrambleWordsExercise() {
    List<Map<String, String>> scrambledWords = [
      {'scrambled': 'hBeetlhem', 'correct': 'Bethlehem'},
      {'scrambled': 'aDbke', 'correct': 'Dabke'},
      {'scrambled': 'Nlsuab', 'correct': 'Nablus'},
      {'scrambled': 'Muqaabl', 'correct': 'Maqluba'},
      {'scrambled': 'alipetnse', 'correct': 'Palestine'}
    ];

    return ListView.builder(
      itemCount: scrambledWords.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text('Unscramble: ${scrambledWords[index]['scrambled']}'),
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
                      color: unscrambleFeedback[index] == 'Correct!' ? Colors.green : Colors.red,
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
    List<Map<String, String>> definitions = [
      {'word': 'Bethlehem', 'definition': 'City known as the birthplace of Jesus.'},
      {'word': 'Dabke', 'definition': 'Traditional Palestinian folk dance.'},
      {'word': 'Dead Sea', 'definition': 'Salt lake bordering Palestine and Jordan.'},
      {'word': 'Maqluba', 'definition': 'Traditional Palestinian dish of rice and meat.'},
      {'word': 'Nablus', 'definition': 'City famous for olive oil soap.'}
    ];

    return ListView.builder(
      itemCount: definitions.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(definitions[index]['definition']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<String>(
                  hint: Text('Select Word'),
                  value: matchSelectedWords[index].isEmpty ? null : matchSelectedWords[index],
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
                if (showMatchResults)
                  Text(
                    matchFeedback[index],
                    style: TextStyle(
                      color: matchFeedback[index] == 'Correct!' ? Colors.green : Colors.red,
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
                      color: question['feedback'] == 'Correct!' ? Colors.green : Colors.red,
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
