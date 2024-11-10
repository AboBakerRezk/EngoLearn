import 'dart:async';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mushaf25/Foundational_lessons/Games/Guess/Guess_1.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../settings/setting_2.dart';
import '../../Difficult_translation/Tutorial_25.dart';
import '../Correction/Correction_1.dart';
import '../Difficult_translation/Difficult_translation_1.dart';
import '../Fill_in_the_blanks/Fill_in_the_blanks_1.dart';
import '../Listening/Listening_1.dart';
import '../Matching/Matching_1.dart';
import '../Memory/Memory_1.dart';
import '../Translation/Translation_1.dart';
import '../the order of letters/the order of letters_1.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ألعاب الكلمات', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'اختر لعبة:',
              style: TextStyle(fontSize: 26, color: Colors.blue[900]), // زيادة حجم الخط
            ),
            SizedBox(height: 30), // إبعاد النص عن الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20), // تكبير الأزرار
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translation()),
                );
              },
              child: Text('لعبة اختيار الكلمة الصحيحة', style: TextStyle(fontSize: 22)), // تكبير الخط
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage1()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),

            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translation()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage1()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage1()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksGamePage()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage1()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CrosswordPuzzlePage()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame1()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 20), // إبعاد بين الأزرار
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // تم تغيير primary إلى backgroundColor
                foregroundColor: Colors.white, // تم تغيير onPrimary إلى foregroundColor
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame1()),
                );
              },
              child: Text('لعبة ملء الفراغات', style: TextStyle(fontSize: 22)),
            ),
          ],
        ),
      ),
    );
  }
}

// الكلمات المستخدمة في الألعاب
final List<List<List<String>>> allWords = [
  [
    ['the', 'ال'],
    ['of', 'من'],
    ['and', 'و'],
    ['to', 'إلى'],
    ['a', 'أ'],
  ],
  [
    ['in', 'في'],
    ['is', 'هو'],
    ['you', 'أنت'],
    ['are', 'تكون'],
    ['for', 'لـ'],
  ],
  [
    ['that', 'أن'],
    ['or', 'أو'],
    ['it', 'هو'],
    ['as', 'مثل'],
    ['be', 'يكون'],
  ],
  [
    ['on', 'على'],
    ['your', 'لك'],
    ['with', 'مع'],
    ['can', 'يستطيع'],
    ['have', 'لديك'],
  ],
];
final List<Map<String, String>> allWords2 = [
  {'word': 'the', 'translation': 'ال', 'image': '🔤'}, // أحرف الأبجدية
  {'word': 'of', 'translation': 'من', 'image': '🔗'}, // رابط أو سلسلة
  {'word': 'and', 'translation': 'و', 'image': '➕'}, // علامة الجمع
  {'word': 'to', 'translation': 'إلى', 'image': '➡️'}, // سهم يشير إلى الأمام
  {'word': 'a', 'translation': 'أ', 'image': '🅰️'}, // حرف A كبير
  {'word': 'in', 'translation': 'في', 'image': '📥'}, // صندوق الوارد
  {'word': 'is', 'translation': 'هو', 'image': '❓'}, // علامة استفهام
  {'word': 'you', 'translation': 'أنت', 'image': '👤'}, // أيقونة شخصية
  {'word': 'are', 'translation': 'تكون', 'image': '✅'}, // علامة صح
  {'word': 'for', 'translation': 'لـ', 'image': '🎁'}, // هدية
  {'word': 'that', 'translation': 'أن', 'image': '⚖️'}, // ميزان العدل
  {'word': 'or', 'translation': 'أو', 'image': '🔀'}, // علامة التبديل
  {'word': 'it', 'translation': 'هو', 'image': '💡'}, // مصباح
  {'word': 'as', 'translation': 'مثل', 'image': '🔗'}, // رابط أو سلسلة
  {'word': 'be', 'translation': 'يكون', 'image': '🌟'}, // نجمة
  {'word': 'on', 'translation': 'على', 'image': '🔛'}, // رمز "ON"
  {'word': 'your', 'translation': 'لك', 'image': '🧑‍🦰'}, // شخصية بشعر أحمر
  {'word': 'with', 'translation': 'مع', 'image': '🤝'}, // مصافحة
  {'word': 'can', 'translation': 'يستطيع', 'image': '🛠️'}, // أدوات
  {'word': 'have', 'translation': 'لديك', 'image': '📦'}, // صندوق
];

// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة



class HomeGame extends StatefulWidget {
  @override
  _HomeGameState createState() => _HomeGameState();
}

class _HomeGameState extends State<HomeGame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E);



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return FadeTransition(
      opacity: _animation,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // خلفية سوداء
      appBar: AppBar(
        title: Text("وَحَارِبْ لِحُلْمٍ مَا يَزَالُ عَالِقًا بَيْنَ النَّجَاحِ أَوْ أَنْ يَبُوءَ بِالفَشَلِ.", style: TextStyle(fontSize:18, color: Colors.white)),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, primaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildButton('${AppLocale.S80.getString(context)}', () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translation()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.Ss80.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => translationd()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.S85.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FillInTheBlanksPage1()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S104.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchWordToImagePage1()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S108.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RearrangeLettersPage1()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.S114.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage1()),
                );               }),
              SizedBox(height: 20),
              ////////////////////
              _buildButton('${AppLocale.S115.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordShootingGame1()),
                );               }),
              SizedBox(height: 20),

              ////////////////////
              _buildButton('${AppLocale.S117.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickMatchGame1()),
                );               }),
              SizedBox(height: 20),
              _buildButton('${AppLocale.S118.getString(context)}', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeningGame()),
                );               }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}




