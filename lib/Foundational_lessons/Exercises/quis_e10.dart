import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';


class QuizScreen10 extends StatefulWidget {
  @override
  _QuizScreen10State createState() => _QuizScreen10State();
}

class _QuizScreen10State extends State<QuizScreen10> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة العاشرة
    'human': [
      'He is a ___.',
      'She studied ___ anatomy.',
      'They discussed ___ rights.',
      'This is a ___ error.'
    ],
    'both': [
      '___ of them went to the market.',
      'I like ___ coffee and tea.',
      'She can play ___ the guitar and the piano.',
      'They are ___ very talented.'
    ],
    'local': [
      'He likes ___ food.',
      'The ___ newspaper reported the news.',
      'She is a ___ artist.',
      'We went to a ___ market.'
    ],
    'sure': [
      'Are you ___ about that?',
      'She was ___ of her answer.',
      'He is not ___ what to do.',
      'I am ___ this is the right way.'
    ],
    'something': [
      'She wants to tell you ___.',
      'There is ___ in the box.',
      'I heard ___ strange.',
      'Do you need ___?'
    ],
    'without': [
      'He left ___ saying goodbye.',
      'She can’t live ___ music.',
      'They went out ___ an umbrella.',
      'I did it ___ any help.'
    ],
    'come': [
      'He will ___ to the party.',
      'She asked him to ___.',
      'They ___ home late.',
      'Can you ___ over here?'
    ],
    'me': [
      'He gave ___ a book.',
      'They are looking for ___.',
      'She told ___ a secret.',
      'Please help ___.'
    ],
    'back': [
      'She turned ___.',
      'They went ___ to the house.',
      'He looked ___ at the street.',
      'The dog is at the ___ door.'
    ],
    'better': [
      'This is ___ than before.',
      'She is getting ___.',
      'He felt ___ after resting.',
      'They deserve a ___ chance.'
    ],
    'general': [
      'He spoke in ___ terms.',
      'The ___ opinion is positive.',
      'This is a ___ rule.',
      'She has a ___ understanding of the topic.'
    ],
    'process': [
      'Learning is a ___.',
      'She is in the ___ of moving.',
      'The ___ took a long time.',
      'They need to ___ the data.'
    ],
    'she': [
      '___ is a good friend.',
      '___ likes to read.',
      'I saw ___ yesterday.',
      '___ has a lot to say.'
    ],
    'heat': [
      'The ___ was intense.',
      'They couldn’t bear the ___.',
      'He turned on the ___.',
      'The ___ of the sun was strong.'
    ],
    'thanks': [
      '___ for your help!',
      'She said, "___ for coming!"',
      'He gave her a small gift to say ___.',
      'They sent a card with their ___.'
    ],
    'specific': [
      'Can you be more ___?',
      'She needs a ___ answer.',
      'He asked for a ___ time.',
      'This is a ___ case.'
    ],
    'enough': [
      'There is ___ food for everyone.',
      'She has ___ money to buy it.',
      'They didn’t get ___ sleep.',
      'He is strong ___.'
    ],
    'long': [
      'It was a ___ journey.',
      'She has ___ hair.',
      'They waited for a ___ time.',
      'The ___ road stretched ahead.'
    ],
    'lot': [
      'He bought a ___ of land.',
      'She has a ___ of books.',
      'There is a parking ___ nearby.',
      'They own a big ___.'
    ],
    'hand': [
      'She held his ___.',
      'He raised his ___.',
      'Give me a ___ with this.',
      'Her ___ was cold.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'human': 'بشري',
    'both': 'كلا',
    'local': 'محلي',
    'sure': 'بالتأكيد',
    'something': 'شيء ما',
    'without': 'بدون',
    'come': 'يأتي',
    'me': 'أنا',
    'back': 'خلف',
    'better': 'أفضل',
    'general': 'عام',
    'process': 'معالجة',
    'she': 'هي',
    'heat': 'حرارة',
    'thanks': 'شكراً',
    'specific': 'محدد',
    'enough': 'كافٍ',
    'long': 'طويل',
    'lot': 'قطعة أرض',
    'hand': 'يد',
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
