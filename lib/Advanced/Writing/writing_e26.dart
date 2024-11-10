import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:list_english_words/list_english_words.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WritingSections26 extends StatefulWidget {
  @override
  _WritingSections26State createState() => _WritingSections26State();
}

class _WritingSections26State extends State<WritingSections26> {
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
  String title = 'The Balance Between Career and Personal Life'; // عنوان القصة باللغة العربية
  String titleFeedback = ''; // ملاحظات حول تطابق القصة مع العنوان
  double titleMatchPercentage = 0.0; // نسبة تطابق النص مع العنوان
  double wordMatchPercentage = 0.0; // نسبة تطابق الكلمات

  // قائمة بالكلمات المتعلقة بالعنوان لتقييم المطابقة باللغة العربية
  List<String> relatedWords = [
    'work-life balance', 'priorities', 'time management', 'boundaries', 'fulfillment', 'stress',
    'well-being', 'productivity', 'harmony', 'flexibility', 'commitment', 'relationships',
    'self-care', 'satisfaction', 'goals', 'responsibilities', 'leisure', 'personal growth',
    'family', 'career development', 'mindfulness', 'awareness', 'planning', 'commitment',
    'adaptability', 'success', 'health', 'focus', 'support', 'values', 'integration',
    'emotional health', 'nurturing', 'sacrifice', 'connection', 'balance', 'time allocation',
    'organization', 'stress management', 'decision-making', 'perspective', 'motivation',
    'reflection', 'self-discipline', 'resilience', 'sustainability', 'purpose', 'engagement'
  ];




  late TextEditingController _controller; // للتحكم في النص المدخل
  DateTime? startTime; // لتخزين وقت بدء الكتابة

  List<String> suggestedCorrections = []; // قائمة الاقتراحات
  List<String> feedbackList = []; // قائمة ملاحظات الكتابة
  Timer? _debounce;

  final Color primaryColor = Color(0xFF13194E); // اللون الأساسي للتصميم

  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int speakingProgressLevel = 0; // New variable for Speaking
  int bottleFillLevel = 0;

