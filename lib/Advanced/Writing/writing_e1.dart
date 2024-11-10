import 'package:flutter/material.dart';
import 'package:list_english_words/list_english_words.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart'; // لإضافة النسخ والمشاركة
import 'package:fluttertoast/fluttertoast.dart'; // لإظهار التنبيهات السريعة
import 'dart:async';

import '../../Foundational_lessons/home_sady.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';






import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
// قائمة الجمل العربية خارج الصفحة
List<String> dailySentences = [
  'صباح الخير',
  'كيف حالك؟',
  'ما هو اسمك؟',
  'أين تسكن؟',
  'ما هو عملك؟',
  'ما هي هواياتك؟',
  'هل تحب السفر؟',
  'ما هو طعامك المفضل؟',
  'ما هي لغتك الأم؟',
  'كم عمرك؟',
  'ما هو فيلمك المفضل؟',
  'هل تفضل القهوة أم الشاي؟',
  'ما هي رياضتك المفضلة؟',
  'متى تستيقظ كل يوم؟',
  'هل تقرأ الكتب؟',
  'هل تفضل الصيف أم الشتاء؟',
  'هل لديك حيوانات أليفة؟',
  'ما هو لونك المفضل؟',
  'هل تحب الطهي؟',
  'ما هي مدينتك المفضلة؟',
];

// قائمة الترجمات الإنجليزية
List<String> correctTranslations = [
  'Good morning',
  'How are you?',
  'What is your name?',
  'Where do you live?',
  'What is your job?',
  'What are your hobbies?',
  'Do you like traveling?',
  'What is your favorite food?',
  'What is your mother tongue?',
  'How old are you?',
  'What is your favorite movie?',
  'Do you prefer coffee or tea?',
  'What is your favorite sport?',
  'When do you wake up every day?',
  'Do you read books?',
  'Do you prefer summer or winter?',
  'Do you have pets?',
  'What is your favorite color?',
  'Do you like cooking?',
  'What is your favorite city?',
];

class WritingSection1 extends StatefulWidget {
  @override
  _WritingSection1State createState() => _WritingSection1State();
}

class _WritingSection1State extends State<WritingSection1> {
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




















class WritingSections1 extends StatefulWidget {
  @override
  _WritingSections1State createState() => _WritingSections1State();
}

class _WritingSections1State extends State<WritingSections1> {
  String userWriting = ''; // لتخزين كتابة المستخدم
  String feedbackMessage = ''; // رسالة التغذية الراجعة
  String writingLevel = ''; // لتخزين مستوى الكتابة
  String correctedText = ''; // النص المصحح
  int targetWords = 50; // هدف الكلمات اليومية
  bool darkMode = false; // وضع المظلم
  Timer? writingTimer; // مؤقت الكتابة
  String speedFeedback = ''; // ملاحظات حول سرعة الكتابة
  String styleFeedback = ''; // ملاحظات حول أسلوب الكتابة
  String coherenceFeedback = ''; // ملاحظات حول التماسك النصي
  String clarityFeedback = ''; // ملاحظات حول وضوح الكتابة
  String repetitionFeedback = ''; // ملاحظات حول التكرار
  String validityFeedback = ''; // ملاحظات حول صحة الكلمات

  late TextEditingController _controller; // للتحكم في النص المدخل
  DateTime? startTime; // لتخزين وقت بدء الكتابة

  List<String> suggestedCorrections = []; // قائمة الاقتراحات
  Timer? _debounce;

  final Color primaryColor = Color(0xFF13194E); // اللون الأساسي للتصميم

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadUserWriting();
    _checkDarkMode(); // التحقق من وضع المظلم
  }

