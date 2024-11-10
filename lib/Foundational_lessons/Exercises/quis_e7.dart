import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';


class QuizScreen7 extends StatefulWidget {
  @override
  _QuizScreen7State createState() => _QuizScreen7State();
}

class _QuizScreen7State extends State<QuizScreen7> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة السابعة
    'between': [
      'The book is ___ the two shelves.',
      'She stood ___ her friends.',
      'We need to choose ___ these options.',
      'He walked ___ the two buildings.'
    ],
    'go': [
      'Let’s ___ to the park.',
      'I need to ___ to work.',
      'She wants to ___ abroad.',
      'He said, "___ now!"'
    ],
    'own': [
      'He has his ___ car.',
      'She wants to start her ___ business.',
      'This is my ___ decision.',
      'They have their ___ ideas.'
    ],
    'however': [
      'He is rich; ___, he is unhappy.',
      'She tried her best; ___, she failed.',
      'The weather was bad; ___, we went hiking.',
      'He is busy; ___, he made time for us.'
    ],
    'business': [
      'She started her own ___.',
      'He has a successful ___.',
      'They are partners in ___.',
      'The ___ meeting is tomorrow.'
    ],
    'us': [
      'Come with ___.',
      'They gave ___ a gift.',
      'This is important to ___.',
      'Can you help ___?'
    ],
    'great': [
      'You did a ___ job!',
      'He is a ___ leader.',
      'The view is ___.',
      'She had a ___ idea.'
    ],
    'his': [
      'This is ___ book.',
      'She is ___ sister.',
      'I saw ___ car.',
      'He loves ___ dog.'
    ],
    'being': [
      'She is ___ honest.',
      'He is tired of ___ alone.',
      '___ a teacher is challenging.',
      'They talked about ___ brave.'
    ],
    'another': [
      'Please give me ___ chance.',
      'She has ___ idea.',
      'Let’s try ___ way.',
      'He bought ___ book.'
    ],
    'health': [
      'She is concerned about her ___.',
      '___ is wealth.',
      'He is in good ___.',
      'They discussed mental ___.'
    ],
    'same': [
      'We have the ___ goal.',
      'They live in the ___ city.',
      'He wore the ___ shirt.',
      'It’s the ___ thing every day.'
    ],
    'study': [
      'She needs to ___ for the exam.',
      'He is going to ___ medicine.',
      'We have a ___ session tomorrow.',
      'They plan to ___ together.'
    ],
    'why': [
      'Tell me ___ you did that.',
      'Do you know ___ he left?',
      'I wonder ___ it happened.',
      '___ are you upset?'
    ],
    'few': [
      'There are a ___ people here.',
      'I have a ___ questions.',
      'She brought a ___ friends.',
      'Only a ___ attended the meeting.'
    ],
    'game': [
      'They played a fun ___.',
      'He won the ___.',
      'Do you like this ___?',
      'We have a new ___.'
    ],
    'might': [
      'He ___ come to the party.',
      'She ___ know the answer.',
      'They ___ visit us.',
      'We ___ need help.'
    ],
    'think': [
      'What do you ___?',
      'I ___ she is right.',
      'He likes to ___ about the future.',
      'They ___ it is a good idea.'
    ],
    'free': [
      'She has some ___ time.',
      'They gave it to us for ___.',
      'He is ___ to choose.',
      'The park is open and ___.'
    ],
    'too': [
      'It’s ___ hot outside.',
      'He is ___ tired to continue.',
      'She talks ___ much.',
      'They arrived ___ late.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'between': 'بين',
    'go': 'اذهب',
    'own': 'خاص',
    'however': 'ومع ذلك',
    'business': 'عمل',
    'us': 'لنا',
    'great': 'عظيم',
    'his': 'له',
    'being': 'يجري',
    'another': 'آخر',
    'health': 'صحة',
    'same': 'نفس',
    'study': 'دراسة',
    'why': 'لماذا',
    'few': 'قليل',
    'game': 'لعبة',
    'might': 'ربما',
    'think': 'يفكر',
    'free': 'حر',
    'too': 'جداً',
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
