import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:math';

import '../../settings/setting_2.dart';


class QuizScreen23 extends StatefulWidget {
  @override
  _QuizScreen23State createState() => _QuizScreen23State();
}

class _QuizScreen23State extends State<QuizScreen23> {
  final Map<String, List<String>> sentenceTemplates = {
    // كلمات المجموعة الثالثة والعشرين
    'following': [
      'Please read the ___ instructions.',
      'The ___ day, she went to work.',
      'He answered the ___ question.',
      'What is the ___ step?'
    ],
    'image': [
      'She took an ___ of the sunset.',
      'I saw an ___ of a cat.',
      'The ___ was very clear.',
      'He shared an ___ on social media.'
    ],
    'quickly': [
      'She ran ___.',
      'He finished his work ___.',
      'They responded to the email ___.',
      'The water boiled ___.'
    ],
    'special': [
      'She wore a ___ dress for the occasion.',
      'He made a ___ cake for her birthday.',
      'They have a ___ bond.',
      'The event was very ___.'
    ],
    'working': [
      'He is ___ on a new project.',
      'She has been ___ all day.',
      'They are ___ hard to meet the deadline.',
      'I enjoy ___ with my team.'
    ],
    'case': [
      'This is an interesting ___.',
      'The lawyer presented the ___.',
      'In this ___, we need more evidence.',
      'What is the ___ number?'
    ],
    'cause': [
      'The ___ of the problem is unclear.',
      'She is fighting for a good ___.',
      'He wants to find the ___ of the issue.',
      'What is the main ___?'
    ],
    'coast': [
      'They drove along the ___.',
      'The ___ is very beautiful.',
      'She lives near the ___.',
      'The ___ guard is on patrol.'
    ],
    'probably': [
      'She will ___ come tomorrow.',
      'He is ___ the best candidate.',
      'They will ___ finish on time.',
      'It will ___ rain later.'
    ],
    'security': [
      'They increased ___ at the event.',
      'The ___ team is well-trained.',
      'He works in cyber ___.',
      'She has a ___ clearance.'
    ],
    'TRUE': [
      'It is ___ that she loves music.',
      'His statement was ___.',
      'She hopes her dreams come ___.',
      'Is it ___ that he is leaving?'
    ],
    'whole': [
      'She ate the ___ cake.',
      'They spent the ___ day together.',
      'He read the ___ book in one sitting.',
      'The ___ process was confusing.'
    ],
    'action': [
      'She took immediate ___.',
      'He is a man of few words but many ___.',
      'The ___ scene was thrilling.',
      'They called for urgent ___.'
    ],
    'age': [
      'She looks young for her ___.',
      'What is your ___?',
      'He retired at a young ___.',
      'They are the same ___.'
    ],
    'among': [
      'She was ___ friends.',
      'He walked ___ the crowd.',
      'The treasure was hidden ___ the trees.',
      'There is trust ___ them.'
    ],
    'bad': [
      'She had a ___ day.',
      'He made a ___ decision.',
      'They encountered ___ weather.',
      'It was a ___ idea.'
    ],
    'boat': [
      'They sailed on a ___.',
      'She bought a new ___.',
      'He loves fishing from his ___.',
      'The ___ was very fast.'
    ],
    'country': [
      'She loves her ___.',
      'They traveled to a different ___.',
      'He represents his ___ in sports.',
      'What is your home ___?'
    ],
    'dance': [
      'She loves to ___.',
      'He asked her for a ___.',
      'They performed a traditional ___.',
      'The ___ was beautiful.'
    ],
    'exam': [
      'She is studying for her ___.',
      'He passed the ___.',
      'They have an ___ tomorrow.',
      'The ___ was very difficult.'
    ],
  };

  final Map<String, String> wordTranslations = {
    'following': 'التالي',
    'image': 'صورة',
    'quickly': 'بسرعة',
    'special': 'خاص',
    'working': 'عمل',
    'case': 'قضية',
    'cause': 'سبب',
    'coast': 'ساحل',
    'probably': 'محتمل',
    'security': 'أمن',
    'TRUE': 'صحيح',
    'whole': 'كامل',
    'action': 'عمل',
    'age': 'عمر',
    'among': 'بين',
    'bad': 'سيئ',
    'boat': 'قارب',
    'country': 'بلد',
    'dance': 'رقص',
    'exam': 'امتحان',
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
