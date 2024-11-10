

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mushaf25/settings/setting_2.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../Robot_chat.dart';
import 'Foundational_lessons/Explanation_of_words/Explanation_of_words_6.dart';
import 'ai_companion.dart';
import 'main.dart';
final List<String> _quickReplies = [
  "ما هي she في الجملة؟",
  "كيف نستخدم he في المحادثات؟",
  "ما الفرق بين they و them؟",
  "متى نستخدم it كضمير محايد؟",
  "كيف نستخدم I في الجملة؟",
  "ما معنى her عندما نستخدمها؟",
  "كيف نستخدم we و us بشكل صحيح؟",
  "ما هو الاستخدام الصحيح لـ my و mine؟",
  "متى نستخدم his و him في الجملة؟",
  "كيف يمكنني استخدام you في المحادثة؟",
  "ما هو المعنى المختلف لـ their و theirs؟",
  "متى يجب أن أستخدم each و every؟",
  "كيف نستخدم one و ones في الجمل؟",
  "ما الفرق بين who و whom في اللغة؟",
  "كيف نستخدم none في الجملة؟",
  "متى نستخدم much و many؟",
  "ما الفرق بين little و few؟",
  "كيف أستخدم that و those في الجمل؟",
  "ما معنى this و these في الاستخدام اليومي؟",
  "كيف يمكنني استخدام it للإشارة إلى الأشياء؟",
  "متى يجب استخدام we بدلاً من I؟",
  "ما الفرق بين some و any؟",
  "كيف نستخدم all و both في المحادثات؟",
  "ما هو الاستخدام الصحيح لـ yourself و myself؟",
  "كيف أستخدم their و they're في الجمل؟",
  "ما معنى each other و one another؟",
  "كيف أستخدم can و could في السياقات المختلفة؟",
  "ما الفرق بين will و would في المحادثات؟",
  "كيف نستخدم should و ought to بشكل صحيح؟",
  "ما هي الأمثلة على استخدام you و your؟",
  "متى نستخدم I و me في الجملة؟",
  "ما هو الاستخدام الصحيح لـ he و his؟",
  "كيف نستخدم she و her بشكل مناسب؟",
  "ما الفرق بين this و that في الإشارة إلى الأشياء؟",
  "كيف أستخدم where و when في الأسئلة؟",
  "ما معنى why و how في المحادثات؟",
  "كيف أستخدم a و an في الجملة؟",
  "ما هو الاستخدام الصحيح لـ the و a؟",
  "كيف أستخدم who في طرح الأسئلة؟",
  "ما الفرق بين could و can في الاستخدام؟",
  "كيف يمكنني استخدام may و might في الجمل؟",
  "متى أستخدم too و enough؟",
  "ما الفرق بين yet و already؟",
  "كيف أستخدم still و anymore؟",
  "ما معنى first و last في السياقات المختلفة؟",
  "كيف أستخدم second و next في المحادثات؟",
  "ما هو الفرق بين before و after؟",
  "كيف يمكنني استخدام since و for في الجمل؟",
  "ما معنى always و sometimes؟",
  "كيف أستخدم often و rarely؟",
  "ما الفرق بين some و several؟",
  "كيف أستخدم many و a lot of؟",
  "متى يجب أن أستخدم all و every؟",
  "كيف نستخدم 'let's' في الاقتراحات؟",
  "ما الفرق بين 's و 'is في الجمل؟",
  "كيف أستخدم 'whoever' و 'whomever' بشكل صحيح؟",
  "ما هي الاستخدامات المختلفة لـ 'make' و 'do'؟",
  "كيف أستخدم 'wish' و 'if only' في الجمل؟",
  "ما الفرق بين 'between' و 'among'؟",
  "كيف أستخدم 'unless' في الجمل؟",
  "ما معنى 'as soon as' و 'as long as'؟",
  "كيف يمكنني استخدام 'either...or' و 'neither...nor'؟",
  "ما الفرق بين 'bring' و 'take' في الاستخدام؟",
  "كيف أستخدم 'after' و 'following' بشكل صحيح؟",
  "ما معنى 'on behalf of' في السياقات المختلفة؟",
  "كيف أستخدم 'in case' و 'in the event of' في الجمل؟",
  "ما الفرق بين 'advise' و 'advice'؟",
  "كيف أستخدم 'suggest' و 'recommend' بشكل مناسب؟",
  "ما معنى 'take advantage of' في الاستخدام اليومي؟",
  "كيف يمكنني استخدام 'get used to' و 'be used to'؟",
  "ما الفرق بين 'listen to' و 'hear'؟",
  "كيف أستخدم 'in order to' في الجمل؟",
  "ما معنى 'in addition to' و 'besides'؟",
];

class Message {
  final String text;
  final DateTime timestamp;
  final bool isUser;

  Message(this.text, this.timestamp, {this.isUser = false});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'isUser': isUser,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      map['text'],
      DateTime.parse(map['timestamp']),
      isUser: map['isUser'],
    );
  }
}

class ChatPage {
  String name;
  List<Message> messages;

  ChatPage({required this.name, required this.messages});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'messages': messages.map((msg) => msg.toMap()).toList(),
    };
  }

  factory ChatPage.fromMap(Map<String, dynamic> map) {
    return ChatPage(
      name: map['name'],
      messages: List<Message>.from(
          map['messages']?.map((msg) => Message.fromMap(msg)) ?? []),
    );
  }
}

class ChatScreen22 extends StatefulWidget {
  @override
  _ChatScreen22State createState() => _ChatScreen22State();
}

class _ChatScreen22State extends State<ChatScreen22>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<ChatPage> _chatPages = [];
  ChatPage? _currentChatPage;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final ApiService apiService = ApiService();
  final Random _random = Random();
  List<Message> _favorites = [];
  // Variables for SharedPreferences data
  double grammarPoints = 0;
  double lessonPoints = 0;
  double studyHoursPoints = 0;
  double listeningPoints = 0;
  double speakingPoints = 0;
  double readingPoints = 0;
  double writingPoints = 0;
  double exercisePoints = 0;
  double sentenceFormationPoints = 0;
  double gamePoints = 0; // Initialized to 900 as per your code

  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int bottleFillLevel = 0;
  late AnimationController _sendButtonController;
  final ApiService _apiService = ApiService();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _isListening = false;
  String _userVoice = '';
  List<Message> _messages = [];
  String _selectedLanguage = 'العربية';
  final List<String> _languageOptions = ['العربية', 'English'];

  double dailyPoints = 0;
  double goalPoints = 10000;
  List<String> learningPlan = [
    "الاستماع",
    "التحدث",
    "القواعد",
    "الكلمات",
    "الكتابة",
    "القراءة"
  ];
  String userRank = "مبتدئ";

  bool showInitialOptions = true;

  // إضافة مؤشر الكتابة
  bool _isTyping = false;

  // قائمة الرسائل المجدولة
  List<ScheduledMessage> _scheduledMessages = [];

  @override
  void initState() {
    super.initState();
    _loadChatPages();
    _sendButtonController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _shuffleQuickReplies();
    _initializeNotifications();
    scheduleMultipleMessages();
    _loadUserData();
    _shuffleQuickReplies();
    _loadFavorites();
    _initializeNotifications();
    _loadStatisticsData();
    loadSavedProgressData();
    _initializeNotifications();
    _requestNotificationPermission();
    _loadStatisticsData();
    loadSavedProgressData();
    _initializeNotifications(); // تهيئة الإشعارات
    _requestNotificationPermission(); // التحقق من الأذونات
    scheduleMultipleMessages();
    langdetect.initLangDetect(); // Initialize the language detector once

  }

  Future<void> _listen2() async {
    String localeId = _selectedLanguage == 'العربية' ? 'ar-SA' : 'en-US';
    bool available = await _speech.initialize(
      onStatus: (val) {
        if (val == 'notListening') {
          setState(() {
            _isListening = false;
          });
        }
      },
      onError: (val) {
        setState(() {
          _isListening = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error while listening')),
        );
      },
    );

    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        localeId: localeId,
        onResult: (val) {
          setState(() {
            _userVoice = val.recognizedWords;
          });
        },
      );
    } else {
      setState(() => _isListening = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Voice recognition not available')),
      );
    }
  }

  Future<void> _stopListening2() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
    });
    _detectLanguageAndSendMessage2(_userVoice); // Detect language before sending message
  }

  Future<void> _detectLanguageAndSendMessage2(String text) async {
    if (text.trim().isEmpty) {
      print('An empty message cannot be sent.');
      return;
    }

    String detectedLang;
    try {
      // كشف اللغة باستخدام مكتبة langdetect
      detectedLang = await langdetect.detect(text);
      print('تم كشف اللغة: $detectedLang');
    } catch (e) {
      print('حدث خطأ أثناء كشف اللغة: $e');
      detectedLang = 'unknown';
    }

    // تعيين اللغة المختارة إذا كانت عربية أو إنجليزية فقط
    setState(() {
      if (detectedLang == 'ar') {
        _selectedLanguage = 'العربية';
      } else if (detectedLang == 'en') {
        _selectedLanguage = 'English';
      } else {
        print('اللغة غير مدعومة، سيتم التعامل كنص إنجليزي افتراضيًا.');
        _selectedLanguage = 'English'; // افتراضيًا للغة غير مدعومة
      }
    });

    // تحسين النص وتحليله
    String optimizedText = _optimizeText2(text);
    String sentiment = await _analyzeSentiment2(text);
    bool containsInappropriateContent = _checkForInappropriateContent2(text);

    // إرسال الرسالة إذا كانت المحتوى مناسب
    if (containsInappropriateContent) {
      print('المحتوى غير ملائم للإرسال.');
      return;
    }

    // تسجيل البيانات
    _logMessageData2(text, detectedLang, sentiment);

    // إرسال الرسالة بعد التحليل
    await _sendMessage(optimizedText, sentiment: sentiment);
  }