class CrosswordPuzzlePage extends StatefulWidget {
  @override
  _CrosswordPuzzlePageState createState() => _CrosswordPuzzlePageState();
}

class _CrosswordPuzzlePageState extends State<CrosswordPuzzlePage> {
  // الكلمات الإنجليزية مع ترجمتها العربية، والموقع في الشبكة
  final List<Map<String, dynamic>> words = [
    {'word': 'live', 'translation': 'يعيش', 'row': 0, 'col': 0, 'horizontal': true},
    {'word': 'plan', 'translation': 'خطة', 'row': 0, 'col': 4, 'horizontal': false},
    {'word': 'cold', 'translation': 'بارد', 'row': 2, 'col': 0, 'horizontal': true},
    {'word': 'tax', 'translation': 'ضريبة', 'row': 4, 'col': 0, 'horizontal': true},
    {'word': 'store', 'translation': 'متجر', 'row': 6, 'col': 0, 'horizontal': true},
    {'word': 'physics', 'translation': 'فيزياء', 'row': 8, 'col': 0, 'horizontal': true},
    {'word': 'analysis', 'translation': 'تحليل', 'row': 10, 'col': 0, 'horizontal': true},
    {'word': 'period', 'translation': 'فترة', 'row': 12, 'col': 0, 'horizontal': true},
    {'word': 'series', 'translation': 'سلسلة', 'row': 14, 'col': 0, 'horizontal': true},
    {'word': 'nothing', 'translation': 'لا شيء', 'row': 16, 'col': 0, 'horizontal': true},
    {'word': 'full', 'translation': 'ممتلئ', 'row': 18, 'col': 0, 'horizontal': true},
    {'word': 'low', 'translation': 'منخفض', 'row': 5, 'col': 10, 'horizontal': true},
    {'word': 'political', 'translation': 'سياسي', 'row': 7, 'col': 10, 'horizontal': true},
    {'word': 'policy', 'translation': 'سياسة', 'row': 9, 'col': 10, 'horizontal': true},
    {'word': 'purchase', 'translation': 'شراء', 'row': 11, 'col': 10, 'horizontal': true},
    {'word': 'commercial', 'translation': 'تجاري', 'row': 13, 'col': 10, 'horizontal': true},
    {'word': 'involved', 'translation': 'متورط', 'row': 15, 'col': 10, 'horizontal': true},
    {'word': 'itself', 'translation': 'ذاته', 'row': 17, 'col': 10, 'horizontal': true},
    {'word': 'directly', 'translation': 'مباشرة', 'row': 19, 'col': 10, 'horizontal': true},
    {'word': 'old', 'translation': 'قديم', 'row': 3, 'col': 6, 'horizontal': true},
  ];

  // حجم الشبكة 20x20
  List<List<String?>> grid = List.generate(20, (_) => List<String?>.filled(20, null));

  // حالة إدخال الحروف
  List<List<TextEditingController>> controllers = [];

  @override
  void initState() {
    super.initState();

    // تعبئة الشبكة بالكلمات المتقاطعة
    for (var wordData in words) {
      String word = wordData['word'];
      int row = wordData['row'];
      int col = wordData['col'];
      bool horizontal = wordData['horizontal'];

      for (int i = 0; i < word.length; i++) {
        if (horizontal) {
          grid[row][col + i] = word[i];
        } else {
          grid[row + i][col] = word[i];
        }
      }
    }

    // إنشاء محررات النصوص
    for (int i = 0; i < 20; i++) {
      controllers.add(List<TextEditingController>.generate(20, (_) => TextEditingController()));
    }
  }

  // دالة للتحقق من صحة الكلمات المدخلة
  bool checkCrossword() {
    for (var wordData in words) {
      String word = wordData['word'];
      int row = wordData['row'];
      int col = wordData['col'];
      bool horizontal = wordData['horizontal'];

      for (int i = 0; i < word.length; i++) {
        String? letter = horizontal ? controllers[row][col + i].text : controllers[row + i][col].text;

        if (letter == null || letter.isEmpty || letter != word[i]) {
          return false;
        }
      }
    }
    return true;
  }

  // واجهة المستخدم
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لعبة الكلمات المتقاطعة'),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 20,
                  childAspectRatio: 1.0,
                ),
                itemCount: 400, // 20x20 شبكة
                itemBuilder: (context, index) {
                  int row = index ~/ 20;
                  int col = index % 20;

                  // إذا كانت الحروف جزءًا من الكلمة
                  if (grid[row][col] != null) {
                    return Padding(
                      padding: EdgeInsets.all(2),
                      child: TextField(
                        controller: controllers[row][col],
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    // مربع فارغ
                    return Container(
                      margin: EdgeInsets.all(2),
                      color: Colors.grey[300],
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                bool result = checkCrossword();
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(result ? 'مبروك!' : 'حاول مرة أخرى'),
                    content: Text(result
                        ? 'لقد أكملت الكلمات المتقاطعة بنجاح!'
                        : 'يوجد بعض الأخطاء.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('حسنًا'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('تحقق من الإجابات'),
            ),
          ],
        ),
      ),
    );
  }
}



