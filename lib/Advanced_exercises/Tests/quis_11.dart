import 'package:flutter/material.dart';

class ExerciseHomePage11 extends StatefulWidget {
  @override
  _ExerciseHomePage11State createState() => _ExerciseHomePage11State();
}

class _ExerciseHomePage11State extends State<ExerciseHomePage11> {
  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E);

  // Define questions and exercises as class-level arrays
  List<Map<String, dynamic>> multipleChoiceQuestions = [];
  List<Map<String, dynamic>> synonymQuestions = [];
  List<Map<String, dynamic>> antonymQuestions = [];
  List<TextEditingController> fillBlankControllers = [];
  List<String> fillBlankFeedback = [];
  List<String> matchSelectedWords = [];
  List<String> matchFeedback = [];

  bool showResults = false;

  @override
  void initState() {
    super.initState();

    // Initialize multiple choice questions (10 questions)
    multipleChoiceQuestions = [
      {
        'question': '1: He faced his greatest _________.',
        'options': ['Challenge', 'Curiosity', 'Wisdom', 'Courage'],
        'answer': 'Challenge',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '2: She is known for her _________.',
        'options': ['Intelligence', 'Anger', 'Fear', 'Sadness'],
        'answer': 'Intelligence',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '3: The weather was extremely _________.',
        'options': ['Pleasant', 'Dull', 'Hot', 'Boring'],
        'answer': 'Pleasant',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '4: He showed great _________ during the competition.',
        'options': ['Bravery', 'Weakness', 'Fearfulness', 'Indecision'],
        'answer': 'Bravery',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '5: She has a very _________ personality.',
        'options': ['Charming', 'Annoying', 'Boring', 'Dull'],
        'answer': 'Charming',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '6: The lecture was very _________.',
        'options': ['Engaging', 'Confusing', 'Boring', 'Long'],
        'answer': 'Engaging',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '7: The team celebrated their _________.',
        'options': ['Victory', 'Defeat', 'Loss', 'Failure'],
        'answer': 'Victory',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '8: She gave a _________ performance.',
        'options': ['Stunning', 'Weak', 'Awful', 'Mediocre'],
        'answer': 'Stunning',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '9: His explanation was very _________.',
        'options': ['Clear', 'Obscure', 'Vague', 'Unclear'],
        'answer': 'Clear',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '10: They reached a _________ after long negotiations.',
        'options': ['Agreement', 'Disagreement', 'Conflict', 'Debate'],
        'answer': 'Agreement',
        'selected': null,
        'feedback': ''
      },
    ];

    // Initialize synonym questions (10 questions)
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

    // Initialize antonym questions (10 questions)
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

    // Initialize fill-in-the-blanks questions (10 questions)
    fillBlankControllers = List.generate(10, (_) => TextEditingController());
    fillBlankFeedback = List.filled(10, '');

    // Initialize match definitions questions (10 questions)
    matchSelectedWords = List.filled(10, '');
    matchFeedback = List.filled(10, '');
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
            evaluateMultipleChoice();
            break;
          case 1:
            evaluateSynonyms();
            break;
          case 2:
            evaluateAntonyms();
            break;
          case 3:
            evaluateFillBlanks();
            break;
          case 4:
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
        'Wrong! The right answer: ${question['answer']}';
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
        'Wrong! The right answer: ${question['answer']}';
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
        'Wrong! The right answer: ${question['answer']}';
      }
    }
  }

  void evaluateFillBlanks() {
    // Define correct answers for fill-in-the-blanks questions
    List<String> correctAnswers = [
      'dedication',    // Sentence 1
      'brilliance',    // Sentence 2
      'dedication',    // Sentence 3
      'brilliance',    // Sentence 4
      'dedication',    // Sentence 5
      'brilliance',    // Sentence 6
      'dedication',    // Sentence 7
      'brilliance',    // Sentence 8
      'dedication',    // Sentence 9
      'brilliance',    // Sentence 10
    ];

    for (int i = 0; i < fillBlankControllers.length; i++) {
      String userAnswer = fillBlankControllers[i].text.trim().toLowerCase();
      if (userAnswer == correctAnswers[i]) {
        fillBlankFeedback[i] = 'Correct!';
        score++;
      } else {
        fillBlankFeedback[i] =
        'Wrong! The right answer: ${correctAnswers[i]}';
      }
    }
  }

  void evaluateMatchDefinitions() {
    // List of definitions and corresponding words
    List<Map<String, String>> definitions = [
      {
        'definition': 'A domesticated carnivorous mammal',
        'word': 'cat',
      },
      {
        'definition': 'A large, heavy-bodied member of the dog family',
        'word': 'dog',
      },
      {
        'definition': 'A small rodent that typically has a pointed snout',
        'word': 'mouse',
      },
      {
        'definition': 'A solid-hoofed plant-eating domesticated mammal',
        'word': 'horse',
      },
      {
        'definition': 'A domesticated ruminant animal with a thick woolly coat',
        'word': 'sheep',
      },
      {
        'definition': 'An omnivorous hoofed mammal with sparse bristly hair',
        'word': 'pig',
      },
      {
        'definition': 'A warm-blooded egg-laying vertebrate animal',
        'word': 'bird',
      },
      {
        'definition': 'A limbless cold-blooded vertebrate animal with gills',
        'word': 'fish',
      },
      {
        'definition': 'A burrowing plant-eating mammal with long ears',
        'word': 'rabbit',
      },
      {
        'definition': 'A fully grown female animal of a domesticated breed of ox',
        'word': 'cow',
      },
    ];

    for (int i = 0; i < matchSelectedWords.length; i++) {
      if (matchSelectedWords[i].toLowerCase() ==
          definitions[i]['word']!.toLowerCase()) {
        matchFeedback[i] = 'Correct!';
        score++;
      } else {
        matchFeedback[i] =
        'Wrong! The right answer: ${definitions[i]['word']}';
      }
    }
  }

  void showSummaryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Great job!'),
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

                  synonymQuestions.forEach((question) {
                    question['selected'] = null;
                    question['feedback'] = '';
                  });

                  antonymQuestions.forEach((question) {
                    question['selected'] = null;
                    question['feedback'] = '';
                  });

                  fillBlankControllers =
                      List.generate(10, (_) => TextEditingController());
                  fillBlankFeedback = List.filled(10, '');

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
      appBar: AppBar(
        title: Text('Exercise Home Page'),
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
              foregroundColor: Colors.white,
              backgroundColor: primaryColor, // Button text color
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
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.quiz), label: 'Multiple Choice'),
          BottomNavigationBarItem(
              icon: Icon(Icons.find_in_page), label: 'Synonyms'),
          BottomNavigationBarItem(
              icon: Icon(Icons.find_replace), label: 'Antonyms'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), label: 'Fill in the Blanks'),
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
        return findSynonymExercise();
      case 2:
        return findAntonymExercise();
      case 3:
        return fillInTheBlanksExercise();
      case 4:
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    color: question['feedback'].toLowerCase().contains('correct')
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    color: question['feedback'].toLowerCase().contains('correct')
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    color: question['feedback'].toLowerCase().contains('correct')
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

  Widget fillInTheBlanksExercise() {
    List<String> sentences = [
      '1. He is known for his __________.',
      '2. Her __________ was evident in her performance.',
      '3. The artist’s __________ captured the essence of the moment.',
      '4. His __________ to the project was impressive.',
      '5. They showed great __________ during the presentation.',
      '6. The athlete’s __________ helped him achieve his goals.',
      '7. Her __________ in the competition was admirable.',
      '8. The teacher praised the students for their __________.',
      '9. His __________ to learn new skills was remarkable.',
      '10. Their __________ in overcoming obstacles inspired everyone.',
    ];

    return ListView.builder(
      itemCount: sentences.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sentences[index],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: fillBlankControllers[index],
                decoration: InputDecoration(
                  labelText: 'Enter your answer here',
                ),
              ),
              if (showResults)
                Text(
                  fillBlankFeedback[index],
                  style: TextStyle(
                    color: fillBlankFeedback[index].toLowerCase().contains('correct')
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
      {
        'definition': 'A domesticated carnivorous mammal',
        'word': 'cat',
      },
      {
        'definition': 'A large, heavy-bodied member of the dog family',
        'word': 'dog',
      },
      {
        'definition': 'A small rodent that typically has a pointed snout',
        'word': 'mouse',
      },
      {
        'definition': 'A solid-hoofed plant-eating domesticated mammal',
        'word': 'horse',
      },
      {
        'definition': 'A domesticated ruminant animal with a thick woolly coat',
        'word': 'sheep',
      },
      {
        'definition': 'An omnivorous hoofed mammal with sparse bristly hair',
        'word': 'pig',
      },
      {
        'definition': 'A warm-blooded egg-laying vertebrate animal',
        'word': 'bird',
      },
      {
        'definition': 'A limbless cold-blooded vertebrate animal with gills',
        'word': 'fish',
      },
      {
        'definition': 'A burrowing plant-eating mammal with long ears',
        'word': 'rabbit',
      },
      {
        'definition': 'A fully grown female animal of a domesticated breed of ox',
        'word': 'cow',
      },
    ];

    return ListView.builder(
      itemCount: definitions.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Definition: ${definitions[index]['definition']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                hint: Text('Choose the word'),
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
                    color: matchFeedback[index].toLowerCase().contains('correct')
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

  // Helper method to wrap each exercise in a Container with consistent styling
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
