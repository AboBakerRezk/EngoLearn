import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final Map<String, List<String>> sentenceTemplates = {
    'the': [
      'She went to ___ store to buy some groceries.',
      '___ cat is sitting on the wall.',
      'I saw ___ best movie yesterday.',
      '___ sky is very clear today.'
    ],
    'of': [
      'It is a part ___ the plan.',
      'The color ___ the car is red.',
      'The city ___ dreams.',
      'A piece ___ cake.'
    ],
    'and': [
      'He likes tea ___ coffee.',
      'Cats ___ dogs are common pets.',
      'You ___ I are friends.',
      'Bread ___ butter is a classic combination.'
    ],
    'to': [
      'She is going ___ the market.',
      'I need ___ finish my work.',
      'We will travel ___ Paris.',
      'He decided ___ go home.'
    ],
    'a': [
      'He has ___ car.',
      'I want ___ apple.',
      'She saw ___ bird.',
      'It is ___ sunny day.'
    ],
    'in': [
      'There is a cat ___ the house.',
      'We are ___ the garden.',
      'He lives ___ New York.',
      'Water is stored ___ the tank.'
    ],
    'is': [
      'She ___ very happy today.',
      'This ___ a great idea.',
      'He ___ my best friend.',
      'The answer ___ correct.'
    ],
    'you': [
      '___ are invited to the party.',
      'Do ___ like coffee?',
      'Are ___ coming with us?',
      '___ should try this.'
    ],
    'are': [
      'They ___ going to the park.',
      'You ___ very kind.',
      'We ___ learning Flutter.',
      'Cats ___ cute animals.'
    ],
    'for': [
      'This gift is ___ you.',
      'A tool ___ cooking.',
      'Waiting ___ a friend.',
      'The medicine is ___ headache.'
    ],
    'that': [
      'I believe ___ she can do it.',
      'It is important ___ you come.',
      'He knows ___ it is true.',
      'She said ___ she loves you.'
    ],
    'or': [
      'Would you like tea ___ coffee?',
      'Is it black ___ white?',
      'You can choose this ___ that.',
      'Either you do it ___ I will.'
    ],
    'as': [
      'He is ___ a father to me.',
      'She dances ___ a professional.',
      'Run ___ the wind.',
      'He acts ___ he knows everything.'
    ],
    'be': [
      'You should ___ careful.',
      'Let it ___ known.',
      'He wants to ___ a doctor.',
      'Will you ___ there?'
    ],
    'on': [
      'The book is ___ the table.',
      'She sits ___ the chair.',
      'A picture hangs ___ the wall.',
      'He walks ___ the road.'
    ],
    'your': [
      'Is this ___ phone?',
      'The book is ___ yours.',
      'A gift ___ you.',
      'This is ___ responsibility.'
    ],
    'with': [
      'She went to the party ___ her friends.',
      'I live ___ my parents.',
      'He talks ___ a soft voice.',
      'We are ___ you.'
    ],
    'can': [
      'He ___ speak three languages.',
      'She ___ swim very fast.',
      'They ___ do it by themselves.',
      'You ___ try again.'
    ],
    'have': [
      'They ___ a new house.',
      'You ___ everything you need.',
      'We ___ a lot of work to do.',
      'She ___ many friends.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'the': 'ال',
    'of': 'من',
    'and': 'و',
    'to': 'إلى',
    'a': 'أ',
    'in': 'في',
    'is': 'هو',
    'you': 'أنت',
    'are': 'تكون',
    'for': 'لـ',
    'that': 'أن',
    'or': 'أو',
    'as': 'مثل',
    'be': 'يكون',
    'on': 'على',
    'your': 'لك',
    'with': 'مع',
    'can': 'يستطيع',
    'have': 'لديك',
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
        feedback = '${AppLocale.S60.getString(context)} ${wordTranslations[correctWord]}';
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
                  '${AppLocale.S64.getString(context)} ${questionIndex + 1}  ',
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
