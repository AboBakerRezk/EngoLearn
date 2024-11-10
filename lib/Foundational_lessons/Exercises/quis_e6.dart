import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';


class QuizScreen6 extends StatefulWidget {
  @override
  _QuizScreen6State createState() => _QuizScreen6State();
}

class _QuizScreen6State extends State<QuizScreen6> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة السادسة
    'over': [
      'He jumped ___ the fence.',
      'The plane flew ___ the ocean.',
      'She looked ___ the documents.',
      'It’s not ___ until we say it is.'
    ],
    'world': [
      'He traveled around the ___.',
      'The ___ is a big place.',
      'There are many cultures in the ___.',
      'She wants to see the ___.'
    ],
    'information': [
      'We need more ___.',
      'She shared important ___.',
      'The website has a lot of ___.',
      'I found some useful ___.'
    ],
    'map': [
      'Can you read this ___?',
      'We need a ___ to find the location.',
      'The ___ shows all the countries.',
      'She drew a ___ of the area.'
    ],
    'find': [
      'He wants to ___ a new job.',
      'Can you ___ the key?',
      'She needs to ___ her way home.',
      'They hope to ___ the solution.'
    ],
    'where': [
      'Do you know ___ he went?',
      'Tell me ___ the keys are.',
      'She asked ___ the station is.',
      '___ did they put it?'
    ],
    'much': [
      'There is too ___ noise here.',
      'How ___ does this cost?',
      'He has so ___ to say.',
      'She likes it very ___.'
    ],
    'take': [
      '___ this book with you.',
      'He wants to ___ a break.',
      'She will ___ the exam tomorrow.',
      'Please ___ me to the store.'
    ],
    'two': [
      'I have ___ dogs.',
      'There are ___ options to choose from.',
      'He gave me ___ apples.',
      'We need ___ more chairs.'
    ],
    'want': [
      'Do you ___ some coffee?',
      'She doesn’t ___ to go.',
      'They ___ to learn more.',
      'I ___ a new phone.'
    ],
    'important': [
      'This is an ___ decision.',
      'She has an ___ meeting.',
      'It is ___ to be on time.',
      'He made an ___ announcement.'
    ],
    'family': [
      'She loves her ___.',
      'They spent the weekend with their ___.',
      'His ___ is very supportive.',
      'We are going to have a ___ reunion.'
    ],
    'those': [
      '___ books belong to me.',
      'Can you see ___ stars?',
      '___ are my friends.',
      'She likes ___ shoes.'
    ],
    'example': [
      'This is an ___ of good behavior.',
      'He gave an ___ to illustrate his point.',
      'For ___, look at this chart.',
      'There are many ___ of this case.'
    ],
    'while': [
      'She read a book ___ waiting.',
      'He listened to music ___ working.',
      'I will cook dinner ___ you set the table.',
      'They talked ___ walking.'
    ],
    'he': [
      '___ is my best friend.',
      '___ went to the store.',
      '___ doesn’t know yet.',
      'I told him, but ___ forgot.'
    ],
    'look': [
      'Please ___ at the board.',
      'She likes to ___ at the stars.',
      'He had a sad ___.',
      'They ___ happy today.'
    ],
    'government': [
      'The ___ passed a new law.',
      'She works for the ___.',
      'The ___ is responsible for public services.',
      'They protested against the ___.'
    ],
    'before': [
      'Finish your homework ___ dinner.',
      'He arrived ___ the meeting started.',
      'Call me ___ you leave.',
      'Wash your hands ___ eating.'
    ],
    'help': [
      'Can you ___ me with this?',
      'She needs some ___.',
      'They offered to ___.',
      'I want to ___ you.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'over': 'على',
    'world': 'العالم',
    'information': 'معلومات',
    'map': 'خريطة',
    'find': 'جد',
    'where': 'أين',
    'much': 'كثير',
    'take': 'خذ',
    'two': 'اثنان',
    'want': 'تريد',
    'important': 'مهم',
    'family': 'أسرة',
    'those': 'أولئك',
    'example': 'مثال',
    'while': 'بينما',
    'he': 'هو',
    'look': 'ينظر',
    'government': 'حكومة',
    'before': 'قبل',
    'help': 'مساعدة',
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
