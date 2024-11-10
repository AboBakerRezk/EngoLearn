import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:mushaf25/settings/setting_1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:mushaf25/settings/setting_1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/profile.dart';

mixin AppLocale {

  static const String S1 = 'The application relies on long-term learning, unlike all applications that rely on rapid learning. The learning path will be from 9 months to a year, with a little learning per day to ensure continuity. Studies indicate that rapid learning often leads to a loss of 70- 80% of the information in a few days because there is not enough time for consolidation and practical application, which makes learners less able to use the skills in real-life situations (Mango Languages).';
  static const String S2 = 'English Learning Goal';
  static const String S3 = 'Educational Level';
  static const String S4 = 'You must choose';
  static const String S5 = 'You must select at least one goal.';
  static const String S6 = 'Memory Type';
  static const String S7 = 'Visual Memory';
  static const String S8 = 'Visual';
  static const String S9 = 'Auditory Memory';
  static const String S10 = 'Auditory';
  static const String S11 = 'You must select a memory type.';
  static const String S12 = 'No Qualification';
  static const String S13 = 'High School';
  static const String S14 = 'Bachelor’s Degree';
  static const String S15 = 'Master’s Degree';
  static const String S16 = 'PhD';
  static const String S17 = 'Age must be between 10 and 60.';
  static const String S18 = 'Name must be at least 3 letters.';
  static const String S19 = 'Name must not exceed 15 words.';
  static const String S20 = 'Name:';
  static const String S21 = 'English Learning Goal:';
  static const String S22 = 'Educational Level:';
  static const String S23 = 'Memory Type:';
  static const String S24 = 'Developer: Abu Bakr';
  static const String S25 = 'We develop the app daily, if you encounter any issues, don\'t hesitate to contact us.';
  static const String S26 = 'Track Your Progress';
  static const String S27 = 'Exercises';
  static const String S28 = 'Path';
  static const String S29 = 'Profile';
  static const String S30 = 'Lesson';
  static const String S31 = 'next';

  static const String S32 = 'Grammar';
  static const String S33 = 'Reading';
  static const String S34 = 'Listening';
  static const String S35 = 'Writing';
  static const String S36 = 'Progress';
  static const String S37 = 'Name';
  static const String S38 = 'Age';
  static const String S39 = 'Save';
  static const String S40 = 'Personal Interest';
  static const String S41 = 'No Qualification';
  static const String S42 = 'High School';
  static const String S43 = 'Bachelor’s Degree';
  static const String S44 = 'Master’s Degree';
  static const String S45 = 'PhD';
  static const String S46 = 'Male';
  static const String S47 = 'Female';
  static const String S48 = 'Visual Memory';
  static const String S49 = 'Auditory Memory';
  static const String S50 = 'Beginner';
  static const String S51 = 'Intermediate';
  static const String S52 = 'Advanced';
  static const String S53 = 'Fight for a dream that still hangs between success or failure.';
  static const String S54 = 'Vocabulary';
  static const String Ss54 = 'Vocabulary(difficult)';
  static const String S55 = 'Grammar';
  static const String S56 = 'Sentences';
  static const String S57 = 'Exercises';
  static const String S58 = 'Your Score';
  static const String S59 = 'Retry';
  static const String S60 = 'Wrong! The correct answer is';
  static const String S61 = 'You have completed all tests! Start again!';
  static const String S62 = 'Word Test';
  static const String S63 = 'Choose the correct word to complete the sentence:';
  static const String S64 = 'Question';
  static const String S65 = 'Correct';
  static const String S66 = 'Try Again';
  static const String S67 = 'The journey of a thousand miles begins with a single step.';
  static const String S68 = 'Sentences and Instructions';
  static const String S69 = 'Interactive Stories';
  static const String S70 = 'Tests';
  static const String S71 = 'Coming soon: Reading';
  static const String S72 = 'Coming soon: Listening';
  static const String S73 = 'Story';
  static const String S74 = 'Practice';
  static const String S75_test = 'Test';
  static const String S75_travel = 'Travel';
  static const String S75_work = 'Work';
  static const String S75_study = 'Study';
  static const String S76 = 'Gender';
  static const String S77 = 'Memory Type';
  static const String S78 = 'Vocabulary';
  static const String S79 = 'game';
  static const String S80 = 'translation';
  static const String Ss80 = 'translation(difficult)';
  static const String S81 = 'Game Over';
  static const String S82 = 'Final Score';
  static const String S83 = 'Final Level';
  static const String S84 = 'Replay';
  static const String S85 = 'Fill-in-the-Blanks Game';
  static const String S86 = 'Current Level';
  static const String S87 = 'Score';
  static const String S88 = 'Choose the correct word game';
  static const String S89 = 'Choose the correct word';
  static const String S90 = 'Time remaining';
  static const String S91 = 'Seconds';
  static const String S92 = 'Highest score';
  static const String S93 = 'Close';
  static const String S94 = 'Fill in the Blanks';
  static const String S95 = 'Complete the sentence:';
  static const String S96 = 'Score';
  static const String S97 = 'Game Over';
  static const String S98 = 'Your score:';
  static const String Ss98 = 'Level reached:';
  static const String S99 = 'Restart';
  static const String S100 = 'Next';
  static const String S101 = 'Word-to-Image Matching Game';
  static const String S102 = 'Choose the correct word for the image';
  static const String S103 = 'Points';
  static const String S104 = 'Guess game';
  static const String S105 = 'Write the correct word here';
  static const String S106 = 'Correct answer!';
  static const String S107 = 'Wrong answer!';
  static const String S108 = 'Letter Arrangement Game';
  static const String S109 = 'Arrange the letters to form the correct word:';
  static const String S110 = 'Guessing Game';
  static const String S111 = 'Easy';
  static const String S112 = 'Medium';
  static const String S113 = 'Hard';
  static const String S114 = 'Memory';
  static const String S115 = 'correction';
  static const String S116 = 'Quick Match';
  static const String S117 = 'Connecting';
  static const String S118 = 'Listen';
 // static const String S119 = "Advanced";
  static const String S120 = "reading";
  static const String S121 = "listen";
  static const String S122 = "Interactive stories";
  static const String S123 = "Tests";
  static const String S124 = "Formation of sentences";
  static const String S125 = "Speaking";
  static const String S126 = "Word bank";
  static const String S127 = "Explanation of words";
  static const String S128 = "Companion";
  static const String S129 = "You";
  static const String S130 = "Voice recognition not available";
  static const String S131 = "Processing...";
  static const String S132 = "Error getting response. Try again.";
  static const String S133 = "API connection failed";
  static const String S134 = "The text has been copied to the clipboard";
  static const String S135 = "The file has been downloaded successfully";
  static const String S136 = "Error downloading file:";
  static const String S137 = "Congrats! I achieved 100 points in grammar.";
  static const String S138 = "amazing! You have completed 50 lessons.";
  static const String S139 = "excellent! I spent 20 hours studying.";
  static const String S140 = "I did well! You achieved 80 points in listening.";
  static const String S141 = "amazing! I achieved 70 points in speaking.";
  static const String S142 = "Congrats! I achieved 90 points in reading.";
  static const String S143 = "I did well! I achieved 60 points in writing.";
  static const String S144 = "excellent! I have completed 40 exercises.";
  static const String S145 = "amazing! I made 30 sentences.";
  static const String S146 = "Congrats! You have collected 1000 points in games.";
  static const String S147 = "Congratulations! You have reached the level";
  static const String S148 = "In reading.";
  static const String S149 = "Notification permission denied";
  static const String S150 = "To receive notifications about your progress, please allow notifications in the app settings.";
  static const String S151 = "cancellation";
  static const String S152 = "Settings";
  static const String S153 = "Remember to review the new words today!";
  static const String S154 = "Be sure to check out everything you learned this week!";
  static const String S155 = "In reading.";
  static const String S156 = "In reading.";



  static const Map<String, dynamic> EN = {
    S1: 'The application relies on long-term learning, unlike all applications that rely on rapid learning. The learning path will be from 9 months to a year, with a little learning per day to ensure continuity. Studies indicate that rapid learning often leads to a loss of 70- 80% of the information in a few days because there is not enough time for consolidation and practical application, which makes learners less able to use the skills in real-life situations (Mango Languages).',
    S2: 'English Learning Goal',
    S3: 'Educational Level',
    S4: 'You must choose',
    S5: 'You must select at least one goal.',
    S6: 'Memory Type',
    S7: 'Visual Memory',
    S8: 'Visual',
    S9: 'Auditory Memory',
    S10: 'Auditory',
    S11: 'You must select a memory type.',
    S12: 'No Qualification',
    S13: 'High School',
    S14: 'Bachelor’s Degree',
    S15: 'Master’s Degree',
    S16: 'PhD',
    S17: 'Age must be between 10 and 60.',
    S18: 'Name must be at least 3 letters.',
    S19: 'Name must not exceed 15 words.',
    S20: 'Name:',
    S21: 'English Learning Goal:',
    S22: 'Educational Level:',
    S23: 'Memory Type:',
    S24: 'Developer: Abu Bakr',
    S25: 'We develop the app daily, if you encounter any issues, don\'t hesitate to contact us.',
    S26: 'Track Your Progress',
    S27: 'Exercises',
    S28: 'Path',
    S29: 'Profile',
    S30: 'Lesson',
    S31: 'next',
    S32: 'Grammar',
    S33: 'Reading',
    S34: 'Listening',
    S35: 'Writing',
    S36: 'Progress',
    S37: 'Name',
    S38: 'Age',
    S39: 'Save',
    S40: 'Personal Interest',
    S46: 'Male',
    S47: 'Female',
    S50: 'Beginner',
    S51: 'Intermediate',
    S52: 'Advanced',
    S53: 'Fight for a dream that still hangs between success or failure.',
    S54: 'Vocabulary',
    Ss54: 'Vocabulary(difficult)',
    S56: 'Sentences',
    S58: 'Your Score',
    S59: 'Retry',
    S60: 'Wrong! The correct answer is',
    S61: 'You have completed all tests! Start again!',
    S62: 'Word Test',
    S63: 'Choose the correct word to complete the sentence:',
    S64: 'Question',
    S65: 'Correct',
    S66: 'Try Again',
    S67: 'The journey of a thousand miles begins with a single step.',
    S68: 'Sentences and Instructions',
    S69: 'Interactive Stories',
    S70: 'Tests',
    S71: 'Coming soon: Reading',
    S72: 'Coming soon: Listening',
    S73: 'Story',
    S74: 'Practice',
    S75_test: 'Test',
    S75_travel: 'Travel',
    S75_work: 'Work',
    S75_study: 'Study',
    S76: 'Gender',
    S79: 'Game',
    S80: 'translation',
    Ss80: 'translation(difficult)',
    S81: 'Game Over',
    S82: 'Final Score',
    S83: 'Final Level',
    S84: 'Replay',
    S85: 'Fill-in-the-Blanks Game',
    S86: 'Current Level',
    S87: 'Score',
    S88: 'Choose the correct word game',
    S89: 'Choose the correct word',
    S90: 'Time remaining',
    S91: 'Seconds',
    S92: 'Highest score',
    S93: 'Close',
    S94: 'Fill in the Blanks',
    S95: 'Complete the sentence:',
    S98: 'Your score:',
    Ss98: 'Level reached::',
    S99: 'Restart',
    S100: 'Next',
    S101: 'Word-to-Image Matching Game',
    S102: 'Choose the correct word for the image',
    S103: 'Points',
    S104: 'Guess game',
    S105: 'Write the correct word here',
    S106: 'Correct answer!',
    S107: 'Incorrect answer!',
    S108: 'Letter Arrangement Game',
    S109: 'Arrange the letters to form the correct word:',
    S110: 'Guessing Game',
    S111: 'Easy',
    S112: 'Medium',
    S113: 'Hard',
    S114: 'Memory',
    S115: 'correction',
    S116: 'Quick Match',
    S117: 'Connecting',
    S118: 'Listen',
    //S119: "Advanced",
    S120: "reading.",
    S121: "listen",
    S122: "Interactive stories",
    S124: "Formation of sentences",
    S125: "Speaking",
    S126: "Word bank",
    S127: "Explanation of words",
    S128: "Companion",
    S129: "You",

  };

  static const Map<String, dynamic> AR = {
    S1: 'التطبيق يعتمد على التعلم طويل الأمد، على عكس جميع التطبيقات التي تعتمد على التعلم السريع. ستكون مدة مسار التعلم من 9 أشهر إلى سنة، مع تعلم قليل كل يوم لضمان الاستمرارية. تشير الدراسات إلى أن التعلم السريع غالبًا ما يؤدي إلى فقدان 70-80% من المعلومات خلال أيام قليلة بسبب عدم توفر الوقت الكافي للترسيخ والتطبيق العملي، مما يجعل المتعلمين أقل قدرة على استخدام المهارات في المواقف الواقعية (Mango Languages).',
    S2: 'هدف تعلم اللغة الإنجليزية',
    S3: 'المستوى التعليمي',
    S4: 'يجب أن تختار',
    S5: 'يجب أن تختار هدفًا واحدًا على الأقل.',
    S6: 'نوع الذاكرة',
    S7: 'ذاكرة بصرية',
    S8: 'بصري',
    S9: 'ذاكرة سمعية',
    S10: 'سمعي',
    S11: 'يجب أن تختار نوع الذاكرة.',
    S12: 'بدون مؤهل',
    S13: 'الثانوية العامة',
    S14: 'درجة البكالوريوس',
    S15: 'درجة الماجستير',
    S16: 'دكتوراه',
    S17: 'يجب أن يكون العمر بين 10 و 60 عامًا.',
    S18: 'يجب أن يحتوي الاسم على 3 أحرف على الأقل.',
    S19: 'يجب ألا يتجاوز الاسم 15 كلمة.',
    S20: 'الاسم:',
    S21: 'هدف تعلم اللغة الإنجليزية:',
    S22: 'المستوى التعليمي:',
    S23: 'نوع الذاكرة:',
    S24: 'المطور: أبو بكر',
    S25: 'نقوم بتطوير التطبيق يوميًا، إذا واجهت أي مشاكل، لا تتردد في الاتصال بنا.',
    S26: 'تابع تقدمك',
    S27: 'التمارين',
    S28: 'المسار',
    S29: 'الملف الشخصي',
    S30: 'الدرس',
    S31: 'التالي',
    S32: 'القواعد',
    S33: 'القراءة',
    S34: 'الاستماع',
    S35: 'الكتابة',
    S36: 'التقدم',
    S37: 'الاسم',
    S38: 'العمر',
    S39: 'حفظ',
    S40: 'الاهتمام الشخصي',
    S46: 'ذكر',
    S47: 'أنثى',
    S50: 'مبتدئ',
    S51: 'متوسط',
    S52: 'متقدم',
    S53: 'وَحَارِبْ لِحُلْمٍ مَا يَزَالُ عَالِقًا بَيْنَ النَّجَاحِ أَوْ أَنْ يَبُوءَ بِالفَشَل',
    S54: 'المفردات',
    Ss54: '(صعب)المفردات',
    S56: 'الجمل',
    S58: 'نتيجتك',
    S59: 'إعادة المحاولة',
    S60: 'خطأ! الإجابة الصحيحة هي',
    S61: 'لقد أكملت جميع الاختبارات! ابدأ من جديد!',
    S62: 'اختبار الكلمات',
    S63: 'اختر الكلمة الصحيحة لإكمال الجملة:',
    S64: 'السؤال',
    S65: 'صحيح',
    S66: 'أعد المحاولة',
    S67: 'رحلة الألف ميل تبدأ بخطوة واحدة.',
    S68: 'الجمل والتعليمات',
    S69: 'قصص تفاعلية',
    S70: 'الاختبارات',
    S71: 'قريبًا: القراءة',
    S72: 'قريبًا: الاستماع',
    S73: 'القصة',
    S74: 'التدرب',
    S75_test: 'الاختبار',
    S75_travel: 'السفر',
    S75_work: 'العمل',
    S75_study: 'الدراسة',
    S76: 'النوع',
    S79: 'العاب',
    S80: 'ترجمة',
    Ss80: '(صعب)ترجمة',
    S81: 'انتهت اللعبة',
    S82: 'النقاط النهائية',
    S83: 'المستوى النهائي',
    S84: 'إعادة اللعب',
    S85: 'لعبة ملء الفراغات',
    S86: 'المستوى الحالي',
    S87: 'النقاط',
    S88: 'لعبة اختيار الكلمة الصحيحة',
    S89: 'اختر الكلمة الصحيحة',
    S90: 'الوقت المتبقي',
    S91: 'ثانية',
    S92: 'أعلى نتيجة',
    S93: 'أغلق',
    S94: 'املأ الفراغات',
    S95: 'أكمل الجملة:',
    S98: 'نتيجتك:',
    Ss98: 'المستوى الذي وصلت إليه:',
    S99: 'إعادة التشغيل',
    S100: 'التالي',
    S101: 'لعبة مطابقة الكلمة بالصورة',
    S102: 'اختر الكلمة الصحيحة للصورة',
    S103: 'النقاط',
    S104: ' لعبة  خمن',
    S105: ' اكتب الكلمة الصحيحة هنا',
    S106: ' إجابة صحيحة!',
    S107: ' إجابة خاطئة!',
    S108: ' لعبة ترتيب الحروف',
    S109: ' رتب الحروف لتكوين الكلمة الصحيحة:',
    S111: ' سهل',
    S112: 'متوسط',
    S113: 'صعب',
    S114: 'الذاكره',
    S115: 'التصويب',
    S116: 'لعبة الجمع السريع ',
    S117: 'التوصيل ',
    S118: 'استماع ',
   // S119: 'متقدم',
    S120: 'قرائة',
    S121: 'استماع',
    S122: 'قصص تفاعلية',
    S124: 'تكوين جمل',
    S125: 'التحدث',
    S126: 'بنك الكلمات',
    S127: 'شرح الكلمات',
    S128: 'رفيق',
    S129: 'انت',



  };
}


