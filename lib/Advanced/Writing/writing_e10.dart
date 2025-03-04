import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:list_english_words/list_english_words.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> dailySentences = [
  'ما هو الشيء الذي يجعلك تشعر بالأمان؟',
  'كيف تتعامل مع الخوف؟',
  'ما هو الشيء الذي يعزز ثقتك بنفسك؟',
  'كيف تطور نفسك باستمرار؟',
  'ما هي استراتيجيتك في تحقيق أهدافك؟',
  'هل تؤمن بالتخطيط على المدى الطويل؟',
  'كيف تتعامل مع الأوقات الصعبة؟',
  'ما هو أهم درس تعلمته من الحياة؟',
  'ما هو تأثير الآخرين عليك؟',
  'ما هو هدفك الأسمى؟',
  'هل لديك خطة طوارئ في حياتك؟',
  'ما هو الشيء الذي يجعلك سعيداً؟',
  'كيف تتعامل مع الضغط النفسي؟',
  'هل تعتقد أن النجاح يأتي من المثابرة أم الحظ؟',
  'ما هي خططك لتطوير مهاراتك المهنية؟',
  'هل تؤمن بأن الفشل جزء من النجاح؟',
  'ما هو التحدي الأكبر الذي واجهته؟',
  'كيف تحافظ على توازنك بين الحياة والعمل؟',
  'ما هي القيم التي تحترمها في الآخرين؟',
  'كيف تصف نفسك في ثلاث كلمات؟',
];

List<String> correctTranslations = [
  'What makes you feel safe?',
  'How do you deal with fear?',
  'What boosts your self-confidence?',
  'How do you constantly improve yourself?',
  'What’s your strategy for achieving your goals?',
  'Do you believe in long-term planning?',
  'How do you cope with tough times?',
  'What’s the most important lesson life has taught you?',
  'How do others influence you?',
  'What’s your ultimate goal?',
  'Do you have an emergency plan in life?',
  'What makes you happy?',
  'How do you handle stress?',
  'Do you think success comes from persistence or luck?',
  'What are your plans to develop your professional skills?',
  'Do you believe failure is part of success?',
  'What’s the biggest challenge you’ve faced?',
  'How do you maintain a work-life balance?',
  'What values do you respect in others?',
  'How would you describe yourself in three words?',
];





class WritingSection10 extends StatefulWidget {
  @override
  _WritingSection10State createState() => _WritingSection10State();
}

class _WritingSection10State extends State<WritingSection10>  {
  String userWriting = '';
  String feedbackMessage = '';
  String writingLevel = '';
  String correctedText = '';
  int targetWords = 50;
  bool darkMode = false;
  Timer? writingTimer;
  String speedFeedback = '';
  String styleFeedback = '';
  String coherenceFeedback = '';
  String clarityFeedback = '';
  String repetitionFeedback = '';
  String validityFeedback = '';
  late TextEditingController _controller;
  DateTime? startTime;
  List<String> suggestedCorrections = [];
  Timer? _debounce;
  final Color primaryColor = Color(0xFF13194E);

  int currentSentenceIndex = 0;

  // نقاط المستخدم المختلفة
  double writingPoints = 0;

  // مستويات التقدم
  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int speakingProgressLevel = 0; // New variable for Speaking
  int bottleFillLevel = 0;

  // دالة لتحميل البيانات المحفوظة من SharedPreferences
  Future<void> loadSavedProgressData() async {
    SharedPreferences sharedPreferencesInstance =
    await SharedPreferences.getInstance();
    setState(() {
      readingProgressLevel =
          sharedPreferencesInstance.getInt('progressReading') ?? 0;
      listeningProgressLevel =
          sharedPreferencesInstance.getInt('progressListening') ?? 0;
      writingProgressLevel =
          sharedPreferencesInstance.getInt('progressWriting') ?? 0;
      grammarProgressLevel =
          sharedPreferencesInstance.getInt('progressGrammar') ?? 0;
      speakingProgressLevel =
          sharedPreferencesInstance.getInt('progressSpeaking') ?? 0; // Load Speaking
      bottleFillLevel = sharedPreferencesInstance.getInt('bottleLevel') ?? 0;
    });
  }

