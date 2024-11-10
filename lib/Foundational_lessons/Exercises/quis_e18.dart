import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';



class QuizScreen18 extends StatefulWidget {
  @override
  _QuizScreen18State createState() => _QuizScreen18State();
}

class _QuizScreen18State extends State<QuizScreen18> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الثامنة عشرة
    'instead': [
      'She chose tea ___ of coffee.',
      'He decided to stay home ___ of going out.',
      'They used wood ___ of plastic.',
      'She wore a dress ___ of jeans.'
    ],
    'least': [
      'She has the ___ amount of experience.',
      'He is the ___ likely to succeed.',
      'At the ___, try to be polite.',
      'She has the ___ number of errors.'
    ],
    'natural': [
      'She loves ___ beauty.',
      'He prefers ___ ingredients.',
      'They admired the ___ landscape.',
      'It is ___ to feel nervous.'
    ],
    'physical': [
      'She enjoys ___ activities.',
      'He is in great ___ shape.',
      'They need to do more ___ exercise.',
      'It is a ___ challenge.'
    ],
    'piece': [
      'She took a ___ of cake.',
      'He found a ___ of the puzzle.',
      'They need one more ___ of information.',
      'The artist created a new ___.'
    ],
    'show': [
      'She wants to ___ her skills.',
      'He will ___ us how to do it.',
      'They plan to ___ the results.',
      'The movie will ___ tonight.'
    ],
    'society': [
      'She studied the impact on ___.',
      'He believes in a fair ___.',
      'They discussed issues in modern ___.',
      'The ___ is changing rapidly.'
    ],
    'try': [
      'She decided to ___ again.',
      'He will ___ to solve the problem.',
      'They need to ___ harder.',
      'Let’s ___ a new approach.'
    ],
    'check': [
      'She needs to ___ her email.',
      'He forgot to ___ the list.',
      'They will ___ the report.',
      'Can you ___ the time?'
    ],
    'choose': [
      'She has to ___ a new car.',
      'He will ___ his classes tomorrow.',
      'They need to ___ a leader.',
      'You must ___ wisely.'
    ],
    'develop': [
      'She wants to ___ a new skill.',
      'He helped ___ the project.',
      'They aim to ___ the app further.',
      'It takes time to ___ a habit.'
    ],
    'second': [
      'She came in ___.',
      'He is my ___ choice.',
      'They met for the ___ time.',
      'This is the ___ part of the lesson.'
    ],
    'useful': [
      'She found the book very ___.',
      'He gave me some ___ advice.',
      'They need a ___ tool.',
      'It is ___ to know these facts.'
    ],
    'web': [
      'She browsed the ___.',
      'He is a ___ developer.',
      'They created a new ___.',
      'The spider spun a ___.'
    ],
    'activity': [
      'She enjoys outdoor ___.',
      'He planned a fun ___.',
      'They participate in group ___.',
      'The ___ was successful.'
    ],
    'boss': [
      'She met with her ___.',
      'He is the new ___.',
      'They have a strict ___.',
      'The ___ gave a speech.'
    ],
    'short': [
      'She wrote a ___ story.',
      'He took a ___ break.',
      'They have a ___ meeting.',
      'The ___ answer is yes.'
    ],
    'story': [
      'She told a beautiful ___.',
      'He reads a new ___ every night.',
      'They listened to an exciting ___.',
      'The ___ has a happy ending.'
    ],
    'call': [
      'She received a phone ___.',
      'He will ___ his friend later.',
      'They made an emergency ___.',
      'Please ___ me back.'
    ],
    'industry': [
      'She works in the tech ___.',
      'He is part of the film ___.',
      'They lead in the fashion ___.',
      'The ___ is growing fast.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'instead': 'بدلاً',
    'least': 'الأقل',
    'natural': 'طبيعي',
    'physical': 'بدني',
    'piece': 'قطعة',
    'show': 'يظهر',
    'society': 'مجتمع',
    'try': 'محاولة',
    'check': 'تحقق',
    'choose': 'اختر',
    'develop': 'طور',
    'second': 'ثاني',
    'useful': 'مفيد',
    'web': 'شبكة',
    'activity': 'نشاط',
    'boss': 'رئيس',
    'short': 'قصير',
    'story': 'قصة',
    'call': 'مكالمة',
    'industry': 'صناعة',
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
