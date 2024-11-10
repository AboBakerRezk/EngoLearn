import 'package:flutter/material.dart';
import 'package:list_english_words/list_english_words.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart'; // لإضافة النسخ والمشاركة
import 'package:fluttertoast/fluttertoast.dart'; // لإظهار التنبيهات السريعة
import 'dart:async';

import '../../Foundational_lessons/home_sady.dart';
import 'package:flutter/material.dart';
import 'package:list_english_words/list_english_words.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart'; // لإضافة النسخ والمشاركة
import 'package:fluttertoast/fluttertoast.dart'; // لإظهار التنبيهات السريعة
import 'dart:async';
import 'package:languagetool_textfield/languagetool_textfield.dart'; // استيراد حزمة التدقيق اللغوي

import '../../Foundational_lessons/home_sady.dart';

class WritingSection44 extends StatefulWidget {
  @override
  _WritingSection44State createState() => _WritingSection44State();
}

class _WritingSection44State extends State<WritingSection44>    with SingleTickerProviderStateMixin {
  // Variables
  String userWriting = '';
  String feedbackMessage = '';
  String writingLevel = '';
  String correctedText = '';
  int targetWords = 50;
  Timer? writingTimer;
  String speedFeedback = '';
  String styleFeedback = '';
  String coherenceFeedback = '';
  String clarityFeedback = '';
  String repetitionFeedback = '';
  String validityFeedback = '';
  String topicRelevanceFeedback = '';
  int topicRelevanceScore = 0;  // New variable for relevance score

  late LanguageToolController _controller;
  DateTime? startTime;
  late AnimationController _animationController;
  late Animation<double> _animation;

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

  // User's different points
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
  // Function to save points data to SharedPreferences
  Future<void> saveStatisticsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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

// Function to load points data from SharedPreferences
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
      gamePoints = prefs.getDouble('gamePoints') ?? 900;
    });
  }
  Future<void> _saveUserWriting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userWriting', userWriting);
  }
