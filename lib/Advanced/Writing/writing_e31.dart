import 'package:flutter/material.dart';
import 'package:list_english_words/list_english_words.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:languagetool_textfield/languagetool_textfield.dart';

class WritingSection31 extends StatefulWidget {
  @override
  _WritingSection31State createState() => _WritingSection31State();
}

class _WritingSection31State extends State<WritingSection31>
    with SingleTickerProviderStateMixin {
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
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('progressReading', readingProgressLevel);
    await prefs.setInt('progressListening', listeningProgressLevel);
    await prefs.setInt('progressWriting', writingProgressLevel);
    await prefs.setInt('progressGrammar', grammarProgressLevel);
    await prefs.setInt('bottleLevel', bottleFillLevel); // Save bottleFillLevel
  }
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
      // كلمات عامة عن التكنولوجيا
      'technology', 'innovation', 'digital', 'automation', 'software', 'hardware', 'data',
      'computing', 'cyber', 'network', 'internet', 'cloud', 'system', 'device', 'platform',

      // كلمات متعلقة بالذكاء الاصطناعي
      'artificial intelligence', 'ai', 'machine learning', 'deep learning', 'neural networks',
      'algorithm', 'automation', 'cognitive computing', 'natural language processing',
      'ai ethics', 'ai governance', 'intelligent systems', 'ai-powered', 'ai in healthcare',
      'ai in education', 'ai in finance', 'ai in business', 'ai in marketing', 'ai research',
      'ai tools', 'supervised learning', 'unsupervised learning', 'recurrent neural networks',

      // كلمات متعلقة بالبرمجيات
      'programming', 'coding', 'software development', 'app', 'mobile app', 'application',
      'open source', 'backend', 'frontend', 'debugging', 'framework', 'library', 'API',
      'user interface', 'user experience', 'cloud computing', 'SaaS', 'PaaS', 'IaaS',
      'virtual machine', 'virtualization', 'microservices', 'agile development', 'devops',
      'continuous integration', 'continuous delivery', 'version control', 'repository',
      'software testing', 'software engineering', 'code review', 'bug tracking', 'code quality',

      // كلمات متعلقة بالبيانات
      'data', 'data analysis', 'data mining', 'big data', 'data science', 'data processing',
      'data visualization', 'structured data', 'unstructured data', 'data integrity',
      'data security', 'data privacy', 'data governance', 'data warehouse', 'data lake',
      'data modeling', 'data encryption', 'predictive analytics', 'business intelligence',
      'real-time data', 'data-driven', 'data insights', 'ETL (Extract, Transform, Load)',
      'data analytics', 'data pipeline', 'data storage', 'data validation', 'data backup',

      // كلمات متعلقة بالأجهزة
      'hardware', 'device', 'smartphone', 'tablet', 'laptop', 'desktop', 'PC', 'server',
      'processor', 'CPU', 'GPU', 'RAM', 'SSD', 'hard drive', 'motherboard', 'circuit',
      'microchip', 'sensor', 'IoT device', 'smartwatch', 'wearable technology', '3D printer',
      'virtual reality headset', 'augmented reality glasses', 'robotics', 'drones',
      'automated vehicle', 'autonomous systems', 'electric car', 'charging station',
      'battery technology', 'solar panel', 'smart home', 'home automation',

      // كلمات متعلقة بالشبكات
      'network', 'LAN', 'WAN', 'VPN', 'Wi-Fi', 'router', 'modem', 'firewall', 'switch',
      'ethernet', 'IP address', 'TCP/IP', 'DNS', 'network security', 'bandwidth',
      'latency', 'network topology', 'wireless communication', 'fiber optics', '5G', '4G',
      '3G', 'mobile network', 'cellular network', 'signal', 'Bluetooth', 'NFC', 'RFID',
      'satellite communication', 'data transmission', 'broadband', 'network infrastructure',

      // كلمات متعلقة بالإنترنت
      'internet', 'world wide web', 'browser', 'website', 'web page', 'web application',
      'HTML', 'CSS', 'JavaScript', 'PHP', 'database', 'SQL', 'NoSQL', 'backend', 'frontend',
      'web development', 'web hosting', 'domain name', 'IP address', 'cloud service',
      'cloud storage', 'CDN (Content Delivery Network)', 'internet security', 'malware',
      'phishing', 'DDoS attack', 'encryption', 'SSL certificate', 'search engine',
      'SEO (Search Engine Optimization)', 'online marketing', 'e-commerce', 'digital payment',

      // كلمات متعلقة بالتخزين السحابي
      'cloud', 'cloud computing', 'cloud storage', 'SaaS', 'PaaS', 'IaaS', 'virtual machine',
      'hybrid cloud', 'public cloud', 'private cloud', 'cloud migration', 'cloud security',
      'cloud infrastructure', 'scalability', 'elasticity', 'cloud provider', 'data center',
      'serverless computing', 'containerization', 'Kubernetes', 'Docker', 'cloud backup',
      'cloud disaster recovery', 'cloud platform', 'cloud architecture', 'cloud compliance',
      'multi-cloud', 'cloud-native', 'cloud networking',

      // كلمات متعلقة بالأمن السيبراني
      'cybersecurity', 'encryption', 'firewall', 'malware', 'antivirus', 'ransomware',
      'phishing', 'DDoS attack', 'hacking', 'ethical hacking', 'penetration testing',
      'vulnerability', 'zero-day exploit', 'password protection', 'data breach', 'cyber attack',
      'network security', 'data encryption', 'security audit', 'security protocol',
      'multi-factor authentication', 'VPN', 'secure browsing', 'cyber risk', 'data privacy',
      'GDPR compliance', 'cyber defense', 'endpoint security', 'identity theft', 'dark web',

      // كلمات متعلقة بالذكاء الاصطناعي والتعلم الآلي
      'artificial intelligence', 'machine learning', 'deep learning', 'neural networks',
      'supervised learning', 'unsupervised learning', 'reinforcement learning', 'natural language processing',
      'speech recognition', 'image recognition', 'computer vision', 'robotics', 'automation',
      'AI ethics', 'AI bias', 'AI governance', 'autonomous vehicles', 'AI in healthcare',
      'AI in finance', 'AI in education', 'AI in business', 'AI research', 'AI applications',
      'AI tools', 'predictive analytics', 'intelligent automation', 'conversational AI',
      'smart algorithms', 'AI-powered systems', 'AI in retail', 'AI in marketing',
      'AI in manufacturing', 'augmented intelligence', 'AI regulations',

      // كلمات متعلقة بالواقع الافتراضي والمعزز
      'virtual reality', 'augmented reality', 'VR headset', 'AR glasses', 'immersive experience',
      '3D environment', 'simulation', 'virtual world', 'interactive experience',
      'haptic feedback', 'VR gaming', 'AR in education', 'AR in marketing',
      'VR in training', 'mixed reality', 'extended reality', 'VR in healthcare',
      'VR in real estate', 'AR in retail', 'VR in entertainment', 'spatial computing',

      // كلمات متعلقة بتكنولوجيا المال (FinTech)
      'fintech', 'blockchain', 'cryptocurrency', 'Bitcoin', 'Ethereum', 'smart contracts',
      'decentralized finance (DeFi)', 'digital wallet', 'mobile banking', 'online payment',
      'digital currency', 'peer-to-peer lending', 'crowdfunding', 'financial technology',
      'robo-advisors', 'payment gateway', 'cryptocurrency exchange', 'digital assets',
      'fintech regulations', 'cybersecurity in fintech', 'open banking', 'digital banking',
      'regtech', 'insurtech', 'wealthtech',

      // كلمات متعلقة بالتكنولوجيا الخضراء
      'green technology', 'sustainable technology', 'renewable energy', 'solar energy',
      'wind energy', 'hydroelectric power', 'geothermal energy', 'clean technology',
      'energy efficiency', 'carbon footprint', 'eco-friendly', 'electric vehicle',
      'sustainable development', 'recycling', 'waste management', 'green innovation',
      'climate change technology', 'smart grid', 'sustainable agriculture', 'clean energy solutions',
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
              ' The Consequences of Artificial Intelligence on the Job Market.',
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
