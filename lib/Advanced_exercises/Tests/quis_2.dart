import 'package:flutter/material.dart';

class ExerciseHomePage2 extends StatefulWidget {
  @override
  _ExerciseHomePage2State createState() => _ExerciseHomePage2State();
}

class _ExerciseHomePage2State extends State<ExerciseHomePage2> {
  final List<String> words = [
    'Adventure',
    'Courage',
    'Discovery',
    'Horizon',
    'Journey',
    'Mystery',
    'Opportunity',
    'Quest',
    'Resilient',
    'Treasure',
    'Wisdom',
    'Ambition',
    'Inspire',
    'Challenge',
    'Endeavor',
    'Innovation',
    'Achievement',
    'Confidence',
    'Curiosity',
    'Perseverance'
  ];

  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E);

  // متغيرات للتحكم في الإدخالات والتغذية الراجعة
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

    // تهيئة المتغيرات
    fillBlankControllers = List.generate(5, (_) => TextEditingController());
    fillBlankFeedback = List.filled(5, '');

    sentenceControllers = List.generate(5, (_) => TextEditingController());

    unscrambleControllers = List.generate(5, (_) => TextEditingController());
    unscrambleFeedback = List.filled(5, '');

    matchSelectedWords = List.filled(5, '');
    matchFeedback = List.filled(5, '');

    multipleChoiceQuestions = [
      {
        'question':
        'Which word means "Able to recover quickly from difficulties"?',
        'options': ['Resilient', 'Courage', 'Inspire', 'Adventure'],
        'answer': 'Resilient',
        'selected': null,
        'feedback': ''
      },
      {
        'question':
        'Which word refers to "A long or arduous search for something"?',
        'options': ['Quest', 'Journey', 'Mystery', 'Discovery'],
        'answer': 'Quest',
        'selected': null,
        'feedback': ''
      },
      {
        'question':
        'Which word is defined as "Persistence in doing something despite difficulty"?',
        'options': ['Perseverance', 'Confidence', 'Wisdom', 'Endeavor'],
        'answer': 'Perseverance',
        'selected': null,
        'feedback': ''
      },
      {
        'question':
        'Which word means "An attempt to achieve a goal"?',
        'options': ['Endeavor', 'Challenge', 'Achievement', 'Opportunity'],
        'answer': 'Endeavor',
        'selected': null,
        'feedback': ''
      },
      {
        'question':
        'Which word refers to "A strong desire to achieve something"?',
        'options': ['Ambition', 'Inspire', 'Courage', 'Curiosity'],
        'answer': 'Ambition',
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
    List<String> correctAnswers = [
      'Adventure',
      'Courage',
      'Discovery',
      'Horizon',
      'Journey'
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

  void evaluateSentences() {
    bool allFilled = sentenceControllers
        .every((controller) => controller.text.trim().isNotEmpty);

    setState(() {
      sentenceFeedback = allFilled
          ? 'All sentences are filled!'
          : 'Please fill all sentences.';
      if (allFilled) score++;
    });
  }

  void evaluateUnscramble() {
    List<Map<String, String>> scrambledWords = [
      {'scrambled': 'evAnurdt', 'correct': 'Adventure'},
      {'scrambled': 'egCraou', 'correct': 'Courage'},
      {'scrambled': 'sDicovery', 'correct': 'Discovery'},
      {'scrambled': 'roHzino', 'correct': 'Horizon'},
      {'scrambled': 'roJeuny', 'correct': 'Journey'}
    ];

    for (int i = 0; i < unscrambleControllers.length; i++) {
      String userAnswer = unscrambleControllers[i].text.trim().toLowerCase();
      if (userAnswer == scrambledWords[i]['correct']!.toLowerCase()) {
        unscrambleFeedback[i] = 'Correct!';
        score++;
      } else {
        unscrambleFeedback[i] =
        'Incorrect! Correct answer: ${scrambledWords[i]['correct']}';
      }
    }
  }

  void evaluateMatch() {
    List<Map<String, String>> definitions = [
      {
        'word': 'Resilient',
        'definition': 'Able to recover quickly from difficulties.'
      },
      {
        'word': 'Opportunity',
        'definition': 'A set of circumstances that makes something possible.'
      },
      {
        'word': 'Quest',
        'definition': 'A long or arduous search for something.'
      },
      {
        'word': 'Wisdom',
        'definition': 'The quality of having experience and good judgment.'
      },
      {
        'word': 'Treasure',
        'definition':
        'A quantity of precious metals or valuable objects.'
      }
    ];

    for (int i = 0; i < matchSelectedWords.length; i++) {
      if (matchSelectedWords[i] == definitions[i]['word']) {
        matchFeedback[i] = 'Correct!';
        score++;
      } else {
        matchFeedback[i] =
        'Incorrect! Correct answer: ${definitions[i]['word']}';
      }
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

  void showSummaryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Your total score is $score out of 16.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  // إعادة تعيين جميع المتغيرات
                  currentExercise = 0;
                  score = 0;

                  fillBlankControllers =
                      List.generate(5, (_) => TextEditingController());
                  fillBlankFeedback = List.filled(5, '');
                  showFillBlankResults = false;

                  sentenceControllers =
                      List.generate(5, (_) => TextEditingController());
                  sentenceFeedback = '';
                  showSentenceResults = false;

                  unscrambleControllers =
                      List.generate(5, (_) => TextEditingController());
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

  // واجهة المستخدم
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), label: 'Fill Blanks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_fields), label: 'Sentences'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shuffle), label: 'Unscramble'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Match'),
          BottomNavigationBarItem(
              icon: Icon(Icons.quiz), label: 'Multiple Choice'),
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
        return Container();
    }
  }

  Widget fillInTheBlanksExercise() {
    List<String> sentences = [
      'Her _________ led her to explore unknown lands.',
      'He showed great _________ in facing challenges.',
      'The scientist made a remarkable _________.',
      'We could see the distant _________ from the mountain.',
      'Their _________ to the top was exhausting but rewarding.'
    ];

    List<String> correctAnswers = [
      'Adventure',
      'Courage',
      'Discovery',
      'Horizon',
      'Journey'
    ];

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

  Widget sentenceCreationExercise() {
    List<String> exerciseWords = words.sublist(5, 10);

    return ListView(
      children: [
        Text(
          'Create sentences using these words:',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        for (String word in exerciseWords)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('- $word'),
          ),
        for (int i = 0; i < exerciseWords.length; i++)
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
                color: sentenceFeedback == 'All sentences are filled!'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  Widget unscrambleWordsExercise() {
    List<Map<String, String>> scrambledWords = [
      {'scrambled': 'ytMsrye', 'correct': 'Mystery'},
      {'scrambled': 'tOpryunpoit', 'correct': 'Opportunity'},
      {'scrambled': 'eQust', 'correct': 'Quest'},
      {'scrambled': 'entRlseii', 'correct': 'Resilient'},
      {'scrambled': 'reTreusa', 'correct': 'Treasure'}
    ];

    return ListView.builder(
      itemCount: scrambledWords.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title:
            Text('Unscramble: ${scrambledWords[index]['scrambled']}'),
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
    List<Map<String, String>> definitions = [
      {
        'word': 'Wisdom',
        'definition':
        'The quality of having experience and good judgment.'
      },
      {
        'word': 'Ambition',
        'definition': 'A strong desire to achieve something.'
      },
      {
        'word': 'Inspire',
        'definition':
        'Fill someone with the urge or ability to do something.'
      },
      {
        'word': 'Challenge',
        'definition': 'A call to take part in a contest or competition.'
      },
      {
        'word': 'Endeavor',
        'definition': 'An attempt to achieve a goal.'
      },
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
}