// دالة لتحسين النص
  String _optimizeText2(String text) {
    List<String> words = text.split(' ');
    Set<String> uniqueWords = Set.from(words);
    return uniqueWords.join(' ');
  }

// دالة لتحليل المشاعر
  Future<String> _analyzeSentiment2(String text) async {
    if (text.contains(RegExp(r'\b(جميل|رائع|ممتاز|مميز|happy|excellent|great)\b'))) {
      return 'إيجابي';
    } else if (text.contains(RegExp(r'\b(سيء|رديء|حزين|مزعج|sad|bad|annoying)\b'))) {
      return 'سلبي';
    }
    return 'محايد';
  }

// دالة للتحقق من الكلمات المسيئة
  bool _checkForInappropriateContent2(String text) {
    List<String> inappropriateWords = ['كلمة1', 'كلمة2', 'badword1', 'badword2'];
    return inappropriateWords.any((word) => text.contains(word));
  }

// دالة لتسجيل بيانات الرسالة
  void _logMessageData2(String text, String detectedLang, String sentiment) {
    print('تسجيل الرسالة:');
    print('النص: $text');
    print('اللغة: $detectedLang');
    print('المشاعر: $sentiment');
  }




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
      sentenceFormationPoints =
          prefs.getDouble('sentenceFormationPoints') ?? 0;
      gamePoints = prefs.getDouble('gamePoints') ?? 0;
    });
  }
  // دالة لتحميل بيانات مستويات التقدم من SharedPreferences
  Future<void> loadSavedProgressData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      readingProgressLevel = prefs.getInt('progressReading') ?? 0;
      listeningProgressLevel = prefs.getInt('progressListening') ?? 0;
      writingProgressLevel = prefs.getInt('progressWriting') ?? 0;
      grammarProgressLevel = prefs.getInt('progressGrammar') ?? 0;
      bottleFillLevel = prefs.getInt('bottleLevel') ?? 0;
    });
  }
  void _shuffleQuickReplies() {
    _quickReplies.shuffle(_random);
  }
  @override
  void dispose() {
    _controller.dispose();
    _sendButtonController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
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

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      dailyPoints = prefs.getDouble('dailyPoints') ?? 0;
    });
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('totalPoints', totalPoints);
    prefs.setDouble('dailyPoints', dailyPoints);
  }

  Future<void> _updatePoints(double points) async {
    setState(() {
      dailyPoints += points;
      _updateUserRank();
    });
    await _saveUserData();
    _checkProgress();
  }

  void _updateUserRank() {
    if (totalPoints < 2000) {
      userRank = "مبتدئ";
    } else if (totalPoints < 5000) {
      userRank = "متعلم";
    } else if (totalPoints < 10000) {
      userRank = "متوسط";
    } else if (totalPoints < 20000) {
      userRank = "متعلم متقدم";
    } else {
      userRank = "خبير";
    }
  }


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

    // اختيار الرسالة بناءً على النقاط الإجمالية
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
      await _saveUserData();
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

  void _sendMessageToUser(String message) {
    // final botMessage = Message("Bot: $message", DateTime.now(), isUser: false);
    // setState(() {
    //   _currentChatPage?.messages.add(botMessage);
    //   _listKey.currentState?.insertItem(_currentChatPage!.messages.length - 1);
    //   showInitialOptions = false;
    // });
    _saveChatPages();
    _scrollToBottom();
  }
  List<String> progressTemplates = [
    // القالب الأول
    """
📊 **تقرير تقدمك في تطبيق EngoLearn** 

مرحبًا \$name، هذا ملخص عن تقدمك في تعلم اللغة من خلال التطبيق:

1. **النقاط الكلية المكتسبة**:
   - حققت **\$totalPoints** نقطة من إجمالي **\$goalPoints** نقطة مستهدفة.
   - **نسبة الإنجاز**: \${(totalPoints / goalPoints * 100).toStringAsFixed(1)}% من الهدف.
   - **النقاط المتبقية** لتحقيق هدفك: **\${(goalPoints - totalPoints).toStringAsFixed(0)} نقطة**.

2. **مهارة القراءة**:
   - **مستواك الحالي**: **\$english_level_reading**.
   - **أداءك**: مستواك في القراءة يتحسن بشكل ملحوظ! استمر في قراءة القصص المتوفرة في التطبيق.
   - **التوصية**: جرب قراءة نصوص جديدة وممارسة الألعاب المرتبطة بالقراءة لتعزيز الفهم.

3. **مهارة الاستماع**:
   - **مستواك الحالي**: **\$english_level_listening**.
   - **أداءك**: هناك فرص للتحسن! استخدم الدروس الصوتية يوميًا لتعزيز مهارات الاستماع.
   - **التوصية**: ابدأ بمراجعة المقاطع الصوتية القديمة وحاول تطبيق المفردات الجديدة في الحوارات.

4. **مهارة التحدث**:
   - **مستواك الحالي**: **\$english_level_speaking**.
   - **أداءك**: جيد! يمكنك تحسين مهارات التحدث باستخدام خاصية الذكاء الاصطناعي في التطبيق.
   - **التوصية**: تمرن على التحدث باستخدام الجمل الجديدة من الدروس اليومية.

5. **مهارة الكتابة**:
   - **مستواك الحالي**: **\$english_level_writing**.
   - **أداءك**: تقدم ملحوظ! استمر بكتابة ملخصات يومية باستخدام ميزة الكتابة التفاعلية.
   - **التوصية**: مارس الكتابة عبر سرد أحداث يومية أو تلخيص دروسك.

✨ استمر في استخدام EngoLearn وتابع تقدمك خطوة بخطوة! 🚀
""",
    // القالب الثاني
    """
📈 **تقرير مختصر عن تقدمك في EngoLearn**

مرحبًا \$name! فيما يلي تقرير سريع حول أدائك في التطبيق:

1. **النقاط الكلية**:
   - لقد جمعت **\$totalPoints** من **\$goalPoints** نقاط.
   - **نسبة التقدم**: \${(totalPoints / goalPoints * 100).toStringAsFixed(1)}%.
   - **النقاط المتبقية**: **\${(goalPoints - totalPoints).toStringAsFixed(0)} نقطة** للوصول إلى هدفك.

2. **القراءة**:
   - **مستواك**: **\$english_level_reading**.
   - **تقييم**: أداء جيد، استمر في القراءة المنتظمة.
   - **اقتراح**: جرب قصصًا جديدة وزد من مفرداتك باستخدام الألعاب.

3. **الاستماع**:
   - **مستواك**: **\$english_level_listening**.
   - **تقييم**: يمكن تعزيز مهاراتك عبر التمارين الصوتية.
   - **اقتراح**: استمع بانتظام لدروس التطبيق الصوتية.

4. **التحدث**:
   - **مستواك**: **\$english_level_speaking**.
   - **تقييم**: جيد، تمرن أكثر مع الروبوت التفاعلي.
   - **اقتراح**: استخدم الجمل التي تتعلمها في محادثات مع الذكاء الاصطناعي.

... (تابع لنفس الأسلوب لكل مهارة)
"""
  ];

  List<String> learningPlanTemplates = [
    // القالب الأول
    """
✨ مرحبًا بك في خطتك التعليمية، يا \$name! 🎉

1. 🎧 **الاستماع**: استمع إلى الدروس الصوتية والقصص في التطبيق لمدة **30 دقيقة يوميًا** لتحسين مهارات السمع والفهم.
2. 🗣️ **التحدث**: استخدم صفحة التحدث في التطبيق للتمرين مع الذكاء الاصطناعي أو تطبيقات التحدث لمدة **20 دقيقة يوميًا** لتحسين مهارات النطق والتواصل.
3. 📚 **القواعد**: خصص **15 دقيقة** يوميًا لدراسة دروس القواعد المتوفرة في التطبيق وتطبيقها على تمارين القواعد.
4. 📝 **المفردات**: تعلم **10 كلمات جديدة** من قسم المفردات، واستخدمها في جمل داخل الألعاب التفاعلية لتعزيز حفظك.
5. ✍️ **الكتابة**: استخدم صفحة الكتابة لكتابة فقرات قصيرة أو تلخيص الدروس اليومية لمدة **15 دقيقة** لتحسين مهارات الكتابة.
6. 📖 **القراءة**: اقرأ القصص والمقالات القصيرة في التطبيق لمدة **20 دقيقة يوميًا** لتحسين مهارات القراءة.

🚀 استمر في هذا البرنامج لتحقق تقدمًا مستمرًا في مستواك اللغوي! 🌟
""",
    // القالب الثاني
    """
📅 **خطتك اليومية، يا \$name، عبر تطبيق EngoLearn:**

1. 👂 **الاستماع**: استمع لدروس الصوت والقصص التفاعلية لمدة **25 دقيقة** لتحسين الفهم والاستيعاب.
2. 🗣️ **التحدث**: تحدث مع الذكاء الاصطناعي في التطبيق لمدة **15 دقيقة** يوميًا لتحسين النطق والتفاعل.
3. 📙 **المفردات**: تعلم **12 كلمة جديدة** من دروس المفردات اليومية وقم بممارستها في الألعاب المتاحة.
4. ✍️ **الكتابة**: اكتب ملاحظاتك أو ملخصاتك اليومية باستخدام قسم الكتابة التفاعلي لمدة **20 دقيقة**.
5. 📖 **القراءة**: اقرأ المقالات والقصص التفاعلية الموجودة في التطبيق لمدة **25 دقيقة** لتحسين مهارات القراءة.

🎯 التزامك بهذه الأنشطة من خلال التطبيق سيعزز مستوى تعلمك بشكل ملحوظ! 💪
""",
    // القالب الثالث
    """
🌟 **خطة مكثفة للتعلم عبر EngoLearn، يا \$name:**

1. 🎧 **الاستماع المركز**: استخدم دروس الصوت المتقدمة في التطبيق لمدة **40 دقيقة** يوميًا لتحسين الاستماع.
2. 🗣️ **التحدث مع الذكاء الاصطناعي**: قم بتطوير مهاراتك بالتحدث مع الشريك التفاعلي لمدة **30 دقيقة**.
3. 📚 **تطبيق قواعد اللغة**: خصص **20 دقيقة** لمراجعة الدروس القواعدية المتقدمة في التطبيق وطبقها في تمارين الكتابة.
4. 📝 **كتابة مخصصة**: استخدم ميزة الكتابة لكتابة قصص قصيرة أو مواضيع تعبير لتحسين الكتابة.
5. 📖 **القراءة المتقدمة**: اختر نصوصًا أكثر تعقيدًا من مكتبة التطبيق واقرأها لمدة **30 دقيقة**.
6. 🎮 **اللعب التفاعلي**: استخدم الألعاب التعليمية لتحسين المفردات والقواعد لمدة **15 دقيقة**.

✨ التزامك بهذه الخطة سيساعدك على تحقيق نتائج مبهرة في وقت قصير! 🚀
"""
  ];

