import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';


class QuizScreen19 extends StatefulWidget {
  @override
  _QuizScreen19State createState() => _QuizScreen19State();
}

class _QuizScreen19State extends State<QuizScreen19> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة التاسعة عشرة
    'last': [
      'This is the ___ day of the year.',
      'She finished the race in ___.',
      'He is the ___ person to arrive.',
      'They enjoyed their ___ meal.'
    ],
    'media': [
      'She works in the ___ industry.',
      'He followed the news on social ___.',
      'They covered the event on national ___.',
      'The ___ reported the incident.'
    ],
    'mental': [
      'She takes care of her ___ health.',
      'He has a strong ___ capacity.',
      'They faced many ___ challenges.',
      'It requires a lot of ___ effort.'
    ],
    'move': [
      'She decided to ___ to a new city.',
      'He needs to ___ the table.',
      'They ___ forward with the plan.',
      'Let’s ___ to the next point.'
    ],
    'pay': [
      'She needs to ___ the bills.',
      'He forgot to ___ for the coffee.',
      'They will ___ their respects.',
      'Please ___ attention to the rules.'
    ],
    'sport': [
      'She loves to play ___.',
      'He watches ___ on TV.',
      'They practice their favorite ___.',
      'The ___ team won the match.'
    ],
    'thing': [
      'She couldn’t remember a single ___.',
      'He has everything except one ___.',
      'They found an interesting ___.',
      'This is the best ___ ever.'
    ],
    'actually': [
      'She is ___ very nice.',
      'He is ___ coming to the party.',
      'They were ___ surprised by the results.',
      'It was ___ a good idea.'
    ],
    'against': [
      'She is ___ the proposal.',
      'He stood ___ the wall.',
      'They competed ___ each other.',
      'It is ___ the rules.'
    ],
    'far': [
      'She traveled ___ to see him.',
      'He is ___ away from here.',
      'They walked ___ down the road.',
      'It is too ___ to reach by foot.'
    ],
    'fun': [
      'She had a lot of ___ at the park.',
      'He thinks it is not just work but also ___.',
      'They made the event very ___.',
      'The game was pure ___.'
    ],
    'house': [
      'She moved into a new ___.',
      'He painted the ___.',
      'They bought a big ___.',
      'The ___ is near the lake.'
    ],
    'let': [
      'She decided to ___ him go.',
      'He will ___ her know soon.',
      'They cannot ___ this happen.',
      'Please ___ me help you.'
    ],
    'page': [
      'She wrote a new ___ in her diary.',
      'He turned the ___.',
      'They read the first ___.',
      'The ___ is missing from the book.'
    ],
    'remember': [
      'She couldn’t ___ his name.',
      'He will always ___ this day.',
      'They asked her to ___ the details.',
      'Please ___ to call him.'
    ],
    'term': [
      'She defined the ___ clearly.',
      'He understood the ___ used in the text.',
      'They agreed to the new ___.',
      'It is a common ___.'
    ],
    'test': [
      'She studied hard for the ___.',
      'He failed the driving ___.',
      'They are preparing for a big ___.',
      'The ___ results were positive.'
    ],
    'within': [
      'She finished the task ___ an hour.',
      'He lives ___ the city.',
      'They must complete it ___ the deadline.',
      'It is ___ walking distance.'
    ],
    'along': [
      'She walked ___ the river.',
      'He came ___ with his friends.',
      'They sat ___ the edge.',
      'The road runs ___ the coast.'
    ],
    'answer': [
      'She knew the correct ___.',
      'He needs to find the ___.',
      'They are waiting for your ___.',
      'Please provide an ___.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'last': 'الأخير',
    'media': 'وسائل الإعلام',
    'mental': 'عقلي',
    'move': 'تحرك',
    'pay': 'يدفع',
    'sport': 'رياضة',
    'thing': 'شيء',
    'actually': 'فعلياً',
    'against': 'ضد',
    'far': 'بعيد',
    'fun': 'مرح',
    'house': 'منزل',
    'let': 'دع',
    'page': 'صفحة',
    'remember': 'تذكر',
    'term': 'مصطلح',
    'test': 'اختبار',
    'within': 'داخل',
    'along': 'على طول',
    'answer': 'إجابة',
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
