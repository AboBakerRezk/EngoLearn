import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


import 'package:http/http.dart' as http;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mushaf25/Foundational_lessons/Games/homes_Games/game_26.dart';
import 'package:mushaf25/provider/provider.dart';
import 'package:mushaf25/Pages/lang.dart';
import 'package:mushaf25/Pages/profile.dart';
import 'package:mushaf25/Pages/qu.dart';
import 'package:mushaf25/settings/setting_2.dart';
import 'package:mushaf25/Advanced/Speaking/Speak_1.dart';
import 'package:mushaf25/Advanced/Speaking/Speak_11.dart';
import 'package:mushaf25/Advanced/Speaking/Speak_4.dart';
import 'package:mushaf25/Advanced/Speaking/Speak_6.dart';
import 'package:mushaf25/Advanced/Speaking/Speak_hom.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:typewritertext/typewritertext.dart';

import 'Advanced/Listening/hom_listen.dart';
import 'Advanced/Listening/listen_e.dart';
import 'Advanced/Listening/listen_e2.dart';
import 'Advanced/Writing/writing_e1.dart';
import 'Advanced/Writing/writing_e11.dart';
import 'Advanced/Writing/writing_e12.dart';
import 'Advanced/Writing/writing_e21.dart';
import 'Advanced/Writing/writing_e31.dart';
import 'Advanced/Writing/writing_e9.dart';
import 'Foundational_lessons/Difficult_translation/Tutorial_24.dart';
import 'Advanced_exercises/Tests/quis_22.dart';
import 'Advanced_exercises/Tests/quis_home.dart';

import 'Advanced_exercises/tamarin120.dart';
import 'Foundational_lessons/Explanation_of_words/Explanation_of_words_1.dart';
import 'Foundational_lessons/Explanation_of_words/Explanation_of_words_2.dart';
import 'Foundational_lessons/Explanation_of_words/Explanation_of_words_3.dart';
import 'Foundational_lessons/Explanation_of_words/Explanation_of_words_6.dart';
import 'Foundational_lessons/Games/Correction/Correction_1.dart';
import 'Foundational_lessons/Games/Difficult_translation/Difficult_translation_1.dart';
import 'Foundational_lessons/Games/Fill_in_the_blanks/Fill_in_the_blanks_1.dart';
import 'Foundational_lessons/Games/Guess/Guess_1.dart';
import 'Foundational_lessons/Games/Listening/Listening_1.dart';
import 'Foundational_lessons/Games/Matching/Matching_1.dart';
import 'Foundational_lessons/Games/Memory/Memory_1.dart';
import 'Foundational_lessons/Games/homes_Games/game_1.dart';
import 'Foundational_lessons/Games/homes_Games/game_25.dart';
import 'Foundational_lessons/Games/the order of letters/the order of letters_1.dart';
import 'Foundational_lessons/Review.dart';
import 'Robot_chat.dart';
import 'control/AI/Ropot.dart';
import 'Pages/Introduction_to_the_app/intro.dart';
import 'control/AI/Ropot_2.dart';
import 'control/AI/analysis.dart';
import 'hom.dart';
import 'home_pay.dart';
import 'old_code.dart';
import 'package:google_generative_ai/google_generative_ai.dart' as google;
import 'package:speech_to_text/speech_to_text.dart' as stt;

