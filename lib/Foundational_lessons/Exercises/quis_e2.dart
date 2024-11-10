import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';



class QuizScreen2 extends StatefulWidget {
  @override
  _QuizScreen2State createState() => _QuizScreen2State();
}

class _QuizScreen2State extends State<QuizScreen2> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الثانية
    'this': [
      '___ is a good day.',
      'Can you see ___?',
      'I bought ___ yesterday.',
      '___ book is mine.'
    ],
    'an': [
      'I saw ___ elephant at the zoo.',
      'She has ___ apple in her bag.',
      'He wants ___ opportunity to prove himself.',
      '___ idea just came to me.'
    ],
    'by': [
      'This letter was written ___ her.',
      'He traveled ___ train.',
      'The book was published ___ the author.',
      'She stood ___ the door.'
    ],
    'not': [
      'I am ___ sure about this.',
      'She is ___ coming today.',
      'This is ___ what I expected.',
      'He is ___ going to agree.'
    ],
    'but': [
      'I like tea, ___ I don’t like coffee.',
      'He tried, ___ failed.',
      'She is smart ___ lazy.',
      'It’s expensive, ___ worth it.'
    ],
    'at': [
      'She is ___ the station.',
      'He works ___ the university.',
      'I met him ___ the party.',
      'The car is parked ___ the corner.'
    ],
    'from': [
      'He came ___ Paris.',
      'This gift is ___ my friend.',
      'I learned it ___ a book.',
      'She received a letter ___ her mom.'
    ],
    'I': [
      '___ am happy to see you.',
      '___ have a car.',
      '___ will go tomorrow.',
      '___ don’t understand.'
    ],
    'they': [
      '___ are playing outside.',
      '___ want to eat.',
      '___ have finished their homework.',
      '___ are leaving soon.'
    ],
    'more': [
      'I want ___ information.',
      'Give me ___ time.',
      'She needs ___ help.',
      'We have ___ to do.'
    ],
    'will': [
      'She ___ go to the market.',
      'He ___ finish the work.',
      'I ___ be there.',
      'They ___ arrive soon.'
    ],
    'if': [
      '___ you come, we will go.',
      'Call me ___ you need help.',
      '___ it rains, we will stay inside.',
      '___ you study, you will pass.'
    ],
    'some': [
      'I have ___ money.',
      'She wants ___ water.',
      'There are ___ books on the table.',
      'Can you give me ___ advice?'
    ],
    'there': [
      '___ is a cat on the roof.',
      '___ are many people here.',
      '___ is a chance to win.',
      '___ are many things to do.'
    ],
    'what': [
      '___ is your name?',
      '___ are you doing?',
      '___ do you want?',
      '___ time is it?'
    ],
    'about': [
      'Tell me ___ your day.',
      'What is this book ___?',
      'She is worried ___ the test.',
      'I know nothing ___ it.'
    ],
    'which': [
      '___ one do you prefer?',
      '___ book is yours?',
      '___ way should we go?',
      '___ color do you like?'
    ],
    'when': [
      '___ will you come?',
      'Do you know ___ they will arrive?',
      'Tell me ___ you are free.',
      'I wonder ___ it will happen.'
    ],
    'one': [
      'I have only ___ apple.',
      '___ of them is missing.',
      'She is the ___ who knows.',
      'Can I have ___ more?'
    ],
    'their': [
      'This is ___ house.',
      'I met ___ friends.',
      '___ decision was final.',
      '___ dog is very friendly.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'this': 'هذا',
    'an': 'أ',
    'by': 'بواسطة',
    'not': 'ليس',
    'but': 'لكن',
    'at': 'في',
    'from': 'من',
    'I': 'أنا',
    'they': 'هم',
    'more': 'أكثر',
    'will': 'سوف',
    'if': 'إذا',
    'some': 'بعض',
    'there': 'هناك',
    'what': 'ماذا',
    'about': 'حول',
    'which': 'التي',
    'when': 'متى',
    'one': 'واحد',
    'their': 'لهم',
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