  // دالة لتحميل البيانات المحفوظة من SharedPreferences
  Future<void> loadSavedProgressData() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    setState(() {
      readingProgressLevel = sharedPreferencesInstance.getInt('progressReading') ?? 0;
      listeningProgressLevel = sharedPreferencesInstance.getInt('progressListening') ?? 0;
      writingProgressLevel = sharedPreferencesInstance.getInt('progressWriting') ?? 0;
      grammarProgressLevel = sharedPreferencesInstance.getInt('progressGrammar') ?? 0;
      speakingProgressLevel = sharedPreferencesInstance.getInt('progressSpeaking') ?? 0; // Load Speaking
      bottleFillLevel = sharedPreferencesInstance.getInt('bottleLevel') ?? 0;
    });
  }

  // دالة لحفظ البيانات إلى SharedPreferences
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    await sharedPreferencesInstance.setInt('progressReading', readingProgressLevel);
    await sharedPreferencesInstance.setInt('progressListening', listeningProgressLevel);
    await sharedPreferencesInstance.setInt('progressWriting', writingProgressLevel);
    await sharedPreferencesInstance.setInt('progressGrammar', grammarProgressLevel);
    await sharedPreferencesInstance.setInt('progressSpeaking', speakingProgressLevel); // Save Speaking
    await sharedPreferencesInstance.setInt('bottleLevel', bottleFillLevel);
  }
  double writingPoints = 0;
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
        speedFeedback =
        'أنت تكتب بسرعة ${wordsPerMinute.toStringAsFixed(1)} كلمة في الدقيقة.';
      }

      if (validWordCount >= targetWords) {
        Fluttertoast.showToast(
            msg: "لقد وصلت إلى هدفك اليومي!", backgroundColor: Colors.green);
        _increaseWritingPoints(10); // زيادة نقاط الكتابة بمقدار 10
      }

      _saveUserWriting();
    });
  }

  void _increaseWritingPoints(double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      writingPoints += amount;
      prefs.setDouble('writingPoints', writingPoints);
    });
  }

  Future<void> _loadWritingPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      writingPoints = prefs.getDouble('writingPoints') ?? 0;
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    _saveWritingPoints();
    super.dispose();
  }

  Future<void> _saveWritingPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('writingPoints', writingPoints);
  }
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadUserWriting();
    _checkDarkMode(); // التحقق من وضع المظلم
    _loadWritingPoints(); // تحميل نقاط الكتابة
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

  int targetWords2 = 1000; // الحد الأقصى لعدد الكلمات
  List<String> _suggestCorrectWords(String word, {int maxDistance = 2}) {
    if (word.isEmpty) {
      return []; // إذا كانت الكلمة فارغة، نعيد قائمة فارغة
    }

    // تحويل الكلمة إلى أحرف صغيرة للتأكد من أن المقارنة غير حساسة لحالة الأحرف
    String wordLower = word.toLowerCase();

    // الحصول على الحرف الأول من الكلمة
    String firstLetter = wordLower[0];

    // دالة للحصول على كل مجموعات الحروف الثلاثية من الكلمة
    List<String> _getTrigrams(String word) {
      List<String> trigrams = [];
      for (int i = 0; i <= word.length - 3; i++) {
        trigrams.add(word.substring(i, i + 3));
      }
      return trigrams;
    }

    // نحصل على كل التريجرامات (مجموعات الحروف الثلاثية) من الكلمة المدخلة
    List<String> trigrams = _getTrigrams(wordLower);

    // نبحث عن الكلمات التي تحتوي على أي مجموعة من الثلاث حروف المتتالية وتبدأ بنفس الحرف الأول
    Set<String> candidateWords = list_english_words.where((w) {
      String wLower = w.toLowerCase();
      return wLower.startsWith(firstLetter) && trigrams.any((tri) => wLower.contains(tri));
    }).toSet();

    // إذا كانت القائمة فارغة بعد الفلترة، نعيد الكلمة الأصلية
    if (candidateWords.isEmpty) {
      return [word];
    }

    // حساب مسافة Levenshtein لكل كلمة تحتوي على ثلاث حروف متتالية وتبدأ بنفس الحرف
    List<Map<String, dynamic>> distances = candidateWords
        .map((w) => {
      'word': w,
      'distance': _levenshteinDistance(w.toLowerCase(), wordLower)
    })
        .toList();

    // نرتب القائمة بناءً على مسافة Levenshtein تصاعديًا
    distances.sort((a, b) => a['distance'].compareTo(b['distance']));

    // نأخذ الكلمات ذات أقل مسافة (مثلاً مسافة أقل من أو تساوي maxDistance)
    List<String> similarWords = distances
        .where((entry) => entry['distance'] <= maxDistance)
        .take(6) // نأخذ 6 اقتراحات
        .map((entry) => entry['word'] as String)
        .toList();

    // نعيد قائمة الاقتراحات، وإذا لم نجد اقتراحات، نعيد قائمة تحتوي على الكلمة الأصلية
    return similarWords.isNotEmpty ? similarWords : [word];
  }

