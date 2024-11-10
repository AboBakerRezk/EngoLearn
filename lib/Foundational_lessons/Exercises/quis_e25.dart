import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';



class QuizScreen25 extends StatefulWidget {
  @override
  _QuizScreen25State createState() => _QuizScreen25State();
}

class _QuizScreen25State extends State<QuizScreen25> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الخامسة والعشرين
    'live': [
      'They ___ in a small village.',
      'She wants to ___ in peace.',
      'He ___ close to his family.',
      'Where do you ___ now?'
    ],
    'nothing': [
      'There is ___ left in the fridge.',
      'He said ___ about the plans.',
      'She found ___ to worry about.',
      'Is there ___ you need help with?'
    ],
    'period': [
      'The project will last for a ___ of six months.',
      'She took a ___ from work.',
      'They discussed the ___ of the event.',
      'Can you tell me the ___ for the course?'
    ],
    'physics': [
      'He is studying ___ at university.',
      '___ is a branch of science.',
      'She needs help with her ___ homework.',
      'Do you understand the basics of __?'
    ],
    'plan': [
      'They made a ___ for their vacation.',
      'She needs to ___ her work schedule.',
      'He has a ___ to start a business.',
      'What is your ___ for the weekend?'
    ],
    'store': [
      'They went to the ___ to buy groceries.',
      'The ___ has a sale this week.',
      'He visited the ___ to buy a gift.',
      'What time does the ___ open?'
    ],
    'tax': [
      'They need to pay their annual ___.',
      'The ___ rate has increased this year.',
      'She is preparing her ___ return.',
      'Do you understand the ___ laws?'
    ],
    'analysis': [
      'The report includes a detailed ___.',
      'She is working on data ___.',
      'They conducted an ___ of the survey.',
      'What is your ___ of the results?'
    ],
    'cold': [
      'The weather is very ___.',
      'He caught a ___ from the rain.',
      'She prefers ___ drinks in summer.',
      'Is it ___ outside today?'
    ],
    'commercial': [
      'The company launched a new ___.',
      'They are making a ___ advertisement.',
      'She works in the ___ sector.',
      'What is the ___ of the product?'
    ],
    'directly': [
      'He spoke to the manager ___.',
      'She responded ___ to the email.',
      'They arrived ___ at the venue.',
      'Can you talk to me ___?'
    ],
    'full': [
      'The glass is ___ of water.',
      'The room is ___ of furniture.',
      'He felt ___ after eating.',
      'Is the tank ___ of gas?'
    ],
    'involved': [
      'He is ___ in the project.',
      'She became ___ in the community.',
      'They are ___ in the new initiative.',
      'Are you ___ in any activities?'
    ],
    'itself': [
      'The machine operates by ___.',
      'The book is about the history of ___.',
      'She made the decision ___.',
      'The problem solved ___ over time.'
    ],
    'low': [
      'The temperature is very ___.',
      'He kept his voice ___.',
      'The stock prices are ___.',
      'Is the battery ___?'
    ],
    'old': [
      'He wore an ___ watch.',
      'The house is very ___.',
      'She prefers ___ movies.',
      'How ___ is this book?'
    ],
    'policy': [
      'The company has a strict ___ on attendance.',
      'She read the new ___ carefully.',
      'They changed their ___ on refunds.',
      'What is the ___ regarding customer service?'
    ],
    'political': [
      'The debate was about ___ issues.',
      'She follows ___ news closely.',
      'They discussed ___ strategies.',
      'What are the main ___ parties?'
    ],
    'purchase': [
      'They made a ___ online.',
      'She wants to ___ a new car.',
      'The ___ process was easy.',
      'Did you ___ the tickets yet?'
    ],
    'series': [
      'They watched a TV ___.',
      'He is reading a book ___.',
      'She collects a ___ of stamps.',
      'What is your favorite ___?'
    ],
  };

  final Map<String, String> wordTranslations = {
    'live': 'يعيش',
    'nothing': 'لا شيء',
    'period': 'فترة',
    'physics': 'فيزياء',
    'plan': 'خطة',
    'store': 'متجر',
    'tax': 'ضريبة',
    'analysis': 'تحليل',
    'cold': 'بارد',
    'commercial': 'تجاري',
    'directly': 'مباشرة',
    'full': 'ممتلئ',
    'involved': 'متورط',
    'itself': 'ذاته',
    'low': 'منخفض',
    'old': 'قديم',
    'policy': 'سياسة',
    'political': 'سياسي',
    'purchase': 'شراء',
    'series': 'سلسلة',
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
                        ),
                      ),
                      onPressed: () {
                        checkAnswer(options[index]);
                      },
                      child: Text(
                        options[index],
                        style: TextStyle(fontSize: 18),
                      ),
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