class MyApp3 extends StatefulWidget {
  const MyApp3({super.key});

  @override
  State<MyApp3> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp3> {
  final FlutterLocalization _localization = FlutterLocalization.instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  double _opacity = 0.0;



  void _animateText() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  void initState() {
    _animateText();

    _loadSavedLanguagePreference();
    _localization.init(
      mapLocales: [
        const MapLocale(
          'en',
          AppLocale.EN,
        ),
        const MapLocale(
          'ar',
          AppLocale.AR,
        ),

      ],
      initLanguageCode: 'ar',
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  void _loadSavedLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguageCode = prefs.getString('languageCode');
    if (savedLanguageCode != null) {
      _localization.translate(savedLanguageCode);
    }
  }

  void _saveLanguagePreference(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      supportedLocales: _localization.supportedLocales,
      localizationsDelegates: _localization.localizationsDelegates,
      home: const SettingsScreen(),
      theme: ThemeData(fontFamily: _localization.fontFamily),
    );
  }
}


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static String id = 'SettingsScreen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FlutterLocalization _localization = FlutterLocalization.instance;
  bool isLanguageSelected = false;
  double _opacity = 0.0;
  String _savedText = "";

  @override
  void initState() {
    super.initState();
    _animateText();
    _loadSavedChat(); // تحميل الدردشة المحفوظة عند بدء التطبيق
  }

