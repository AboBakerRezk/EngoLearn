import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';



class QuizScreen15 extends StatefulWidget {
  @override
  _QuizScreen15State createState() => _QuizScreen15State();
}

class _QuizScreen15State extends State<QuizScreen15> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الخامسة عشرة
    'television': [
      'She is watching ___.',
      'They turned on the ___.',
      'He works for a ___ station.',
      'The ___ is broken.'
    ],
    'three': [
      'I have ___ apples.',
      'She bought ___ books.',
      'They have ___ children.',
      'We need ___ more chairs.'
    ],
    'understand': [
      'I ___ the problem now.',
      'She couldn’t ___ the question.',
      'He tried to ___ her feelings.',
      'They finally ___ the instructions.'
    ],
    'various': [
      'She has ___ interests.',
      'There are ___ options available.',
      'They studied ___ subjects.',
      'He likes ___ kinds of music.'
    ],
    'yourself': [
      'You should take care of ___.',
      'Please help ___ to the food.',
      'She made it all by ___.',
      'Believe in ___.'
    ],
    'card': [
      'He gave her a birthday ___.',
      'She paid with a credit ___.',
      'They sent a holiday ___.',
      'I lost my ID ___.'
    ],
    'difficult': [
      'The exam was very ___.',
      'She faced a ___ decision.',
      'He found the task ___.',
      'It is a ___ question to answer.'
    ],
    'including': [
      'The book covers many topics, ___ history.',
      'He has many hobbies, ___ painting.',
      'They traveled to several countries, ___ Japan.',
      'She invited everyone, ___ him.'
    ],
    'list': [
      'She made a shopping ___.',
      'He is on the guest ___.',
      'They have a long to-do ___.',
      'The names are on the ___.'
    ],
    'mind': [
      'She has a sharp ___.',
      'He changed his ___.',
      'They are of one ___.',
      'You need to focus your ___.'
    ],
    'particular': [
      'She has a ___ interest in art.',
      'He is looking for a ___ type of book.',
      'They have a ___ way of doing things.',
      'There is no ___ reason for the delay.'
    ],
    'real': [
      'She has ___ talent.',
      'He is a ___ friend.',
      'This is a ___ diamond.',
      'The fear was very ___.'
    ],
    'science': [
      'He is a ___ teacher.',
      'She loves studying ___.',
      'They conducted a ___ experiment.',
      'The ___ fair was exciting.'
    ],
    'trade': [
      'They want to ___ goods.',
      'She is involved in international ___.',
      'He learned the ___ at a young age.',
      'They made a ___ agreement.'
    ],
    'consider': [
      'She will ___ the offer.',
      'He needs to ___ all options.',
      'They ___ it as a possibility.',
      'Please ___ the consequences.'
    ],
    'either': [
      'You can ___ stay or go.',
      'She will ___ call or write.',
      'He is ___ at home or at work.',
      'They are ___ coming or not.'
    ],
    'library': [
      'She went to the ___.',
      'He borrowed a book from the ___.',
      'They are meeting at the ___.',
      'The ___ has many resources.'
    ],
    'likely': [
      'It is ___ to rain today.',
      'She is ___ to succeed.',
      'They are ___ to join us.',
      'He is the most ___ candidate.'
    ],
    'nature': [
      'She loves spending time in ___.',
      'He studies the beauty of ___.',
      'They explored the wonders of ___.',
      'The book is about human ___.'
    ],
    'fact': [
      'This is a proven ___.',
      'She stated a surprising ___.',
      'They need to know the ___.',
      'He presented the ___.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'television': 'تلفزيون',
    'three': 'ثلاثة',
    'understand': 'يفهم',
    'various': 'متنوع',
    'yourself': 'نفسك',
    'card': 'بطاقة',
    'difficult': 'صعب',
    'including': 'بما في ذلك',
    'list': 'قائمة',
    'mind': 'عقل',
    'particular': 'خاص',
    'real': 'حقيقي',
    'science': 'علم',
    'trade': 'تجارة',
    'consider': 'يعتبر',
    'either': 'إما',
    'library': 'مكتبة',
    'likely': 'من المحتمل',
    'nature': 'طبيعة',
    'fact': 'حقيقة',
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
