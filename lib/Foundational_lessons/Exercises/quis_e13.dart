import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';

class QuizScreen13 extends StatefulWidget {
  @override
  _QuizScreen13State createState() => _QuizScreen13State();
}

class _QuizScreen13State extends State<QuizScreen13> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الثالثة عشرة
    'always': [
      'She ___ wakes up early.',
      'He is ___ late to work.',
      'They ___ have breakfast together.',
      'I ___ enjoy reading.'
    ],
    'body': [
      'She takes care of her ___.',
      'The human ___ is complex.',
      'He has a strong ___.',
      'They found a ___ in the water.'
    ],
    'common': [
      'This is a ___ mistake.',
      'They have a ___ interest.',
      'It is ___ to see them together.',
      'This word is very ___.'
    ],
    'market': [
      'She went to the ___.',
      'The ___ is crowded today.',
      'He works at the ___.',
      'They sell fresh vegetables in the ___.'
    ],
    'set': [
      'Please ___ the table.',
      'She ___ down on the chair.',
      'He ___ a goal for the team.',
      'They ___ out on their journey.'
    ],
    'bird': [
      'The ___ is singing.',
      'She saw a colorful ___.',
      'They watched the ___ fly.',
      'He found a ___ in the garden.'
    ],
    'guide': [
      'He works as a tour ___.',
      'She will ___ them through the city.',
      'They need a ___ for the trip.',
      'He gave them a ___ to the museum.'
    ],
    'provide': [
      'She will ___ food for the guests.',
      'They ___ shelter for the homeless.',
      'He can ___ a good service.',
      'We ___ support for our customers.'
    ],
    'change': [
      'He decided to ___ his career.',
      'She wants to ___ her hairstyle.',
      'They made a significant ___.',
      'We need to ___ the plan.'
    ],
    'interest': [
      'He has a great ___ in music.',
      'She shows ___ in history.',
      'They have a shared ___.',
      'This is a topic of ___ for many.'
    ],
    'literature': [
      'She studies ___.',
      'He loves reading classical ___.',
      'They are discussing modern ___.',
      'This course focuses on ___.'
    ],
    'sometimes': [
      'She ___ feels lonely.',
      'He ___ forgets to call.',
      'They ___ go for a walk.',
      'I ___ like to watch movies.'
    ],
    'problem': [
      'She solved the ___.',
      'He has a big ___.',
      'They are working on a ___.',
      'This is a difficult ___.'
    ],
    'say': [
      'She didn’t ___ anything.',
      'He wanted to ___ something.',
      'They will ___ their opinion.',
      'I heard him ___ hello.'
    ],
    'next': [
      'He will visit her ___ week.',
      'She is the ___ speaker.',
      'They are planning their ___ trip.',
      'The ___ step is important.'
    ],
    'create': [
      'She loves to ___ art.',
      'He will ___ a new design.',
      'They plan to ___ a website.',
      'I want to ___ something new.'
    ],
    'simple': [
      'She prefers a ___ life.',
      'He gave a ___ explanation.',
      'They made a ___ plan.',
      'The solution was ___.'
    ],
    'software': [
      'He develops ___.',
      'She is an expert in ___.',
      'They installed new ___.',
      'This ___ is easy to use.'
    ],
    'state': [
      'She is in a happy ___.',
      'He will visit another ___.',
      'They are in a good ___.',
      'The ___ of the house is excellent.'
    ],
    'together': [
      'They worked ___.',
      'She likes spending time ___.',
      'We will solve this ___.',
      'He brought them ___.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'always': 'دائماً',
    'body': 'جسم',
    'common': 'شائع',
    'market': 'سوق',
    'set': 'جلس',
    'bird': 'طائر',
    'guide': 'مرشد',
    'provide': 'تزود',
    'change': 'تغيير',
    'interest': 'فائدة',
    'literature': 'أدب',
    'sometimes': 'أحياناً',
    'problem': 'مشكلة',
    'say': 'يقول',
    'next': 'التالي',
    'create': 'ينشئ',
    'simple': 'بسيط',
    'software': 'برمجيات',
    'state': 'حالة',
    'together': 'سوياً',
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
