import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';



class QuizScreen3 extends StatefulWidget {
  @override
  _QuizScreen3State createState() => _QuizScreen3State();
}

class _QuizScreen3State extends State<QuizScreen3> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الثالثة
    'all': [
      '___ of the students passed the exam.',
      'She wants to know ___ the details.',
      '___ you need to do is ask.',
      '___ the people left early.'
    ],
    'also': [
      'She is kind and ___ very smart.',
      'He ___ likes to read books.',
      'You can ___ try it this way.',
      'I ___ want to visit Paris.'
    ],
    'how': [
      '___ are you today?',
      'Do you know ___ to solve this?',
      '___ did they react?',
      'Tell me ___ it works.'
    ],
    'many': [
      'There are ___ options to choose from.',
      '___ people attended the event.',
      'She has ___ friends.',
      '___ times have you been here?'
    ],
    'do': [
      'What should I ___ now?',
      '___ you like coffee?',
      'Please ___ your best.',
      '___ not forget to call me.'
    ],
    'has': [
      'She ___ a beautiful house.',
      'He ___ two cats.',
      'The book ___ many pages.',
      'The car ___ a powerful engine.'
    ],
    'most': [
      '___ people like chocolate.',
      'She is the ___ talented student in the class.',
      '___ of the work is done.',
      'He spends ___ of his time reading.'
    ],
    'people': [
      'Many ___ enjoy music.',
      '___ from all over the world came.',
      'She loves helping ___ in need.',
      '___ are waiting outside.'
    ],
    'other': [
      'I have no ___ choice.',
      'She went the ___ way.',
      'He met some ___ students.',
      'We should consider the ___ options.'
    ],
    'time': [
      'What ___ is it now?',
      'He spends his free ___ reading.',
      'She will arrive on ___.',
      'There is no ___ to waste.'
    ],
    'so': [
      'She was tired, ___ she went to bed.',
      'It was raining, ___ we stayed inside.',
      'He didn’t study, ___ he failed.',
      'She is busy, ___ I will wait.'
    ],
    'was': [
      'He ___ here yesterday.',
      'She ___ very happy to see you.',
      'The book ___ on the table.',
      'It ___ a wonderful experience.'
    ],
    'we': [
      '___ are going to the park.',
      '___ should help each other.',
      '___ decided to stay.',
      '___ will meet tomorrow.'
    ],
    'these': [
      '___ are my friends.',
      'She bought ___ shoes yesterday.',
      '___ books are interesting.',
      '___ are the results of the test.'
    ],
    'may': [
      'She ___ come tomorrow.',
      'It ___ rain later.',
      'You ___ leave if you want.',
      'He ___ not know the answer.'
    ],
    'like': [
      'I ___ pizza very much.',
      'She dances ___ a professional.',
      'They are ___ brothers.',
      'He is just ___ his father.'
    ],
    'use': [
      'You can ___ my phone.',
      'How do you ___ this tool?',
      'She knows how to ___ a computer.',
      'He wants to ___ the new software.'
    ],
    'into': [
      'She went ___ the room.',
      'He looked ___ her eyes.',
      'The car crashed ___ the wall.',
      'Pour the milk ___ the bowl.'
    ],
    'than': [
      'She is taller ___ her sister.',
      'He runs faster ___ anyone.',
      'This book is better ___ that one.',
      'I have more money ___ you.'
    ],
    'up': [
      'Look ___ at the sky.',
      'She woke ___ early.',
      'Pick ___ the book.',
      'They climbed ___ the hill.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'all': 'الكل',
    'also': 'أيضاً',
    'how': 'كيف',
    'many': 'كثير',
    'do': 'افعل',
    'has': 'لديه',
    'most': 'معظم',
    'people': 'الناس',
    'other': 'آخر',
    'time': 'وقت',
    'so': 'لذلك',
    'was': 'كان',
    'we': 'نحن',
    'these': 'هؤلاء',
    'may': 'قد',
    'like': 'مثل',
    'use': 'يستخدم',
    'into': 'إلى',
    'than': 'من',
    'up': 'أعلى',
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
        feedback = '${AppLocale.S60.getString(context)}: ${wordTranslations[correctWord]} ';
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
                  '${AppLocale.S64.getString(context)} ${questionIndex + 1} من 4 لكلمة "${currentWord}"',
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