// await Purchases.setDebugLogsEnabled(true);  // لتمكين تسجيل الدخول
// await Purchases.setup("api_public_key_from_revenuecat");
// تشغيل التطبيق مع توفير BlocProvider لتطبيق الكل


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // التأكد من تهيئة الـ Widgets قبل تشغيل التطبيق
  final bool showLanguageSelection = await _checkIfShowLanguageSelection();






  // const String apiKey = String.fromEnvironment('AIzaSyAPwF5uPPoldpQGpd0q6LuXxCKz6O5HifY');
  //
  // if (apiKey.isEmpty) {
  //   print('لا يوجد متغير بيئي \$API_KEY');
  //   exit(1);
  // }
  //
  // // إعداد النموذج
  // final model = google.GenerativeModel(
  //   model: 'gemini-1.5-flash',
  //   apiKey: apiKey,
  // );
  //
  // // طلب توليد نص
  // final prompt = 'اكتب قصة عن حقيبة سحرية.';
  // final response = await model.generateContent([google.Content.text(prompt)]);
  // print(response.text);

  WidgetsFlutterBinding.ensureInitialized();
  // await ChatBotService().init();
  // void someUserAction() {
  //   // عندما يقوم المستخدم بإجراء معين، قم بتحديث النقاط
  //   ChatBotService().updatePoints(100);
  // }

  final educationalModel = UnifiedEducationalModel();

  // قم بتعديل هذه القيم حسب الحاجة



  // التأكد من تهيئة الـ Widgets قبل تشغيل التطبيق
  // التحقق مما إذا كان التطبيق محملًا من Google Play
   // assert((await PackageInfo.fromPlatform()).installerStore == 'com.android.vending', 'يجب تحميل التطبيق من Google Play');

  // التحقق مما إذا كان يجب عرض شاشة اختيار اللغة
  //final bool showLanguageSelection = await _checkIfShowLanguageSelection();

  // تشغيل التطبيق مع توفير BlocProvider لتطبيق الكل
  runApp(
    OverlaySupport.global(
      child: BlocProvider(
        create: (context) => ProgressCubit()..loadProgressIndicators(),
        child: WordMemorizationApp(showLanguageSelection: showLanguageSelection),
      ), // تطبيقك الرئيسي
    ),
  );

}

// التحقق مما إذا كان المستخدم قد رأى شاشة اختيار اللغة مسبقًا
Future<bool> _checkIfShowLanguageSelection() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? hasShown = prefs.getBool('has_shown_language_selection');
  if (hasShown == null || !hasShown) {
    await prefs.setBool('has_shown_language_selection', true);
    return true;
  }
  return false;
}

class WordMemorizationApp extends StatefulWidget {
  final bool showLanguageSelection;

  // استخدام الوسيط showLanguageSelection في التطبيق
  WordMemorizationApp({required this.showLanguageSelection});

  @override
  State<WordMemorizationApp> createState() => _WordMemorizationAppState();
}

class _WordMemorizationAppState extends State<WordMemorizationApp> {
  final FlutterLocalization _localization = FlutterLocalization.instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // تحميل تفضيلات اللغة المحفوظة
    _loadSavedLanguagePreference();
    _animateText();

    // تهيئة الترجمة للغات المدعومة
    _localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('ar', AppLocale.AR),
      ],
      initLanguageCode: 'en', // تعيين اللغة الافتراضية للإنجليزية
    );

    // الاستماع لتغيير اللغة
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  // يتم استدعاء هذه الدالة عند تغيير اللغة
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {}); // تحديث الواجهة لعرض الترجمة الجديدة
  }

  // تحميل اللغة المفضلة للمستخدم من SharedPreferences
  void _loadSavedLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguageCode = prefs.getString('languageCode');
    if (savedLanguageCode != null) {
      _localization.translate(savedLanguageCode);
    }
  }

  // حفظ تفضيل اللغة عند تغييره
  void _saveLanguagePreference(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
  }

  // تحريك النص
  void _animateText() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // تهيئة ScreenUtil بناءً على حجم الشاشة
    return ScreenUtilInit(
      designSize: Size(375, 812), // تعيين الحجم المرجعي للتصميم (مثال iPhone X)
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(

          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Word Memorization App',
          theme: ThemeData(
              primarySwatch: Colors.blue, fontFamily: _localization.fontFamily),
          supportedLocales: _localization.supportedLocales,
          localizationsDelegates: _localization.localizationsDelegates,
          // فرض اتجاه النص ليكون من اليسار إلى اليمين
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.ltr,
              // فرض اتجاه التطبيق ليبدأ من اليسار
              child: child!,
            );
          },
          home: widget.showLanguageSelection
              ? IntroPage()
              : WaterBottleTask(),


        );
      },
    );
  }
}