  Future<void> _checkDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  Future<void> _toggleDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      darkMode = !darkMode;
      prefs.setBool('darkMode', darkMode);
    });
  }

  Future<void> _loadUserWriting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userWriting = prefs.getString('userWriting') ?? '';
      _controller.text = userWriting; // تحميل النص في الـ TextField
      _updateWordCount(userWriting);
    });
  }

  Future<void> _saveUserWriting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userWriting', userWriting);
  }

  int _levenshteinDistance(String word1, String word2) {
    int len1 = word1.length;
    int len2 = word2.length;
    List<List<int>> dp = List.generate(len1 + 1, (_) => List.filled(len2 + 1, 0));

    for (int i = 0; i <= len1; i++) {
      for (int j = 0; j <= len2; j++) {
        if (i == 0) {
          dp[i][j] = j; // حذف كل الأحرف في word2
        } else if (j == 0) {
          dp[i][j] = i; // حذف كل الأحرف في word1
        } else if (word1[i - 1] == word2[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else {
          dp[i][j] = 1 + [
            dp[i - 1][j],    // حذف
            dp[i][j - 1],    // إضافة
            dp[i - 1][j - 1] // تبديل
          ].reduce((a, b) => a < b ? a : b);
        }
      }
    }

    return dp[len1][len2];
  }

  String _suggestCorrection(String word) {
    List<String> possibleCorrections = [];

    final Set<String> validEnglishWords = Set.from(list_english_words); // استبدل بالقائمة الفعلية لديك

    Map<String, int> wordDistances = {};

    for (String validWord in validEnglishWords) {
      if (_hasThreeCommonLetters(word.toLowerCase(), validWord.toLowerCase())) {
        int distance = _levenshteinDistance(word.toLowerCase(), validWord.toLowerCase());
        wordDistances[validWord] = distance;
      }
    }

    var sortedCorrections = wordDistances.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    possibleCorrections = sortedCorrections.take(10).map((e) => e.key).toList();

    if (possibleCorrections.isNotEmpty) {
      return possibleCorrections.join(', ');
    } else {
      return "لا توجد بدائل متاحة";
    }
  }

  bool _hasThreeCommonLetters(String word1, String word2) {
    int commonLettersCount = 0;

    for (int i = 0; i < word1.length - 2; i++) {
      String substring = word1.substring(i, i + 3);

      if (word2.contains(substring)) {
        commonLettersCount++;
      }

      if (commonLettersCount >= 1) {
        return true;
      }
    }
    return false;
  }

  void _onWritingChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        userWriting = value;
        _updateWordCount(value);
        _analyzeWritingStyle();
        _analyzeClarity();
        _analyzeCoherence();
        _detectRepetition();
        _checkWordValidity();

        // تحقق تلقائيًا من الاقتراحات وتحديثها
        List<String> allWords = value.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();
        List<String> incorrectWords = [];
        Map<String, String> wordCorrections = {};

        allWords.forEach((word) {
          if (!SentenceValidators().isEnglishWord(word)) {
            incorrectWords.add(word);
            String correctedWord = _suggestCorrection(word);
            wordCorrections[word] = correctedWord;
            suggestedCorrections = correctedWord.split(', ');
          }
        });
      });
    });
  }

  void _updateWordCount(String text) {
    setState(() {
      userWriting = text;

      SentenceValidators validator = SentenceValidators();
      List<String> validWords = validator.getValidWords(userWriting);
      int validWordCount = validWords.length;

      if (startTime == null) {
        startTime = DateTime.now();
      } else {
        final elapsedTime = DateTime.now().difference(startTime!).inSeconds;
        final wordsPerMinute = (validWordCount / elapsedTime) * 60;
        speedFeedback = 'You are writing at a speed of ${wordsPerMinute.toStringAsFixed(1)} words per minute.';
      }

      if (validWordCount >= targetWords) {
        Fluttertoast.showToast(msg: "You've reached your daily goal!", backgroundColor: Colors.green);
      }

      _saveUserWriting();
    });
  }

  void _clearText() {
    setState(() {
      userWriting = '';
      _controller.clear();
      feedbackMessage = '';
      writingLevel = '';
      correctedText = '';
      startTime = null;
    });
  }

  void _shareText() {
    Clipboard.setData(ClipboardData(text: userWriting));
    Fluttertoast.showToast(msg: "Text copied to clipboard!", backgroundColor: Colors.blue);
  }

  void _analyzeWritingStyle() {
    styleFeedback = 'Your writing style is formal and structured.'; // تخصيص هذه بناءً على التحليل
  }

  void _analyzeClarity() {
    clarityFeedback = 'Some sentences are complex and could be simplified for better clarity.'; // تخصيص هذه بناءً على التحليل
  }

  void _analyzeCoherence() {
    coherenceFeedback = 'The ideas in your writing are mostly coherent, but transitions between paragraphs can be improved.'; // تخصيص هذه بناءً على التحليل
  }

  void _detectRepetition() {
    Map<String, int> wordFrequency = {};
    List<String> words = userWriting.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();

    words.forEach((word) {
      wordFrequency[word] = (wordFrequency[word] ?? 0) + 1;
    });

    repetitionFeedback = '';
    wordFrequency.forEach((word, count) {
      if (count > 3) {
        repetitionFeedback += 'Repetition detected: "$word" is used $count times.\n';
      }
    });
  }

  void _checkWordValidity() {
    SentenceValidators validator = SentenceValidators();
    validityFeedback = validator.isValidSentence(userWriting) ? 'الجملة صحيحة.' : 'الجملة تحتوي على كلمات غير صالحة أو مكررة.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Writing Section'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Writing Task:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Please write a short paragraph about your favorite hobby and why you enjoy it.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 5,
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                controller: _controller,
                onChanged: _onWritingChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Writing',
                  hintText: 'Start writing your paragraph...',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: SentenceValidators().getValidWords(userWriting).length / targetWords,
                backgroundColor: Colors.grey[300],
                color: Colors.blue,
                minHeight: 10,
              ),
              SizedBox(height: 10),
              Text(
                'Valid word count: ${SentenceValidators().getValidWords(userWriting).length}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 10),
              if (suggestedCorrections.isNotEmpty)
                Wrap(
                  children: suggestedCorrections
                      .map((suggestion) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ActionChip(
                      label: Text(suggestion),
                      onPressed: () {
                        setState(() {
                          userWriting += ' $suggestion';
                          _controller.text = userWriting;
                          _updateWordCount(userWriting);
                        });
                      },
                    ),
                  ))
                      .toList(),
                ),
              SizedBox(height: 10),
              Text(
                'Current Level: $writingLevel',
                style: TextStyle(fontSize: 14, color: Colors.green[600]),
              ),
              SizedBox(height: 10),
              Text('Speed feedback: $speedFeedback', style: TextStyle(color: Colors.blue)),
              SizedBox(height: 10),
              Text('Style feedback: $styleFeedback', style: TextStyle(color: Colors.purple)),
              SizedBox(height: 10),
              Text('Clarity feedback: $clarityFeedback', style: TextStyle(color: Colors.green)),
              SizedBox(height: 10),
              Text('Coherence feedback: $coherenceFeedback', style: TextStyle(color: Colors.orange)),
              SizedBox(height: 10),
              Text('Repetition feedback: $repetitionFeedback', style: TextStyle(color: Colors.red)),
              SizedBox(height: 10),
              Text('Validity feedback: $validityFeedback', style: TextStyle(color: Colors.teal)),
              Spacer(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class SentenceValidators {
  final Set<String> validEnglishWords = Set.from(list_english_words); // استبدل بالقائمة الفعلية لديك

  bool isValidSentence(String? sentence) {
    if (sentence == null || sentence.isEmpty) return false;

    List<String> words = sentence.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();

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

    List<String> words = sentence.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();

    return words.where((word) => isEnglishWord(word)).toList();
  }

  bool isEnglishWord(String word) {
    return word.length > 1 && validEnglishWords.contains(word.toLowerCase());
  }
}

//
//
// .import 'package:flutter/material.dart';
// import 'package:list_english_words/list_english_words.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/services.dart'; // لإضافة النسخ والمشاركة
// import 'package:fluttertoast/fluttertoast.dart'; // لإظهار التنبيهات السريعة
// import 'dart:async';
//
// import '../../stady_Beginning/home_sady.dart';
//
// class WritingSection1 extends StatefulWidget {
//   @override
//   _WritingSection1State createState() => _WritingSection1State();
// }
//
// class _WritingSection1State extends State<WritingSection1> {
//   String userWriting = ''; // لتخزين كتابة المستخدم
//   String feedbackMessage = ''; // رسالة التغذية الراجعة
//   String writingLevel = ''; // لتخزين مستوى الكتابة
//   String correctedText = ''; // النص المصحح
//   int targetWords = 50; // هدف الكلمات اليومية
//   bool darkMode = false; // وضع المظلم
//   Timer? writingTimer; // مؤقت الكتابة
//   String speedFeedback = ''; // ملاحظات حول سرعة الكتابة
//   String styleFeedback = ''; // ملاحظات حول أسلوب الكتابة
//   String coherenceFeedback = ''; // ملاحظات حول التماسك النصي
//   String clarityFeedback = ''; // ملاحظات حول وضوح الكتابة
//   String repetitionFeedback = ''; // ملاحظات حول التكرار
//   String validityFeedback = ''; // ملاحظات حول صحة الكلمات
//
//   late TextEditingController _controller; // للتحكم في النص المدخل
//   DateTime? startTime; // لتخزين وقت بدء الكتابة
//
//   List<String> suggestedCorrections = []; // قائمة الاقتراحات
//   Timer? _debounce;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//     _loadUserWriting();
//     _checkDarkMode(); // التحقق من وضع المظلم
//   }
//
//   Future<void> _checkDarkMode() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       darkMode = prefs.getBool('darkMode') ?? false;
//     });
//   }
//
//   Future<void> _toggleDarkMode() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       darkMode = !darkMode;
//       prefs.setBool('darkMode', darkMode);
//     });
//   }
//
//   Future<void> _loadUserWriting() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       userWriting = prefs.getString('userWriting') ?? '';
//       _controller.text = userWriting; // تحميل النص في الـ TextField
//       _updateWordCount(userWriting);
//     });
//   }
//
//   Future<void> _saveUserWriting() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('userWriting', userWriting);
//   }
//
//   Future<void> _checkAIWriting() async {
//     setState(() {
//       feedbackMessage = 'Analyzing your writing...'; // إظهار رسالة أثناء التحليل
//     });
//
//     try {
//       String aiFeedback = await analyzeAndCorrectWriting(userWriting);
//       setState(() {
//         feedbackMessage = 'Your writing has been analyzed.';
//         correctedText = aiFeedback;
//       });
//     } catch (e) {
//       setState(() {
//         feedbackMessage = 'Error analyzing the writing. Please try again later.';
//       });
//     }
//   }
//
//   Future<String> analyzeAndCorrectWriting(String text) async {
//     // ميزة: تحليل النص لتحديد الأسلوب، التماسك، الوضوح، التكرار وغيرها
//     return 'Corrected text with detailed corrections.';
//   }
//
//   int _levenshteinDistance(String word1, String word2) {
//     int len1 = word1.length;
//     int len2 = word2.length;
//     List<List<int>> dp = List.generate(len1 + 1, (_) => List.filled(len2 + 1, 0));
//
//     for (int i = 0; i <= len1; i++) {
//       for (int j = 0; j <= len2; j++) {
//         if (i == 0) {
//           dp[i][j] = j; // حذف كل الأحرف في word2
//         } else if (j == 0) {
//           dp[i][j] = i; // حذف كل الأحرف في word1
//         } else if (word1[i - 1] == word2[j - 1]) {
//           dp[i][j] = dp[i - 1][j - 1];
//         } else {
//           dp[i][j] = 1 + [
//             dp[i - 1][j],    // حذف
//             dp[i][j - 1],    // إضافة
//             dp[i - 1][j - 1] // تبديل
//           ].reduce((a, b) => a < b ? a : b);
//         }
//       }
//     }
//
//     return dp[len1][len2];
//   }
//
//   String _suggestCorrection(String word) {
//     List<String> possibleCorrections = [];
//
//     final Set<String> validEnglishWords = Set.from(list_english_words);
//
//     Map<String, int> wordDistances = {};
//
//     for (String validWord in validEnglishWords) {
//       if (_hasThreeCommonLetters(word.toLowerCase(), validWord.toLowerCase())) {
//         int distance = _levenshteinDistance(word.toLowerCase(), validWord.toLowerCase());
//         wordDistances[validWord] = distance;
//       }
//     }
//
//     var sortedCorrections = wordDistances.entries.toList()
//       ..sort((a, b) => a.value.compareTo(b.value));
//
//     possibleCorrections = sortedCorrections.take(10).map((e) => e.key).toList();
//
//     if (possibleCorrections.isNotEmpty) {
//       return possibleCorrections.join(', ');
//     } else {
//       return "لا توجد بدائل متاحة";
//     }
//   }
//
//   bool _hasThreeCommonLetters(String word1, String word2) {
//     int commonLettersCount = 0;
//
//     for (int i = 0; i < word1.length - 2; i++) {
//       String substring = word1.substring(i, i + 3);
//
//       if (word2.contains(substring)) {
//         commonLettersCount++;
//       }
//
//       if (commonLettersCount >= 1) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   void _onWritingChanged(String value) {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       _updateWordCount(value);
//       _analyzeWritingStyle();
//       _analyzeClarity();
//       _analyzeCoherence();
//       _detectRepetition();
//       _checkWordValidity();
//     });
//   }
//
//   void _checkWriting() {
//     if (userWriting.isEmpty) {
//       setState(() {
//         feedbackMessage = 'يرجى كتابة شيء قبل الإرسال.';
//         writingLevel = 'لم يتم التقديم';
//       });
//       return;
//     }
//
//     _checkAIWriting();
//     _analyzeWritingStyle();
//     _analyzeClarity();
//     _analyzeCoherence();
//     _detectRepetition();
//
//     List<String> validWords = SentenceValidator().getValidWords(userWriting);
//     List<String> allWords = userWriting.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();
//
//     int totalWordCount = allWords.length;
//     int validWordCount = validWords.length;
//
//     List<String> incorrectWords = [];
//     Map<String, String> wordCorrections = {};
//
//     allWords.forEach((word) {
//       if (!validWords.contains(word.toLowerCase())) {
//         incorrectWords.add(word);
//         String correctedWord = _suggestCorrection(word);
//         wordCorrections[word] = correctedWord;
//         setState(() {
//           suggestedCorrections = correctedWord.split(', ');
//         });
//       }
//     });
//
//     String incorrectWordsMessage = incorrectWords.isEmpty
//         ? "كل الكلمات صحيحة."
//         : "الكلمات الخاطئة:\n" + incorrectWords.map((word) => '$word -> ${wordCorrections[word]}').join('\n');
//
//     double correctPercentage = (validWordCount / totalWordCount) * 100;
//
//     validityFeedback = 'الكلمات الصحيحة: $validWordCount من أصل $totalWordCount. نسبة الدقة: ${correctPercentage.toStringAsFixed(2)}%.\n\n$incorrectWordsMessage';
//
//     if (validWordCount < 30) {
//       feedbackMessage = 'حاول كتابة 30 كلمة صحيحة على الأقل للحصول على إجابة كاملة.';
//       writingLevel = 'ضعيف';
//     } else if (validWordCount < 50) {
//       feedbackMessage = 'محاولة جيدة! حاول التوسع أكثر للحصول على إجابة أقوى.';
//       writingLevel = 'متوسط';
//     } else {
//       writingLevel = 'ممتاز';
//       feedbackMessage = "لقد حققت هدفك اليومي!";
//       Fluttertoast.showToast(msg: feedbackMessage, backgroundColor: Colors.green);
//     }
//
//     _showFeedbackDialog();
//   }
//
//   void _showFeedbackDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Writing Task Feedback'),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('$feedbackMessage'),
//               SizedBox(height: 10),
//               Text('Your writing level is: $writingLevel', style: TextStyle(fontWeight: FontWeight.bold)),
//               SizedBox(height: 10),
//               Text('Corrected Text:', style: TextStyle(fontWeight: FontWeight.bold)),
//               Text(correctedText.isEmpty ? 'No corrections available.' : correctedText),
//               SizedBox(height: 10),
//               Text('Speed feedback: $speedFeedback', style: TextStyle(color: Colors.blue)),
//               SizedBox(height: 10),
//               Text('Style feedback: $styleFeedback', style: TextStyle(color: Colors.purple)),
//               SizedBox(height: 10),
//               Text('Clarity feedback: $clarityFeedback', style: TextStyle(color: Colors.green)),
//               SizedBox(height: 10),
//               Text('Coherence feedback: $coherenceFeedback', style: TextStyle(color: Colors.orange)),
//               SizedBox(height: 10),
//               Text('Repetition feedback: $repetitionFeedback', style: TextStyle(color: Colors.red)),
//               SizedBox(height: 10),
//               Text('Validity feedback: $validityFeedback', style: TextStyle(color: Colors.teal)),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _updateWordCount(String text) {
//     setState(() {
//       userWriting = text;
//
//       SentenceValidator validator = SentenceValidator();
//       List<String> validWords = validator.getValidWords(userWriting);
//       int validWordCount = validWords.length;
//
//       if (startTime == null) {
//         startTime = DateTime.now();
//       } else {
//         final elapsedTime = DateTime.now().difference(startTime!).inSeconds;
//         final wordsPerMinute = (validWordCount / elapsedTime) * 60;
//         speedFeedback = 'You are writing at a speed of ${wordsPerMinute.toStringAsFixed(1)} words per minute.';
//       }
//
//       if (validWordCount >= targetWords) {
//         Fluttertoast.showToast(msg: "You've reached your daily goal!", backgroundColor: Colors.green);
//       }
//
//       _saveUserWriting();
//     });
//   }
//
//   void _clearText() {
//     setState(() {
//       userWriting = '';
//       _controller.clear();
//       feedbackMessage = '';
//       writingLevel = '';
//       correctedText = '';
//       startTime = null;
//     });
//   }
//
//   void _shareText() {
//     Clipboard.setData(ClipboardData(text: userWriting));
//     Fluttertoast.showToast(msg: "Text copied to clipboard!", backgroundColor: Colors.blue);
//   }
//
//   void _startTimer(int seconds) {
//     if (writingTimer != null) {
//       writingTimer!.cancel();
//     }
//
//     writingTimer = Timer(Duration(seconds: seconds), () {
//       _checkWriting();
//     });
//
//     Fluttertoast.showToast(msg: "Timer set for $seconds seconds", backgroundColor: Colors.blue);
//   }
//
//   void _analyzeWritingStyle() {
//     styleFeedback = 'Your writing style is formal and structured.';
//   }
//
//   void _analyzeClarity() {
//     clarityFeedback = 'Some sentences are complex and could be simplified for better clarity.';
//   }
//
//   void _analyzeCoherence() {
//     coherenceFeedback = 'The ideas in your writing are mostly coherent, but transitions between paragraphs can be improved.';
//   }
//
//   void _detectRepetition() {
//     Map<String, int> wordFrequency = {};
//     List<String> words = userWriting.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();
//
//     words.forEach((word) {
//       wordFrequency[word] = (wordFrequency[word] ?? 0) + 1;
//     });
//
//     repetitionFeedback = '';
//     wordFrequency.forEach((word, count) {
//       if (count > 3) {
//         repetitionFeedback += 'Repetition detected: "$word" is used $count times.\n';
//       }
//     });
//   }
//
//   void _checkWordValidity() {
//     SentenceValidator validator = SentenceValidator();
//     validityFeedback = validator.isValidSentence(userWriting) ? 'الجملة صحيحة.' : 'الجملة تحتوي على كلمات غير صالحة أو مكررة.';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Writing Section'),
//         actions: [
//           IconButton(
//             icon: Icon(darkMode ? Icons.dark_mode : Icons.light_mode),
//             onPressed: _toggleDarkMode,
//           ),
//           IconButton(
//             icon: Icon(Icons.share),
//             onPressed: _shareText,
//           ),
//           IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: _clearText,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Writing Task:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Please write a short paragraph about your favorite hobby and why you enjoy it.',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               maxLines: 5,
//               textAlign: TextAlign.left,
//               textDirection: TextDirection.ltr,
//               controller: _controller,
//               onChanged: _onWritingChanged,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Your Writing',
//                 hintText: 'Start writing your paragraph...',
//               ),
//             ),
//             SizedBox(height: 10),
//             LinearProgressIndicator(
//               value: SentenceValidator().getValidWords(userWriting).length / targetWords,
//               backgroundColor: Colors.grey[300],
//               color: Colors.blue,
//               minHeight: 10,
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Valid word count: ${SentenceValidator().getValidWords(userWriting).length}',
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             ),
//             SizedBox(height: 10),
//             if (suggestedCorrections.isNotEmpty)
//               Wrap(
//                 children: suggestedCorrections
//                     .map((suggestion) => Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: ActionChip(
//                     label: Text(suggestion),
//                     onPressed: () {
//                       setState(() {
//                         userWriting += ' $suggestion';
//                         _controller.text = userWriting;
//                         _updateWordCount(userWriting);
//                       });
//                     },
//                   ),
//                 ))
//                     .toList(),
//               ),
//             SizedBox(height: 10),
//             Text(
//               'Current Level: $writingLevel',
//               style: TextStyle(fontSize: 14, color: Colors.green[600]),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: _checkWriting,
//               icon: Icon(Icons.send),
//               label: Text('Submit Writing'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//             ElevatedButton.icon(
//               onPressed: () => _startTimer(300),
//               icon: Icon(Icons.timer),
//               label: Text('Start 5-min Timer'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//             Spacer(),
//
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SentenceValidator {
//   final Set<String> validEnglishWords = Set.from(list_english_words);
//
//   bool isValidSentence(String? sentence) {
//     if (sentence == null || sentence.isEmpty) return false;
//
//     List<String> words = sentence.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();
//
//     Set<String> uniqueWords = {};
//     for (String word in words) {
//       if (uniqueWords.contains(word)) {
//         return false;
//       }
//       uniqueWords.add(word);
//     }
//
//     return true;
//   }
//
//   List<String> getValidWords(String? sentence) {
//     if (sentence == null || sentence.isEmpty) return [];
//
//     List<String> words = sentence.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();
//
//     return words.where((word) => isEnglishWord(word)).toList();
//   }
//
//   bool isEnglishWord(String word) {
//     return word.length > 1 && validEnglishWords.contains(word.toLowerCase());
//   }
// }
//
