import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';



class QuizScreen5 extends StatefulWidget {
  @override
  _QuizScreen5State createState() => _QuizScreen5State();
}

class _QuizScreen5State extends State<QuizScreen5> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الخامسة
    'good': [
      'This is a ___ idea.',
      'She has a ___ job.',
      'He is a ___ friend.',
      'They had a ___ time.'
    ],
    'water': [
      'Please bring me some ___.',
      '___ is essential for life.',
      'She drank a glass of ___.',
      'The plant needs ___.'
    ],
    'been': [
      'She has ___ to London.',
      'I have ___ working hard.',
      'He has ___ very kind.',
      'We have ___ there before.'
    ],
    'need': [
      'I ___ some help.',
      'We ___ to finish the project.',
      'She ___ to go to the store.',
      'They ___ more time.'
    ],
    'should': [
      'You ___ try this.',
      'He ___ be more careful.',
      'They ___ listen to the teacher.',
      'We ___ go now.'
    ],
    'very': [
      'It is ___ hot today.',
      'She is ___ talented.',
      'He was ___ happy with the result.',
      'The movie was ___ interesting.'
    ],
    'any': [
      'Do you have ___ questions?',
      'You can choose ___ color you like.',
      'I don’t have ___ money.',
      'Is there ___ news?'
    ],
    'history': [
      'I love studying ___.',
      'She is a professor of ___.',
      'The book is about world ___.',
      'We learned a lot about ancient ___.'
    ],
    'often': [
      'He ___ visits his grandparents.',
      'She ___ goes for a walk.',
      'We ___ eat out.',
      'They ___ travel abroad.'
    ],
    'way': [
      'This is the best ___ to do it.',
      'Show me the ___ to the station.',
      'He found a new ___.',
      'They are on their ___.'
    ],
    'well': [
      'She speaks English ___.',
      'He did his job ___.',
      'Everything is going ___.',
      'They know each other ___.'
    ],
    'art': [
      'She is passionate about ___.',
      'The gallery has beautiful pieces of ___.',
      'He is an ___ lover.',
      'They studied ___ in college.'
    ],
    'know': [
      'I ___ the answer.',
      'Do you ___ how to cook?',
      'She ___ a lot of people.',
      'They ___ what they want.'
    ],
    'were': [
      'They ___ very happy.',
      'We ___ there yesterday.',
      'The dogs ___ barking loudly.',
      'You ___ my best friends.'
    ],
    'then': [
      'Finish your homework, ___ you can play.',
      'We went shopping, and ___ we had dinner.',
      'He paused, ___ continued speaking.',
      'First, mix the ingredients, ___ bake.'
    ],
    'my': [
      'This is ___ book.',
      'He is ___ friend.',
      'I lost ___ keys.',
      '___ house is near the park.'
    ],
    'first': [
      'She won the ___ prize.',
      'This is the ___ time I’ve been here.',
      'He was the ___ to arrive.',
      'I want to be the ___ in line.'
    ],
    'would': [
      'I ___ like to have a cup of tea.',
      'She ___ help if she could.',
      'They ___ go if they had time.',
      'He ___ be happy to join us.'
    ],
    'money': [
      'I need more ___.',
      'He lost all his ___.',
      'They earned a lot of ___.',
      'She saved her ___.'
    ],
    'each': [
      '___ student has a book.',
      'They greeted ___ other warmly.',
      '___ of them has a unique talent.',
      'She gave a gift to ___ child.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'good': 'جيد',
    'water': 'ماء',
    'been': 'كان',
    'need': 'يحتاج',
    'should': 'ينبغي',
    'very': 'جداً',
    'any': 'أي',
    'history': 'تاريخ',
    'often': 'غالباً',
    'way': 'طريق',
    'well': 'حسناً',
    'art': 'فن',
    'know': 'يعرف',
    'were': 'كانوا',
    'then': 'ثم',
    'my': 'لي',
    'first': 'أول',
    'would': 'سوف',
    'money': 'مال',
    'each': 'كل',
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
