import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';

class QuizScreen20 extends StatefulWidget {
  @override
  _QuizScreen20State createState() => _QuizScreen20State();
}

class _QuizScreen20State extends State<QuizScreen20> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة العشرين
    'increase': [
      'They want to ___ their profits.',
      'She noticed an ___ in temperature.',
      'The ___ in prices is concerning.',
      'We need to ___ production.'
    ],
    'oven': [
      'She baked a cake in the ___.',
      'He preheated the ___ to 350 degrees.',
      'The ___ is very hot.',
      'The cookies are in the ___.'
    ],
    'quite': [
      'She is ___ smart.',
      'He is ___ the talented artist.',
      'It’s ___ difficult to solve.',
      'They are ___ friendly.'
    ],
    'scared': [
      'She was ___ of the dark.',
      'He felt ___ before the exam.',
      'They are ___ of spiders.',
      'I was ___ by the noise.'
    ],
    'single': [
      'She is currently ___.',
      'He bought a ___ ticket.',
      'There is not a ___ cloud in the sky.',
      'She read every ___ page.'
    ],
    'sound': [
      'She heard a strange ___.',
      'The ___ of music filled the room.',
      'He made a loud ___.',
      'They enjoyed the ___ of waves.'
    ],
    'again': [
      'She tried ___ and again.',
      'He will visit them ___.',
      'They asked him to do it ___.',
      'I have to start all over ___.'
    ],
    'community': [
      'She lives in a small ___.',
      'He joined the local ___.',
      'They helped build a new ___.',
      'The ___ is very supportive.'
    ],
    'definition': [
      'She looked up the ___ in the dictionary.',
      'He gave a clear ___ of the term.',
      'The ___ of the word is important.',
      'They discussed the ___ of success.'
    ],
    'focus': [
      'She needs to ___ on her studies.',
      'He lost ___ during the lecture.',
      'They need to ___ on the main issues.',
      'It’s important to maintain your ___.'
    ],
    'individual': [
      'She is a unique ___.',
      'He respects every ___.',
      'They value each ___.',
      'The ___ rights are protected.'
    ],
    'matter': [
      'This is a serious ___.',
      'He believes it does not ___.',
      'They discussed the important ___.',
      'It does not ___ what they say.'
    ],
    'safety': [
      'She is concerned about her ___.',
      'He follows all ___ rules.',
      'They ensured the ___ of the children.',
      '___ comes first in all situations.'
    ],
    'turn': [
      'It’s your ___.',
      'He made a sharp ___.',
      'They waited for their ___.',
      'She took a ___ to the left.'
    ],
    'everything': [
      'She lost ___.',
      'He remembered ___.',
      'They tried ___ they could.',
      '___ is ready for the trip.'
    ],
    'kind': [
      'She is very ___.',
      'He showed a ___ gesture.',
      'They are ___ to everyone.',
      'A ___ person helped me.'
    ],
    'quality': [
      'She checks the ___ of products.',
      'He values high ___.',
      'They maintain the ___ of service.',
      '___ is more important than quantity.'
    ],
    'soil': [
      'She planted flowers in the ___.',
      'He studies the ___ composition.',
      'They need rich ___ for farming.',
      'The ___ is fertile here.'
    ],
    'ask': [
      'She decided to ___ for help.',
      'He wants to ___ a question.',
      'They will ___ for a favor.',
      'Can I ___ you something?'
    ],
    'board': [
      'She serves on the ___.',
      'He presented to the ___.',
      'They put their names on the ___.',
      'The ___ meeting starts at noon.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'increase': 'زيادة',
    'oven': 'فرن',
    'quite': 'إلى حد كبير',
    'scared': 'خائف',
    'single': 'غير مرتبط',
    'sound': 'صوت',
    'again': 'مرة أخرى',
    'community': 'مجتمع',
    'definition': 'تعريف',
    'focus': 'تركيز',
    'individual': 'فرد',
    'matter': 'شيء',
    'safety': 'سلامة',
    'turn': 'دور',
    'everything': 'كل شيء',
    'kind': 'طيب',
    'quality': 'جودة',
    'soil': 'تربة',
    'ask': 'يطلب',
    'board': 'مجلس',
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
