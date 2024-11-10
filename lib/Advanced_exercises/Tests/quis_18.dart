import 'package:flutter/material.dart';

class ExerciseHomePage18 extends StatefulWidget {
  @override
  _ExerciseHomePage18State createState() => _ExerciseHomePage18State();
}

class _ExerciseHomePage18State extends State<ExerciseHomePage18> {
  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E);

  // Words for various exercises
  final List<String> words = [
    'Adventure',
    'Brave',
    'Discovery',
    'Horizon',
    'Journey'
  ];

  final List<Map<String, String>> matchDefinitions = [
    {'word': 'Oasis', 'definition': 'A fertile spot in a desert.'},
    {'word': 'Astronomy', 'definition': 'The study of stars and planets.'},
    {'word': 'Eclipse', 'definition': 'When the sun or moon is obscured.'},
    {'word': 'Symphony', 'definition': 'A long musical composition.'},
    {
      'word': 'Pyramid',
      'definition': 'A monumental structure with a square base.'
    }
  ];

  final List<Map<String, dynamic>> multipleChoiceQuestions = [
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Mars', 'Jupiter', 'Venus', 'Saturn'],
      'answer': 'Mars',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'Rome', 'Berlin', 'Madrid'],
      'answer': 'Paris',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Who wrote "Hamlet"?',
      'options': ['Shakespeare', 'Homer', 'Dante', 'Tolstoy'],
      'answer': 'Shakespeare',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'What is H2O commonly known as?',
      'options': ['Water', 'Oxygen', 'Hydrogen', 'Salt'],
      'answer': 'Water',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'What is the fastest land animal?',
      'options': ['Cheetah', 'Lion', 'Tiger', 'Elephant'],
      'answer': 'Cheetah',
      'selected': null,
      'feedback': ''
    },
  ];

  // Variables to control inputs and feedback
  List<TextEditingController> fillBlankControllers =
  List.generate(5, (_) => TextEditingController());
  List<String> fillBlankFeedback = List.filled(5, '');
  bool showFillBlankResults = false;

  List<TextEditingController> unscrambleControllers =
  List.generate(5, (_) => TextEditingController());
  List<String> unscrambleFeedback = List.filled(5, '');
  bool showUnscrambleResults = false;

  List<String> matchSelectedWords = List.filled(5, '');
  List<String> matchFeedback = List.filled(5, '');
  bool showMatchResults = false;

  bool showMCQResults = false;

  List<TextEditingController> sentenceControllers =
  List.generate(5, (_) => TextEditingController());
  String sentenceFeedback = '';
  bool showSentenceResults = false;

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
            Expanded(
              child: getExerciseWidget(),
            ),
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
              icon: Icon(Icons.text_fields), label: 'Sentences'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shuffle), label: 'Unscramble'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: 'Match Definitions'),
          BottomNavigationBarItem(
              icon: Icon(Icons.quiz), label: 'Multiple Choice'),
        ],
      ),
    );
  }

  // Check if we can evaluate the current exercise
  bool canEvaluateCurrentExercise() {
    switch (currentExercise) {
      case 0:
        return !showFillBlankResults;
      case 1:
        return !showSentenceResults;
      case 2:
        return !showUnscrambleResults;
      case 3:
        return !showMatchResults;
      case 4:
        return !showMCQResults;
      default:
        return false;
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
      'Brave',
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
          ? 'Great! All sentences are filled.'
          : 'Incomplete! Please fill all sentences.';
      if (allFilled) score++;
    });
  }

  void evaluateUnscramble() {
    List<Map<String, String>> scrambledWords = [
      {'scrambled': 'ventureAd', 'correct': 'Adventure'},
      {'scrambled': 'raveB', 'correct': 'Brave'},
      {'scrambled': 'coveryDis', 'correct': 'Discovery'},
      {'scrambled': 'rizonHo', 'correct': 'Horizon'},
      {'scrambled': 'urneyJo', 'correct': 'Journey'}
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

  void nextExercise() {
    if (currentExercise < 4) {
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
          content: Text('Your total score is $score out of 16.'),
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

      // Reset variables
      fillBlankControllers =
          List.generate(5, (_) => TextEditingController());
      fillBlankFeedback = List.filled(5, '');
      showFillBlankResults = false;

      unscrambleControllers =
          List.generate(5, (_) => TextEditingController());
      unscrambleFeedback = List.filled(5, '');
      showUnscrambleResults = false;

      matchSelectedWords = List.filled(5, '');
      matchFeedback = List.filled(5, '');
      showMatchResults = false;

      showMCQResults = false;

      sentenceControllers =
          List.generate(5, (_) => TextEditingController());
      sentenceFeedback = '';
      showSentenceResults = false;

      multipleChoiceQuestions.forEach((question) {
        question['selected'] = null;
        question['feedback'] = '';
      });
    });
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
      'She went on an amazing _________.',
      'He is very _________ when facing problems.',
      'They made an interesting _________.',
      'We saw the _________ from the hill.',
      'Their _________ to the city was fun.'
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
                  decoration: InputDecoration(
                    hintText: 'Enter the missing word',
                  ),
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
    return ListView(
      children: [
        Text(
          'Create sentences using these words:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        for (String word in words)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('- $word'),
          ),
        for (int i = 0; i < 5; i++)
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
                color: sentenceFeedback.contains('Great')
                    ? Colors.green
                    : Colors.red,
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }

  Widget unscrambleWordsExercise() {
    List<Map<String, String>> scrambledWords = [
      {'scrambled': 'ventureAd', 'correct': 'Adventure'},
      {'scrambled': 'raveB', 'correct': 'Brave'},
      {'scrambled': 'coveryDis', 'correct': 'Discovery'},
      {'scrambled': 'rizonHo', 'correct': 'Horizon'},
      {'scrambled': 'urneyJo', 'correct': 'Journey'}
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
