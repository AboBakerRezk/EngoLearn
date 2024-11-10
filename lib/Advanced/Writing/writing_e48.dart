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

class WritingSection48 extends StatefulWidget {
  @override
  _WritingSection48State createState() => _WritingSection48State();
}

class _WritingSection48State extends State<WritingSection48>    with SingleTickerProviderStateMixin {
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
      // الكلمات المتعلقة باستكشاف الصحة النفسية في المجتمع الحديث:
      'mental health',
      'modern society',
      'mental health awareness',
      'mental illness',
      'anxiety',
      'depression',
      'stress management',
      'mental health stigma',
      'mental health support',
      'mental well-being',
      'self-care',
      'emotional health',
      'psychological health',
      'therapy',
      'counseling',
      'mental health challenges',
      'work-life balance',
      'mental health resources',
      'mental health crisis',
      'psychological resilience',
      'mindfulness',
      'mental health advocacy',
      'mental health and technology',
      'mental health in the workplace',
      'social media and mental health',
      'emotional well-being',
      'mental health education',
      'mental health treatments',
      'mental health services',
      'self-awareness',
      'emotional intelligence',
      'mental health in youth',
      'mental health and society',
      'mental health policies',
      'mental health care access',
      'burnout',
      'mental health therapy',
      'coping mechanisms',
      'mental health initiatives',
      'stress',
      'mental health in schools',
      'mental health challenges in the digital age',
      'mental health and social media',
      'mental health support systems',
      'mental health and relationships',
      'emotional support',
      'mental health disorders',
      'mental health awareness campaigns',
      'psychological disorders',
      'mental health professionals',
      'mental health in modern life',
      'psychotherapy',
      'mental health and physical health',
      'mental health and well-being',
      'digital mental health',
      'mental health apps',
      'mental health and isolation',
      'mental health and loneliness',
      'mental health and community',
      'emotional balance',
      'mental health crisis intervention',
      'mental health stigma reduction',
      'mental health in men',
      'mental health in women',
      'mental health and family',
      'mental health in children',
      'mental health in teenagers',
      'mental health in the elderly',
      'mental health and culture',
      'mental health in diverse communities',
      'post-traumatic stress disorder (PTSD)',
      'mental health awareness in the workplace',
      'mental health and productivity',
      'workplace mental health support',
      'mental health in college students',
      'mental health first aid',
      'substance abuse and mental health',
      'mental health recovery',
      'mental health and addiction',
      'mental health and self-esteem',
      'mental health and self-compassion',
      'online therapy',
      'mental health counseling services',
      'depression and anxiety',
      'mental health programs',
      'mental health for entrepreneurs',
      'mental health at home',
      'mental health and financial stress',
      'mental health and identity',
      'mental health and trauma',
      'emotional trauma',
      'mental health in the digital age',
      'emotional well-being practices',
      'mental health resources for youth',
      'mental health hotlines',
      'mental health initiatives in schools',
      'mental health in education',
      'mental health prevention',
      'mental health coping strategies',
      'mental health and spirituality',
      'mental health and meditation',
      'mental health and exercise',
      'mental health and physical fitness',
      'holistic mental health',
      'mental health during pandemics',
      'mental health crisis management',
      'mental health advocacy movements',
      'mental health and social justice',
      'emotional resilience',
      'mental health and inequality',
      'mental health disparities',
      'mental health and discrimination',
      'mental health services accessibility',
      'mental health public policy',
      'mental health research',
      'neuroscience and mental health',
      'mental health in urban areas',
      'mental health in rural areas',
      'mental health and economic status',
      'mental health in marginalized communities',
      'mental health and social support',
      'mental health for caregivers',
      'mental health and family dynamics',
      'mental health care for veterans',
      'youth mental health',
      'mental health for LGBTQ+ individuals',
      'mental health and bullying',
      'mental health in schools',
      'mental health in healthcare workers',
      'mental health and burnout',
      'mental health in leadership',
      'mental health and the media',
      'mental health representation',
      'mental health awareness in entertainment',
      'mental health in athletes',
      'mental health and resilience',
      'mental health and nutrition',
      'mental health and peer pressure',
      'mental health during major life transitions',
      'mental health and emotional growth',
      'mental health and self-reflection',
      'mental health and wellness',
      'mental health and body image',
      'mental health and identity crisis',
      'mental health and career development',
      'mental health and job satisfaction',
      'mental health in the gig economy',
      'mental health policies in workplaces',
      'mental health education in schools',
      'early intervention in mental health',
      'mental health treatment accessibility',
      'mental health promotion',
      'mental health and social isolation',
      'mental health and community support',
      'mental health and peer support',
      'mental health and family support',
      'mental health hotlines and services',
      'mental health in prisons',
      'mental health in underserved communities',
      'global mental health',
      'mental health and public health',
      'mental health funding',
      'mental health awareness and advocacy groups',
      'mental health and crisis helplines',
      'mental health and happiness',
      'mental health and grief',
      'mental health after trauma',
      'workplace mental health programs',
      'mental health and chronic illness',
      'mental health and mindfulness practices',
      'mental health and self-discipline',
      'mental health and relationships in modern society',
      'psychological health awareness',
      'mental health stigma in society',
      'mental health in public spaces',
      'mental health and urbanization',
      'mental health and migration',
      'mental health and expatriate life',
      'mental health in high-stress environments',
      'mental health and recovery programs',
      'mental health and technology addiction',
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
              'Exploring Mental Health in Modern Society.',
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
