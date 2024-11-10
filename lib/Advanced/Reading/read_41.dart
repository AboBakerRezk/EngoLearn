import 'package:flutter/material.dart';


//S
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingAssessmentPage41 extends StatefulWidget {
  @override
  _ReadingAssessmentPage41State createState() => _ReadingAssessmentPage41State();
}

class _ReadingAssessmentPage41State extends State<ReadingAssessmentPage41>
    with SingleTickerProviderStateMixin {
  int _currentStoryIndex = 0;
  int _currentQuestionIndex = 0;
  int _score = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E);

  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int speakingProgressLevel = 0; // New variable for Speaking
  int bottleFillLevel = 0;

  double readingPoints = 0.0;

// Load saved data
  Future<void> loadSavedProgressData() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    setState(() {
      readingProgressLevel = sharedPreferencesInstance.getInt('readingProgressLevel') ?? 0;
      bottleFillLevel = sharedPreferencesInstance.getInt('bottleFillLevel') ?? 0;
      readingPoints = sharedPreferencesInstance.getDouble('readingPoints') ?? 0.0;
    });
  }

// Save data
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    await sharedPreferencesInstance.setInt('readingProgressLevel', readingProgressLevel);
    await sharedPreferencesInstance.setInt('bottleFillLevel', bottleFillLevel);
    await sharedPreferencesInstance.setDouble('readingPoints', readingPoints);
  }

  @override
  void initState() {
    super.initState();
    loadSavedProgressData();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        _score += 10;
        readingProgressLevel += (_score * 0.5).toInt();
        if (readingProgressLevel > 500) readingProgressLevel = 500;

        // تحديث نقاط الاستماع
        readingPoints += (_score * 0.5).toInt();
        if (readingPoints > 500) readingPoints = 500;

        // زيادة مستوى تعبئة الزجاجة
        bottleFillLevel += _score;
        if (bottleFillLevel > 6000) bottleFillLevel = 6000;
        // تحديث مستويات التقدم
        saveProgressDataToPreferences();
      } else {
        _score -= 5;
      }

      // Check if there are more questions in the current story
      if (_currentQuestionIndex < ReadingData.questionsList[_currentStoryIndex].length - 1) {
        _currentQuestionIndex++;
      } else if (_currentStoryIndex < ReadingData.readingTexts.length - 1) {
        _currentStoryIndex++;
        _currentQuestionIndex = 0;
      } else {
        _showPerformanceStats();
      }

      // Save progress data
      saveProgressDataToPreferences();
    });
  }

  Widget _buildButton(String option, bool isCorrect) {
    return FadeTransition(
      opacity: _animation,
      child: ElevatedButton(
        onPressed: () {
          checkAnswer(isCorrect);

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        child: Text(
          option,
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }

  void _showPerformanceStats() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Performance Statistics'),
        content: Text('Score: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentText = ReadingData.readingTexts[_currentStoryIndex];
    List<ReadingQuestion> currentQuestions = ReadingData.questionsList[_currentStoryIndex];
    ReadingQuestion currentQuestion = currentQuestions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Reading Quiz',
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
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              Text(
                'Read the following text:',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                currentText,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                currentQuestion.questionText,
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              SizedBox(height: 20),
              ...currentQuestion.options.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _buildButton(option, option == currentQuestion.correctAnswer),
                );
              }).toList(),
              SizedBox(height: 30),
              Text(
                'Score: $_score',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ReadingData {
  // قائمة النصوص
  static final List<String> readingTexts = [
    '''
    In a bustling city, there lived a wise mother named Fatima. She was known for her nurturing spirit and her ability to raise children who were not only intelligent but also compassionate. Fatima had three children: Amina, Yusuf, and Zain.

    From a young age, Fatima believed in the importance of education. She often told her children, "Knowledge is the key that opens the door to your dreams." Every evening, after dinner, she would gather them in the living room for study sessions. They would read books together, discuss stories, and even solve math problems. Fatima encouraged her children to ask questions and think critically about the world around them.

    One day, Amina came home from school feeling upset. She had received a low grade on a math test. Instead of scolding her, Fatima sat down with Amina and asked her what had happened. Amina explained that she hadn’t understood the material well. Fatima smiled and said, "It's okay to make mistakes, Amina. What matters is how we learn from them. Let's review the concepts together." They spent the evening working through the problems, and Amina felt much better by the end of the night.

    Fatima also emphasized the importance of kindness and empathy. She often took her children to volunteer at the local shelter. There, they learned about the struggles of others and the importance of giving back to the community. One winter, they organized a coat drive to help those in need. Amina, Yusuf, and Zain were excited to collect warm clothes from friends and family. They even spent their allowance on new coats to donate. Seeing the smiles on the faces of those they helped brought the children immense joy and a deeper understanding of compassion.

    As they grew older, Fatima instilled in her children a sense of responsibility. She encouraged them to take care of their belongings and to help with household chores. "Being responsible is not just about doing your own tasks; it’s about contributing to the well-being of our family," she would say. Every Saturday, they had a family cleaning day. Each child had specific tasks, and they would work together while sharing stories and laughter.

    On weekends, Fatima often took her children on educational trips to museums, parks, and historical sites. These outings sparked their curiosity and love for learning. One day, they visited a science museum, where they saw fascinating exhibits about space and technology. Yusuf, who had always been interested in engineering, was particularly inspired. He decided he wanted to become an engineer one day, and Fatima encouraged him to pursue his passions.

    Fatima also taught her children the value of gratitude. Each evening, before bed, they would share something they were thankful for that day. This practice helped them appreciate the small joys in life and fostered a positive mindset.

    As the years passed, Amina, Yusuf, and Zain grew into remarkable young adults. They excelled in their studies and were actively involved in their community. Amina became a teacher, Yusuf pursued engineering, and Zain developed a passion for environmental activism. They often reflected on their mother’s teachings and how they shaped their lives.

    One day, as they gathered for dinner, Fatima expressed her pride in her children. "You have all grown into wonderful individuals who care about others and strive to make a difference in the world," she said with a smile. "Always remember that education, kindness, and responsibility are the pillars of a fulfilling life."

    Amina, Yusuf, and Zain looked at each other and nodded in agreement. They knew that the values their mother instilled in them would guide them throughout their lives. They promised to continue her legacy by teaching their own children the importance of knowledge, compassion, and responsibility. As they shared stories and laughter over dinner, they felt grateful for the love and wisdom that Fatima had given them, shaping them into the people they had become.
    '''
  ];

  // قائمة الأسئلة للنص
  static final List<List<ReadingQuestion>> questionsList = [
    [
      ReadingQuestion(
        questionText: "1. What did Fatima believe was essential for her children's success?",
        options: ["Knowledge", "Wealth", "Popularity", "Appearance"],
        correctAnswer: "Knowledge",
        hint: "She often emphasized the importance of education.",
      ),
      ReadingQuestion(
        questionText: "2. How did Fatima respond to Amina's low grade?",
        options: ["She scolded her", "She ignored her", "She helped her review the material", "She punished her"],
        correctAnswer: "She helped her review the material",
        hint: "Fatima believed in learning from mistakes.",
      ),
      ReadingQuestion(
        questionText: "3. What activity did Fatima do with her children to teach them kindness?",
        options: ["Going to the movies", "Volunteering at a shelter", "Shopping for clothes", "Attending parties"],
        correctAnswer: "Volunteering at a shelter",
        hint: "They learned about giving back to the community.",
      ),
      ReadingQuestion(
        questionText: "4. What was the purpose of the coat drive organized by the children?",
        options: ["To sell clothes", "To collect warm clothes for those in need", "To give clothes to friends", "To donate toys"],
        correctAnswer: "To collect warm clothes for those in need",
        hint: "They wanted to help others during winter.",
      ),
      ReadingQuestion(
        questionText: "5. How did Fatima instill a sense of responsibility in her children?",
        options: ["By giving them money", "By ignoring their chores", "By assigning them household tasks", "By allowing them to play all day"],
        correctAnswer: "By assigning them household tasks",
        hint: "They had family cleaning days every Saturday.",
      ),
      ReadingQuestion(
        questionText: "6. What did Yusuf want to become after visiting the science museum?",
        options: ["A teacher", "An artist", "An engineer", "A doctor"],
        correctAnswer: "An engineer",
        hint: "He was inspired by the exhibits about space and technology.",
      ),
      ReadingQuestion(
        questionText: "7. What practice did Fatima implement to teach her children gratitude?",
        options: ["Reading books", "Sharing something they were thankful for each day", "Playing games", "Watching TV"],
        correctAnswer: "Sharing something they were thankful for each day",
        hint: "This helped them appreciate the small joys in life.",
      ),
      ReadingQuestion(
        questionText: "8. What careers did Amina, Yusuf, and Zain pursue?",
        options: ["Doctor, Lawyer, Teacher", "Teacher, Engineer, Environmental Activist", "Artist, Musician, Writer", "Scientist, Businessman, Politician"],
        correctAnswer: "Teacher, Engineer, Environmental Activist",
        hint: "They followed their passions and made a difference in the world.",
      ),
      ReadingQuestion(
        questionText: "9. How did Fatima feel about her children's growth?",
        options: ["Disappointed", "Proud", "Indifferent", "Worried"],
        correctAnswer: "Proud",
        hint: "She expressed her pride during dinner.",
      ),
      ReadingQuestion(
        questionText: "10. What values did Fatima emphasize to her children?",
        options: ["Knowledge, Kindness, Responsibility", "Wealth, Fame, Power", "Beauty, Popularity, Success", "Sports, Music, Art"],
        correctAnswer: "Knowledge, Kindness, Responsibility",
        hint: "These were the pillars of a fulfilling life.",
      ),
    ]
  ];
}


class ReadingQuestion {
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  final String? hint;
  String? selectedAnswer;

  ReadingQuestion({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    this.hint,
    this.selectedAnswer,
  });
}

