import 'package:flutter/material.dart';

class ExerciseHomePage17 extends StatefulWidget {
  @override
  _ExerciseHomePage17State createState() => _ExerciseHomePage17State();
}

class _ExerciseHomePage17State extends State<ExerciseHomePage17> {
  int currentExercise = 0;
  int score = 0;
  final Color primaryColor = Color(0xFF13194E);
  bool showMCQResults = false;

  // Multiple Choice Questions
  final List<Map<String, dynamic>> multipleChoiceQuestions = [
    {
      'question': 'He faced his greatest ________ without hesitation.',
      'options': ['Challenge', 'Curiosity', 'Wisdom', 'Courage'],
      'answer': 'Challenge',
      'selected': null,
      'feedback': ''
    },
    // Add 9 more multiple-choice questions
    {
      'question': 'She completed the ________ with ease.',
      'options': ['task', 'play', 'sleep', 'silence'],
      'answer': 'task',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'They decided to ________ the project.',
      'options': ['start', 'end', 'pause', 'forget'],
      'answer': 'start',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'The ________ rises in the east.',
      'options': ['moon', 'sun', 'star', 'planet'],
      'answer': 'sun',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'He is known for his great ________.',
      'options': ['wisdom', 'height', 'silence', 'wealth'],
      'answer': 'wisdom',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'The ________ flows into the sea.',
      'options': ['river', 'road', 'mountain', 'cloud'],
      'answer': 'river',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'They live in a small ________.',
      'options': ['city', 'village', 'country', 'continent'],
      'answer': 'village',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'She is an excellent ________.',
      'options': ['writer', 'reader', 'speaker', 'listener'],
      'answer': 'writer',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'The ________ was full of stars.',
      'options': ['sky', 'ground', 'ocean', 'forest'],
      'answer': 'sky',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'He bought a new ________.',
      'options': ['car', 'book', 'phone', 'house'],
      'answer': 'car',
      'selected': null,
      'feedback': ''
    },
  ];

  // Complete Phrase Questions
  final List<String> completePhraseQuestions = [
    'Actions speak louder than ________.',
    // Add 9 more phrases
    'A picture is worth a thousand ________.',
    'When in Rome, do as the Romans ________.',
    'The pen is mightier than the ________.',
    'All that glitters is not ________.',
    'Better late than ________.',
    'Birds of a feather flock ________.',
    'Every cloud has a silver ________.',
    'The early bird catches the ________.',
    'Honesty is the best ________.',
  ];

  final List<String> completePhraseAnswers = [
    'words',
    'words',
    'do',
    'sword',
    'gold',
    'never',
    'together',
    'lining',
    'worm',
    'policy',
  ];

  List<TextEditingController> completePhraseControllers =
  List.generate(10, (_) => TextEditingController());
  List<String> completePhraseFeedback = List.filled(10, '');
  bool showCompletePhraseResults = false;

  // Synonym Questions
  final List<Map<String, dynamic>> synonymQuestions = [
    {
      'word': 'Resilient',
      'options': ['Flexible', 'Rigid', 'Fragile', 'Sensitive'],
      'answer': 'Flexible',
      'selected': null,
      'feedback': ''
    },
    // Add 9 more synonym questions
    {
      'word': 'Happy',
      'options': ['Sad', 'Joyful', 'Angry', 'Fearful'],
      'answer': 'Joyful',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Quick',
      'options': ['Slow', 'Fast', 'Lazy', 'Calm'],
      'answer': 'Fast',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Silent',
      'options': ['Noisy', 'Quiet', 'Loud', 'Busy'],
      'answer': 'Quiet',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Beautiful',
      'options': ['Ugly', 'Pretty', 'Dirty', 'Messy'],
      'answer': 'Pretty',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Strong',
      'options': ['Weak', 'Powerful', 'Small', 'Tiny'],
      'answer': 'Powerful',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Bright',
      'options': ['Dark', 'Dim', 'Shiny', 'Dull'],
      'answer': 'Shiny',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Brave',
      'options': ['Cowardly', 'Fearful', 'Courageous', 'Scared'],
      'answer': 'Courageous',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Cold',
      'options': ['Hot', 'Warm', 'Chilly', 'Cool'],
      'answer': 'Chilly',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Happy',
      'options': ['Sad', 'Joyful', 'Angry', 'Fearful'],
      'answer': 'Joyful',
      'selected': null,
      'feedback': ''
    },
  ];

