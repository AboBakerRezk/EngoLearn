import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';


class QuizScreen22 extends StatefulWidget {
  @override
  _QuizScreen22State createState() => _QuizScreen22State();
}

class _QuizScreen22State extends State<QuizScreen22> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الثانية والعشرين
    'management': [
      'She is studying ___.',
      'He works in project ___.',
      'Good ___ is key to success.',
      'They need better ___ for the team.'
    ],
    'open': [
      'She decided to ___ the window.',
      'He asked me to ___ the door.',
      'They will ___ the shop early.',
      'Please ___ your books.'
    ],
    'player': [
      'He is a talented football ___.',
      'She is the best ___ on the team.',
      'The ___ scored a goal.',
      'They need a new ___ for the game.'
    ],
    'range': [
      'The temperature ___ is high.',
      'She has a wide ___ of skills.',
      'The product ___ is diverse.',
      'They offer a ___ of services.'
    ],
    'rate': [
      'The birth ___ has decreased.',
      'She asked about the exchange ___.',
      'They want to ___ the performance.',
      'He knows the current interest ___.'
    ],
    'reason': [
      'She has a good ___ for leaving.',
      'What is the ___ for the delay?',
      'He couldn’t find a ___ to stay.',
      'The ___ was clear and understandable.'
    ],
    'travel': [
      'She loves to ___.',
      'He decided to ___ abroad.',
      'They ___ frequently for work.',
      'I want to ___ the world.'
    ],
    'variety': [
      'They offer a ___ of products.',
      'She likes the ___ in her job.',
      'There is a ___ of opinions.',
      'The menu has a great ___.'
    ],
    'video': [
      'He watched a ___ on YouTube.',
      'She recorded a ___ for her blog.',
      'They produced a new ___.',
      'The ___ went viral.'
    ],
    'week': [
      'She will arrive next ___.',
      'He works five days a ___.',
      'They plan to meet every ___.',
      'I had a busy ___.'
    ],
    'above': [
      'The airplane flew ___.',
      'She hung the picture ___.',
      'He looked ___ at the sky.',
      'The temperature is ___ normal.'
    ],
    'according': [
      '___ to the report, sales increased.',
      'He acted ___ to the plan.',
      'She completed the task ___ to instructions.',
      'The meeting was held ___ to schedule.'
    ],
    'cook': [
      'She likes to ___ Italian food.',
      'He learned to ___ from his mother.',
      'They decided to ___ dinner together.',
      'I want to ___ a special meal.'
    ],
    'determine': [
      'She wants to ___ the best course of action.',
      'He will ___ the outcome.',
      'They need to ___ the cause of the problem.',
      'I couldn’t ___ the correct answer.'
    ],
    'future': [
      'She is thinking about her ___.',
      'He plans for the ___.',
      'They are investing in the ___.',
      'The ___ looks bright.'
    ],
    'site': [
      'The construction ___ is huge.',
      'She visited the company ___.',
      'They chose a new ___ for the event.',
      'The ___ is currently under maintenance.'
    ],
    'alternative': [
      'She is looking for an ___.',
      'He offered an ___ solution.',
      'They found an ___ to the problem.',
      'I need an ___ plan.'
    ],
    'demand': [
      'There is high ___ for the product.',
      'She met the customer ___.',
      'They need to increase supply to meet ___.',
      'The job requires a lot of ___.'
    ],
    'ever': [
      'Have you ___ been to Paris?',
      'She is the best singer ___.',
      'He rarely, if ___, misses a meeting.',
      'I will love you forever and ___.'
    ],
    'exercise': [
      'She does ___ every morning.',
      'He loves to ___ at the gym.',
      'They recommend daily ___.',
      'I should start doing more ___.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'management': 'إدارة',
    'open': 'افتح',
    'player': 'لاعب',
    'range': 'نطاق',
    'rate': 'معدل',
    'reason': 'سبب',
    'travel': 'سفر',
    'variety': 'تنوع',
    'video': 'فيديو',
    'week': 'أسبوع',
    'above': 'أعلى',
    'according': 'وفقاً',
    'cook': 'يطبخ',
    'determine': 'تحديد',
    'future': 'مستقبل',
    'site': 'موقع',
    'alternative': 'بديل',
    'demand': 'طلب',
    'ever': 'أبداً',
    'exercise': 'ممارسة الرياضة',
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
        feedback = '${AppLocale.S60.getString(context)}:${wordTranslations[correctWord]}';
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