// دالة لإرسال الرسالة للمستخدم
void _sendMessageToUser(String message) {
  // إضافة الرسالة إلى الواجهة باستخدام overlay_support
  showOverlayNotification(
        (context) {
      return NotificationWidget(
        message: message,
        onDismiss: () {
          // إخفاء الرسالة عند التفاعل معها
          OverlaySupportEntry.of(context)?.dismiss();
        },
      );
    },
  );
}




class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final Random _random = Random();
  double grammarPoints = 0;
  double lessonPoints = 0;
  double studyHoursPoints = 0;
  double listeningPoints = 0;
  double speakingPoints = 0;
  double readingPoints = 0;
  double writingPoints = 0;
  double exercisePoints = 0;
  double sentenceFormationPoints = 0;
  double gamePoints = 0;
  double dailyPoints = 0;
  double goalPoints = 10000;

  // دالة لفحص التقدم وتحديد الرسالة المناسبة
  Future<void> _checkProgress() async {
    String? message;
    final Random random = Random();

    // توسيع قوائم الرسائل لكل حالة
    List<String> messages5000 = [
      "🎉 مبروك! لقد وصلت إلى **5000 نقطة**. أنت في تقدم ممتاز!",
      "👏 رائع! تجاوزت **5000 نقطة** في خطتك التعليمية.",
      "✨ إنجاز رائع! **5000 نقطة** و ما زال الطريق أمامك.",
      "🥳 خطتك تزدهر! **5000 نقطة** تم تحقيقها بالفعل.",
      "🚀 تقدم مذهل! أكملت **5000 نقطة**، استمر بنفس الحماس.",
      "🌟 **5000 نقطة** تم تجاوزها، تقدمك ملهم!",
    ];

    List<String> messages10000 = [
      "🏆 تهانينا! لقد حققت هدف الخطة التعليمية وأكملت **10000 نقطة**.",
      "🎯 هدفك تحقق! **10000 نقطة** تم تحقيقها بنجاح.",
      "🔥 ممتاز! **10000 نقطة** وأنت في القمة.",
      "🎖️ نجاح كبير! لقد أكملت **10000 نقطة**، إنجاز لا يصدق!",
      "👏 أنت في أعلى المستويات الآن بعد الوصول إلى **10000 نقطة**.",
      "🌈 حلمك تحقق! **10000 نقطة** قد تم إتمامها."
    ];

    List<String> messagesBetterThanYesterday = [
      "📈 لقد جمعت اليوم نقاطًا أكثر من أمس. **أداء رائع!**",
      "👍 تحسن ملحوظ! نقاطك اليوم تفوق أمس.",
      "💪 عمل ممتاز! تجاوزت نقاط أمس اليوم.",
      "🎉 أداء مدهش! نقاطك لهذا اليوم أفضل من اليوم السابق.",
      "🔝 تقدمك اليوم يتفوق على الأمس، استمر على هذا المنوال!",
      "🚀 أداء مبهر اليوم، واصل التفوق على نفسك!"
    ];

    List<String> messagesWorseThanYesterday = [
      "😟 حاول جمع نقاط أكثر غدًا للوصول إلى أهدافك!",
      "⚠️ يبدو أنك بحاجة لبذل جهد أكبر غدًا لجمع المزيد من النقاط.",
      "📉 لم تحقق النقاط المطلوبة اليوم. لا تيأس وحاول غدًا!",
      "😔 يمكنك تحسين أدائك غدًا، حافظ على حماسك.",
      "🔄 غدًا فرصة جديدة لجمع نقاط أكثر والوصول لهدفك.",
      "📊 أداءك اليوم أقل من الأمس، جرب استراتيجيات جديدة غدًا."
    ];

    List<String> messagesPointsRemaining = [
      "🔔 أنت على بُعد **${(goalPoints - totalPoints).toStringAsFixed(0)} نقطة** من إكمال الخطة التعليمية.",
      "⏳ تبقى لك **${(goalPoints - totalPoints).toStringAsFixed(0)} نقطة** لإنهاء خطتك التعليمية.",
      "🚀 قريبًا تنتهي! فقط **${(goalPoints - totalPoints).toStringAsFixed(0)} نقطة** تفصلك عن إكمال الخطة.",
      "🛤️ طريقك نحو الهدف قريب! **${(goalPoints - totalPoints).toStringAsFixed(0)} نقطة** فقط.",
      "🔜 قريبًا تصل للنهاية! فقط **${(goalPoints - totalPoints).toStringAsFixed(0)} نقطة** تفصلك عن النجاح.",
      "🏅 تبقى خطوة صغيرة! **${(goalPoints - totalPoints).toStringAsFixed(0)} نقطة** للوصول إلى هدفك."
    ];

    // تحديد الرسالة بناءً على النقاط
    if (totalPoints >= 5000 && totalPoints < 10000) {
      message = messages5000[random.nextInt(messages5000.length)];
    } else if (totalPoints >= 10000) {
      message = messages10000[random.nextInt(messages10000.length)];
    }
    final prefs = await SharedPreferences.getInstance();
    DateTime lastUpdateDate =
        DateTime.tryParse(prefs.getString('lastUpdateDate') ?? '') ??
            DateTime.now();

    if (DateTime.now().day != lastUpdateDate.day) {
      if (dailyPoints > (prefs.getDouble('previousDayPoints') ?? 0)) {
        message = messagesBetterThanYesterday[random.nextInt(messagesBetterThanYesterday.length)];
      } else {
        message = messagesWorseThanYesterday[random.nextInt(messagesWorseThanYesterday.length)];
      }

      prefs.setDouble('previousDayPoints', dailyPoints);
      dailyPoints = 0;
      prefs.setString('lastUpdateDate', DateTime.now().toIso8601String());

    }

    double pointsRemaining = goalPoints - totalPoints;
    if (pointsRemaining > 0 && message == null) {
      // اختيار رسالة عشوائية من قائمة النقاط المتبقية
      message = messagesPointsRemaining[random.nextInt(messagesPointsRemaining.length)];
    }

    if (message != null) {
      _sendMessageToUser(message); // تأكد من تنسيق الرسائل بشكل جذاب
    }
  }

  // دالة لإرسال الرسالة للمستخدم
  void _sendMessageToUser(String message) {
    // إضافة الرسالة إلى الواجهة باستخدام overlay_support
    showOverlayNotification(
          (context) {
        return NotificationWidget(
          message: message,
          onDismiss: () {
            // إخفاء الرسالة عند التفاعل معها
            OverlaySupportEntry.of(context)?.dismiss();
          },
        );
      },
    );
  }

  // حساب إجمالي النقاط
  double get totalPoints {
    return grammarPoints + lessonPoints + studyHoursPoints + listeningPoints +
        speakingPoints + readingPoints + writingPoints + exercisePoints +
        sentenceFormationPoints + gamePoints;
  }

  @override
  void initState() {
    super.initState();
    _loadStatisticsData();
  }

  // دالة لتحميل بيانات النقاط من SharedPreferences
  Future<void> _loadStatisticsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('دردشة')),
      body: Center(child: Text('هنا يظهر المحتوى')),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkProgress, // تنفيذ فحص التقدم عند الضغط على الزر
        child: Icon(Icons.check),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  NotificationWidget({required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
        trailing: IconButton(
          icon: Icon(Icons.close),
          onPressed: onDismiss,
        ),
      ),
    );
  }
}

















