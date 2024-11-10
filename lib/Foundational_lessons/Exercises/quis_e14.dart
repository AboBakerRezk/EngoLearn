import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';

class QuizScreen14 extends StatefulWidget {
  @override
  _QuizScreen14State createState() => _QuizScreen14State();
}

class _QuizScreen14State extends State<QuizScreen14> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الرابعة عشرة
    'control': [
      'She tried to ___ the situation.',
      'He lost ___ of the car.',
      'They need better ___ over the process.',
      'We have to ___ our emotions.'
    ],
    'knowledge': [
      'He has a deep ___ of the subject.',
      'Her ___ in physics is impressive.',
      'They shared their ___ with us.',
      'The ___ of history is vast.'
    ],
    'power': [
      'He has the ___ to change things.',
      'The engine has a lot of ___.',
      'They seek political ___.',
      'She used her ___ to help others.'
    ],
    'radio': [
      'She listened to the ___.',
      'He works at a ___.',
      'They broadcast the news on ___.',
      'The ___ was very loud.'
    ],
    'ability': [
      'She has the ___ to sing well.',
      'He showed great ___ in mathematics.',
      'They admire his ___ to learn.',
      'Your ___ to adapt is impressive.'
    ],
    'basic': [
      'They need some ___ supplies.',
      'She taught them the ___ steps.',
      'He has a ___ understanding of the topic.',
      'We covered the ___ concepts.'
    ],
    'course': [
      'She is taking a new ___.',
      'He teaches an online ___.',
      'They completed the ___.',
      'This ___ is very popular.'
    ],
    'economics': [
      'He is studying ___.',
      'She read a book on ___.',
      'They discussed global ___.',
      'The professor teaches ___.'
    ],
    'hard': [
      'The task is very ___.',
      'He works ___.',
      'They faced a ___ decision.',
      'Life can be ___.'
    ],
    'add': [
      'She wants to ___ more details.',
      'He will ___ another item to the list.',
      'They decided to ___ a new member.',
      'Let’s ___ some colors to the design.'
    ],
    'company': [
      'He started a new ___.',
      'She works at a tech ___.',
      'They own a big ___.',
      'The ___ is hiring new employees.'
    ],
    'known': [
      'He is well ___ for his generosity.',
      'She is a ___ artist.',
      'They are ___ to everyone.',
      'This place is ___ for its beauty.'
    ],
    'love': [
      'She is in ___ with him.',
      'He has a deep ___ for music.',
      'They ___ their family.',
      'We ___ to travel.'
    ],
    'past': [
      'She wants to forget the ___.',
      'He learned from his ___.',
      'They talk about the ___ often.',
      'Let’s not dwell in the ___.'
    ],
    'price': [
      'The ___ of gold is high.',
      'She asked about the ___.',
      'They negotiated the ___.',
      'He paid a heavy ___.'
    ],
    'size': [
      'She bought a medium ___.',
      'The ___ of the house is perfect.',
      'He increased the font ___.',
      'They were amazed by the ___ of the ship.'
    ],
    'away': [
      'She moved ___.',
      'He threw the ball ___.',
      'They walked ___.',
      'The solution is just a few steps ___.'
    ],
    'big': [
      'He has a ___ dream.',
      'The house is very ___.',
      'She made a ___ decision.',
      'They live in a ___ city.'
    ],
    'internet': [
      'She uses the ___ for research.',
      'They met on the ___.',
      'He works as an ___ developer.',
      'The ___ was down for hours.'
    ],
    'possible': [
      'It is ___ to achieve success.',
      'She made the ___ effort.',
      'They explored all ___ options.',
      'Nothing is ___.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'control': 'مراقبة',
    'knowledge': 'معرفة',
    'power': 'قوة',
    'radio': 'راديو',
    'ability': 'قدرة',
    'basic': 'أساسي',
    'course': 'دورة',
    'economics': 'اقتصاديات',
    'hard': 'صعب',
    'add': 'إضافة',
    'company': 'شركة',
    'known': 'معروف',
    'love': 'حب',
    'past': 'الماضي',
    'price': 'سعر',
    'size': 'حجم',
    'away': 'بعيد',
    'big': 'كبير',
    'internet': 'إنترنت',
    'possible': 'ممكن',
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
