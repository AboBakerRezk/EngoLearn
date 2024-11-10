import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';


class QuizScreen4 extends StatefulWidget {
  @override
  _QuizScreen4State createState() => _QuizScreen4State();
}

class _QuizScreen4State extends State<QuizScreen4> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الرابعة
    'out': [
      'He went ___ to play.',
      'She looked ___ of the window.',
      'Take the trash ___.',
      'They walked ___ of the room.'
    ],
    'who': [
      '___ is coming to the party?',
      'I don’t know ___ he is.',
      '___ would like to go?',
      'Do you know ___ she is?'
    ],
    'them': [
      'Give ___ the keys.',
      'I saw ___ at the park.',
      'Tell ___ to wait here.',
      'He asked ___ for help.'
    ],
    'make': [
      'Can you ___ a cake?',
      'She wants to ___ a decision.',
      'They ___ a lot of noise.',
      'Let’s ___ it happen.'
    ],
    'because': [
      'I stayed home ___ it was raining.',
      'She is happy ___ she got a gift.',
      'They left early ___ they were tired.',
      'He can’t come ___ he is busy.'
    ],
    'such': [
      'She has ___ a beautiful voice.',
      'It was ___ a nice day.',
      'He is ___ a great person.',
      'They had ___ fun at the party.'
    ],
    'through': [
      'She walked ___ the forest.',
      'He looked ___ the documents.',
      'The light came ___ the window.',
      'They went ___ a difficult time.'
    ],
    'get': [
      'Can you ___ the book for me?',
      'She will ___ a present tomorrow.',
      'He wants to ___ a new job.',
      'They need to ___ more information.'
    ],
    'work': [
      'I have to ___ today.',
      'She likes her ___.',
      'They are looking for ___.',
      'He finished his ___.'
    ],
    'even': [
      '___ he agreed with me.',
      'She didn’t ___ try.',
      'He’s smart, ___ if he doesn’t study.',
      'They ___ know about it.'
    ],
    'different': [
      'This is a ___ color.',
      'She looks ___ today.',
      'They have a ___ opinion.',
      'It’s a ___ situation.'
    ],
    'its': [
      'The cat chased ___ tail.',
      'This car has lost ___ value.',
      'Every dog has ___ day.',
      'The company is known for ___ success.'
    ],
    'no': [
      'There is ___ way to solve this.',
      'She has ___ idea what happened.',
      'I have ___ money left.',
      '___ one came to the meeting.'
    ],
    'our': [
      'This is ___ house.',
      '___ team won the game.',
      'It is ___ responsibility.',
      '___ family is coming over.'
    ],
    'new': [
      'He bought a ___ car.',
      'She moved to a ___ city.',
      'This is a ___ idea.',
      'We have a ___ project.'
    ],
    'film': [
      'They watched a ___ last night.',
      'He is a famous ___ director.',
      'The ___ was very interesting.',
      'Have you seen this ___?'
    ],
    'just': [
      'I ___ finished my work.',
      'She is ___ like her mother.',
      'He arrived ___ in time.',
      'It’s ___ a game.'
    ],
    'only': [
      'He is the ___ one who knows.',
      'She has ___ one friend.',
      'I can ___ imagine how it feels.',
      'This is the ___ solution.'
    ],
    'see': [
      'Can you ___ the stars?',
      'I want to ___ you tomorrow.',
      'He didn’t ___ it coming.',
      'We will ___ what happens.'
    ],
    'used': [
      'This machine is ___ for cutting.',
      'He ___ to work here.',
      'She is ___ to the cold weather.',
      'It is ___ by professionals.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'out': 'خارج',
    'who': 'من',
    'them': 'هم',
    'make': 'يصنع',
    'because': 'لأن',
    'such': 'مثل',
    'through': 'عبر',
    'get': 'يحصل على',
    'work': 'عمل',
    'even': 'حتى',
    'different': 'مختلف',
    'its': 'له',
    'no': 'لا',
    'our': 'لنا',
    'new': 'جديد',
    'film': 'فيلم',
    'just': 'فقط',
    'only': 'فقط',
    'see': 'يرى',
    'used': 'مستخدم',
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
                          side: BorderSide(color: Colors.blue, width: 2), // لون الحدود
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                      onPressed: () => checkAnswer(options[index]),
                      child: Text(options[index]), // نص الزر
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