  // وظيفة لتحريك النص
  void _animateText() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  // وظيفة لتحديث اللغة المختارة
  void _updateAppLanguage(String languageCode) {
    _localization.translate(languageCode);
    setState(() {
      isLanguageSelected = true;
    });
  }

  // وظيفة لحفظ النص في Shared Preferences
  Future<void> _saveChat(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_chat', text);
    setState(() {
      _savedText = text;
    });
  }

  // وظيفة لتحميل الدردشة المحفوظة من Shared Preferences
  Future<void> _loadSavedChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedText = prefs.getString('saved_chat') ?? "";
    });
  }

  // وظيفة لحذف الدردشة المحفوظة
  Future<void> _deleteChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_chat');
    setState(() {
      _savedText = "";
    });
  }

  // إنشاء الأزرار للغات
  Widget _buildLanguageButton(String languageName, String languageCode) {
    return ElevatedButton(
      onPressed: () {
        _updateAppLanguage(languageCode);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF13194E),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: Text(
        languageName,
        style: TextStyle(
          fontSize: 28,
          color: Colors.white,
        ),
      ),
    );
  }

  // بناء جسم الصفحة
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF13194E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLanguageButton('عربي', 'ar'),
                SizedBox(width: 20),
                _buildLanguageButton('English', 'en'),
              ],
            ),
            Spacer(),
            _buildAnimatedText(),
            Spacer(),
            _buildNextButton(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // وظيفة لإنشاء النص المتحرك
  Widget _buildAnimatedText() {
    return Center(
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(seconds: 2),
        child: Text(
          "${AppLocale.S1.getString(context)}",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // وظيفة لإنشاء زر "Next"
  Widget _buildNextButton() {
    return Center(
      child: TextButton(
        onPressed: isLanguageSelected
            ? () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserProfileForm()),
          );
        }
            : null,
        child: Text(
          'Next',
          style: TextStyle(
            fontSize: 25,
            color: isLanguageSelected ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }

  // بناء الأزرار الخاصة بالميزات
}

    // تفعيل الزر حسب اختي