// دالة لاختيار قالب عشوائي لخطة التعلم
  String getRandomLearningPlan() {
    final random = Random();
    int index = random.nextInt(learningPlanTemplates.length);
    return learningPlanTemplates[index];
  }


  Future<void> _sendMessage(String text, {required String sentiment}) async {
    if (text.trim().isEmpty) return;

    final userMessage = Message(text, DateTime.now(), isUser: true);
    setState(() {
      _messages.add(userMessage);
    });

    final processingMessage = Message('Processing...', DateTime.now(), isUser: false);
    setState(() {
      _messages.add(processingMessage);
    });

    try {
      final botResponse = await _apiService.getTextResponse(text);
      setState(() {
        _messages.remove(processingMessage);
      });

      final botMessage = Message(botResponse, DateTime.now(), isUser: false);
      setState(() {
        _messages.add(botMessage);
      });
    } catch (e) {
      setState(() {
        _messages.remove(processingMessage);
      });

      final errorMessage = Message('Error getting response. Try again.', DateTime.now(), isUser: false);
      setState(() {
        _messages.add(errorMessage);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('API connection failed')),
      );
    }
    if (text.isEmpty) return;

    _sendButtonController
        .forward()
        .then((_) => _sendButtonController.reverse());

    final message = Message("${AppLocale.S129.getString(context)}: $text", DateTime.now(), isUser: true);
    setState(() {
      _currentChatPage?.messages.add(message);
      _listKey.currentState?.insertItem(_currentChatPage!.messages.length - 1);
      showInitialOptions = false;
    });
    _saveChatPages();
    _scrollToBottom();

    setState(() {
      _isTyping = true;
    });

    try {
      String response;
      final Random random = Random();

      if (text.toLowerCase().contains("التقدم")) {
        List<String> progressResponses = [
          "📊 إجمالي النقاط الخاصة بك هو ** \n$listeningPoints استماع \n $speakingPoints تحدث\n$readingPoints قرائة\n$writingPoints كتابة\n$exercisePoints تمارين\n$gamePoints  العاب\n$totalPoints المجموع \n**، وأنت في مستوى **$userRank**. استمر في العمل لتحقيق المزيد! 🌟",
          "🚀 لقد وصلت إلى ** \n$listeningPoints استماع \n $speakingPoints تحدث\n$readingPoints قرائة\n$writingPoints كتابة\n$exercisePoints تمارين\n$gamePoints  العاب\n$totalPoints المجموع \n** نقطة**، وهذا يضعك في مستوى **$userRank**. حافظ على هذا الأداء!",
          "💪 نقاطك الإجمالية هي ** \n$listeningPoints استماع \n $speakingPoints تحدث\n$readingPoints قرائة\n$writingPoints كتابة\n$exercisePoints تمارين\n$gamePoints  العاب\n$totalPoints المجموع \n** والمستوى الحالي **$userRank**. واصل المسيرة!",
          "🌈 تقدمك رائع! لديك ** \n$listeningPoints استماع \n $speakingPoints تحدث\n$readingPoints قرائة\n$writingPoints كتابة\n$exercisePoints تمارين\n$gamePoints  العاب\n$totalPoints المجموع \n** نقطة والمستوى الحالي **$userRank**. استمر بالإبداع!",
          "✨ نقاطك الحالية ** \n$listeningPoints استماع \n $speakingPoints تحدث\n$readingPoints قرائة\n$writingPoints كتابة\n$exercisePoints تمارين\n$gamePoints  العاب\n$totalPoints المجموع \n** تعكس جهدك المستمر، وأنت في مستوى **$userRank**. أحسنت!",
          "🏅 مع ** \n$listeningPoints استماع \n $speakingPoints تحدث\n$readingPoints قرائة\n$writingPoints كتابة\n$exercisePoints تمارين\n$gamePoints  العاب\n$totalPoints المجموع \n** نقطة، أنت في طريقك لتحقيق مستوى **$userRank**. ممتاز!",
          "🎯** \n$listeningPoints استماع \n $speakingPoints تحدث\n$readingPoints قرائة\n$writingPoints كتابة\n$exercisePoints تمارين\n$gamePoints  العاب\n$totalPoints المجموع \n** نقطة** حققتها حتى الآن، مما يجعلك في مستوى **$userRank**. استمر بالتميز!",
          "🔥 تقدم ملحوظ مع ** \n$listeningPoints استماع \n $speakingPoints تحدث\n$readingPoints قرائة\n$writingPoints كتابة\n$exercisePoints تمارين\n$gamePoints  العاب\n$totalPoints المجموع \n** نقطة، وأنت الآن في مستوى **$userRank**. استمر في التألق!",
          "🌟 استمر في التقدم! ** \n$listeningPoints استماع \n $speakingPoints تحدث\n$readingPoints قرائة\n$writingPoints كتابة\n$exercisePoints تمارين\n$gamePoints  العاب\n$totalPoints المجموع \n** نقطة و **$userRank** مستوى يميزك.",
          "🎉 تهانينا على ** \n$listeningPoints استماع \n $speakingPoints تحدث\n$readingPoints قرائة\n$writingPoints كتابة\n$exercisePoints تمارين\n$gamePoints  العاب\n$totalPoints المجموع \n** نقطة! أنت تتقدم بسرعة نحو **$userRank**."
        ];
        response = progressResponses[random.nextInt(progressResponses.length)];
      } else if (text.toLowerCase().contains("نصيحة")) {
        List<String> adviceResponses = [
          "📚 حافظ على الاستمرارية في الدراسة واحرص على تحديد أهداف يومية. **التقدم يحتاج إلى وقت!** ⏳",
          "💡 اجعل التعلم عادة يومية، وحدد أهدافًا صغيرة ومتواصلة.",
          "✨ ركز على تحسين مهاراتك يوميًا بخطوات بسيطة لتحقيق نتائج كبيرة.",
          "📖 لا تتوقف عند أي صعوبة؛ كل خطوة تقربك من الهدف!",
          "🌟 نظم وقتك بفعالية وخصص فترات محددة للدراسة والاستراحة.",
          "🔍 ركز على فهم المفاهيم بدلاً من الحفظ فقط لتحقيق استفادة أفضل.",
          "🧘‍♂️ احرص على أخذ فترات راحة منتظمة للحفاظ على تركيزك ونشاطك.",
          "🚀 استخدم تقنيات التعلم النشط مثل النقاش والممارسة العملية لتعزيز مهاراتك.",
          "📅 خطط لدراستك مسبقًا وحدد مواعيد محددة لكل مادة أو موضوع.",
          "🌱 تعلم شيئًا جديدًا كل يوم ولا تخف من مواجهة التحديات."
        ];
        response = adviceResponses[random.nextInt(adviceResponses.length)];
      } else if (text.toLowerCase().contains("الخطة التعليمية")) {
        List<String> learningPlans = [
          """
✨ إليك خطتك التعليمية في EngoLearn:

1. 🎧 **الاستماع**: استمع إلى المحادثات والنصوص باللغة الإنجليزية لمدة **30 دقيقة يوميًا**.
2. 🗣️ **التحدث**: تمرن على التحدث مع روبوت الذكاء الاصطناعي أو مع شريك تعلم لمدة **20 دقيقة يوميًا**.
3. 📚 **القواعد**: خصص **15 دقيقة** لدراسة القواعد اللغوية من خلال دروس القواعد في التطبيق.
4. 📝 **الكلمات**: تعلم **10 كلمات جديدة** يوميًا من خلال التمارين واستخدمها في جمل.
5. ✍️ **الكتابة**: اكتب فقرة أو تمرين يومي لمدة **15 دقيقة** باستخدام الذكاء الاصطناعي لتحسين الكتابة.
6. 📖 **القراءة**: اقرأ مقاطع نصية أو قصص قصيرة لمدة **20 دقيقة يوميًا** من خلال التطبيق.

💪 استمر في هذه الخطة اليومية لتحقيق تقدم ملحوظ في مستواك اللغوي! 🚀
""",
          """
🚀 خطة تعليمية جديدة لك في EngoLearn:

1. 👂 **مهارة الاستماع**: استمع إلى نصوص باللغة الإنجليزية لمدة **40 دقيقة** باستخدام التمارين الصوتية.
2. 🗣️ **التحدث**: شارك بفعالية في محادثات عبر التطبيق أو مع روبوت الذكاء الاصطناعي لمدة **25 دقيقة**.
3. 📙 **المفردات**: احفظ 15 كلمة جديدة يوميًا وحاول استخدامها في المحادثات.
4. ✍️ **الكتابة**: اكتب يومياتك باللغة الإنجليزية لمدة **10 دقائق** باستخدام التمرينات الكتابية.
5. 📖 **القراءة**: اقرأ نصوصًا ومقالات في التطبيق لمدة **20 دقيقة** يوميًا.
6. 🧠 **التفكير النقدي**: حل تمارين تطبيقية لتعزيز الفهم من خلال الأنشطة المتقدمة.

🌱 استمر والتزم بهذه الخطة لتحقيق تقدم كبير!
""",
          """
📅 خطة تعليمية مخصصة في EngoLearn:

1. 🎧 **الاستماع النشط**: استمع إلى بودكاست أو مقاطع تعليمية لمدة **25 دقيقة** يوميًا.
2. 🗣️ **التحدث المستمر**: تحدث مع شريك تعلم أو عبر التطبيق لمدة **30 دقيقة** يوميًا.
3. 📚 **دراسة القواعد**: راجع قواعد اللغة يوميًا لمدة **20 دقيقة** مع أمثلة تطبيقية.
4. 📝 **التدوين اليومي**: اكتب ملخصًا لما تعلمته في اليوم لمدة **15 دقيقة**.
5. 📖 **قراءة متقدمة**: اقرأ كتبًا أو مقالات متقدمة لمدة **30 دقيقة** يوميًا.
6. 🎮 **التعلم التفاعلي**: استخدم الألعاب التفاعلية والتطبيقات التعليمية لمدة **20 دقيقة** يوميًا.

✨ التزامك بهذه الخطة سيساعدك على تحقيق تقدم مستدام وفعّال! 🌟
""",
          """
🌟 خطة تعليمية مكثفة في EngoLearn:

1. 🎧 **الاستماع المكثف**: استمع لمواد تعليمية متنوعة لمدة **45 دقيقة** يوميًا.
2. 🗣️ **التحدث الحر**: شارك في محادثات مفتوحة أو مجموعات نقاش لمدة **30 دقيقة** يوميًا.
3. 📚 **الدراسة المركزة**: ركز على دراسة موضوع معين أو مهارة جديدة لمدة **25 دقيقة**.
4. 📝 **الكتابة الإبداعية**: اكتب قصصًا أو مقالات لتعزيز مهارات الكتابة لمدة **20 دقيقة** يوميًا.
5. 📖 **القراءة المتعمقة**: اقرأ كتبًا متقدمة لمدة **40 دقيقة** يوميًا.
6. 🧠 **التفكير النقدي وحل المشكلات**: شارك في أنشطة أو تمارين تحفز التفكير التحليلي لمدة **30 دقيقة** يوميًا.

🚀 هذه الخطة المكثفة ستدفعك لتحقيق مستويات متقدمة في وقت قصير!
""",
          """
📈 خطة تعليمية متوازنة في EngoLearn:

1. 🎧 **الاستماع اليومي**: استمع لمواد صوتية متنوعة لمدة **20 دقيقة** يوميًا.
2. 🗣️ **ممارسة التحدث**: تحدث مع شريك تعلم أو عبر التطبيق لمدة **15 دقيقة** يوميًا.
3. 📚 **مراجعة القواعد**: راجع قواعد اللغة لمدة **10 دقائق** يوميًا.
4. 📝 **كتابة الجمل**: اكتب 5 جمل جديدة باستخدام المفردات التي تعلمتها يوميًا.
5. 📖 **قراءة النصوص**: اقرأ مقاطع قصيرة أو مقالات لمدة **15 دقيقة** يوميًا.
6. 💡 **التعلم الإضافي**: شاهد فيديوهات تعليمية أو شارك في ورش عمل لمدة **20 دقيقة** يوميًا.

🌟 التوازن في هذه الخطة يضمن تغطية جميع جوانب اللغة لتحقيق تقدم شامل!
"""
        ];
        response = learningPlans[random.nextInt(learningPlans.length)];
      } else if (text.toLowerCase().contains("كم المتبقي")) {
        //double pointsRemaining = goalPoints - totalPoints;
        List<String> pointsRemainingResponses = [
          "🔔 أنت على بُعد **${totalPoints.toStringAsFixed(0)} نقطة** من إكمال الخطة التعليمية. استمر في الجهد! 💪",
          "🚀 قريب من الهدف! تبقى لك **${totalPoints.toStringAsFixed(0)} نقطة** للوصول.",
          "🎯 نقطة واحدة تلو الأخرى! **${totalPoints.toStringAsFixed(0)} نقطة** تفصلك عن هدفك.",
          "🌟 فقط **${totalPoints.toStringAsFixed(0)} نقطة** لتصل إلى النهاية. واصل التقدم!",
          "🛤️ طريقك نحو الهدف قريب! **${totalPoints.toStringAsFixed(0)} نقطة** فقط.",
          "🔜 قريبًا تصل للنهاية! فقط **${totalPoints.toStringAsFixed(0)} نقطة** تفصلك عن النجاح.",
          "🏅 تبقى خطوة صغيرة! **${totalPoints.toStringAsFixed(0)} نقطة** للوصول إلى هدفك.",
          "📈 أنت في الطريق الصحيح! **${totalPoints.toStringAsFixed(0)} نقطة** تفصلك عن إكمال الخطة.",
          "🔥 استمر في جمع النقاط! تبقى لك **${totalPoints.toStringAsFixed(0)} نقطة** فقط.",
          "💡 أنت قريب جدًا من الهدف! **${totalPoints.toStringAsFixed(0)} نقطة** تفصلك عن النجاح."
        ];
        response = pointsRemainingResponses[random.nextInt(pointsRemainingResponses.length)];
      } else {
        // يمكن إضافة المزيد من الشروط هنا إذا لزم الأمر
        response = await apiService.getTextResponse(text);
      }

      await Future.delayed(Duration(seconds: 1));

      final botMessage = Message("${AppLocale.S128.getString(context)}: $response", DateTime.now(), isUser: false);
      setState(() {
       _currentChatPage?.messages.add(botMessage);
         _listKey.currentState?.insertItem(_currentChatPage!.messages.length - 1);
        _isTyping = false;
      });
      _saveChatPages();
      _scrollToBottom();

    } catch (e) {
      final errorMessage = Message(
          "${AppLocale.S128.getString(context)}: حدث خطأ أثناء معالجة الرسالة.", DateTime.now(),
          isUser: false);
      setState(() {
        _currentChatPage?.messages.add(errorMessage);
        _listKey.currentState?.insertItem(_currentChatPage!.messages.length - 1);
        _isTyping = false;
      });
      _saveChatPages();
      _scrollToBottom();
    }
  }

  String _generateLearningPlan() {
    List<String> learningPlans = [
      """
✨ إليك خطتك التعليمية المقترحة:

1. 🎧 **الاستماع**: قم بالاستماع إلى المحادثات والنصوص باللغة المستهدفة لمدة **30 دقيقة يوميًا**.
2. 🗣️ **التحدث**: تمرن على التحدث مع متحدثين أصليين أو عبر تطبيقات التحدث لمدة **20 دقيقة يوميًا**.
3. 📚 **القواعد**: خصص **15 دقيقة** لدراسة قواعد اللغة وفهمها.
4. 📝 **الكلمات**: تعلم **10 كلمات جديدة** كل يوم واستخدمها في جمل.
5. ✍️ **الكتابة**: اكتب فقرة أو يوميات باللغة المستهدفة لمدة **15 دقيقة**.
6. 📖 **القراءة**: اقرأ مقالات أو قصص قصيرة لمدة **20 دقيقة يوميًا**.

💪 استمر على هذه الخطة يوميًا لتحقيق تقدم ملحوظ في مستواك اللغوي! 🚀
""",
      """
🚀 خطة تعليمية جديدة لك:

1. 👂 **مهارة الاستماع**: استمع إلى نصوص باللغة الهدف لمدة **40 دقيقة**.
2. 🗣️ **التحدث**: شارك بفعالية في محادثات يومية، لمدة **25 دقيقة**.
3. 📙 **المفردات**: احفظ 15 كلمة جديدة يوميًا وحاول استخدامهم.
4. ✍️ **الكتابة**: اكتب يومياتك بلغتك المستهدفة، لمدة **10 دقائق**.
5. 📖 **القراءة**: اقرأ نصوصًا ومقالات مثيرة يوميًا.
6. 🧠 **التفكير النقدي**: حل تمارين أو مشكلات تطبيقية لتعزيز فهمك.

🌱 استمر والتزم لتحقق تقدم كبير!
""",
      """
📅 خطة تعليمية مخصصة:

1. 🎧 **الاستماع النشط**: استمع إلى بودكاست أو مقاطع فيديو تعليمية لمدة **25 دقيقة** يوميًا.
2. 🗣️ **التحدث المستمر**: تحدث مع شريك تعلم أو مدرب لمدة **30 دقيقة** يوميًا.
3. 📚 **دراسة القواعد**: مراجعة قواعد اللغة لمدة **20 دقيقة** يوميًا مع أمثلة تطبيقية.
4. 📝 **التدوين اليومي**: اكتب ملخصًا لما تعلمته يوميًا لمدة **15 دقيقة**.
5. 📖 **قراءة متقدمة**: اقرأ كتبًا متقدمة أو أبحاثًا في المجال الذي تدرسه لمدة **30 دقيقة** يوميًا.
6. 🎮 **التعلم التفاعلي**: استخدم تطبيقات تعليمية أو ألعاب لغوية لمدة **20 دقيقة** يوميًا.

✨ التزامك بهذه الخطة سيساعدك على تحقيق تقدم مستدام وفعّال! 🌟
""",
      """
🌟 خطة تعليمية مكثفة:

1. 🎧 **الاستماع المكثف**: استمع لمواد تعليمية متنوعة لمدة **45 دقيقة** يوميًا.
2. 🗣️ **التحدث الحر**: شارك في محادثات مفتوحة أو مجموعات نقاش لمدة **30 دقيقة** يوميًا.
3. 📚 **الدراسة المركزة**: ركز على دراسة موضوع معين أو مهارة جديدة لمدة **25 دقيقة** يوميًا.
4. 📝 **الكتابة الإبداعية**: اكتب قصص قصيرة أو مقالات لتعزيز مهارات الكتابة لمدة **20 دقيقة** يوميًا.
5. 📖 **القراءة المتعمقة**: اقرأ كتبًا متقدمة أو أبحاثًا في المجال الذي تدرسه لمدة **40 دقيقة** يوميًا.
6. 🧠 **التفكير النقدي وحل المشكلات**: شارك في أنشطة أو تمارين تعزز التفكير التحليلي لمدة **30 دقيقة** يوميًا.

🚀 هذه الخطة المكثفة ستدفعك لتحقيق مستويات متقدمة في وقت قصير!
""",
      """
📈 خطة تعليمية متوازنة:

1. 🎧 **الاستماع اليومي**: استمع لمواد صوتية متنوعة لمدة **20 دقيقة** يوميًا.
2. 🗣️ **ممارسة التحدث**: تحدث مع شريك تعلم أو مدرب لمدة **15 دقيقة** يوميًا.
3. 📚 **مراجعة القواعد**: قم بمراجعة قواعد اللغة لمدة **10 دقائق** يوميًا.
4. 📝 **كتابة الجمل**: اكتب 5 جمل جديدة باستخدام المفردات التي تعلمتها يوميًا.
5. 📖 **قراءة النصوص**: اقرأ مقالات أو فقرات قصيرة لمدة **15 دقيقة** يوميًا.
6. 💡 **التعلم الإضافي**: شاهد فيديوهات تعليمية أو شارك في ورش عمل لمدة **20 دقيقة** يوميًا.

🌟 التوازن في هذه الخطة يضمن تغطية جميع جوانب اللغة لتحقيق تقدم شامل!
""",
      """
📘 خطة تعليمية شاملة:

1. 🎧 **الاستماع المكثف**: استمع إلى مواد صوتية متعددة الثقافات لمدة **35 دقيقة** يوميًا.
2. 🗣️ **التحدث المتقدم**: شارك في نقاشات متقدمة مع متحدثين أصليين لمدة **30 دقيقة** يوميًا.
3. 📚 **الدراسة المتخصصة**: ركز على دراسة تخصص معين في اللغة لمدة **25 دقيقة** يوميًا.
4. 📝 **الكتابة المتعمقة**: اكتب مقالات أو بحوث قصيرة لتعزيز مهارات الكتابة لمدة **25 دقيقة** يوميًا.
5. 📖 **القراءة الشاملة**: اقرأ كتبًا أكاديمية أو أدبية باللغة المستهدفة لمدة **35 دقيقة** يوميًا.
6. 🧠 **التفكير التحليلي**: حل مسائل تطبيقية أو شارك في ورش عمل لتطوير التفكير النقدي لمدة **30 دقيقة** يوميًا.

🔍 هذه الخطة ستساعدك على تحقيق فهم عميق ومهارات متقدمة في اللغة المستهدفة!
""",
      """
🌱 خطة تعليمية مستدامة:

1. 🎧 **الاستماع المنتظم**: استمع إلى بودكاست أو برامج تعليمية لمدة **25 دقيقة** يوميًا.
2. 🗣️ **التحدث اليومي**: تحدث مع أصدقاء أو زملاء تعلم لمدة **20 دقيقة** يوميًا.
3. 📚 **الدراسة المستمرة**: قم بمراجعة قواعد اللغة ودراسة مفردات جديدة لمدة **15 دقيقة** يوميًا.
4. 📝 **الكتابة المستمرة**: اكتب يوميات أو مقالات قصيرة لمدة **15 دقيقة** يوميًا.
5. 📖 **القراءة اليومية**: اقرأ مقالات أو كتب قصيرة باللغة المستهدفة لمدة **20 دقيقة** يوميًا.
6. 💡 **التعلم المستمر**: استخدم تطبيقات تعليمية أو شاهد فيديوهات تعليمية لمدة **20 دقيقة** يوميًا.

🌟 الاستمرارية في هذه الخطة تضمن تحقيق تقدم مستدام وفعّال في تعلم اللغة!
"""
    ];

    final Random random = Random();
    return learningPlans[random.nextInt(learningPlans.length)];
  }





  Future<void> _loadChatPages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedChatPages = prefs.getStringList('chat_pages');
    if (savedChatPages != null) {
      setState(() {
        _chatPages.addAll(savedChatPages
            .map((pageJson) => ChatPage.fromMap(json.decode(pageJson)))
            .toList());
        if (_chatPages.isNotEmpty) {
          _currentChatPage = _chatPages.first;
        }
      });
    } else {
      // Initialize with a default chat page
      ChatPage defaultPage = ChatPage(name: "EngoLearn", messages: []);
      _chatPages.add(defaultPage);
      _currentChatPage = defaultPage;
      _saveChatPages();
    }
  }

  Future<void> _saveChatPages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> chatPagesJson =
    _chatPages.map((page) => json.encode(page.toMap())).toList();
    await prefs.setStringList('chat_pages', chatPagesJson);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 60,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _toggleFavorite(Message message) {
    setState(() {
      if (_favorites.contains(message)) {
        _favorites.remove(message);
      } else {
        _favorites.add(message);
      }
    });
    _saveFavorites();
  }
  Future<void> _saveFavorites() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favoriteJsonList =
      _favorites.map((favorite) => json.encode(favorite.toMap())).toList();
      await prefs.setStringList('favorite_messages', favoriteJsonList);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  Future<void> _loadFavorites() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? favoriteJsonList = prefs.getStringList('favorite_messages');
      if (favoriteJsonList != null) {
        setState(() {
          _favorites = favoriteJsonList
              .map((jsonStr) => Message.fromMap(json.decode(jsonStr)))
              .toList();
        });
      }
    } catch (e) {
    //  print('Error loading favorites: $e');
    }
  }

  void _copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    void showTopSnackBar(BuildContext context, String message) {
      final overlay = Overlay.of(context);
      final overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: 50.0,
          left: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      );

      overlay?.insert(overlayEntry);
      Future.delayed(Duration(seconds: 3), () {
        overlayEntry.remove();
      });
    }
    showTopSnackBar(context, 'The text has been copied to the clipboard');

  }

  bool _isFavorite(Message message) {
    return _favorites.contains(message);
  }
  Future<void> _downloadTextAsFile(String text) async {
    try {
      String fileName =
          "chat_${_currentChatPage?.name ?? 'default'}_${DateTime.now().millisecondsSinceEpoch}.txt";
      final bytes = utf8.encode(text);

      await FileSaver.instance.saveFile(
        name: fileName,
        ext: "txt",
        bytes: bytes,
        mimeType: MimeType.text,
      );

      void showTopSnackBar(BuildContext context, String message) {
        final overlay = Overlay.of(context);
        final overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 50.0,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );

        overlay?.insert(overlayEntry);
        Future.delayed(Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      }
      showTopSnackBar(context, 'The file has been downloaded successfully');



    } catch (e) {
      void showTopSnackBar(BuildContext context, String message) {
        final overlay = Overlay.of(context);
        final overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 50.0,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );

        overlay?.insert(overlayEntry);
        Future.delayed(Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      }
      showTopSnackBar(context, 'Error downloading file: $e');



    }
  }

  String _formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm').format(timestamp);
  }



  Future<void> _showNotification(String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'Scheduled Messages',
      channelDescription: 'This channel is for scheduled messages notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'EngoLearn',
      message,
      platformChannelSpecifics,
      payload: 'Scheduled Message',
    );
  }

  void increasePointsByCategory(String category, double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      switch (category) {
        case 'grammar':
          grammarPoints += amount;
          prefs.setDouble('grammarPoints', grammarPoints);
          // تحقق من الشرط لإرسال إشعار
          if (grammarPoints >= 100) { // مثال: عند تحقيق 100 نقطة في قواعد اللغة
            _showNotification('Congrats! I achieved 100 points in grammar.');
          }
          break;
        case 'lessons':
          lessonPoints += amount;
          prefs.setDouble('lessonPoints', lessonPoints);
          if (lessonPoints >= 50) { // مثال: عند تحقيق 50 نقطة في الدروس
            _showNotification('amazing! You have completed 50 lessons.');
          }
          break;
        case 'studyHours':
          studyHoursPoints += amount;
          prefs.setDouble('studyHoursPoints', studyHoursPoints);
          if (studyHoursPoints >= 20) { // مثال: عند تحقيق 20 ساعة دراسة
            _showNotification('excellent! I spent 20 hours studying.');
          }
          break;
        case 'listening':
          listeningPoints += amount;
          prefs.setDouble('listeningPoints', listeningPoints);
          if (listeningPoints >= 80) { // مثال: عند تحقيق 80 نقطة في الاستماع
            _showNotification('I did well! You achieved 80 points in listening.');
          }
          break;
      // أضف حالات أخرى حسب الحاجة
        case 'speaking':
          speakingPoints += amount;
          prefs.setDouble('speakingPoints', speakingPoints);
          if (speakingPoints >= 70) {
            _showNotification('amazing! I achieved 70 points in speaking.');
          }
          break;
        case 'reading':
          readingPoints += amount;
          prefs.setDouble('readingPoints', readingPoints);
          if (readingPoints >= 90) {
            _showNotification('Congrats! I achieved 90 points in reading.');
          }
          break;
        case 'writing':
          writingPoints += amount;
          prefs.setDouble('writingPoints', writingPoints);
          if (writingPoints >= 60) {
            _showNotification('I did well! I achieved 60 points in writing.');
          }
          break;
        case 'exercises':
          exercisePoints += amount;
          prefs.setDouble('exercisePoints', exercisePoints);
          if (exercisePoints >= 40) {
            _showNotification('excellent! I have completed 40 exercises.');
          }
          break;
        case 'sentenceFormation':
          sentenceFormationPoints += amount;
          prefs.setDouble('sentenceFormationPoints', sentenceFormationPoints);
          if (sentenceFormationPoints >= 30) {
            _showNotification('amazing! I made 30 sentences.');
          }
          break;
        case 'games':
          gamePoints += amount;
          prefs.setDouble('gamePoints', gamePoints);
          if (gamePoints >= 1000) { // افتراضياً gamePoints تبدأ من 900
            _showNotification('Congrats! You have collected 1000 points in games.');
          }
          break;
        default:
        // التعامل مع الفئات غير المعروفة إذا لزم الأمر
          break;
      }
    });
  }
  void increaseReadingProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      readingProgressLevel += 1;
      prefs.setInt('progressReading', readingProgressLevel);
      if (readingProgressLevel % 5 == 0) { // مثال: كل 5 مستويات
        _showNotification('Congratulations! You have reached the level $readingProgressLevel In reading.');
      }
    });
  }
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // إنشاء قنوات إشعارات متعددة إذا لزم الأمر
    const AndroidNotificationChannel channel1 = AndroidNotificationChannel(
      'progress_channel', // معرف القناة
      'Progress Notifications', // اسم القناة
      description: 'Notifications based on user progress', // وصف القناة
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel1);
  }







  Future<void> _requestNotificationPermission() async {
    // التحقق من حالة إذن الإشعارات
    var status = await Permission.notification.status;

    if (status.isGranted) {
      // الأذن ممنوحة بالفعل
      print('أذونات الإشعارات ممنوحة بالفعل.');
    } else if (status.isDenied) {
      // الأذن مرفوضة حالياً، نحاول طلب الأذن
      PermissionStatus newStatus = await Permission.notification.request();
      if (newStatus.isGranted) {
        print('أذونات الإشعارات ممنوحة.');
      } else {
        print('أذونات الإشعارات مرفوضة.');
        // يمكنك إظهار حوار للمستخدم لشرح أهمية الأذن أو توجيههم إلى الإعدادات
        _showPermissionDeniedDialog();
      }
    } else if (status.isPermanentlyDenied) {
      // الأذن مرفوضة بشكل دائم، يجب توجيه المستخدم إلى إعدادات التطبيق
      print('أذونات الإشعارات مرفوضة بشكل دائم.');
      _showOpenSettingsDialog();
    }
  }
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification permission denied'),
          content: Text('To receive notifications about your progress, please allow notifications in the app settings.'),
          actions: [
            TextButton(
              child: Text('cancellation'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Settings'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showOpenSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('إذن الإشعارات مرفوض بشكل دائم'),
          content: Text('لتلقي الإشعارات حول تقدمك، يرجى تمكين الإشعارات في إعدادات التطبيق.'),
          actions: [
            TextButton(
              child: Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('إعدادات'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // دالة جديدة لجدولة الرسائل
  void scheduleBotMessage(String text, DateTime scheduledTime) {
    Duration delay = scheduledTime.difference(DateTime.now());
    if (delay.isNegative) {
      // print("الوقت المحدد في الماضي");
      return;
    }

    Timer(delay, () {
      _showNotification(text);

      final botMessage = Message("${AppLocale.S128.getString(context)}: $text", DateTime.now(), isUser: false);
      setState(() {
        _currentChatPage?.messages.add(botMessage);
        _listKey.currentState?.insertItem(_currentChatPage!.messages.length - 1);
      });
      _saveChatPages();
      _scrollToBottom();
    });
  }

  void scheduleMultipleMessages() {
    // رسائل يومية
    List<Map<String, dynamic>> dailyMessages = [
      {
        "text": "Remember to review the new words today!",
        "time": DateTime.now().add(Duration(days: 1)) // رسالة يومية
      },
    ];




    // رسائل أسبوعية
    List<Map<String, dynamic>> weeklyMessages = [
      {
        "text": "Be sure to check out everything you learned this week!",
        "time": DateTime.now().add(Duration(days: 7)) // رسالة أسبوعية
      },
    ];


    // جدولة الرسائل اليومية
    for (var messageData in dailyMessages) {
      scheduleBotMessage(messageData["text"], messageData["time"]);
    }

    // جدولة الرسائل الأسبوعية
    for (var messageData in weeklyMessages) {
      scheduleBotMessage(messageData["text"], messageData["time"]);
    }


  }


  Widget _buildInitialOptions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("اختر موضوعًا لبدء الدردشة حوله:",
            style: TextStyle(fontSize: 18)),
        SizedBox(height: 20),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _sendMessage("الخطة التعليمية", sentiment: ''),
              child: Text("الخطة التعليمية"),
            ),
            ElevatedButton(
              onPressed: () => _sendMessage("التقدم", sentiment: ''),
              child: Text("التقدم"),
            ),
            ElevatedButton(
              onPressed: () => _sendMessage("نصيحة", sentiment: ''),
              child: Text("نصائح"),
            ),
            ElevatedButton(
              onPressed: () => _sendMessage("كم المتبقي", sentiment: ''),
              child: Text("كم المتبقي لإنهاء الخطة التعليمية"),
            ),
          ],
        ),
      ],
    );
  }

  // إضافة مؤشر الكتابة
  Widget _buildTypingIndicator() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 8),
          Text("يكتب..."),
        ],
      ),
    );
  }

  // إضافة إمكانية إرسال الصور
  Future<void> _pickImage() async {
    // هنا يمكنك استخدام حزمة مثل image_picker لاختيار الصور
    // بعد اختيار الصورة، يمكنك إضافتها كرسالة جديدة
  }

  Future<void> _createNewChatPage() async {
    if (_chatPages.length >= 20) {
      void showTopSnackBar(BuildContext context, String message) {
        final overlay = Overlay.of(context);
        final overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 50.0,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );

        overlay?.insert(overlayEntry);
        Future.delayed(Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      }
      showTopSnackBar(context, 'وصلت إلى الحد الأقصى لعدد صفحات الدردشة');

      return;
    }

    String? pageName = await _showInputDialog("تسمية صفحة الدردشة");
    if (pageName != null && pageName.trim().isNotEmpty) {
      setState(() {
        ChatPage newPage = ChatPage(name: pageName.trim(), messages: []);
        _chatPages.add(newPage);
        _currentChatPage = newPage;
      });
      _saveChatPages();
    }
  }

  Future<void> _renameChatPage(ChatPage page) async {
    String? newName = await _showInputDialog("إعادة تسمية صفحة الدردشة", initialValue: page.name);
    if (newName != null && newName.trim().isNotEmpty) {
      setState(() {
        page.name = newName.trim();
      });
      _saveChatPages();
    }
  }

  Future<void> _deleteChatPage(ChatPage page) async {
    bool? confirm = await _showConfirmationDialog("حذف صفحة الدردشة",
        "هل أنت متأكد من حذف صفحة الدردشة '${page.name}'؟");
    if (confirm == true) {
      setState(() {
        _chatPages.remove(page);
        if (_currentChatPage == page) {
          _currentChatPage = _chatPages.isNotEmpty ? _chatPages.first : null;
        }
      });
      _saveChatPages();
    }
  }

  Future<String?> _showInputDialog(String title, {String initialValue = ''}) async {
    TextEditingController dialogController =
    TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: dialogController,
            decoration: InputDecoration(hintText: "أدخل الاسم هنا"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('حفظ'),
              onPressed: () {
                Navigator.of(context).pop(dialogController.text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showConfirmationDialog(String title, String content) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('لا'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('نعم'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  void _selectChatPage(ChatPage page) {
    setState(() {
      _currentChatPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${AppLocale.S128.getString(context)}"),
        actions: [
          IconButton(
            icon: Icon(Icons.keyboard_voice_outlined,color: Colors.black,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VoiceChatPage()),
              );

            },
          ),

          IconButton(
            icon: Icon(Icons.bookmark,color: Colors.black,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    favorites: _favorites,
                    toggleFavorite: _toggleFavorite,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.black),
            onPressed: () {
              if (_currentChatPage != null) {
                setState(() {
                  _currentChatPage!.messages.clear();
                  _listKey.currentState?.setState(() {});
                });
                _saveChatPages();
                void showTopSnackBar(BuildContext context, String message) {
                  final overlay = Overlay.of(context);
                  final overlayEntry = OverlayEntry(
                    builder: (context) => Positioned(
                      top: 50.0,
                      left: MediaQuery.of(context).size.width * 0.1,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  message,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                  overlay?.insert(overlayEntry);
                  Future.delayed(Duration(seconds: 3), () {
                    overlayEntry.remove();
                  });
                }
                showTopSnackBar(context, "تم مسح سجل الدردشة");

              }
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'create':
                  _createNewChatPage();
                  break;
                case 'rename':
                  if (_currentChatPage != null) {
                    _renameChatPage(_currentChatPage!);
                  }
                  break;
                case 'delete':
                  if (_currentChatPage != null) {
                    _deleteChatPage(_currentChatPage!);
                  }
                  break;
                case 'download':
                  if (_currentChatPage != null) {
                    String allMessages = _currentChatPage!.messages
                        .map((msg) =>
                    "${msg.isUser ? 'You' : 'Bot'} (${_formatTimestamp(msg.timestamp)}): ${msg.text}")
                        .join("\n");
                    _downloadTextAsFile(allMessages);
                  }
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'create',
                  child: Text('إنشاء صفحة دردشة جديدة'),
                ),
                PopupMenuItem(
                  value: 'rename',
                  child: Text('إعادة تسمية صفحة الدردشة'),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('حذف صفحة الدردشة'),
                ),
                PopupMenuItem(
                  value: 'download',
                  child: Text('تحميل صفحة الدردشة'),
                ),
              ];
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: _buildChatPagesSelector(),

        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _currentChatPage == null
                ? Center(child: Text("لا توجد صفحات دردشة"))
                : _currentChatPage!.messages.isEmpty && showInitialOptions
                ? Center(child: _buildInitialOptions())
                : AnimatedList(
              key: _listKey,
              controller: _scrollController,
              initialItemCount: _currentChatPage!.messages.length,
              itemBuilder: (context, index, animation) {
                if (index >= _currentChatPage!.messages.length) {
                  return SizedBox.shrink();
                }
                final message = _currentChatPage!.messages[index];
                return _buildMessageItem(message, animation);
              },
            ),
          ),
          if (_isTyping) _buildTypingIndicator(),
          if (_currentChatPage != null &&
              _currentChatPage!.messages.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _quickReplies.map((text) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _sendMessage(text, sentiment: '');
                        },
                        child: Text(text),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          if (_isListening) {
                            _stopListening2();
                          } else {
                            _listen2();
                          }
                        },
                        child: Icon(_isListening ? Icons.stop : Icons.mic),
                      ),
                    ],
                  ),
                ),

                // زر لاختيار الصور
                // IconButton(
                //   icon: Icon(Icons.image),
                //   onPressed: _pickImage,
                // ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "اكتب رسالة",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onSubmitted: (text) {
                      _sendMessage(text, sentiment: '');
                      _controller.clear();
                    },
                  ),
                ),
                SizedBox(width: 8),
                ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 1.2).animate(
                    CurvedAnimation(
                        parent: _sendButtonController,
                        curve: Curves.easeInOut),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      _sendMessage(_controller.text, sentiment: '');
                      _controller.clear();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatPagesSelector() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _chatPages.length,
        itemBuilder: (context, index) {
          final page = _chatPages[index];
          return GestureDetector(
            onTap: () {
              _selectChatPage(page);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: _currentChatPage == page ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                page.name,
                style: TextStyle(
                  color: _currentChatPage == page ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageItem(Message message, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: Align(
          alignment:
          message.isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: message.isUser ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft:
                message.isUser ? Radius.circular(16) : Radius.circular(0),
                bottomRight:
                message.isUser ? Radius.circular(0) : Radius.circular(16),
              ),
            ),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: message.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      message.text,
                      textStyle: TextStyle(
                        color: message.isUser ? Colors.white : Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                      textAlign:
                      message.isUser ? TextAlign.right : TextAlign.left,
                      speed: Duration(milliseconds: 50),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: message.isUser
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    IconButton(
                      iconSize: 20,
                      icon: Icon(
                        _isFavorite(message)
                            ?Icons.bookmark
                            : Icons.bookmark_border,
                        color: Colors.black,
                      ),
                      onPressed: () => _toggleFavorite(message),
                    ),
                    IconButton(
                      iconSize: 20,
                      icon: Icon(Icons.copy, color: Colors.black),
                      onPressed: () => _copyText(message.text),
                    ),
                    IconButton(
                      iconSize: 20,
                      icon: Icon(Icons.download, color: Colors.black),
                      onPressed: () => _downloadTextAsFile(message.text),
                    ),
                    IconButton(
                      iconSize: 20,
                      icon: Icon(Icons.delete, color: Colors.black),
                      onPressed: () {
                        if (_currentChatPage != null) {
                          int index =
                          _currentChatPage!.messages.indexOf(message);
                          if (index != -1) {
                            final removedMessage =
                            _currentChatPage!.messages.removeAt(index);
                            _listKey.currentState?.removeItem(
                              index,
                                  (context, animation) =>
                                  _buildMessageItem(removedMessage, animation),
                              duration: Duration(milliseconds: 300),
                            );
                            _saveChatPages();
                            void showTopSnackBar(BuildContext context, String message) {
                              final overlay = Overlay.of(context);
                              final overlayEntry = OverlayEntry(
                                builder: (context) => Positioned(
                                  top: 50.0,
                                  left: MediaQuery.of(context).size.width * 0.1,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              message,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );

                              overlay?.insert(overlayEntry);
                              Future.delayed(Duration(seconds: 3), () {
                                overlayEntry.remove();
                              });
                            }
                            showTopSnackBar(context, "تم حذف الرسالة");

                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// نموذج للرسالة المجدولة
class ScheduledMessage {
  String text;
  DateTime scheduledTime;

  ScheduledMessage({required this.text, required this.scheduledTime});
}


class ApiService {
  String _apiKey = 'AIzaSyALhb262a99kq0E_swAqyz9bJSPCmHSQv4';

  Future<String> getTextResponse(String message) async {
    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$_apiKey');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'contents': [
        {
          'parts': [
            {
              'text': message,
            },
          ],
        },
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Simplified data extraction with null checks
        final generatedText = data?['candidates']?[0]?['content']?['parts']?[0]?['text'];
        return generatedText ?? 'No response text found';
      } else {
        // print('Error: ${response.statusCode}');
        // print('Response body: ${response.body}');
        return 'Error generating response';
      }
    } catch (e) {
      //  print('Exception in getTextResponse: $e');
      return 'Error generating response';
    }
  }

  Future<String?> getImageTextResponse(File image, String prompt) async {
    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$_apiKey');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'contents': [
        {
          'parts': [
            {
              'text': prompt,
            },
          ],
        },
        // Add image data here if the API accepts it, e.g., Base64 encoding of the image
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final generatedText = data?['candidates']?[0]?['content']?['parts']?[0]?['text'];
        return generatedText ?? 'No response text found';
      } else {
        // print('Error: ${response.statusCode}');
        // print('Response body: ${response.body}');
        return 'Error processing image';
      }
    } catch (e) {
      //print('Exception in getImageTextResponse: $e');
      return null;
    }
  }
}


class FavoritesScreen extends StatefulWidget {
  final List<Message> favorites;
  final Function(Message) toggleFavorite;

  FavoritesScreen({required this.favorites, required this.toggleFavorite});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  String _formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm').format(timestamp);
  }
  bool _isFavorite(Message message) {
    return _favorites.contains(message);
  }
  List<Message> _favorites = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: ListView.builder(
        itemCount: widget.favorites.length,
        itemBuilder: (context, index) {
          final message = widget.favorites[index];
          return Align(
            alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: message.isUser ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    message.text,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _formatTimestamp(message.timestamp),
                    style: TextStyle(
                      fontSize: 10,
                      color: message.isUser ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  // إضافة الأيقونات أسفل كل رسالة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        iconSize: 20,
                        icon: Icon(
                          _isFavorite(message)
                              ?Icons.bookmark
                              : Icons.bookmark_border,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.toggleFavorite(message);
                          });
                        },
                      ),
                      IconButton(
                        iconSize: 20,
                        icon: Icon(Icons.copy, color: Colors.black),
                        onPressed: () => Clipboard.setData(ClipboardData(text: message.text)),
                      ),
                      IconButton(
                        iconSize: 20,
                        icon: Icon(Icons.download, color: Colors.black),
                        onPressed: () => _downloadTextAsFile(context, message.text),
                      ),
                      IconButton(
                        iconSize: 20,
                        icon: Icon(Icons.delete, color: Colors.black),
                        onPressed: () {
                          setState(() {
                            widget.favorites.remove(message);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _downloadTextAsFile(BuildContext context, String text) async {
    try {
      String fileName = "favorite_${DateTime.now().millisecondsSinceEpoch}.txt";
      final bytes = utf8.encode(text);

      await FileSaver.instance.saveFile(
        name: fileName,
        ext: "txt",
        bytes: bytes,
        mimeType: MimeType.text,
      );
      void showTopSnackBar(BuildContext context, String message) {
        final overlay = Overlay.of(context);
        final overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 50.0,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );

        overlay?.insert(overlayEntry);
        Future.delayed(Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      }
      showTopSnackBar(context, 'تم تنزيل الملف بنجاح');

    } catch (e) {
      void showTopSnackBar(BuildContext context, String message) {
        final overlay = Overlay.of(context);
        final overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 50.0,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );

        overlay?.insert(overlayEntry);
        Future.delayed(Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      }
      showTopSnackBar(context, 'حدث خطأ أثناء تنزيل الملف: $e');

    }
  }
}