  // دالة لحفظ البيانات إلى SharedPreferences
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences sharedPreferencesInstance =
    await SharedPreferences.getInstance();
    await sharedPreferencesInstance.setInt(
        'progressReading', readingProgressLevel);
    await sharedPreferencesInstance.setInt(
        'progressListening', listeningProgressLevel);
    await sharedPreferencesInstance.setInt(
        'progressWriting', writingProgressLevel);
    await sharedPreferencesInstance.setInt(
        'progressGrammar', grammarProgressLevel);
    await sharedPreferencesInstance.setInt(
        'progressSpeaking', speakingProgressLevel); // Save Speaking
    await sharedPreferencesInstance.setInt('bottleLevel', bottleFillLevel);
  }

  // دالة لتحميل بيانات النقاط
  Future<void> _loadStatisticsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      writingPoints = prefs.getDouble('writingPoints') ?? 0;
    });
  }

  // دالة لحفظ بيانات النقاط
  Future<void> saveStatisticsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('writingPoints', writingPoints);
  }

  // دالة لزيادة نقاط الكتابة
  void increaseWritingPoints(double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      writingPoints += amount;
    });
    await prefs.setDouble('writingPoints', writingPoints);
  }

  // دالة لتحديث مستوى التقدم في الكتابة
  void updateWritingProgress(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      writingProgressLevel += amount;
      if (writingProgressLevel > 500) writingProgressLevel = 500;
    });
    await prefs.setInt('progressWriting', writingProgressLevel);
  }

  // دالة لتحديث مستوى زجاجة التقدم
  void updateBottleFillLevel(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bottleFillLevel += amount;
      if (bottleFillLevel > 6000) bottleFillLevel = 6000;
    });
    await prefs.setInt('bottleLevel', bottleFillLevel);
  }

  @override
  void initState() {
    super.initState();
    loadSavedProgressData();
    _loadStatisticsData();
    _controller = TextEditingController();
    _loadUserWriting();
    _checkDarkMode();
  }

  Future<void> _checkDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  void _showAnswer() {
    String correctTranslation = _getCorrectTranslation();
    setState(() {
      feedbackMessage = 'الترجمة الصحيحة هي: $correctTranslation';
    });
  }

  Future<void> _loadUserWriting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userWriting = prefs.getString('userWriting') ?? '';
      _controller.text = userWriting;
      _updateWordCount(userWriting);
    });
  }

  Future<void> _saveUserWriting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userWriting', userWriting);
  }

  void _onWritingChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        userWriting = value;
        _updateWordCount(value);
        _checkUserWriting();
      });
    });
  }

  int targetWords2 = 30; // الحد الأقصى لعدد الكلمات

  void _updateWordCount(String text) {
    List<String> words = text
        .split(RegExp(r'[\s,.!?]+'))
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.length > targetWords2) {
      Fluttertoast.showToast(
        msg: "لقد تجاوزت الحد المسموح به وهو 30 كلمة!",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      // قطع النص إلى أول 30 كلمة فقط
      String trimmedText = words.take(targetWords2).join(" ");
      _controller.text = trimmedText;

      // تحريك مؤشر النص إلى نهاية النص
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );

      // تحديث حالة التطبيق بالنص المقتطع
      setState(() {
        userWriting = trimmedText;
      });
    } else {
      setState(() {
        userWriting = text;
        if (startTime == null) {
          startTime = DateTime.now();
        } else {
          final elapsedTime = DateTime.now().difference(startTime!).inSeconds;
          final wordsPerMinute = (words.length / elapsedTime) * 60;
          speedFeedback =
          'سرعة الكتابة لديك ${wordsPerMinute.toStringAsFixed(1)} كلمة في الدقيقة.';
        }

        // حفظ النص المدخل
        _saveUserWriting();
      });
    }
  }

  void _checkUserWriting() {
    String correctTranslation = _getCorrectTranslation();

    // حساب عدد الحروف في الترجمة الصحيحة والنص المدخل من المستخدم
    int correctLength = correctTranslation.replaceAll(RegExp(r'\s+'), '').length;
    int userLength = userWriting.replaceAll(RegExp(r'\s+'), '').length;

    // التحقق من أن المستخدم كتب نفس عدد الحروف أو أكثر
    if (userLength >= correctLength) {
      if (userWriting.trim().toLowerCase() == correctTranslation.toLowerCase()) {
        setState(() {
          feedbackMessage = 'إجابة صحيحة!';
        });
        increaseWritingPoints(10); // زيادة النقاط
        updateWritingProgress(5); // تحديث مستوى التقدم
        updateBottleFillLevel(5); // تحديث زجاجة التقدم
        saveStatisticsData();
        saveProgressDataToPreferences();
      } else {
        setState(() {
          feedbackMessage =
          'حاول مرة أخرى. الترجمة الصحيحة هي: $correctTranslation';
        });
      }
    } else {
      setState(() {
        feedbackMessage = 'حاول كتابة المزيد من الحروف.';
      });
    }
  }

  String _getCorrectTranslation() {
    return correctTranslations[currentSentenceIndex];
  }

  void _nextSentence() {
    setState(() {
      if (userWriting.trim().isNotEmpty) {
        increaseWritingPoints(5); // زيادة النقاط للمحاولة
        updateWritingProgress(1);
        updateBottleFillLevel(1);
      }
      saveStatisticsData();
      saveProgressDataToPreferences();
      currentSentenceIndex =
          (currentSentenceIndex + 1) % dailySentences.length;
      userWriting = '';
      _controller.clear();
      feedbackMessage = '';
      startTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentArabicSentence = dailySentences[currentSentenceIndex];
    return Scaffold(
      appBar: AppBar(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'اكتب الترجمة الإنجليزية للجملة التالية:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                currentArabicSentence,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 2,
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                controller: _controller,
                onChanged: _onWritingChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ترجمتك',
                  hintText: 'اكتب الترجمة هنا...',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                feedbackMessage,
                style: TextStyle(
                    fontSize: 16,
                    color: feedbackMessage == 'إجابة صحيحة!'
                        ? Colors.green
                        : Colors.red),
              ),
              SizedBox(height: 10),
              Text(
                speedFeedback,
                style: TextStyle(color: Colors.blue),
              ),
              ElevatedButton(
                onPressed: _showAnswer,
                child: Text(
                  'إظهار الإجابة',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _nextSentence,
                child: Text(
                  'الجملة التالية',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class SentenceValidator {
  final Set<String> validEnglishWords = Set.from(list_english_words);

  bool isValidSentence(String? sentence) {
    if (sentence == null || sentence.isEmpty) return false;
    List<String> words = sentence
        .split(RegExp(r'[\s,.!?]+'))
        .where((word) => word.isNotEmpty)
        .toList();
    Set<String> uniqueWords = {};
    for (String word in words) {
      if (uniqueWords.contains(word)) {
        return false;
      }
      uniqueWords.add(word);
    }
    return true;
  }

  List<String> getValidWords(String? sentence) {
    if (sentence == null || sentence.isEmpty) return [];
    List<String> words = sentence
        .split(RegExp(r'[\s,.!?]+'))
        .where((word) => word.isNotEmpty)
        .toList();
    return words.where((word) => isEnglishWord(word)).toList();
  }

  bool isEnglishWord(String word) {
    return word.length > 1 && validEnglishWords.contains(word.toLowerCase());
  }
}