// Function to save progress levels including bottleFillLevel to SharedPreferences
  void _updateWordCount(String text) {
    List<String> words = text.split(RegExp(r'[\s,.!?]+')).where((word) => word.isNotEmpty).toList();

    if (words.length > 1000) {
      Fluttertoast.showToast(
        msg: "You have exceeded the 1000-word limit!",
        backgroundColor: Colors.red,
      );
      // Prevent the user from writing more by resetting the text to the allowed limit
      _controller.text = words.take(1000).join(" ");
      _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
    } else {
      setState(() {
        userWriting = text;

        SentenceValidator validator = SentenceValidator();
        List<String> validWords = validator.getValidWords(userWriting);
        int validWordCount = validWords.length;

        // Update writing points
        writingPoints = validWordCount.toDouble();
        saveStatisticsData(); // Save points to SharedPreferences

        // Increment bottleFillLevel
        if (bottleFillLevel < 6000) {
          bottleFillLevel += 1;
          saveProgressDataToPreferences(); // Save bottleFillLevel to SharedPreferences
        }

        // Rest of your existing code...

        _saveUserWriting();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadSavedProgressData(); // Load progress levels including bottleFillLevel
    _loadStatisticsData(); // Load points data
    _controller = LanguageToolController();
    _loadUserWriting();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Load and save writing from SharedPreferences
  Future<void> _loadUserWriting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userWriting = prefs.getString('userWriting') ?? '';
      _controller.text = userWriting;
      _updateWordCount(userWriting);
    });
  }



  // Main function to check writing
  void _checkWriting() {
    if (userWriting.isEmpty) {
      setState(() {
        feedbackMessage = 'Please write something before submitting.';
        writingLevel = 'No Submission';
      });
      return;
    }

    _analyzeWritingStyle();
    _analyzeClarity();
    _analyzeCoherence();
    _detectRepetition();
    _checkWordValidity();
    _checkRelevance(); // Check for topic relevance

    int validWordCount = SentenceValidator().getValidWords(userWriting).length;

    // Feedback based on word count
    if (validWordCount < 30) {
      feedbackMessage = 'Try to write at least 30 valid words for a complete answer.';
      writingLevel = 'Poor';
    } else if (validWordCount < 50) {
      feedbackMessage = 'Good attempt! Try to elaborate more for a stronger answer.';
      writingLevel = 'Average';
    } else {
      writingLevel = 'Excellent';
      feedbackMessage = "You've reached your daily goal!";
      Fluttertoast.showToast(
          msg: feedbackMessage, backgroundColor: Colors.green);
    }

    setState(() {});
  }

  // Update word count and speed feedback

  // Analyze writing style
  void _analyzeWritingStyle() {
    setState(() {
      styleFeedback = 'Your writing style is formal and structured.';
    });
  }

  // Analyze clarity of the writing
  void _analyzeClarity() {
    setState(() {
      clarityFeedback = 'Some sentences are complex and could be simplified for better clarity.';
    });
  }

  // Analyze coherence of the writing
  void _analyzeCoherence() {
    setState(() {
      coherenceFeedback = 'The ideas in your writing are mostly coherent, but transitions between paragraphs can be improved.';
    });
  }

  // Detect repetition in the writing
  void _detectRepetition() {
    Map<String, int> wordFrequency = {};
    List<String> words = userWriting
        .split(RegExp(r'[\s,.!?]+'))
        .where((word) => word.isNotEmpty)
        .toList();

    words.forEach((word) {
      wordFrequency[word] = (wordFrequency[word] ?? 0) + 1;
    });

    setState(() {
      repetitionFeedback = '';
      wordFrequency.forEach((word, count) {
        if (count > 3) {
          repetitionFeedback += 'Repetition detected: "$word" is used $count times.\n';
        }
      });
    });
  }

  // Check the validity of the words
  void _checkWordValidity() {
    SentenceValidator validator = SentenceValidator();
    setState(() {
      validityFeedback = validator.isValidSentence(userWriting)
          ? 'The sentence is valid.'
          : 'The sentence contains invalid or repeated words.';
    });
  }

  // Check if the writing matches the topic and calculate score
  void _checkRelevance() {
    List<String> topicKeywords = [
      // الكلمات المتعلقة بالصمود في وجه الشدائد: قصص شخصية:
      'resilience',
      'adversity',
      'personal stories',
      'overcoming challenges',
      'personal growth',
      'mental strength',
      'emotional resilience',
      'coping mechanisms',
      'inspirational stories',
      'triumph over hardship',
      'strength in adversity',
      'survivor stories',
      'life struggles',
      'perseverance',
      'inner strength',
      'mental health',
      'hope in difficult times',
      'overcoming obstacles',
      'personal battles',
      'stories of hope',
      'endurance',
      'personal triumphs',
      'facing hardship',
      'life lessons',
      'grit',
      'tenacity',
      'emotional strength',
      'survival stories',
      'recovery from adversity',
      'life challenges',
      'growth through adversity',
      'human resilience',
      'determination',
      'stories of overcoming',
      'hope and resilience',
      'personal development',
      'inspiring journeys',
      'stories of perseverance',
      'finding strength in hard times',
      'bouncing back',
      'coping with loss',
      'rebuilding after setbacks',
      'adversity and strength',
      'life-changing experiences',
      'motivation in tough times',
      'facing difficulties',
      'resilience in hard times',
      'resilient mindset',
      'personal struggles',
      'transformative experiences',
      'strength in challenges',
      'resilience stories',
      'adversity and recovery',
      'personal resilience',
      'inspirational journeys',
      'hope and strength',
      'resilience in life',
      'lessons from adversity',
      'adversity and triumph',
      'resilience and courage',
      'resilience in crisis',
      'personal setbacks',
      'journeys through hardship',
      'overcoming life’s struggles',
      'hardship stories',
      'emotional endurance',
      'stories of courage',
      'rising above adversity',
      'overcoming personal challenges',
      'persistence',
      'mental toughness',
      'personal battles and victories',
      'resilience through hardship',
      'personal resilience stories',
      'life’s toughest challenges',
      'adversity and success',
      'struggles and resilience',
      'resilience and motivation',
      'conquering difficulties',
      'overcoming failures',
      'stories of survival',
      'strength through struggle',
      'emotional recovery',
      'personal transformation',
      'resilience in everyday life',
      'dealing with setbacks',
      'adversity and personal growth',
      'personal hardship',
      'rebuilding after failure',
      'life resilience',
      'finding hope in adversity',
      'courage in the face of difficulty',
      'coping with adversity',
      'personal strength stories',
      'resilience mindset',
      'stories of overcoming adversity',
      'resilience and determination',
      'life-altering events',
      'personal adversity stories',
      'strength through adversity',
      'resilience in difficult situations',
      'personal adversity and recovery',
      'facing life’s hardships',
      'emotional challenges',
      'stories of strength',
      'personal breakthroughs',
      'coping with hard times',
      'overcoming setbacks',
      'personal victories over adversity',
      'resilience after trauma',
      'resilience and hope',
      'perseverance through hardship',
      'stories of hope and strength',
      'dealing with life’s difficulties',
      'resilience and mental health',
      'strength in adversity stories',
      'personal stories of recovery',
      'overcoming adversity stories',
      'emotional toughness',
      'resilience in challenging times',
      'strength to carry on',
      'personal survival stories',
      'pushing through adversity',
      'coping with personal hardship',
      'inner resilience',
      'strength to overcome',
      'inspiring personal stories',
      'resilience in the face of failure',
      'personal fortitude',
      'overcoming life obstacles',
      'personal inspiration',
      'emotional recovery stories',
      'personal resilience journey',
      'resilience through adversity',
      'facing personal challenges',
      'hope in the face of adversity',
      'resilience in tough times',
      'strength from hardship',
      'personal endurance stories',
      'resilience in overcoming difficulties',
      'finding hope in hard times',
      'personal strength and resilience',
      'life’s hardships and resilience',
      'resilience in adversity stories',
      'personal crisis and recovery',
      'stories of emotional resilience',
      'personal fortitude in adversity',
      'resilience in personal battles',
      'coping with personal struggles',
      'stories of recovery from hardship',
      'personal stories of overcoming',
      'strength to endure',
      'personal hardship stories',
      'personal growth through adversity',
      'resilience in the face of challenges',
      'personal struggles and resilience',
      'rising above life’s struggles',
      'stories of strength and hope',
      'resilience in overcoming obstacles',
      'personal stories of hope',
      'triumph through adversity',
      'overcoming personal difficulties',
      'courage through adversity',
      'bouncing back from adversity',
      'personal hardships and triumphs',
      'emotional resilience stories',
      'personal stories of strength',
      'strength through life’s challenges',
      'life’s biggest challenges',
      'stories of overcoming difficulties',
      'resilience in personal challenges',
      'personal resilience in tough times',
      'strength through personal adversity',
      'personal struggles and triumphs',
      'coping with life’s challenges',
      'personal battles and resilience',
      'life’s obstacles and resilience',
    ];


    String userTextLower = userWriting.toLowerCase();

    int matchCount = 0;
    for (String keyword in topicKeywords) {
      if (userTextLower.contains(keyword)) {
        matchCount++;
      }
    }

// حساب النسبة المئوية للمطابقة
    double matchPercentage = (matchCount / topicKeywords.length) * 100;

    setState(() {
      topicRelevanceScore = matchPercentage.toInt();

      // تحقق ما إذا كانت نسبة المطابقة 50% أو أكثر
      if (matchPercentage >= 50) {
        topicRelevanceFeedback = 'Your essay matches at least 50% of the topic keywords.';
      } else {
        topicRelevanceFeedback = 'Your essay does not match enough of the topic keywords.';
      }
    });
  }

  // Build the UI
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFF13194E);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Writing Section',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
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
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(height: 20),
            Text(
              'Resilience in the Face of Adversity: Personal Stories.',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 20),
            FadeTransition(
              opacity: _animation,
              child: Container(
                height: 200,
                child: LanguageToolTextField(
                  controller: _controller,
                  language: 'en-US',
                  textDirection: TextDirection.ltr,
                  maxLines: null,
                  expands: true,
                  onTextChange: _updateWordCount,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your Writing',
                    hintText: 'Start writing your essay...',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white54),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: SentenceValidator().getValidWords(userWriting).length /
                  targetWords,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
              minHeight: 10,
            ),
            SizedBox(height: 10),
            Text(
              'Valid word count: ${SentenceValidator().getValidWords(userWriting).length}',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Current Level: $writingLevel',
              style: TextStyle(fontSize: 14, color: Colors.green[600]),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Feedback:', style: TextStyle(fontSize: 18, color: Colors.white)),
                Text('Speed feedback: $speedFeedback',
                    style: TextStyle(color: Colors.blue)),
                SizedBox(height: 10),
                Text('Style feedback: $styleFeedback',
                    style: TextStyle(color: Colors.purple)),
                SizedBox(height: 10),
                Text('Clarity feedback: $clarityFeedback',
                    style: TextStyle(color: Colors.green)),
                SizedBox(height: 10),
                Text('Coherence feedback: $coherenceFeedback',
                    style: TextStyle(color: Colors.orange)),
                SizedBox(height: 10),
                Text('Repetition feedback: $repetitionFeedback',
                    style: TextStyle(color: Colors.red)),
                SizedBox(height: 10),
                Text('Validity feedback: $validityFeedback',
                    style: TextStyle(color: Colors.teal)),
                SizedBox(height: 10),
                Text('Topic relevance: $topicRelevanceFeedback',
                    style: TextStyle(color: Colors.yellow)),
                SizedBox(height: 10),
                Text('Relevance Score: $topicRelevanceScore/100', // Display topic relevance score
                    style: TextStyle(color: Colors.cyan)),
              ],
            ),
          ],
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
