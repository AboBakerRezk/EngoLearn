import 'package:flutter/material.dart';

class ExerciseHomePage10 extends StatefulWidget {
  @override
  _ExerciseHomePage10State createState() => _ExerciseHomePage10State();
}

class _ExerciseHomePage10State extends State<ExerciseHomePage10> {
  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E);

  // Variables to control inputs and feedback
  List<TextEditingController> fillBlankControllers = [];
  List<String> fillBlankFeedback = [];

  List<Map<String, dynamic>> multipleChoiceQuestions = [];
  List<Map<String, dynamic>> synonymQuestions = [];
  List<Map<String, dynamic>> antonymQuestions = [];
  List<TextEditingController> phraseControllers = [];
  List<String> phraseFeedback = [];

  bool showResults = false;

  @override
  void initState() {
    super.initState();

    // Initialize variables
    fillBlankControllers = List.generate(10, (_) => TextEditingController());
    fillBlankFeedback = List.filled(10, '');

    // Updated Multiple Choice Questions
    multipleChoiceQuestions = [
      {
        'question': 'Question 1: The capital city of Saudi Arabia is ________.',
        'options': ['Riyadh', 'Jeddah', 'Mecca', 'Medina'],
        'answer': 'Riyadh',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Question 2: The official language of Egypt is ________.',
        'options': ['Arabic', 'French', 'English', 'Spanish'],
        'answer': 'Arabic',
        'selected': null,
        'feedback': ''
      },
      {
        'question':
        'Question 3: The ancient city of Petra is located in ________.',
        'options': ['Jordan', 'Syria', 'Lebanon', 'Iraq'],
        'answer': 'Jordan',
        'selected': null,
        'feedback': ''
      },
      {
        'question':
        'Question 4: The longest river in the Arab world is the ________.',
        'options': ['Nile', 'Euphrates', 'Tigris', 'Jordan'],
        'answer': 'Nile',
        'selected': null,
        'feedback': ''
      },
      {
        'question':
        'Question 5: The famous Burj Khalifa is located in ________.',
        'options': ['Dubai', 'Abu Dhabi', 'Doha', 'Kuwait City'],
        'answer': 'Dubai',
        'selected': null,
        'feedback': ''
      },
      {
        'question': 'Question 6: The Dead Sea is known for its ________.',
        'options': [
          'High salt content',
          'Freshwater',
          'Fish diversity',
          'Depth'
        ],
        'answer': 'High salt content',
        'selected': null,
        'feedback': ''
      },
      {
        'question':
        'Question 7: The ancient pyramids are located in ________.',
        'options': ['Egypt', 'Morocco', 'Tunisia', 'Algeria'],
        'answer': 'Egypt',
        'selected': null,
        'feedback': ''
      },
      {
        'question':
        'Question 8: The Strait of Hormuz connects the Persian Gulf with the ________.',
        'options': [
          'Gulf of Oman',
          'Red Sea',
          'Mediterranean Sea',
          'Black Sea'
        ],
        'answer': 'Gulf of Oman',
        'selected': null,
        'feedback': ''
      },
      {
        'question':
        'Question 9: The currency used in Saudi Arabia is the ________.',
        'options': ['Riyal', 'Dinar', 'Dirham', 'Pound'],
        'answer': 'Riyal',
        'selected': null,
        'feedback': ''
      },
      {
        'question':
        'Question 10: The city known as the "Pearl of the Gulf" is ________.',
        'options': ['Dubai', 'Manama', 'Doha', 'Muscat'],
        'answer': 'Doha',
        'selected': null,
        'feedback': ''
      },
    ];

    // Updated Synonym Questions
    synonymQuestions = [
      {
        'word': 'Generous',
        'options': ['Charitable', 'Selfish', 'Greedy', 'Stingy'],
        'answer': 'Charitable',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Abundant',
        'options': ['Scarce', 'Plentiful', 'Rare', 'Limited'],
        'answer': 'Plentiful',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Ancient',
        'options': ['Modern', 'Old', 'Recent', 'Current'],
        'answer': 'Old',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Desert',
        'options': ['Forest', 'Arid', 'Wetland', 'Swamp'],
        'answer': 'Arid',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Oasis',
        'options': ['Waterhole', 'Mountain', 'Valley', 'Island'],
        'answer': 'Waterhole',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Hospitality',
        'options': ['Hostility', 'Friendliness', 'Apathy', 'Indifference'],
        'answer': 'Friendliness',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Tradition',
        'options': ['Custom', 'Innovation', 'Change', 'Alteration'],
        'answer': 'Custom',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Unity',
        'options': ['Division', 'Harmony', 'Conflict', 'Discord'],
        'answer': 'Harmony',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Heritage',
        'options': ['Inheritance', 'Future', 'Novelty', 'Ignorance'],
        'answer': 'Inheritance',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Faith',
        'options': ['Belief', 'Doubt', 'Uncertainty', 'Disbelief'],
        'answer': 'Belief',
        'selected': null,
        'feedback': ''
      },
    ];

    // Updated Antonym Questions
    antonymQuestions = [
      {
        'word': 'Peace',
        'options': ['War', 'Calm', 'Tranquility', 'Harmony'],
        'answer': 'War',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Rich',
        'options': ['Wealthy', 'Affluent', 'Poor', 'Prosperous'],
        'answer': 'Poor',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Modern',
        'options': ['Contemporary', 'Ancient', 'Current', 'Recent'],
        'answer': 'Ancient',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Unity',
        'options': ['Division', 'Togetherness', 'Union', 'Agreement'],
        'answer': 'Division',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Generous',
        'options': ['Stingy', 'Kind', 'Charitable', 'Benevolent'],
        'answer': 'Stingy',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Bright',
        'options': ['Intelligent', 'Dull', 'Smart', 'Brilliant'],
        'answer': 'Dull',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Strong',
        'options': ['Weak', 'Powerful', 'Robust', 'Solid'],
        'answer': 'Weak',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Faith',
        'options': ['Belief', 'Trust', 'Doubt', 'Confidence'],
        'answer': 'Doubt',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Build',
        'options': ['Construct', 'Create', 'Destroy', 'Assemble'],
        'answer': 'Destroy',
        'selected': null,
        'feedback': ''
      },
      {
        'word': 'Love',
        'options': ['Hate', 'Affection', 'Care', 'Fondness'],
        'answer': 'Hate',
        'selected': null,
        'feedback': ''
      },
    ];

    phraseControllers = List.generate(10, (_) => TextEditingController());
    phraseFeedback = List.filled(10, '');
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
            evaluateFillBlanks();
            break;
          case 1:
            evaluateMultipleChoice();
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
        }
      });
    }
  }

  void evaluateFillBlanks() {
    // Updated correct answers for fill-in-the-blanks
    List<String> correctAnswers = [
      'Mecca',
      'dates',
      'Empty Quarter',
      'abaya',
      'Ramadan',
      'pound',
      'dhow',
      'Jabal Toubkal',
      'Arabic',
      'parchment'
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

  void evaluateMultipleChoice() {
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

  void evaluateSynonyms() {
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

  void evaluateAntonyms() {
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

  void evaluatePhrases() {
    // Updated correct answers for phrases
    List<String> correctAnswers = [
      'camel',
      'pocket',
      'everything',
      'mountain',
      'darkness',
      'success',
      'back',
      'wisdom',
      'friend',
      'God'
    ];
    for (int i = 0; i < phraseControllers.length; i++) {
      String userAnswer = phraseControllers[i].text.trim().toLowerCase();
      if (userAnswer == correctAnswers[i].toLowerCase()) {
        phraseFeedback[i] = 'Correct!';
        score++;
      } else {
        phraseFeedback[i] =
        'Incorrect! Correct answer: ${correctAnswers[i]}';
      }
    }
  }

  void showSummaryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Great job!'),
          content: Text('Your total score is $score from 50.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  // Reset all variables
                  currentExercise = 0;
                  score = 0;
                  showResults = false;

                  fillBlankControllers =
                      List.generate(10, (_) => TextEditingController());
                  fillBlankFeedback = List.filled(10, '');

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

                  phraseControllers =
                      List.generate(10, (_) => TextEditingController());
                  phraseFeedback = List.filled(10, '');
                });
              },
              child: Text('restart'),
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
              icon: Icon(Icons.edit), label: 'Fill in the blanks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.quiz), label: 'Multiple choice'),
          BottomNavigationBarItem(
              icon: Icon(Icons.find_in_page), label: 'Synonyms'),
          BottomNavigationBarItem(
              icon: Icon(Icons.find_replace), label: 'opposites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_quote), label: 'expressions'),
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
        return multipleChoiceExercise();
      case 2:
        return findSynonymExercise();
      case 3:
        return findAntonymExercise();
      case 4:
        return completePhraseExercise();
      default:
        return Center(
          child: Text('Select an exercise from the bottom menu.'),
        );
    }
  }

  Widget fillInTheBlanksExercise() {
    // Updated sentences for fill-in-the-blanks
    List<String> sentences = [
      'He performed the Hajj pilgrimage to __________.',
      'The traditional Arabic coffee is often served with __________.',
      'The Rub\' al Khali is also known as the __________ Desert.',
      'She wore a beautiful __________ dress for the festival.',
      'The holy month of fasting in Islam is called __________.',
      'The currency used in Egypt is the Egyptian __________.',
      'The traditional boat used in Dubai is called a __________.',
      'Mount __________ is the highest mountain in the Arab world.',
      'The official language of Oman is __________.',
      'The ancient manuscript was written on __________.'
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
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: fillBlankControllers[index],
              ),
              if (showResults)
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
        );
      },
    );
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

  Widget completePhraseExercise() {
    // Updated phrases to complete
    List<String> phrases = [
      'Trust in God but tie your __________.',
      'A book is like a garden carried in the __________.',
      'He who has health has __________.',
      'If the mountain will not come to Muhammad, then Muhammad must go to the __________.',
      'Knowledge is light and ignorance is __________.',
      'Patience is the key to __________.',
      'The camel cannot see the crookedness of its own __________.',
      'Silence is a sign of __________.',
      'The enemy of my enemy is my __________.',
      'Do not stand in a place of danger trusting in miracles from __________.'
    ];

    return ListView.builder(
      itemCount: phraseControllers.length,
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
                controller: phraseControllers[index],
              ),
              if (showResults)
                Text(
                  phraseFeedback[index],
                  style: TextStyle(
                    color: phraseFeedback[index] == 'Correct!'
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
