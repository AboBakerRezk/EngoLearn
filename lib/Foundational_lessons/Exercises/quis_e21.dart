import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';


class QuizScreen21 extends StatefulWidget {
  @override
  _QuizScreen21State createState() => _QuizScreen21State();
}

class _QuizScreen21State extends State<QuizScreen21> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الحادية والعشرين
    'buy': [
      'She wants to ___ a new car.',
      'He decided to ___ some groceries.',
      'They plan to ___ a house next year.',
      'I need to ___ a gift for her.'
    ],
    'development': [
      'The ___ of the project is going well.',
      'He is involved in software ___.',
      'They focus on the ___ of new products.',
      '___ in technology is rapid.'
    ],
    'guard': [
      'He works as a security ___.',
      'She hired a ___ for protection.',
      'They posted a ___ at the entrance.',
      'The ___ was very alert.'
    ],
    'hold': [
      'She will ___ the baby.',
      'He tried to ___ his emotions.',
      'They ___ a meeting every Monday.',
      'Please ___ this for a moment.'
    ],
    'language': [
      'She is fluent in three ___.',
      'He teaches the English ___.',
      'They are learning a new ___.',
      '___ can be a barrier sometimes.'
    ],
    'later': [
      'We will talk ___ after the meeting.',
      'He will arrive ___.',
      'They will finish the project ___.',
      'She will come back ___.'
    ],
    'main': [
      'The ___ reason is unknown.',
      'He is the ___ character in the play.',
      'They discussed the ___ points.',
      'She entered through the ___ gate.'
    ],
    'offer': [
      'She made an ___ to buy the house.',
      'He refused their ___.',
      'They will ___ a discount.',
      'I received a job ___.'
    ],
    'oil': [
      'She cooks with olive ___.',
      'He added some ___ to the engine.',
      'They export a lot of ___.',
      'The ___ prices are rising.'
    ],
    'picture': [
      'She took a beautiful ___.',
      'He showed me a ___ of his family.',
      'They drew a ___ on the wall.',
      'The ___ was very clear.'
    ],
    'potential': [
      'She has great ___ as a leader.',
      'He realized his ___.',
      'They saw the ___ in the market.',
      'The ___ risks are high.'
    ],
    'professional': [
      'She is a ___ dancer.',
      'He is known as a ___ in his field.',
      'They provide ___ services.',
      'She handled the situation in a ___ manner.'
    ],
    'rather': [
      'She would ___ stay home.',
      'He prefers tea ___ than coffee.',
      'They would ___ not discuss it.',
      'I would ___ go for a walk.'
    ],
    'access': [
      'She needs ___ to the database.',
      'He has ___ to all the files.',
      'They granted her ___ to the building.',
      'I couldn’t ___ the information.'
    ],
    'additional': [
      'She requested ___ information.',
      'He needs some ___ help.',
      'They provided ___ resources.',
      'The cost includes ___ fees.'
    ],
    'almost': [
      'She is ___ ready.',
      'He is ___ finished with the task.',
      'They ___ made a mistake.',
      'It is ___ time to leave.'
    ],
    'especially': [
      'She likes fruits, ___ apples.',
      'He enjoys music, ___ jazz.',
      'They are busy, ___ on weekends.',
      'I love desserts, ___ chocolate.'
    ],
    'garden': [
      'She planted flowers in the ___.',
      'He spends time in the ___.',
      'They have a beautiful ___.',
      'The ___ needs some care.'
    ],
    'international': [
      'She works for an ___ company.',
      'He has ___ clients.',
      'They attended an ___ conference.',
      'The ___ market is growing.'
    ],
    'lower': [
      'She tried to ___ the volume.',
      'He needs to ___ his voice.',
      'They want to ___ the prices.',
      'The temperature will ___ tomorrow.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'buy': 'يشتري',
    'development': 'تطوير',
    'guard': 'حارس',
    'hold': 'يمسك',
    'language': 'لغة',
    'later': 'لاحقاً',
    'main': 'أساسي',
    'offer': 'عرض',
    'oil': 'نفط',
    'picture': 'صورة',
    'potential': 'محتمل',
    'professional': 'محترف',
    'rather': 'بدلاً',
    'access': 'تمكن من',
    'additional': 'إضافي',
    'almost': 'تقريباً',
    'especially': 'خصوصاً',
    'garden': 'حديقة',
    'international': 'دولي',
    'lower': 'خفض',
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
