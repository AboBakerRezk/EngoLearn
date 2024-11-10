import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';


class QuizScreen16 extends StatefulWidget {
  @override
  _QuizScreen16State createState() => _QuizScreen16State();
}

class _QuizScreen16State extends State<QuizScreen16> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة السادسة عشرة
    'line': [
      'Please draw a straight ___.',
      'She waited in ___.',
      'The ___ is too long.',
      'He crossed the finish ___.'
    ],
    'product': [
      'This is a new ___.',
      'They launched a new ___.',
      'She tested the ___.',
      'The ___ is available in stores.'
    ],
    'care': [
      'She takes good ___ of her pet.',
      'He needs medical ___.',
      'They ___ for the garden daily.',
      'We should ___ for the elderly.'
    ],
    'group': [
      'She joined a sports ___.',
      'They formed a study ___.',
      'He leads the project ___.',
      'The ___ of people was large.'
    ],
    'idea': [
      'She had a brilliant ___.',
      'His ___ was accepted by everyone.',
      'They discussed a new ___.',
      'It was a creative ___.'
    ],
    'risk': [
      'There is a high ___ of failure.',
      'She took a big ___.',
      'They evaluated the ___.',
      'It is a ___ worth taking.'
    ],
    'several': [
      'She has ___ friends.',
      'They visited ___ places.',
      'He gave ___ examples.',
      '___ people attended the event.'
    ],
    'someone': [
      'She is waiting for ___.',
      '___ knocked on the door.',
      'He needs to talk to ___.',
      'They found ___.'
    ],
    'temperature': [
      'The ___ is very high today.',
      'She checked the ___.',
      'They monitor the ___ regularly.',
      'He feels the change in ___.'
    ],
    'united': [
      'They stand ___.',
      'He supports the ___ team.',
      'We should remain ___.',
      'The countries are ___.'
    ],
    'word': [
      'She learned a new ___.',
      'He couldn’t find the right ___.',
      'They wrote down every ___.',
      'The ___ was difficult to pronounce.'
    ],
    'fat': [
      'This food is low in ___.',
      'She avoided ___ foods.',
      'He has a little extra ___.',
      'They measured the body ___.'
    ],
    'force': [
      'He applied great ___.',
      'She joined the police ___.',
      'They used ___ to open the door.',
      'It is a powerful ___.'
    ],
    'key': [
      'She lost her ___.',
      'He found the hidden ___.',
      'They need the ___ to unlock the door.',
      'The ___ to success is hard work.'
    ],
    'light': [
      'She turned on the ___.',
      'He saw a bright ___.',
      'The ___ was flickering.',
      'They need more ___.'
    ],
    'simply': [
      'She ___ explained the rules.',
      'He ___ could not do it.',
      'They ___ refused to leave.',
      'It was ___ amazing.'
    ],
    'today': [
      'She has a meeting ___.',
      'He is not feeling well ___.',
      '___ is a sunny day.',
      'We will finish it ___.'
    ],
    'training': [
      'She attended the ___.',
      'He is undergoing intensive ___.',
      'They provide ___ for new employees.',
      'It was a ___ session.'
    ],
    'until': [
      'She waited ___ he arrived.',
      'He worked ___ midnight.',
      'They will stay ___ tomorrow.',
      'Don’t leave ___ you finish.'
    ],
    'major': [
      'He is a ___ in the army.',
      'She has a ___ role in the project.',
      'They faced a ___ challenge.',
      'It is a ___ decision.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'line': 'خط',
    'product': 'منتج',
    'care': 'رعاية',
    'group': 'مجموعة',
    'idea': 'فكرة',
    'risk': 'خطر',
    'several': 'عدة',
    'someone': 'شخص ما',
    'temperature': 'درجة الحرارة',
    'united': 'متحد',
    'word': 'كلمة',
    'fat': 'دهون',
    'force': 'قوة',
    'key': 'مفتاح',
    'light': 'ضوء',
    'simply': 'ببساطة',
    'today': 'اليوم',
    'training': 'تدريب',
    'until': 'حتى',
    'major': 'رائد',
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