// دالة لحساب Levenshtein Distance بين كلمتين
  int _levenshteinDistance(String s1, String s2) {
    int len1 = s1.length;
    int len2 = s2.length;

    List<List<int>> dp = List.generate(len1 + 1, (_) => List.filled(len2 + 1, 0));

    for (int i = 0; i <= len1; i++) {
      dp[i][0] = i;
    }
    for (int j = 0; j <= len2; j++) {
      dp[0][j] = j;
    }

    for (int i = 1; i <= len1; i++) {
      for (int j = 1; j <= len2; j++) {
        int cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        dp[i][j] = [
          dp[i - 1][j] + 1,    // حذف
          dp[i][j - 1] + 1,    // إضافة
          dp[i - 1][j - 1] + cost // استبدال
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return dp[len1][len2];
  }

  void _onWritingChanged(String value) {
    List<String> words = value.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();

    if (words.length > targetWords2) {
      Fluttertoast.showToast(
          msg: "لقد تجاوزت الحد المسموح به لعدد الكلمات (${targetWords2} كلمة)!",
          backgroundColor: Colors.red
      );
      _controller.text = words.take(targetWords2).join(" ");
      _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
    } else {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        setState(() {

          userWriting = value;
          _checkTitleMatch();
          _checkWordMatch();
          _updateWordCount(value);
          _analyzeWritingStyle();
          _analyzeClarity();
          _analyzeCoherence();
          _detectRepetition();
          _checkWordValidity();

          // تحديث قائمة الملاحظات
          feedbackList = [
            'سرعة الكتابة: $speedFeedback',
            'ملاحظات الأسلوب: $styleFeedback',
            'وضوح الكتابة: $clarityFeedback',
            'تماسك النص: $coherenceFeedback',
            'ملاحظات التكرار: $repetitionFeedback',
            'صحة الكلمات: $validityFeedback',
          ];

          // هنا نقوم بالتحقق من صحة الكلمات وعرض الاقتراحات
          suggestedCorrections.clear();
          for (String word in words) {
            if (!SentenceValidators().isEnglishWord(word)) {
              List<String> corrections = _suggestCorrectWords(word); // اقتراح عدة كلمات
              suggestedCorrections.addAll(corrections); // إضافة كل الكلمات المقترحة
            }
          }
        });
      });
    }
  }
  void _checkTitleMatch() {
    // حساب نسبة الكلمات المشتركة بين العنوان والنص
    List<String> userWords = userWriting.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();
    int matchingWords = userWords.where((word) => title.contains(word)).length;

    titleMatchPercentage = (matchingWords / title.split(' ').length) * 100;

    if (titleMatchPercentage > 50) {
      titleFeedback = 'القصة مطابقة للعنوان بنسبة $titleMatchPercentage%.';
    } else {
      titleFeedback = 'القصة لا تطابق العنوان بشكل كافٍ. النسبة: $titleMatchPercentage%.';
    }
  }

  void _checkWordMatch() {
    // Split the user writing into words and count how many match the relatedWords list
    List<String> userWords = userWriting.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();
    int matchingWords = userWords.where((word) => relatedWords.contains(word)).length;

    // Calculate word match percentage based on the number of matching words
    if (matchingWords >= 30) {
      wordMatchPercentage = 100.0; // 100% if there are 30 or more matching words
    } else if (matchingWords >= 20) {
      wordMatchPercentage = 50.0; // 50% if there are 20 matching words
    } else {
      wordMatchPercentage = (matchingWords / 30) * 100; // Adjust percentage based on the total number of words
    }

    setState(() {
      wordMatchPercentage = wordMatchPercentage; // Update the UI with the match percentage
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
    Fluttertoast.showToast(msg: "تم نسخ النص إلى الحافظة!", backgroundColor: Colors.blue);
  }

  void _analyzeWritingStyle() {
    styleFeedback = 'أسلوب الكتابة رسمي ومنظم.'; // تخصيص هذه بناءً على التحليل
  }

  void _analyzeClarity() {
    clarityFeedback =
    'بعض الجمل معقدة ويمكن تبسيطها لتحسين الوضوح.'; // تخصيص هذه بناءً على التحليل
  }

  void _analyzeCoherence() {
    coherenceFeedback =
    'الأفكار في كتابتك متماسكة بشكل عام، ولكن يمكن تحسين الانتقالات بين الفقرات.'; // تخصيص هذه بناءً على التحليل
  }

  void _detectRepetition() {
    Map<String, int> wordFrequency = {};
    List<String> words = userWriting
        .split(RegExp(r'[\s,.!?]+'))
        .where((word) => word.isNotEmpty)
        .toList();

    words.forEach((word) {
      wordFrequency[word] = (wordFrequency[word] ?? 0) + 1;
    });

    repetitionFeedback = '';
    wordFrequency.forEach((word, count) {
      if (count > 3) {
        repetitionFeedback += 'تم اكتشاف التكرار: "$word" تم استخدامه $count مرات.\n';
      }
    });
  }

  void _checkWordValidity() {
    SentenceValidators validator = SentenceValidators();
    validityFeedback = validator.isValidSentence(userWriting)
        ? 'الجملة صحيحة.'
        : 'الجملة تحتوي على كلمات غير صالحة أو مكررة.';
  }

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'عنوان القصة: $title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
                  labelText: 'اكتب قصتك هنا',
                  hintText: 'ابدأ بكتابة القصة المتعلقة بالعنوان...',
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
                'عدد الكلمات الصالحة: ${SentenceValidators().getValidWords(userWriting).length}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 10),
              Text(
                titleFeedback,
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              SizedBox(height: 10),
              Text(
                'نسبة تطابق الكلمات مع الموضوع: $wordMatchPercentage%',
                style: TextStyle(fontSize: 16, color: Colors.green),
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
                'المستوى الحالي: $writingLevel',
                style: TextStyle(fontSize: 14, color: Colors.green[600]),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: feedbackList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(feedbackList[index], style: TextStyle(color: Colors.white)),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class SentenceValidators {
  final Set<String> validEnglishWords =
  Set.from(list_english_words); // استبدل بالقائمة الفعلية لديك

  bool isValidSentence(String? sentence) {
    if (sentence == null || sentence.isEmpty) return false;

    List<String> words =
    sentence.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();

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

    List<String> words =
    sentence.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();

    return words.where((word) => isEnglishWord(word)).toList();
  }

  bool isEnglishWord(String word) {
    return word.length > 1 && validEnglishWords.contains(word.toLowerCase());
  }
}