  // Antonym Questions
  final List<Map<String, dynamic>> antonymQuestions = [
    {
      'word': 'Optimistic',
      'options': ['Pessimistic', 'Confident', 'Hopeful', 'Cheerful'],
      'answer': 'Pessimistic',
      'selected': null,
      'feedback': ''
    },
    // Add 9 more antonym questions
    {
      'word': 'Happy',
      'options': ['Sad', 'Joyful', 'Angry', 'Fearful'],
      'answer': 'Sad',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Big',
      'options': ['Large', 'Huge', 'Tiny', 'Enormous'],
      'answer': 'Tiny',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Fast',
      'options': ['Quick', 'Slow', 'Swift', 'Rapid'],
      'answer': 'Slow',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Bright',
      'options': ['Dark', 'Shiny', 'Light', 'Clear'],
      'answer': 'Dark',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Strong',
      'options': ['Weak', 'Powerful', 'Sturdy', 'Solid'],
      'answer': 'Weak',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Brave',
      'options': ['Fearful', 'Courageous', 'Bold', 'Valiant'],
      'answer': 'Fearful',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Hot',
      'options': ['Warm', 'Boiling', 'Cold', 'Heated'],
      'answer': 'Cold',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Above',
      'options': ['Over', 'Under', 'Up', 'On'],
      'answer': 'Under',
      'selected': null,
      'feedback': ''
    },
    {
      'word': 'Old',
      'options': ['Ancient', 'New', 'Vintage', 'Antique'],
      'answer': 'New',
      'selected': null,
      'feedback': ''
    },
  ];

  // Context Use
  final List<String> contextUseWords = [
    'Ambition',
    // Add 9 more words
    'Joy',
    'Courage',
    'Fear',
    'Hope',
    'Peace',
    'Love',
    'Friendship',
    'Knowledge',
    'Wisdom',
    'Strength',
  ];

  List<TextEditingController> contextUseControllers =
  List.generate(10, (_) => TextEditingController());
  List<String> contextUseFeedback = List.filled(10, '');
  bool showContextUseResults = false;

  // Analogies
  final List<Map<String, dynamic>> analogiesQuestions = [
    {
      'question': 'Bright is to Dark as Hot is to ________.',
      'options': ['Cold', 'Warm', 'Cool', 'Mild'],
      'answer': 'Cold',
      'selected': null,
      'feedback': ''
    },
    // Add 9 more analogy questions
    {
      'question': 'Up is to Down as Left is to ________.',
      'options': ['Right', 'Center', 'Middle', 'Top'],
      'answer': 'Right',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Cat is to Kitten as Dog is to ________.',
      'options': ['Puppy', 'Cub', 'Calf', 'Chick'],
      'answer': 'Puppy',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Big is to Small as Hot is to ________.',
      'options': ['Warm', 'Cold', 'Cool', 'Heat'],
      'answer': 'Cold',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Bird is to Fly as Fish is to ________.',
      'options': ['Swim', 'Walk', 'Run', 'Jump'],
      'answer': 'Swim',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Hand is to Finger as Foot is to ________.',
      'options': ['Toe', 'Leg', 'Arm', 'Knee'],
      'answer': 'Toe',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Sun is to Day as Moon is to ________.',
      'options': ['Night', 'Light', 'Star', 'Sky'],
      'answer': 'Night',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Ear is to Hear as Eye is to ________.',
      'options': ['See', 'Smell', 'Taste', 'Touch'],
      'answer': 'See',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Pen is to Write as Knife is to ________.',
      'options': ['Cut', 'Eat', 'Paint', 'Draw'],
      'answer': 'Cut',
      'selected': null,
      'feedback': ''
    },
    {
      'question': 'Cow is to Milk as Hen is to ________.',
      'options': ['Eggs', 'Wool', 'Feathers', 'Meat'],
      'answer': 'Eggs',
      'selected': null,
      'feedback': ''
    },
  ];

