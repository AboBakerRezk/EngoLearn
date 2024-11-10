import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PointsPage extends StatefulWidget {
  @override
  _PointsPageState createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  // متغيرات النقاط
  double grammarPoints = 0;
  double lessonPoints = 0;
  double studyHoursPoints = 0;
  double listeningPoints = 0;
  double speakingPoints = 0;
  double readingPoints = 0;
  double writingPoints = 0;
  double exercisePoints = 0;
  double sentenceFormationPoints = 0;
  double gamePoints = 0; // نقاط الألعاب (9 ألعاب)

  // إجمالي النقاط بحد أقصى مليون نقطة
  double maxPoints = 1000000;

  // حساب إجمالي النقاط
  double get totalPoints {
    return grammarPoints +
        lessonPoints +
        studyHoursPoints +
        listeningPoints +
        speakingPoints +
        readingPoints +
        writingPoints +
        exercisePoints +
        sentenceFormationPoints +
        gamePoints;
  }

  // تحديد الألقاب بناءً على النقاط
  String get userRank {
    if (totalPoints < 20000) {
      return "مبتدئ";
    } else if (totalPoints < 100000) {
      return "متعلم";
    } else if (totalPoints < 300000) {
      return "متوسط";
    } else if (totalPoints < 600000) {
      return "متعلم متقدم";
    } else if (totalPoints < 900000) {
      return "خبير";
    } else {
      return "متمرس";
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // تحميل البيانات من SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      grammarPoints = prefs.getDouble('grammarPoints') ?? 0;
      lessonPoints = prefs.getDouble('lessonPoints') ?? 0;
      studyHoursPoints = prefs.getDouble('studyHoursPoints') ?? 0;
      listeningPoints = prefs.getDouble('listeningPoints') ?? 0;
      speakingPoints = prefs.getDouble('speakingPoints') ?? 0;
      readingPoints = prefs.getDouble('readingPoints') ?? 0;
      writingPoints = prefs.getDouble('writingPoints') ?? 0;
      exercisePoints = prefs.getDouble('exercisePoints') ?? 0;
      sentenceFormationPoints = prefs.getDouble('sentenceFormationPoints') ?? 0;
      gamePoints = prefs.getDouble('gamePoints') ?? 0;
    });
  }

  // حفظ النقاط في SharedPreferences
  Future<void> _savePoints() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('grammarPoints', grammarPoints);
    await prefs.setDouble('lessonPoints', lessonPoints);
    await prefs.setDouble('studyHoursPoints', studyHoursPoints);
    await prefs.setDouble('listeningPoints', listeningPoints);
    await prefs.setDouble('speakingPoints', speakingPoints);
    await prefs.setDouble('readingPoints', readingPoints);
    await prefs.setDouble('writingPoints', writingPoints);
    await prefs.setDouble('exercisePoints', exercisePoints);
    await prefs.setDouble('sentenceFormationPoints', sentenceFormationPoints);
    await prefs.setDouble('gamePoints', gamePoints);
  }

  // واجهة المستخدم لإدخال النقاط
  Widget _buildInputField(String label, double currentValue, Function(double) onChanged) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        SizedBox(
          width: 100,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: currentValue.toString(),
            ),
            onSubmitted: (value) {
              double val = double.tryParse(value) ?? 0;
              onChanged(val);
            },
          ),
        ),
      ],
    );
  }

  // واجهة المستخدم الرئيسية
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نظام النقاط'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // حقول إدخال النقاط
            _buildInputField('نقاط القواعد النحوية', grammarPoints, (val) {
              setState(() {
                grammarPoints = val;
              });
              _savePoints();
            }),
            _buildInputField('نقاط الدروس', lessonPoints, (val) {
              setState(() {
                lessonPoints = val;
              });
              _savePoints();
            }),
            _buildInputField('نقاط ساعات الدراسة', studyHoursPoints, (val) {
              setState(() {
                studyHoursPoints = val;
              });
              _savePoints();
            }),
            _buildInputField('نقاط الاستماع', listeningPoints, (val) {
              setState(() {
                listeningPoints = val;
              });
              _savePoints();
            }),
            _buildInputField('نقاط التحدث', speakingPoints, (val) {
              setState(() {
                speakingPoints = val;
              });
              _savePoints();
            }),
            _buildInputField('نقاط القراءة', readingPoints, (val) {
              setState(() {
                readingPoints = val;
              });
              _savePoints();
            }),
            _buildInputField('نقاط الكتابة', writingPoints, (val) {
              setState(() {
                writingPoints = val;
              });
              _savePoints();
            }),
            _buildInputField('نقاط التمارين', exercisePoints, (val) {
              setState(() {
                exercisePoints = val;
              });
              _savePoints();
            }),
            _buildInputField('نقاط تشكيل الجمل', sentenceFormationPoints, (val) {
              setState(() {
                sentenceFormationPoints = val;
              });
              _savePoints();
            }),
            _buildInputField('نقاط الألعاب', gamePoints, (val) {
              setState(() {
                gamePoints = val;
              });
              _savePoints();
            }),
            SizedBox(height: 20),
            // عرض إجمالي النقاط والألقاب
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'إجمالي النقاط: $totalPoints',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'اللقب: $userRank',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
