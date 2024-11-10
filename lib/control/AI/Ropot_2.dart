

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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Robot_chat.dart';
import '../../settings/setting_2.dart';
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

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  final List<Message> _favorites = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final ApiService apiService = ApiService();
  final Random _random = Random();


  late AnimationController _sendButtonController;

  double totalPoints = 0;
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
    _loadMessages();
    _loadFavorites();
    _sendButtonController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _shuffleQuickReplies();
    _initializeNotifications();
    scheduleMultipleMessages();
    _loadUserData();
  }

  @override
  void dispose() {
    _controller.dispose();
    _sendButtonController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalPoints = prefs.getDouble('totalPoints') ?? 0;
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
      totalPoints += points;
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

    if (totalPoints >= 5000 && totalPoints < 10000) {
      message =
      "مبروك! لقد وصلت إلى 5000 نقطة. أنت في تقدم ممتاز!";
    } else if (totalPoints >= 10000) {
      message =
      "تهانينا! لقد حققت هدف الخطة التعليمية وأكملت 10000 نقطة.";
    }

    final prefs = await SharedPreferences.getInstance();
    DateTime lastUpdateDate = DateTime.tryParse(
        prefs.getString('lastUpdateDate') ?? '') ??
        DateTime.now();

    if (DateTime.now().day != lastUpdateDate.day) {
      if (dailyPoints > (prefs.getDouble('previousDayPoints') ?? 0)) {
        message = "لقد جمعت اليوم نقاطًا أكثر من أمس. أداء رائع!";
      } else {
        message = "حاول جمع نقاط أكثر غدًا للوصول إلى أهدافك!";
      }

      prefs.setDouble('previousDayPoints', dailyPoints);
      dailyPoints = 0;
      prefs.setString('lastUpdateDate', DateTime.now().toIso8601String());
      await _saveUserData();
    }

    double pointsRemaining = goalPoints - totalPoints;
    if (pointsRemaining > 0 && message == null) {
      message =
      "أنت على بُعد ${pointsRemaining.toStringAsFixed(0)} نقطة من إكمال الخطة التعليمية.";
    }

    if (message != null) {
      _sendMessageToUser(message);
    }
  }

  void _sendMessageToUser(String message) {
    final botMessage = Message("${AppLocale.S128.getString(context)}: $message", DateTime.now(), isUser: false);
    setState(() {
      _messages.add(botMessage);
      _listKey.currentState?.insertItem(_messages.length - 1);
      showInitialOptions = false;
    });
    _saveMessages();
    _scrollToBottom();
  }

  Future<void> _sendMessage(String text) async {
    if (text.isEmpty) return;

    _sendButtonController
        .forward()
        .then((_) => _sendButtonController.reverse());

    final message = Message("You: $text", DateTime.now(), isUser: true);
    setState(() {
      _messages.add(message);
      _listKey.currentState?.insertItem(_messages.length - 1);
      showInitialOptions = false;
    });
    _saveMessages();
    _scrollToBottom();

    // إظهار مؤشر الكتابة
    setState(() {
      _isTyping = true;
    });

    try {
      String response;
      if (text.toLowerCase().contains("التقدم")) {
        response =
        "إجمالي النقاط الخاصة بك هو $totalPoints، وأنت في مستوى $userRank. استمر في العمل لتحقيق المزيد!";
      } else if (text.toLowerCase().contains("نصيحة")) {
        response =
        "حافظ على الاستمرارية في الدراسة واحرص على تحديد أهداف يومية.";
      } else if (text.toLowerCase().contains("الخطة التعليمية")) {
        response = _generateLearningPlan();
      } else if (text.toLowerCase().contains("كم المتبقي")) {
        double pointsRemaining = goalPoints - totalPoints;
        response =
        "أنت على بُعد ${pointsRemaining.toStringAsFixed(0)} نقطة من إكمال الخطة التعليمية.";
      } else {
        response = await apiService.getTextResponse(text);
      }

      // إضافة تأخير لمحاكاة الكتابة
      await Future.delayed(Duration(seconds: 1));

      final botMessage =
      Message("${AppLocale.S128.getString(context)}: $response", DateTime.now(), isUser: false);
      setState(() {
        _messages.add(botMessage);
        _listKey.currentState?.insertItem(_messages.length - 1);
        _isTyping = false;
      });
      _saveMessages();
      _scrollToBottom();

      await _updatePoints(100);
    } catch (e) {
      final errorMessage = Message(
          "${AppLocale.S128.getString(context)}: حدث خطأ أثناء معالجة الرسالة.", DateTime.now(),
          isUser: false);
      setState(() {
        _messages.add(errorMessage);
        _listKey.currentState?.insertItem(_messages.length - 1);
        _isTyping = false;
      });
      _saveMessages();
      _scrollToBottom();
    }
  }

  String _generateLearningPlan() {
    return """
إليك خطتك التعليمية المقترحة:

1. **الاستماع**: قم بالاستماع إلى المحادثات والنصوص باللغة المستهدفة لمدة 30 دقيقة يوميًا.
2. **التحدث**: تمرن على التحدث مع متحدثين أصليين أو عبر تطبيقات التحدث لمدة 20 دقيقة يوميًا.
3. **القواعد**: خصص 15 دقيقة لدراسة قواعد اللغة وفهمها.
4. **الكلمات**: تعلم 10 كلمات جديدة كل يوم واستخدمها في جمل.
5. **الكتابة**: اكتب فقرة أو يوميات باللغة المستهدفة لمدة 15 دقيقة.
6. **القراءة**: اقرأ مقالات أو قصص قصيرة لمدة 20 دقيقة يوميًا.

استمر على هذه الخطة يوميًا لتحقيق تقدم ملحوظ في مستواك اللغوي.
""";
  }

  void _shuffleQuickReplies() {
    _quickReplies.shuffle(_random);
  }

  Future<void> _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedMessages = prefs.getStringList('chat_messages');
    if (savedMessages != null) {
      for (var messageJson in savedMessages) {
        final message = Message.fromMap(json.decode(messageJson));
        _messages.add(message);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _listKey.currentState?.insertItem(_messages.indexOf(message));
        });
      }
    }
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedFavorites = prefs.getStringList('favorite_messages');
    if (savedFavorites != null) {
      setState(() {
        _favorites.addAll(savedFavorites
            .map((favoriteJson) => Message.fromMap(json.decode(favoriteJson)))
            .toList());
      });
    }
  }

  Future<void> _saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> messageJsonList =
    _messages.map((message) => json.encode(message.toMap())).toList();
    await prefs.setStringList('chat_messages', messageJsonList);
  }

  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteJsonList =
    _favorites.map((favorite) => json.encode(favorite.toMap())).toList();
    await prefs.setStringList('favorite_messages', favoriteJsonList);
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

  void _copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم نسخ النص إلى الحافظة')),
    );
  }

  bool _isFavorite(Message message) {
    return _favorites.contains(message);
  }

  Future<void> _downloadTextAsFile(String text) async {
    try {
      String fileName =
          "message_${DateTime.now().millisecondsSinceEpoch}.txt";
      final bytes = utf8.encode(text);

      await FileSaver.instance.saveFile(
        name: fileName,
        ext: "txt",
        bytes: bytes,
        mimeType: MimeType.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم تنزيل الملف بنجاح')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في تنزيل الملف: $e')),
      );
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm').format(timestamp);
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification(String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'Scheduled Messages',
      channelDescription:
      'This channel is for scheduled messages notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'رسالة مجدولة',
      message,
      platformChannelSpecifics,
      payload: 'Scheduled Message',
    );
  }

  // دالة جديدة لجدولة الرسائل
  void scheduleBotMessage(String text, DateTime scheduledTime) {
    Duration delay = scheduledTime.difference(DateTime.now());
    if (delay.isNegative) {
      print("الوقت المحدد في الماضي");
      return;
    }

    Timer(delay, () {
      _showNotification(text);

      final botMessage = Message("${AppLocale.S128.getString(context)}: $text", DateTime.now(), isUser: false);
      setState(() {
        _messages.add(botMessage);
        _listKey.currentState?.insertItem(_messages.length - 1);
      });
      _saveMessages();
      _scrollToBottom();
    });
  }

  void scheduleMultipleMessages() {
    List<Map<String, dynamic>> messages = [
      {
        "text": "تذكر مراجعة الكلمات الجديدة اليوم!",
        "time": DateTime.now().add(Duration(minutes: 1))
      },
      {
        "text": "حان وقت التمرن على التحدث!",
        "time": DateTime.now().add(Duration(minutes: 5))
      },
      {
        "text": "لا تنسَ قراءة مقال اليوم.",
        "time": DateTime.now().add(Duration(minutes: 10))
      },
    ];

    for (var messageData in messages) {
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
              onPressed: () => _sendMessage("الخطة التعليمية"),
              child: Text("الخطة التعليمية"),
            ),
            ElevatedButton(
              onPressed: () => _sendMessage("التقدم"),
              child: Text("التقدم"),
            ),
            ElevatedButton(
              onPressed: () => _sendMessage("نصيحة"),
              child: Text("نصائح"),
            ),
            ElevatedButton(
              onPressed: () => _sendMessage("كم المتبقي"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${AppLocale.S128.getString(context)}"),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.favorite),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => FavoritesScreen(
          //           favorites: _favorites,
          //           toggleFavorite: _toggleFavorite,
          //         ),
          //       ),
          //     );
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              for (int i = _messages.length - 1; i >= 0; i--) {
                final removedMessage = _messages.removeAt(i);
                _listKey.currentState?.removeItem(
                  i,
                      (context, animation) => _buildMessageItem(removedMessage, animation),
                  duration: Duration(milliseconds: 300),
                );
              }
              _saveMessages();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Chat history cleared")),
              );
            },
          ),
        ],
      ),       body: Column(
      children: [
        Expanded(
          child: _messages.isEmpty && showInitialOptions
              ? Center(child: _buildInitialOptions())
              : AnimatedList(
            key: _listKey,
            controller: _scrollController,
            initialItemCount: _messages.length,
            itemBuilder: (context, index, animation) {
              if (index >= _messages.length) {
                return SizedBox.shrink();
              }
              final message = _messages[index];
              return _buildMessageItem(message, animation);
            },
          ),
        ),
        if (_isTyping) _buildTypingIndicator(),
        if (_messages.isNotEmpty)
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
                        _sendMessage(text);
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
              // زر لاختيار الصور
              IconButton(
                icon: Icon(Icons.image),
                onPressed: _pickImage,
              ),
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
                    _sendMessage(text);
                    _controller.clear();
                  },
                ),
              ),
              SizedBox(width: 8),
              ScaleTransition(
                scale: Tween<double>(begin: 1.0, end: 1.2).animate(
                  CurvedAnimation(
                      parent: _sendButtonController, curve: Curves.easeInOut),
                ),
                child: IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    _sendMessage(_controller.text);
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
                topRight: Radius.circular(16),
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
                            ? Icons.favorite
                            : Icons.favorite_border,
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
                        int index = _messages.indexOf(message);
                        if (index != -1) {
                          final removedMessage = _messages.removeAt(index);
                          _listKey.currentState?.removeItem(
                            index,
                                (context, animation) =>
                                _buildMessageItem(removedMessage, animation),
                            duration: Duration(milliseconds: 300),
                          );
                          _saveMessages();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("تم حذف الرسالة")),
                          );
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

// نموذج للرسائل المجدولة
class ScheduledMessage {
  final String text;
  final DateTime scheduledTime;

  ScheduledMessage(this.text, this.scheduledTime);
}
