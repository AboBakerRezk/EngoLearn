import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';


class QuizScreen11 extends StatefulWidget {
  @override
  _QuizScreen11State createState() => _QuizScreen11State();
}

class _QuizScreen11State extends State<QuizScreen11> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الحادية عشرة
    'popular': [
      'She is a very ___ singer.',
      'This park is ___ among locals.',
      'The book became ___.',
      'They are ___ in their town.'
    ],
    'small': [
      'He lives in a ___ house.',
      'There is a ___ cat in the garden.',
      'She has a ___ family.',
      'We bought a ___ gift.'
    ],
    'though': [
      'He went out, ___ it was raining.',
      'She smiled, ___ she was tired.',
      'They stayed late, ___ they were busy.',
      '___ he was sick, he went to work.'
    ],
    'experience': [
      'She has a lot of work ___.',
      'This is a great learning ___.',
      'He shared his travel ___.',
      'They had an unforgettable ___.'
    ],
    'include': [
      'The package ___ breakfast.',
      'He decided to ___ everyone in the event.',
      'The list ___ all necessary items.',
      'We should ___ this topic in our discussion.'
    ],
    'job': [
      'She got a new ___.',
      'He loves his ___.',
      'They are looking for a ___.',
      'I need to find a better ___.'
    ],
    'music': [
      'She listens to ___ every day.',
      'He plays ___ in a band.',
      'The ___ was very relaxing.',
      'They enjoy classical ___.'
    ],
    'person': [
      'He is a kind ___.',
      'She met a new ___ at work.',
      'They saw a strange ___ in the park.',
      'A ___ came to the door.'
    ],
    'really': [
      'I ___ like this movie.',
      'She is ___ good at her job.',
      'He was ___ happy with the gift.',
      'They are ___ excited about the trip.'
    ],
    'although': [
      '___ it was late, they continued working.',
      'She was tired, ___ she kept running.',
      'He smiled, ___ he was angry.',
      '___ he tried hard, he couldn’t solve it.'
    ],
    'thank': [
      'I want to ___ you for your help.',
      'She said, "___ you!"',
      'They always ___ their supporters.',
      'He wrote a letter to ___ her.'
    ],
    'book': [
      'She is reading a ___.',
      'He bought a new ___.',
      'The ___ was very interesting.',
      'They published a new ___.'
    ],
    'early': [
      'He wakes up ___.',
      'She arrived ___.',
      'They finished the project ___.',
      'It is too ___ to tell.'
    ],
    'reading': [
      'She enjoys ___.',
      'He spends his time ___.',
      'They were caught up in their ___.',
      'We are ___ a new novel.'
    ],
    'end': [
      'The movie had a happy ___.',
      'He reached the ___ of the road.',
      'She decided to ___ the meeting.',
      'They are working to ___ the project.'
    ],
    'method': [
      'This is a new teaching ___.',
      'She uses a different ___.',
      'They are testing a new ___.',
      'He explained his ___.'
    ],
    'never': [
      'She has ___ been to Paris.',
      'He ___ gives up.',
      'They ___ forget a kindness.',
      'I have ___ seen anything like it.'
    ],
    'less': [
      'He wants to eat ___.',
      'She spends ___ money now.',
      'They have ___ time than before.',
      'This costs ___ than the other one.'
    ],
    'play': [
      'He likes to ___ football.',
      'She learned to ___ the piano.',
      'They want to ___ outside.',
      'We will ___ a game tonight.'
    ],
    'able': [
      'She is ___ to speak three languages.',
      'He was ___ to solve the problem.',
      'They are ___ to help us.',
      'I am ___ to finish my work early.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'popular': 'شعبي',
    'small': 'صغير',
    'though': 'مع ذلك',
    'experience': 'تجربة',
    'include': 'تضمن',
    'job': 'وظيفة',
    'music': 'موسيقى',
    'person': 'شخص',
    'really': 'حقاً',
    'although': 'مع ذلك',
    'thank': 'شكر',
    'book': 'كتاب',
    'early': 'مبكر',
    'reading': 'القراءة',
    'end': 'نهاية',
    'method': 'طريقة',
    'never': 'أبداً',
    'less': 'أقل',
    'play': 'لعب',
    'able': 'قادر',
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
