import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';


class QuizScreen12 extends StatefulWidget {
  @override
  _QuizScreen12State createState() => _QuizScreen12State();
}

class _QuizScreen12State extends State<QuizScreen12> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الثانية عشرة
    'data': [
      'She collected a lot of ___.',
      'The ___ shows different trends.',
      'He analyzed the ___.',
      'They need more ___ for the report.'
    ],
    'feel': [
      'I ___ happy today.',
      'She ___ tired after the trip.',
      'They ___ excited about the news.',
      'He ___ the cold air on his face.'
    ],
    'high': [
      'The mountain is very ___.',
      'He jumped ___.',
      'They reached a ___ level of success.',
      'The prices are too ___.'
    ],
    'off': [
      'Please turn the lights ___.',
      'He took the day ___.',
      'The show was called ___.',
      'She turned the alarm ___.'
    ],
    'point': [
      'He made a good ___.',
      'She showed him the ___ on the map.',
      'They reached the turning ___.',
      'This is the critical ___.'
    ],
    'type': [
      'What ___ of music do you like?',
      'She has a different ___ of car.',
      'This ___ of bird is rare.',
      'He likes this ___ of coffee.'
    ],
    'whether': [
      'I don’t know ___ to go or stay.',
      'She asked him ___ he wanted tea or coffee.',
      'They will decide ___ to join the club.',
      'He is unsure ___ it will rain.'
    ],
    'food': [
      'She likes Italian ___.',
      'They ordered a lot of ___.',
      'He prefers healthy ___.',
      'The ___ was delicious.'
    ],
    'understanding': [
      'He has a deep ___ of the subject.',
      'She showed great ___ of the situation.',
      'They reached an ___ quickly.',
      'Your ___ is important to us.'
    ],
    'here': [
      'Come ___.',
      'She lives ___.',
      'The meeting will be held ___.',
      'Please sit ___.'
    ],
    'home': [
      'She wants to go ___.',
      'He stayed at ___.',
      'They built a new ___.',
      '___ is where the heart is.'
    ],
    'certain': [
      'I am ___ about my decision.',
      'She is not ___ of the results.',
      'He is ___ that he locked the door.',
      'They are ___ of their success.'
    ],
    'economy': [
      'The ___ is growing.',
      'She studied ___.',
      'He is interested in the ___.',
      'The global ___ is changing.'
    ],
    'little': [
      'He has very ___ time.',
      'She gave him a ___ bit of advice.',
      'There is ___ water left.',
      'They moved a ___ closer.'
    ],
    'theory': [
      'He proposed a new ___.',
      'She is studying the ___ of relativity.',
      'They discussed the ___ in class.',
      'His ___ was proven right.'
    ],
    'tonight': [
      'We are going out ___.',
      'She has a meeting ___.',
      'They will watch a movie ___.',
      'He is staying late ___.'
    ],
    'law': [
      'He is studying ___.',
      'She practices ___.',
      'They have to obey the ___.',
      'The ___ was passed recently.'
    ],
    'put': [
      'He ___ the book on the table.',
      'She ___ the groceries away.',
      'They ___ their trust in him.',
      'Please ___ your hand up.'
    ],
    'under': [
      'The cat is hiding ___ the bed.',
      'He put the paper ___ the book.',
      'They went ___ the bridge.',
      'The boat sailed ___ the water.'
    ],
    'value': [
      'He knows the ___ of hard work.',
      'The ___ of the house has increased.',
      'She teaches the ___ of honesty.',
      'They appreciate the ___ of time.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'data': 'بيانات',
    'feel': 'يشعر',
    'high': 'مرتفع',
    'off': 'إيقاف',
    'point': 'نقطة',
    'type': 'نوع',
    'whether': 'سواء',
    'food': 'طعام',
    'understanding': 'فهم',
    'here': 'هنا',
    'home': 'الصفحة الرئيسية',
    'certain': 'مؤكد',
    'economy': 'اقتصاد',
    'little': 'قليل',
    'theory': 'نظرية',
    'tonight': 'هذه الليلة',
    'law': 'قانون',
    'put': 'وضع',
    'under': 'تحت',
    'value': 'قيمة',
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
