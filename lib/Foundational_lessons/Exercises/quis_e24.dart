import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';



class QuizScreen24 extends StatefulWidget {
  @override
  _QuizScreen24State createState() => _QuizScreen24State();
}

class _QuizScreen24State extends State<QuizScreen24> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الرابعة والعشرين
    'excuse': [
      'Please provide an ___.',
      'He made an ___ for his absence.',
      'Can you give a ___ for being late?',
      'She apologized with an ___.'
    ],
    'grow': [
      'Children ___ quickly.',
      'The plants ___ in the garden.',
      'He hopes to ___ as a person.',
      'The company continues to ___.'
    ],
    'movie': [
      'They watched a new ___.',
      'She enjoyed the ___ at the theater.',
      'He rented a ___ from the store.',
      'What is your favorite ___ genre?'
    ],
    'organization': [
      'The ___ held a conference.',
      'She works for a non-profit ___.',
      'The ___ is known for its charity work.',
      'Can you name a famous __?'
    ],
    'record': [
      'He set a new ___ in the game.',
      'She broke the world ___.',
      'The ___ shows the data from last year.',
      'Can you update the ___ with the latest figures?'
    ],
    'result': [
      'The ___ of the test was positive.',
      'He checked the ___ of the experiment.',
      'The ___ was what they expected.',
      'What is the ___ of the survey?'
    ],
    'section': [
      'Read the first ___ of the book.',
      'This ___ of the report needs revision.',
      'She highlighted the important ___ in the document.',
      'Can you review this ___ of the paper?'
    ],
    'across': [
      'He walked ___ the street.',
      'They traveled ___ the country.',
      'The path goes ___ the river.',
      'Can you see the house ___ the lake?'
    ],
    'already': [
      'The project is ___ completed.',
      'She has ___ finished her homework.',
      'The tickets are ___ sold out.',
      'He had ___ seen the movie before.'
    ],
    'below': [
      'The temperature is ___ freezing.',
      'The cat is hiding ___ the table.',
      'He placed the box ___ the shelf.',
      'Can you look ___ the desk for the keys?'
    ],
    'building': [
      'The ___ is under construction.',
      'They work in a tall ___.',
      'The ___ is made of glass and steel.',
      'What is the tallest ___ in your city?'
    ],
    'mouse': [
      'The ___ ran across the floor.',
      'She uses a computer ___.',
      'A ___ was caught in the trap.',
      'He saw a ___ in the kitchen.'
    ],
    'allow': [
      'They do not ___ pets in the dorm.',
      'He ___ her to leave early.',
      'The policy does not ___ smoking.',
      'Can you ___ me to use your phone?'
    ],
    'cash': [
      'He paid in ___.',
      'The store accepts ___ payments.',
      'She kept the ___ in a safe.',
      'Do you have any ___ on you?'
    ],
    'class': [
      'The teacher is in the ___.',
      'She is attending a ___ on biology.',
      'The ___ starts at 9 AM.',
      'What is your favorite ___ subject?'
    ],
    'clear': [
      'The instructions are very ___.',
      'The sky is ___ today.',
      'He made a ___ statement.',
      'Is this explanation ___ enough?'
    ],
    'dry': [
      'The clothes are ___ after washing.',
      'He felt ___ after the workout.',
      'The desert is very ___.',
      'Can you make sure the towel is ___?'
    ],
    'easy': [
      'The exam was quite ___.',
      'This recipe is very ___.',
      'He found the task ___.',
      'Is this puzzle ___ to solve?'
    ],
    'emotional': [
      'She gave an ___ speech.',
      'The movie was very ___.',
      'He had an ___ response to the news.',
      'Can you describe your ___ reaction?'
    ],
    'equipment': [
      'They need new ___ for the lab.',
      'The gym has updated its ___.',
      'She bought some cooking ___.',
      'What kind of ___ do you use for painting?'
    ],
  };

  final Map<String, String> wordTranslations = {
    'excuse': 'عذر',
    'grow': 'ينمو',
    'movie': 'فيلم',
    'organization': 'منظمة',
    'record': 'سجل',
    'result': 'نتيجة',
    'section': 'قسم',
    'across': 'عبر',
    'already': 'سابقاً',
    'below': 'أسفل',
    'building': 'بناء',
    'mouse': 'فأر',
    'allow': 'يسمح',
    'cash': 'نقدي',
    'class': 'فصل دراسي',
    'clear': 'واضح',
    'dry': 'جاف',
    'easy': 'سهل',
    'emotional': 'عاطفي',
    'equipment': 'معدات',
  };

  late List<String> keys;
  int currentIndex = 0;
  int questionIndex = 0; // To track the current question for the word
  String feedback = '';

  @override
  void initState() {
    super.initState();
    keys = sentenceTemplates.keys.toList();
    keys.shuffle();
  }

  void checkAnswer(String selectedWord) {
    setState(() {
      String correctWord = keys[currentIndex];
      if (correctWord == selectedWord) {
        feedback = '${AppLocale.S65.getString(context)}';
      } else {
        feedback = '${AppLocale.S60.getString(context)}: ${wordTranslations[correctWord]}';
      }

      questionIndex++;
      if (questionIndex >= 4) { // بعد 4 أسئلة ننتقل للكلمة التالية
        questionIndex = 0;
        currentIndex++;
      }

      if (currentIndex >= keys.length) {
        feedback = '${AppLocale.S61.getString(context)}!';
        currentIndex = 0;
        questionIndex = 0;
        keys.shuffle();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentWord = keys[currentIndex];
    String sentence = sentenceTemplates[currentWord]![questionIndex].replaceAll('___', '(${wordTranslations[currentWord]})');
    List<String> options = [currentWord];
    while (options.length < 4) {
      String randomWord = sentenceTemplates.keys.elementAt(Random().nextInt(sentenceTemplates.length));
      if (!options.contains(randomWord)) {
        options.add(randomWord);
      }
    }
    options.shuffle();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${AppLocale.S62.getString(context)}',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        backgroundColor: Colors.blue, // لون شريط التطبيق
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.black87], // لون الخلفية المتدرجة
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${AppLocale.S63.getString(context)}',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  sentence,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // عدد الأزرار في كل صف
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2,
                  ),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.white, // لون النص
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // حواف الزر الدائرية
                        ),
                      ),
                      onPressed: () {
                        checkAnswer(options[index]);
                      },
                      child: Text(
                        options[index],
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  feedback,
                  style: TextStyle(fontSize: 18, color: feedback == '${AppLocale.S65.getString(context)}' ? Colors.green : Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${AppLocale.S64.getString(context)} ${questionIndex + 1}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
