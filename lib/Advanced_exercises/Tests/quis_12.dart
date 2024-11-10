import 'package:flutter/material.dart';

class ExerciseHomePage12 extends StatefulWidget {
  @override
  _ExerciseHomePage12State createState() => _ExerciseHomePage12State();
}

class _ExerciseHomePage12State extends State<ExerciseHomePage12> {
  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E); // لون النص المطلوب

  // متغيرات للتحكم في الإدخالات والتغذية الراجعة
  List<Map<String, dynamic>> multipleChoiceQuestions = [];
  List<Map<String, dynamic>> multipleChoiceAdvancedQuestions = [];
  List<Map<String, dynamic>> synonymQuestions = [];
  List<Map<String, dynamic>> antonymQuestions = [];
  List<TextEditingController> phraseControllers = [];
  List<String> phraseFeedback = [];

  bool showResults = false;

  @override
  void initState() {
    super.initState();

    // تهيئة الأسئلة والتمارين

    // أسئلة الاختيار من متعدد (10 أسئلة)
    multipleChoiceQuestions = [
      {
        'question': '1. He faced his greatest _________ without hesitation.',
        'options': ['Challenge', 'Curiosity', 'Wisdom', 'Courage'],
        'answer': 'Challenge',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '2. She is known for her _________.',
        'options': ['Intelligence', 'Anger', 'Fear', 'Sadness'],
        'answer': 'Intelligence',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '3. The weather was extremely _________.',
        'options': ['Pleasant', 'Dull', 'Hot', 'Boring'],
        'answer': 'Pleasant',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '4. He showed great _________ during the competition.',
        'options': ['Bravery', 'Weakness', 'Fearfulness', 'Indecision'],
        'answer': 'Bravery',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '5. She has a very _________ personality.',
        'options': ['Charming', 'Annoying', 'Boring', 'Dull'],
        'answer': 'Charming',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '6. The lecture was very _________.',
        'options': ['Engaging', 'Confusing', 'Boring', 'Long'],
        'answer': 'Engaging',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '7. The team celebrated their _________.',
        'options': ['Victory', 'Defeat', 'Loss', 'Failure'],
        'answer': 'Victory',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '8. She gave a _________ performance.',
        'options': ['Stunning', 'Weak', 'Awful', 'Mediocre'],
        'answer': 'Stunning',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '9. His explanation was very _________.',
        'options': ['Clear', 'Obscure', 'Vague', 'Unclear'],
        'answer': 'Clear',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '10. They reached a _________ after long negotiations.',
        'options': ['Agreement', 'Disagreement', 'Conflict', 'Debate'],
        'answer': 'Agreement',
        'selected': null,
        'feedback': ''
      },
    ];

    // أسئلة الاختيار من متعدد المتقدمة (10 أسئلة)
    multipleChoiceAdvancedQuestions = [
      {
        'question': '1. Her _________ helped her overcome many challenges.',
        'options': ['Opportunity', 'Challenge', 'Curiosity', 'Achievement'],
        'answer': 'Opportunity',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '2. The scientist made a significant ________ in her field.',
        'options': ['Discovery', 'Mistake', 'Question', 'Theory'],
        'answer': 'Discovery',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '3. His _________ attitude inspired everyone around him.',
        'options': ['Positive', 'Negative', 'Indifferent', 'Apathetic'],
        'answer': 'Positive',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '4. The project was a _________ success.',
        'options': ['Complete', 'Partial', 'Minor', 'Moderate'],
        'answer': 'Complete',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '5. She has a _________ understanding of the subject.',
        'options': ['Superficial', 'In-depth', 'Basic', 'Limited'],
        'answer': 'In-depth',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '6. His _________ skills are exceptional.',
        'options': ['Communication', 'Technical', 'Artistic', 'Physical'],
        'answer': 'Communication',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '7. The manager appreciated her _________ work ethic.',
        'options': ['Strong', 'Weak', 'Lazy', 'Inconsistent'],
        'answer': 'Strong',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '8. The company aims to _________ its market presence.',
        'options': ['Expand', 'Reduce', 'Maintain', 'Ignore'],
        'answer': 'Expand',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '9. His _________ behavior caused many issues.',
        'options': ['Reckless', 'Careful', 'Thoughtful', 'Prudent'],
        'answer': 'Reckless',
        'selected': null,
        'feedback': ''
      },
      {
        'question': '10. The artist\'s _________ was evident in every piece.',
        'options': ['Creativity', 'Boredom', 'Indifference', 'Stagnation'],
        'answer': 'Creativity',
        'selected': null,
        'feedback': ''
      },
    ];

    // أسئلة المرادفات (10 أسئلة)
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

    // أسئلة الأضداد (10 أسئلة)
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

    // أسئلة اكمل العبارة (10 أسئلة)
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
            evaluateMultipleChoice();
            break;
          case 1:
            evaluateMultipleChoiceAdvanced();
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

  void evaluateMultipleChoice() {
    for (var question in multipleChoiceQuestions) {
      if (question['selected'] == question['answer']) {
        question['feedback'] = 'correct!';
        score++;
      } else {
        question['feedback'] =
        'wrong! the right answer: ${question['answer']}';
      }
    }
  }

  void evaluateMultipleChoiceAdvanced() {
    for (var question in multipleChoiceAdvancedQuestions) {
      if (question['selected'] == question['answer']) {
        question['feedback'] = 'correct!';
        score++;
      } else {
        question['feedback'] =
        'wrong! the right answer: ${question['answer']}';
      }
    }
  }

  void evaluateSynonyms() {
    for (var question in synonymQuestions) {
      if (question['selected'] == question['answer']) {
        question['feedback'] = 'correct!';
        score++;
      } else {
        question['feedback'] =
        'wrong! the right answer: ${question['answer']}';
      }
    }
  }

  void evaluateAntonyms() {
    for (var question in antonymQuestions) {
      if (question['selected'] == question['answer']) {
        question['feedback'] = 'correct!';
        score++;
      } else {
        question['feedback'] =
        'wrong! the right answer: ${question['answer']}';
      }
    }
  }

  void evaluatePhrases() {
    List<String> correctAnswers = [
      'words', // Example answer for all phrases; يمكنك تعديلها حسب الحاجة
      'dedication',
      'courage',
      'wisdom',
      'strength',
      'perseverance',
      'talent',
      'determination',
      'grace',
      'brilliance',
    ];
    for (int i = 0; i < phraseControllers.length; i++) {
      String userAnswer = phraseControllers[i].text.trim().toLowerCase();
      if (userAnswer == correctAnswers[i].toLowerCase()) {
        phraseFeedback[i] = 'correct!';
        score++;
      } else {
        phraseFeedback[i] =
        'wrong! the right answer: ${correctAnswers[i]}';
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
                  // إعادة تعيين جميع المتغيرات
                  currentExercise = 0;
                  score = 0;
                  showResults = false;

                  multipleChoiceQuestions.forEach((question) {
                    question['selected'] = null;
                    question['feedback'] = '';
                  });

                  multipleChoiceAdvancedQuestions.forEach((question) {
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

  // واجهة المستخدم
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // تغيير لون الخلفية إلى الأبيض
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
              icon: Icon(Icons.quiz), label: 'Multiple choice'),
          BottomNavigationBarItem(
              icon: Icon(Icons.quiz_outlined), label: 'Advanced multiple selection'),
          BottomNavigationBarItem(
              icon: Icon(Icons.find_in_page), label: 'Synonyms'),
          BottomNavigationBarItem(
              icon: Icon(Icons.find_replace), label: 'opposites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_quote), label: 'Complete the phrase'),
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
        return multipleChoiceExerciseAdvanced();
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
                style:
                TextStyle(color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...question['options'].map<Widget>((option) {
                return RadioListTile<String>(
                  title: Text(option, style: TextStyle(color: primaryColor)),
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
                    color: question['feedback'] == 'correct!'
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

  Widget multipleChoiceExerciseAdvanced() {
    return ListView.builder(
      itemCount: multipleChoiceAdvancedQuestions.length,
      itemBuilder: (context, index) {
        var question = multipleChoiceAdvancedQuestions[index];
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question['question'],
                style:
                TextStyle(color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...question['options'].map<Widget>((option) {
                return RadioListTile<String>(
                  title: Text(option, style: TextStyle(color: primaryColor)),
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
                    color: question['feedback'] == 'correct!'
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
                'Find a synonym for the word: ${question['word']}',
                style:
                TextStyle(color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...question['options'].map<Widget>((option) {
                return RadioListTile<String>(
                  title: Text(option, style: TextStyle(color: primaryColor)),
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
                    color: question['feedback'] == 'correct!'
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
                'Find the opposite of the word: ${question['word']}',
                style:
                TextStyle(color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...question['options'].map<Widget>((option) {
                return RadioListTile<String>(
                  title: Text(option, style: TextStyle(color: primaryColor)),
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
                    color: question['feedback'] == 'correct!'
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

  Widget completePhraseExercise() {
    List<String> phrases = [
      '1. Actions speak louder than _________.',
      '2. Every cloud has a _________ lining.',
      '3. A picture is worth a thousand _________.',
      '4. When in Rome, do as the Romans _________.',
      '5. The early bird catches the _________.',
      '6. Better late than _________.',
      '7. Two heads are better than _________.',
      '8. A watched pot never _________.',
      '9. Don\'t count your chickens before they _________.',
      '10. When the going gets tough, the tough get _________.',
    ];

    List<String> correctAnswers = [
      'words', // For first phrase
      'silver',
      'words',
      'do',
      'worm',
      'never',
      'one',
      'boils',
      'hatch',
      'going',
    ];

    return ListView.builder(
      itemCount: phraseControllers.length,
      itemBuilder: (context, index) {
        return buildExerciseContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Complete the sentence:',
                style: TextStyle(
                    color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                phrases[index],
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              TextField(
                controller: phraseControllers[index],
                style: TextStyle(color: primaryColor),
                decoration: InputDecoration(
                  hintText: 'Enter your answer here',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              if (showResults)
                Text(
                  phraseFeedback[index],
                  style: TextStyle(
                    color: phraseFeedback[index] == 'correct!'
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

  // دالة مساعدة لتنسيق كل تمرين
  Widget buildExerciseContainer(Widget child) {
    return Card(
      color: Colors.white,
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
