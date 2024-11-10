import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';


class QuizScreen9 extends StatefulWidget {
  @override
  _QuizScreen9State createState() => _QuizScreen9State();
}

class _QuizScreen9State extends State<QuizScreen9> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة التاسعة
    'meat': [
      'He likes to eat ___.',
      '___ is rich in protein.',
      'She prepared a dish with ___.',
      'They bought some fresh ___ from the market.'
    ],
    'air': [
      'The ___ is fresh today.',
      'He needs some fresh ___.',
      'We breathe ___.',
      'Close the window to keep the cold ___ out.'
    ],
    'day': [
      'Today is a beautiful ___.',
      'We met the other ___.',
      'She works every ___.',
      'He went to the park during the ___.'
    ],
    'place': [
      'This is a nice ___.',
      'He found a quiet ___.',
      'The party will take ___ at 7 PM.',
      'She likes to visit new ___.'
    ],
    'become': [
      'She wants to ___ a doctor.',
      'He will ___ famous one day.',
      'They might ___ friends.',
      'It will ___ dark soon.'
    ],
    'number': [
      'What is your phone ___?',
      'She wrote down the ___.',
      'There is a large ___ of people.',
      'The ___ of participants is increasing.'
    ],
    'public': [
      'The park is open to the ___.',
      'She works in the ___ sector.',
      'This is a ___ announcement.',
      'He is a ___ figure.'
    ],
    'read': [
      'She likes to ___ books.',
      'He ___ the letter out loud.',
      'They want to ___ the newspaper.',
      'We ___ the instructions carefully.'
    ],
    'keep': [
      'Please ___ the door closed.',
      'He wants to ___ his promises.',
      'She ___ the money in a safe place.',
      'They ___ asking questions.'
    ],
    'part': [
      'This is an important ___ of the project.',
      'She played a major ___.',
      'He is a ___ of the team.',
      'The ___ was missing.'
    ],
    'start': [
      'It’s time to ___ the meeting.',
      'She wants to ___ a new hobby.',
      'They decided to ___ over.',
      'He will ___ his new job tomorrow.'
    ],
    'year': [
      'This ___ has been great.',
      'He was born in the ___ 2000.',
      'She spent a ___ abroad.',
      'The ___ ended quickly.'
    ],
    'every': [
      'She goes to the gym ___ day.',
      'He checks his mail ___ morning.',
      'They meet ___ week.',
      'We need to clean ___ room.'
    ],
    'field': [
      'He works in the medical ___.',
      'The ___ was full of flowers.',
      'She is an expert in her ___.',
      'They played soccer on the ___.'
    ],
    'large': [
      'They live in a ___ house.',
      'The elephant is a very ___ animal.',
      'She has a ___ collection of books.',
      'There was a ___ crowd at the concert.'
    ],
    'once': [
      'I visited that place ___.',
      'She only made the mistake ___.',
      'He will try it at least ___.',
      'We met only ___ before.'
    ],
    'available': [
      'The book is now ___.',
      'Is there a seat ___?',
      'She is not ___ at the moment.',
      'The tickets are no longer ___.'
    ],
    'down': [
      'He sat ___ on the chair.',
      'The cat jumped ___.',
      'She looked ___ the stairs.',
      'They ran ___ the hill.'
    ],
    'give': [
      'Please ___ me a pen.',
      'She will ___ him a gift.',
      'He wants to ___ them some advice.',
      'They decided to ___ it a try.'
    ],
    'fish': [
      'They caught a big ___.',
      'He likes to eat grilled ___.',
      'She bought some fresh ___ from the market.',
      'The pond is full of ___.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'meat': 'لحم',
    'air': 'هواء',
    'day': 'يوم',
    'place': 'مكان',
    'become': 'يصبح',
    'number': 'رقم',
    'public': 'عام',
    'read': 'قرأ',
    'keep': 'احتفظ',
    'part': 'جزء',
    'start': 'بداية',
    'year': 'عام',
    'every': 'كل',
    'field': 'حقل',
    'large': 'كبير',
    'once': 'مرة واحدة',
    'available': 'متاح',
    'down': 'أسفل',
    'give': 'يعطي',
    'fish': 'سمك',
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
        feedback = '${AppLocale.S60.getString(context)}: ${wordTranslations[correctWord]}: ${wordTranslations[correctWord]}';
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
