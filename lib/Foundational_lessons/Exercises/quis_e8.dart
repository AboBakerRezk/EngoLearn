import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';


class QuizScreen8 extends StatefulWidget {
  @override
  _QuizScreen8State createState() => _QuizScreen8State();
}

class _QuizScreen8State extends State<QuizScreen8> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الثامنة
    'had': [
      'She ___ a great time at the party.',
      'We ___ dinner at a nice restaurant.',
      'He ___ a lot of homework to do.',
      'They ___ many opportunities to succeed.'
    ],
    'hi': [
      '___! How are you today?',
      'I waved and said, "___!"',
      'He greeted her with a friendly "___!"',
      '___ there, nice to meet you!'
    ],
    'right': [
      'You are absolutely ___.',
      'Turn to the ___ at the next corner.',
      'She made the ___ decision.',
      'Is this the ___ way to the station?'
    ],
    'still': [
      'He is ___ working on the project.',
      'They ___ live in the same house.',
      'She is ___ waiting for a response.',
      'We are ___ friends.'
    ],
    'system': [
      'The computer ___ crashed.',
      'She learned about the solar ___.',
      'They installed a new heating ___.',
      'The education ___ needs reform.'
    ],
    'after': [
      'We went for coffee ___ the movie.',
      'He came back ___ a long journey.',
      'She felt better ___ resting.',
      '___ you finish, let me know.'
    ],
    'computer': [
      'He bought a new ___.',
      'She works with a ___ all day.',
      'The ___ is very fast.',
      'We need to fix the ___.'
    ],
    'best': [
      'She is the ___ in her class.',
      'He tried his ___.',
      'This is the ___ cake I have ever tasted.',
      'We wish you all the ___.'
    ],
    'must': [
      'You ___ study for the exam.',
      'We ___ leave now.',
      'She ___ finish her work.',
      'He ___ be tired after the trip.'
    ],
    'her': [
      'That is ___ book.',
      'She lost ___ keys.',
      'I gave ___ a gift.',
      'The dog is following ___.'
    ],
    'life': [
      'He has a good ___.',
      'She enjoys her ___.',
      'We want to live a happy ___.',
      'They talked about the meaning of ___.'
    ],
    'since': [
      'I haven’t seen him ___ last year.',
      'She has been happy ___ the move.',
      'We have known each other ___ childhood.',
      '___ that day, everything changed.'
    ],
    'could': [
      'He ___ not believe his eyes.',
      'She ___ swim when she was four.',
      'They ___ see the mountains from their window.',
      'We ___ help if we knew how.'
    ],
    'does': [
      'What ___ she do for a living?',
      'He ___ not like coffee.',
      'She ___ her homework every day.',
      'Why ___ it matter?'
    ],
    'now': [
      'We need to go ___.',
      'She is busy right ___.',
      'He wants to eat lunch ___.',
      'Do it ___.'
    ],
    'during': [
      'She slept ___ the flight.',
      'He talked ___ the entire meeting.',
      'They were quiet ___ the movie.',
      'We went out ___ the break.'
    ],
    'learn': [
      'She wants to ___ French.',
      'He is trying to ___ how to cook.',
      'They need to ___ new skills.',
      'We must ___ from our mistakes.'
    ],
    'around': [
      'He looked ___ the room.',
      'They traveled ___ the world.',
      'She walked ___ the park.',
      'We are planning to go ___ noon.'
    ],
    'usually': [
      'She ___ wakes up early.',
      'They ___ go to the beach on weekends.',
      'He is ___ on time.',
      'I ___ have coffee in the morning.'
    ],
    'form': [
      'Please fill out this ___.',
      'They signed the consent ___.',
      'She needs to complete the application ___.',
      'The sculpture took the ___ of a lion.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'had': 'كان',
    'hi': 'مرحبا',
    'right': 'حق',
    'still': 'ما زال',
    'system': 'نظام',
    'after': 'بعد',
    'computer': 'حاسوب',
    'best': 'الأفضل',
    'must': 'يجب',
    'her': 'لها',
    'life': 'حياة',
    'since': 'منذ',
    'could': 'استطاع',
    'does': 'يفعل',
    'now': 'الآن',
    'during': 'أثناء',
    'learn': 'تعلم',
    'around': 'حول',
    'usually': 'عادة',
    'form': 'شكل',
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