  // Sentence Creation Words
  final List<List<String>> sentenceCreationWords = [
    ['happy', 'joyful', 'excited'],
    // Add 9 more sets of words
    ['sad', 'gloomy', 'unhappy'],
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

  // Unscramble Words
  final List<Map<String, String>> unscrambleWords = [
    {'scrambled': 'tac', 'correct': 'cat'},
    {'scrambled': 'god', 'correct': 'dog'},
    {'scrambled': 'esuom', 'correct': 'mouse'},
    {'scrambled': 'tihbrd', 'correct': 'bird'},
    {'scrambled': 'hsfi', 'correct': 'fish'},
    {'scrambled': 'fnoehlat', 'correct': 'elephant'},
    {'scrambled': 'grite', 'correct': 'tiger'},
    {'scrambled': 'nilo', 'correct': 'lion'},
    {'scrambled': 'eazbr', 'correct': 'zebra'},
    {'scrambled': 'kcdu', 'correct': 'duck'},
  ];

  List<TextEditingController> unscrambleControllers =
  List.generate(10, (_) => TextEditingController());
  List<String> unscrambleFeedback = List.filled(10, '');
  bool showUnscrambleResults = false;

  // Match Definitions
  final List<Map<String, String>> matchDefinitions = [
    {'definition': 'A domesticated carnivorous mammal', 'word': 'cat'},
    {'definition': 'A large, heavy-bodied member of the dog family', 'word': 'dog'},
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
              icon: Icon(Icons.sync), label: 'Synonyms'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sync_disabled), label: 'Antonyms'),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_fields), label: 'Context Use'),
          BottomNavigationBarItem(
              icon: Icon(Icons.linear_scale), label: 'Analogies'),
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
        (currentExercise == 2 && synonymQuestions.every((q) => q['feedback'] != '')) ||
        (currentExercise == 3 && antonymQuestions.every((q) => q['feedback'] != '')) ||
        (currentExercise == 4 && showContextUseResults) ||
        (currentExercise == 5 && analogiesQuestions.every((q) => q['feedback'] != '')) ||
        (currentExercise == 6 && showSentenceCreationResults) ||
        (currentExercise == 7 && showUnscrambleResults) ||
        (currentExercise == 8 && showMatchResults);
  }


  void evaluateCurrentExercise() {
    switch (currentExercise) {
      case 0:
        evaluateMCQ();
        break;
      case 1:
        evaluateCompletePhrase();
        break;
      case 2:
        evaluateSynonyms();
        break;
      case 3:
        evaluateAntonyms();
        break;
      case 4:
        evaluateContextUse();
        break;
      case 5:
        evaluateAnalogies();
        break;
      case 6:
        evaluateSentenceCreation();
        break;
      case 7:
        evaluateUnscramble();
        break;
      case 8:
        evaluateMatch();
        break;
    }
  }
  void evaluateMCQ() {
    setState(() {
      for (var question in multipleChoiceQuestions) {
        if (question['selected'] == null) {
          question['feedback'] = 'No answer selected.';
        } else if (question['selected'] == question['answer']) {
          question['feedback'] = 'Correct!';
          score++;
        } else {
          question['feedback'] =
          'Incorrect! The correct answer is: ${question['answer']}';
        }
      }
      showMCQResults = true; // علشان يظهر النتائج بعد التقييم
    });
  }



  void evaluateCompletePhrase() {
    setState(() {
      showCompletePhraseResults = true;
      for (int i = 0; i < completePhraseControllers.length; i++) {
        String userAnswer =
        completePhraseControllers[i].text.trim().toLowerCase();
        if (userAnswer == completePhraseAnswers[i].toLowerCase()) {
          completePhraseFeedback[i] = 'Correct!';
          score++;
        } else {
          completePhraseFeedback[i] =
          'Incorrect! Correct answer: ${completePhraseAnswers[i]}';
        }
      }
    });
  }

  void evaluateSynonyms() {
    setState(() {
      for (var question in synonymQuestions) {
        if (question['selected'] == question['answer']) {
          question['feedback'] = 'Correct!';
          score++;
        } else {
          question['feedback'] =
          'Incorrect! Correct answer: ${question['answer']}';
        }
      }
    });
  }

  void evaluateAntonyms() {
    setState(() {
      for (var question in antonymQuestions) {
        if (question['selected'] == question['answer']) {
          question['feedback'] = 'Correct!';
          score++;
        } else {
          question['feedback'] =
          'Incorrect! Correct answer: ${question['answer']}';
        }
      }
    });
  }

  void evaluateContextUse() {
    setState(() {
      showContextUseResults = true;
      for (int i = 0; i < contextUseControllers.length; i++) {
        String userSentence =
        contextUseControllers[i].text.trim().toLowerCase();
        if (userSentence.contains(contextUseWords[i].toLowerCase())) {
          contextUseFeedback[i] = 'Correct usage!';
          score++;
        } else {
          contextUseFeedback[i] =
          'Please use the word "${contextUseWords[i]}" in your sentence.';
        }
      }
    });
  }

  void evaluateAnalogies() {
    setState(() {
      for (var question in analogiesQuestions) {
        if (question['selected'] == question['answer']) {
          question['feedback'] = 'Correct!';
          score++;
        } else {
          question['feedback'] =
          'Incorrect! Correct answer: ${question['answer']}';
        }
      }
    });
  }

  void evaluateSentenceCreation() {
    setState(() {
      showSentenceCreationResults = true;
      for (int i = 0; i < sentenceCreationControllers.length; i++) {
        String sentence =
        sentenceCreationControllers[i].text.trim().toLowerCase();
        List<String> words = sentenceCreationWords[i];
        if (words.every((word) => sentence.contains(word.toLowerCase()))) {
          sentenceCreationFeedback[i] = 'Great sentence!';
          score++;
        } else {
          sentenceCreationFeedback[i] =
          'Please include all the words: ${words.join(", ")}';
        }
      }
    });
  }

  void evaluateUnscramble() {
    setState(() {
      showUnscrambleResults = true;
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
    });
  }

  void evaluateMatch() {
    setState(() {
      showMatchResults = true;
      for (int i = 0; i < matchSelectedWords.length; i++) {
        if (matchSelectedWords[i] == matchDefinitions[i]['word']) {
          matchFeedback[i] = 'Correct!';
          score++;
        } else {
          matchFeedback[i] =
          'Incorrect! Correct answer: ${matchDefinitions[i]['word']}';
        }
      }
    });
  }

  void nextExercise() {
    if (currentExercise < 8) {
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
          content: Text('Your total score is $score out of 90.'),
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
      showMCQResults = false; // Reset the flag

      // ... rest of your reset code
    });
  }

  Widget getExerciseWidget() {
    switch (currentExercise) {
      case 0:
        return multipleChoiceExercise();
      case 1:
        return completePhraseExercise();
      case 2:
        return synonymExercise();
      case 3:
        return antonymExercise();
      case 4:
        return contextUseExercise();
      case 5:
        return analogiesExercise();
      case 6:
        return sentenceCreationExercise();
      case 7:
        return unscrambleWordsExercise();
      case 8:
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
                if (question['feedback'] != '')
                  Text(
                    question['feedback'],
                    style: TextStyle(
                      color: question['feedback'].contains('صحيحة')
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

  Widget synonymExercise() {
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
                if (question['feedback'] != '')
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

  Widget antonymExercise() {
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
                if (question['feedback'] != '')
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

  Widget contextUseExercise() {
    return ListView.builder(
      itemCount: contextUseWords.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title:
            Text('Use the word "${contextUseWords[index]}" in a sentence:'),
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

  Widget analogiesExercise() {
    return ListView.builder(
      itemCount: analogiesQuestions.length,
      itemBuilder: (context, index) {
        var question = analogiesQuestions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Complete the analogy: ${question['question']}'),
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
                if (question['feedback'] != '')
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

  Widget sentenceCreationExercise() {
    return ListView.builder(
      itemCount: sentenceCreationWords.length,
      itemBuilder: (context, index) {
        List<String> words = sentenceCreationWords[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title:
            Text('Create a sentence using these words: ${words.join(", ")}'),
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
                      color: sentenceCreationFeedback[index] ==
                          'Great sentence!'
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
            title:
            Text('Unscramble: ${unscrambleWords[index]['scrambled']}'),
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
