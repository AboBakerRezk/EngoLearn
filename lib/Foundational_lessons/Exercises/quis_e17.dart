import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';



class QuizScreen17 extends StatefulWidget {
  @override
  _QuizScreen17State createState() => _QuizScreen17State();
}

class _QuizScreen17State extends State<QuizScreen17> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة السابعة عشرة
    'name': [
      'She changed her ___.',
      'He wrote his ___ on the form.',
      'They asked for her ___.',
      'The ___ of the movie is unique.'
    ],
    'personal': [
      'She shared her ___ story.',
      'He has ___ goals.',
      'This is my ___ opinion.',
      'Keep your ___ information secure.'
    ],
    'school': [
      'She goes to ___ every day.',
      'They built a new ___.',
      'He is a teacher at the ___.',
      'The ___ is very large.'
    ],
    'top': [
      'She climbed to the ___ of the mountain.',
      'He reached the ___ of his career.',
      'They live on the ___ floor.',
      'The ___ of the page is blank.'
    ],
    'current': [
      'She is the ___ president.',
      'He checked the ___ weather.',
      'This is my ___ project.',
      'The ___ news is alarming.'
    ],
    'generally': [
      'She is ___ a quiet person.',
      'He ___ works from home.',
      'They ___ agree with the plan.',
      'The movie was ___ well-received.'
    ],
    'historical': [
      'She read a ___ novel.',
      'He visited a ___ site.',
      'They are studying ___ events.',
      'The building has ___ significance.'
    ],
    'investment': [
      'She made a big ___.',
      'He is interested in ___.',
      'They discussed their ___ options.',
      'The ___ paid off.'
    ],
    'left': [
      'She turned to the ___.',
      'He is on the ___ side.',
      'They have ___ the building.',
      'The chair is to the ___.'
    ],
    'national': [
      'She is proud of her ___ identity.',
      'He supports the ___ team.',
      'They celebrated the ___ holiday.',
      'The ___ anthem is playing.'
    ],
    'amount': [
      'She paid a large ___.',
      'He needs a small ___.',
      'They donated a considerable ___.',
      'The ___ of sugar is too much.'
    ],
    'level': [
      'She reached a new ___.',
      'He is at the beginner ___.',
      'They raised the ___.',
      'The water ___ is high.'
    ],
    'order': [
      'She placed an ___.',
      'He gave a direct ___.',
      'They followed the ___.',
      'The ___ has been shipped.'
    ],
    'practice': [
      'She needs more ___.',
      'He goes to ___ every day.',
      'They discussed best ___.',
      'The ___ session was long.'
    ],
    'research': [
      'She is doing ___ on cancer.',
      'He works in the ___ department.',
      'They published new ___.',
      'The ___ took years.'
    ],
    'sense': [
      'She has a strong ___ of smell.',
      'He tried to make ___.',
      'They felt a ___ of urgency.',
      'It does not make any ___.'
    ],
    'service': [
      'She works in customer ___.',
      'He received poor ___.',
      'They provide excellent ___.',
      'The ___ was quick.'
    ],
    'area': [
      'She lives in this ___.',
      'He moved to a new ___.',
      'They explored the surrounding ___.',
      'The ___ is quite large.'
    ],
    'cut': [
      'She ___ the cake.',
      'He ___ the paper.',
      'They ___ their losses.',
      'The budget was ___.'
    ],
    'hot': [
      'The weather is very ___.',
      'She likes her coffee ___.',
      'He enjoys ___ food.',
      'The soup is too ___.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'name': 'اسم',
    'personal': 'شخصي',
    'school': 'مدرسة',
    'top': 'أعلى',
    'current': 'حالي',
    'generally': 'عموماً',
    'historical': 'تاريخي',
    'investment': 'استثمار',
    'left': 'يسار',
    'national': 'وطني',
    'amount': 'كمية',
    'level': 'مستوى',
    'order': 'طلب',
    'practice': 'ممارسة',
    'research': 'بحث',
    'sense': 'إحساس',
    'service': 'خدمة',
    'area': 'منطقة',
    'cut': 'قطع',
    'hot': 'حار',
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
