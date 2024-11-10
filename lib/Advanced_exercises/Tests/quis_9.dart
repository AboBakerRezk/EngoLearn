import 'package:flutter/material.dart';

class ExerciseHomePage9 extends StatefulWidget {
  @override
  _ExerciseHomePage9State createState() => _ExerciseHomePage9State();
}

class _ExerciseHomePage9State extends State<ExerciseHomePage9> {
  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E);

  // Variables to control inputs and feedback
  List<Map<String, dynamic>> multipleChoiceQuestions = [];
  List<TextEditingController> textControllers = [];
  List<String> textFeedback = [];
  bool showResults = false;

  @override
  void initState() {
    super.initState();

    // Initialize questions and exercises

    // Multiple-choice questions (10 questions)
    multipleChoiceQuestions = [
      {
        'question': 'Who is known as the "Poet of Love" in modern Arabic literature?',
        'options': ['Nizar Qabbani', 'Mahmoud Darwish', 'Ahmed Shawqi', 'Badr Shakir al-Sayyab'],
        'answer': 'Nizar Qabbani',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Which city was the Arab Capital of Culture in 2020?',
        'options': ['Cairo', 'Sharjah', 'Riyadh', 'Beirut'],
        'answer': 'Sharjah',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Who was the first Arab astronaut?',
        'options': ['Sultan bin Salman', 'Hazza Al Mansouri', 'Muhammed Faris', 'Abdullah Al-Rabeeah'],
        'answer': 'Sultan bin Salman',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'In which Arab country is Al-Qarawiyyin University, the oldest university in the world, located?',
        'options': ['Morocco', 'Egypt', 'Tunisia', 'Iraq'],
        'answer': 'Morocco',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'What is the longest river in the Arab world?',
        'options': ['Nile', 'Euphrates', 'Jordan', 'Orontes'],
        'answer': 'Nile',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Who is considered the founder of sociology in the Arab world?',
        'options': ['Ibn Khaldun', 'Al-Farabi', 'Ibn Sina', 'Al-Ghazali'],
        'answer': 'Ibn Khaldun',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Which Arab country is known as the "Land of the Cedars"?',
        'options': ['Lebanon', 'Syria', 'Jordan', 'Palestine'],
        'answer': 'Lebanon',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Which Arab writer won the Nobel Prize in Literature?',
        'options': ['Naguib Mahfouz', 'Taha Hussein', 'Kahlil Gibran', 'Adonis'],
        'answer': 'Naguib Mahfouz',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Which sea lies between the Arabian Peninsula and Africa?',
        'options': ['Red Sea', 'Dead Sea', 'Black Sea', 'Mediterranean Sea'],
        'answer': 'Red Sea',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'What is the official language in most Arab countries?',
        'options': ['Arabic', 'French', 'English', 'Spanish'],
        'answer': 'Arabic',
        'selected': null,
        'feedback': ''
      },
    ];

    // Create 10 text controllers for textual questions
    textControllers = List.generate(10, (_) => TextEditingController());
    textFeedback = List.filled(10, '');
  }

  void nextExercise() {
    if (currentExercise < 4) {
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
            evaluateMultipleChoiceExercise();
            break;
          case 1:
            evaluateFindSynonymExercise();
            break;
          case 2:
            evaluateFindAntonymExercise();
            break;
          case 3:
            evaluateCompletePhraseExercise();
            break;
          case 4:
            evaluateContextUseExercise();
            break;
        }
      });
    }
  }

  void evaluateMultipleChoiceExercise() {
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

  void evaluateFindSynonymExercise() {
    List<String> words = [
      'Fast',
      'Big',
      'Beautiful',
      'Smart',
      'Strong',
      'Happy',
      'Near',
      'Old',
      'Important',
      'Easy',
    ];

    List<String> correctAnswers = [
      'Quick',
      'Large',
      'Pretty',
      'Intelligent',
      'Powerful',
      'Joyful',
      'Close',
      'Ancient',
      'Significant',
      'Simple',
    ];

    for (int i = 0; i < words.length; i++) {
      String userAnswer = textControllers[i].text.trim();
      if (userAnswer.toLowerCase() == correctAnswers[i].toLowerCase()) {
        textFeedback[i] = 'Correct!';
        score++;
      } else {
        textFeedback[i] =
        'Incorrect! The correct synonym is: ${correctAnswers[i]}';
      }
    }
  }

  void evaluateFindAntonymExercise() {
    List<String> words = [
      'Fast',
      'Big',
      'Beautiful',
      'Smart',
      'Strong',
      'Happy',
      'Near',
      'Old',
      'Important',
      'Easy',
    ];

    List<String> correctAnswers = [
      'Slow',
      'Small',
      'Ugly',
      'Stupid',
      'Weak',
      'Sad',
      'Far',
      'New',
      'Trivial',
      'Difficult',
    ];

    for (int i = 0; i < words.length; i++) {
      String userAnswer = textControllers[i].text.trim();
      if (userAnswer.toLowerCase() == correctAnswers[i].toLowerCase()) {
        textFeedback[i] = 'Correct!';
        score++;
      } else {
        textFeedback[i] =
        'Incorrect! The correct antonym is: ${correctAnswers[i]}';
      }
    }
  }

  void evaluateCompletePhraseExercise() {
    List<String> correctAnswers = [
      'No pain, no gain',
      'Knowledge is power',
      'Patience is a virtue',
      'Time is money',
      'Unity is strength',
      'Prevention is better than cure',
      'Health is wealth',
      'Honesty is the best policy',
      'Actions speak louder than words',
      'Practice makes perfect',
    ];

    for (int i = 0; i < textControllers.length; i++) {
      String userAnswer = textControllers[i].text.trim();
      if (userAnswer.toLowerCase() == correctAnswers[i].toLowerCase()) {
        textFeedback[i] = 'Correct!';
        score++;
      } else {
        textFeedback[i] =
        'Incorrect! The correct phrase is: ${correctAnswers[i]}';
      }
    }
  }

  void evaluateContextUseExercise() {
    List<String> words = [
      'Generosity',
      'Courage',
      'Honesty',
      'Truth',
      'Wisdom',
      'Patience',
      'Humility',
      'Loyalty',
      'Justice',
      'Sincerity',
    ];

    for (int i = 0; i < textControllers.length; i++) {
      String userAnswer = textControllers[i].text.trim();
      if (userAnswer.toLowerCase().contains(words[i].toLowerCase())) {
        textFeedback[i] = 'Good job!';
        score++;
      } else {
        textFeedback[i] = 'Try to use the word "${words[i]}" in your sentence.';
      }
    }
  }

  void showSummaryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Great Job!'),
          content: Text('Your total score is $score out of 50.'),
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

                  textControllers =
                      List.generate(10, (_) => TextEditingController());
                  textFeedback = List.filled(10, '');
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
            showResults = false;
          });
        },
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.quiz), label: 'Multiple Choice'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sync_alt), label: 'Synonyms'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sync_disabled), label: 'Antonyms'),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_fields), label: 'Phrases'),
          BottomNavigationBarItem(
              icon: Icon(Icons.create), label: 'Context Use'),
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
        return findSynonymExercise();
      case 2:
        return findAntonymExercise();
      case 3:
        return completePhraseExercise();
      case 4:
        return contextUseExercise();
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
                style: TextStyle(fontSize: 18),
              ),
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
              if (showResults)
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
        );
      },
    );
  }

  Widget findSynonymExercise() {
    List<String> words = [
      'Fast',
      'Big',
      'Beautiful',
      'Smart',
      'Strong',
      'Happy',
      'Near',
      'Old',
      'Important',
      'Easy',
    ];

    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find the synonym of the word: ${words[index]}',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: textControllers[index],
                decoration: InputDecoration(
                  hintText: 'Enter the synonym',
                ),
              ),
              if (showResults)
                Text(
                  textFeedback[index],
                  style: TextStyle(
                    color: textFeedback[index] == 'Correct!'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget findAntonymExercise() {
    List<String> words = [
      'Fast',
      'Big',
      'Beautiful',
      'Smart',
      'Strong',
      'Happy',
      'Near',
      'Old',
      'Important',
      'Easy',
    ];

    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find the antonym of the word: ${words[index]}',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: textControllers[index],
                decoration: InputDecoration(
                  hintText: 'Enter the antonym',
                ),
              ),
              if (showResults)
                Text(
                  textFeedback[index],
                  style: TextStyle(
                    color: textFeedback[index] == 'Correct!'
                        ? Colors.green
                        : Colors.red,
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
      'No pain, _____',
      'Knowledge is _____',
      'Patience is _____',
      'Time is _____',
      'Unity is _____',
      'Prevention is better than _____',
      'Health is _____',
      'Honesty is the best _____',
      'Actions speak louder than _____',
      'Practice makes _____',
    ];

    return ListView.builder(
      itemCount: phrases.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Complete the following phrase:',
                style: TextStyle(fontSize: 18),
              ),
              Text(phrases[index]),
              TextField(
                controller: textControllers[index],
                decoration: InputDecoration(
                  hintText: 'Enter the missing word(s)',
                ),
              ),
              if (showResults)
                Text(
                  textFeedback[index],
                  style: TextStyle(
                    color: textFeedback[index] == 'Correct!'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget contextUseExercise() {
    List<String> words = [
      'Generosity',
      'Courage',
      'Honesty',
      'Truth',
      'Wisdom',
      'Patience',
      'Humility',
      'Loyalty',
      'Justice',
      'Sincerity',
    ];

    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Use the word in a sentence: ${words[index]}',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: textControllers[index],
                decoration: InputDecoration(
                  hintText: 'Write a sentence containing "${words[index]}"',
                ),
              ),
              if (showResults)
                Text(
                  textFeedback[index],
                  style: TextStyle(
                    color: textFeedback[index] == 'Good job!'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Helper function to format each exercise
  Widget buildExerciseContainer(Widget child) {
    return Card(
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
