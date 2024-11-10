import 'package:flutter/material.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class SentenceConstructionExercise22 extends StatefulWidget {
  @override
  _SentenceConstructionExercise22State createState() =>
      _SentenceConstructionExercise22State();
}

class _SentenceConstructionExercise22State
    extends State<SentenceConstructionExercise22> {

  // قوائم الكلمات المترابطة
  List<String> subjects = [
    'I', 'He', 'She', 'They', 'We', 'John', 'Mary', 'The dog', 'The cat', 'My friend',
    'My parents', 'The teacher', 'The student', 'The man', 'The woman', 'The child',
    'The police officer', 'The doctor', 'The engineer', 'The musician', 'My brother', 'My sister',
    'My uncle', 'My aunt', 'My cousin', 'The driver', 'The waiter', 'The chef', 'The artist',
    'The pilot', 'The farmer', 'The lawyer', 'The judge', 'The nurse', 'The patient', 'The customer',
    'The manager', 'The worker', 'The soldier', 'The officer', 'The firefighter', 'The baker',
    'The grocer', 'The fisherman', 'The cleaner', 'The builder', 'The architect', 'The designer',
    'The scientist', 'The programmer', 'The journalist', 'The photographer', 'The painter',
    'The plumber', 'The electrician', 'The technician', 'The mechanic', 'The dentist', 'The vet',
    'The shopkeeper', 'The cashier', 'The security guard', 'The gardener', 'The janitor',
    'The carpenter', 'The driver', 'The courier', 'The cyclist', 'The runner', 'The swimmer',
    'The skier', 'The snowboarder', 'The climber', 'The teacher', 'The coach', 'The player',
    'The referee', 'The fan', 'The singer', 'The dancer', 'The actor', 'The director',
    'The producer', 'The writer', 'The author', 'The poet', 'The speaker', 'The presenter',
    'The host', 'The guest', 'The visitor', 'The tourist', 'The traveler', 'The explorer',
    'The guide', 'The researcher', 'The inventor', 'The entrepreneur', 'The investor',
    'The accountant', 'The banker', 'The trader', 'The economist', 'The scientist'
  ];


  List<String> verbs = [
    'is', 'are', 'was', 'were', 'will', 'can', 'do', 'does', 'did', 'have',
    'has', 'had', 'run', 'walk', 'talk', 'eat', 'drink', 'sleep', 'study',
    'play', 'watch', 'listen', 'drive', 'write', 'read', 'swim', 'sing', 'jump',
    'build', 'cook', 'clean', 'buy', 'sell', 'make', 'find', 'help', 'teach',
    'learn', 'draw', 'paint', 'fix', 'repair', 'create', 'invent', 'explore',
    'discover', 'measure', 'calculate', 'build', 'solve', 'code', 'program',
    'design', 'control', 'manage', 'operate', 'organize', 'plan', 'prepare',
    'lead', 'guide', 'run', 'walk', 'talk', 'swim', 'fly', 'drive', 'sail',
    'jump', 'hop', 'skip', 'dance', 'sing', 'laugh', 'cry', 'smile', 'frown',
    'shout', 'whisper', 'look', 'see', 'hear', 'listen', 'smell', 'taste',
    'feel', 'touch', 'think', 'understand', 'believe', 'imagine', 'guess',
    'remember', 'forget', 'hope', 'wish', 'plan', 'organize', 'fix', 'repair'
  ];


  List<String> objects = [
    'a book', 'the car', 'the house', 'dinner', 'a song', 'the homework',
    'a movie', 'the bed', 'a friend', 'a letter', 'an apple', 'the park',
    'a ball', 'the city', 'the garden', 'a computer', 'the game', 'the project',
    'a cup of tea', 'the phone', 'a notebook', 'the bike', 'the table',
    'the chair', 'a boat', 'the ship', 'the airplane', 'a rocket', 'a lamp',
    'the pen', 'the pencil', 'a pair of shoes', 'a hat', 'a jacket', 'the key',
    'a door', 'a window', 'the floor', 'a bag', 'the suitcase', 'the clock',
    'the watch', 'a mirror', 'the phone', 'a computer', 'the printer',
    'a camera', 'the TV', 'a remote control', 'the sofa', 'the bed', 'the blanket',
    'the pillow', 'a shirt', 'a tie', 'a dress', 'a skirt', 'the coat', 'a scarf',
    'the book', 'the page', 'a story', 'a newspaper', 'a magazine', 'a cup',
    'a plate', 'the fork', 'a spoon', 'a knife', 'the bottle', 'a glass', 'the door',
    'the window', 'the chair', 'the table', 'a lamp', 'the bed', 'the sofa',
    'a rug', 'the curtains', 'a picture', 'a painting', 'the clock', 'a mirror'
  ];


  List<String> adjectives = [
    'big', 'small', 'happy', 'sad', 'fast', 'slow', 'beautiful', 'ugly', 'new',
    'old', 'hot', 'cold', 'smart', 'funny', 'kind', 'loud', 'quiet', 'strong',
    'weak', 'brave', 'tall', 'short', 'young', 'old', 'rich', 'poor', 'nice',
    'mean', 'friendly', 'angry', 'excited', 'bored', 'tired', 'energetic',
    'lazy', 'clean', 'dirty', 'hungry', 'thirsty', 'full', 'empty', 'soft',
    'hard', 'heavy', 'light', 'sharp', 'dull', 'wet', 'dry', 'thick', 'thin',
    'long', 'short', 'bright', 'dark', 'colorful', 'plain', 'smooth', 'rough',
    'quiet', 'noisy', 'happy', 'sad', 'angry', 'calm', 'curious', 'confused',
    'afraid', 'brave', 'honest', 'loyal', 'polite', 'rude', 'careful',
    'careless', 'funny', 'serious', 'shy', 'confident', 'proud', 'humble',
    'lazy', 'active', 'fast', 'slow', 'quick', 'patient', 'impatient'
  ];

  List<String> prepositions = [
    'to', 'in', 'on', 'at', 'with', 'about', 'for', 'from', 'under', 'over',
    'between', 'behind', 'beside', 'near', 'around', 'through', 'against',
    'before', 'after', 'during', 'along', 'by', 'within', 'without', 'beneath',
    'above', 'below', 'next to', 'in front of', 'behind', 'inside', 'outside',
    'onto', 'into', 'up', 'down', 'around', 'across', 'alongside', 'beside',
    'beyond', 'opposite', 'underneath', 'toward', 'towards', 'past', 'off',
    'throughout', 'upon', 'within', 'without', 'near', 'around', 'against',
    'besides', 'between', 'among', 'amongst', 'along', 'concerning', 'despite',
    'except', 'excluding', 'following', 'including', 'like', 'toward',
    'upon', 'within', 'without', 'according to', 'ahead of', 'apart from',
    'as for', 'as of', 'aside from', 'because of', 'due to', 'in addition to'
  ];



  List<String> words = [];
  List<String> correctSentence = [];
  List<String> userSentence = [];

  int readingProgressLevel = 0;
  int listeningProgressLevel = 0;
  int writingProgressLevel = 0;
  int grammarProgressLevel = 0;
  int sentenceFormationPoints = 0; // New variable for Speaking
  int bottleFillLevel = 0;

// Load saved data
  Future<void> loadSavedProgressData() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    setState(() {
      readingProgressLevel = sharedPreferencesInstance.getInt('readingProgressLevel') ?? 0;
      bottleFillLevel = sharedPreferencesInstance.getInt('bottleFillLevel') ?? 0;
      sentenceFormationPoints = sharedPreferencesInstance.getInt('sentenceFormationPoints') ?? 0;
    });
  }

// Save data
  Future<void> saveProgressDataToPreferences() async {
    SharedPreferences sharedPreferencesInstance = await SharedPreferences.getInstance();
    await sharedPreferencesInstance.setInt('readingProgressLevel', readingProgressLevel);
    await sharedPreferencesInstance.setInt('bottleFillLevel', bottleFillLevel);
    await sharedPreferencesInstance.setInt('sentenceFormationPoints', sentenceFormationPoints);
  }
  @override
  void initState() {
    super.initState();
    loadSavedProgressData();
    _generateRandomWords();
  }

  void _generateRandomWords() {
    words.clear();
    String subject = subjects[Random().nextInt(subjects.length)];
    String verb = verbs[Random().nextInt(verbs.length)];
    String object = objects[Random().nextInt(objects.length)];
    String preposition = prepositions[Random().nextInt(prepositions.length)];
    String adjective = adjectives[Random().nextInt(adjectives.length)];

    correctSentence = [subject, verb, adjective, object, preposition];
    words = List.from(correctSentence);
    words.shuffle();
  }

  void checkAnswer() {
    String userInput = userSentence.join(' ');
    String correctInput = correctSentence.join(' ');
    if (userInput == correctInput) {
      setState(() {

        loadSavedProgressData();
      });
      showDialog(
          context: context, builder: (_) => _buildDialog('إجابة صحيحة! 🎉'));
      sentenceFormationPoints = 0 ;
      // تحديث مستويات التقدم بناءً على النقاط الجديدة
      if (sentenceFormationPoints < 500) {
        sentenceFormationPoints += (sentenceFormationPoints * 0.50).toInt();
        if (sentenceFormationPoints > 500) sentenceFormationPoints = 500; // الحد الأقصى
      }
      if (bottleFillLevel < 6000) {
        bottleFillLevel += (sentenceFormationPoints * 0.50).toInt();
        if (bottleFillLevel > 6000) bottleFillLevel = 6000; // الحد الأقصى
      }
    } else {
      showDialog(
          context: context, builder: (_) => _buildDialog('إجابة خاطئة! ❌'));
    }
  }

  Widget _buildDialog(String message) {
    return AlertDialog(
      title: Text('نتيجة'),
      content: Text(message, style: TextStyle(fontSize: 18)),
      actions: [
        TextButton(
          child: Text('إغلاق'),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              userSentence.clear();
              _generateRandomWords();
            });
          },
        ),
      ],
    );
  }

  void resetGame() {
    setState(() {
      userSentence.clear();
      _generateRandomWords();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SentenceConstructionExercise20()),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            textStyle: TextStyle(fontSize: 18),
          ),
          child: Text('الانتقال لصفحة التسلية',style: TextStyle(color: Colors.white),),
        ) ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'رتب الكلمات لتكوين جملة صحيحة:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: words.map((word) {
                return Draggable<String>(
                  data: word,
                  child: Chip(
                    label: Text(word),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                  feedback: Material(
                    color: Colors.transparent,
                    child: Chip(
                      label: Text(word),
                      backgroundColor: Colors.blueAccent,
                      padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                  ),
                  childWhenDragging: Chip(
                    label: Text(word),
                    backgroundColor: Colors.grey[300],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            DragTarget<String>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blueAccent, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      userSentence.isEmpty
                          ? 'اسحب الكلمات هنا'
                          : userSentence.join(' '),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
              onAccept: (data) {
                setState(() {
                  userSentence.add(data);
                  words.remove(data);
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: userSentence.isEmpty ? null : checkAnswer,
              style: ElevatedButton.styleFrom(
                padding:
                EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('تحقق من الإجابة'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetGame,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                backgroundColor: Colors.blue,
              ),
              child: Text('إعادة التشغيل',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}



class SentenceConstructionExercise20 extends StatefulWidget {
  @override
  _SentenceConstructionExercise20State createState() =>
      _SentenceConstructionExercise20State();
}

class _SentenceConstructionExercise20State
    extends State<SentenceConstructionExercise20> {

  // قوائم الكلمات المترابطة
  List<String> subjects = [
    'I', 'He', 'She', 'They', 'We', 'John', 'Mary', 'The dog', 'The cat', 'My friend',
    'My parents', 'The teacher', 'The student', 'The man', 'The woman', 'The child',
    'The police officer', 'The doctor', 'The engineer', 'The musician', 'My brother', 'My sister',
    'My uncle', 'My aunt', 'My cousin', 'The driver', 'The waiter', 'The chef', 'The artist',
    'The pilot', 'The farmer', 'The lawyer', 'The judge', 'The nurse', 'The patient', 'The customer',
    'The manager', 'The worker', 'The soldier', 'The officer', 'The firefighter', 'The baker',
    'The grocer', 'The fisherman', 'The cleaner', 'The builder', 'The architect', 'The designer',
    'The scientist', 'The programmer', 'The journalist', 'The photographer', 'The painter',
    'The plumber', 'The electrician', 'The technician', 'The mechanic', 'The dentist', 'The vet',
    'The shopkeeper', 'The cashier', 'The security guard', 'The gardener', 'The janitor',
    'The carpenter', 'The driver', 'The courier', 'The cyclist', 'The runner', 'The swimmer',
    'The skier', 'The snowboarder', 'The climber', 'The teacher', 'The coach', 'The player',
    'The referee', 'The fan', 'The singer', 'The dancer', 'The actor', 'The director',
    'The producer', 'The writer', 'The author', 'The poet', 'The speaker', 'The presenter',
    'The host', 'The guest', 'The visitor', 'The tourist', 'The traveler', 'The explorer',
    'The guide', 'The researcher', 'The inventor', 'The entrepreneur', 'The investor',
    'The accountant', 'The banker', 'The trader', 'The economist', 'The scientist'
  ];


  List<String> verbs = [
    'is', 'are', 'was', 'were', 'will', 'can', 'do', 'does', 'did', 'have',
    'has', 'had', 'run', 'walk', 'talk', 'eat', 'drink', 'sleep', 'study',
    'play', 'watch', 'listen', 'drive', 'write', 'read', 'swim', 'sing', 'jump',
    'build', 'cook', 'clean', 'buy', 'sell', 'make', 'find', 'help', 'teach',
    'learn', 'draw', 'paint', 'fix', 'repair', 'create', 'invent', 'explore',
    'discover', 'measure', 'calculate', 'build', 'solve', 'code', 'program',
    'design', 'control', 'manage', 'operate', 'organize', 'plan', 'prepare',
    'lead', 'guide', 'run', 'walk', 'talk', 'swim', 'fly', 'drive', 'sail',
    'jump', 'hop', 'skip', 'dance', 'sing', 'laugh', 'cry', 'smile', 'frown',
    'shout', 'whisper', 'look', 'see', 'hear', 'listen', 'smell', 'taste',
    'feel', 'touch', 'think', 'understand', 'believe', 'imagine', 'guess',
    'remember', 'forget', 'hope', 'wish', 'plan', 'organize', 'fix', 'repair'
  ];


  List<String> objects = [
    'a book', 'the car', 'the house', 'dinner', 'a song', 'the homework',
    'a movie', 'the bed', 'a friend', 'a letter', 'an apple', 'the park',
    'a ball', 'the city', 'the garden', 'a computer', 'the game', 'the project',
    'a cup of tea', 'the phone', 'a notebook', 'the bike', 'the table',
    'the chair', 'a boat', 'the ship', 'the airplane', 'a rocket', 'a lamp',
    'the pen', 'the pencil', 'a pair of shoes', 'a hat', 'a jacket', 'the key',
    'a door', 'a window', 'the floor', 'a bag', 'the suitcase', 'the clock',
    'the watch', 'a mirror', 'the phone', 'a computer', 'the printer',
    'a camera', 'the TV', 'a remote control', 'the sofa', 'the bed', 'the blanket',
    'the pillow', 'a shirt', 'a tie', 'a dress', 'a skirt', 'the coat', 'a scarf',
    'the book', 'the page', 'a story', 'a newspaper', 'a magazine', 'a cup',
    'a plate', 'the fork', 'a spoon', 'a knife', 'the bottle', 'a glass', 'the door',
    'the window', 'the chair', 'the table', 'a lamp', 'the bed', 'the sofa',
    'a rug', 'the curtains', 'a picture', 'a painting', 'the clock', 'a mirror'
  ];


  List<String> adjectives = [
    'big', 'small', 'happy', 'sad', 'fast', 'slow', 'beautiful', 'ugly', 'new',
    'old', 'hot', 'cold', 'smart', 'funny', 'kind', 'loud', 'quiet', 'strong',
    'weak', 'brave', 'tall', 'short', 'young', 'old', 'rich', 'poor', 'nice',
    'mean', 'friendly', 'angry', 'excited', 'bored', 'tired', 'energetic',
    'lazy', 'clean', 'dirty', 'hungry', 'thirsty', 'full', 'empty', 'soft',
    'hard', 'heavy', 'light', 'sharp', 'dull', 'wet', 'dry', 'thick', 'thin',
    'long', 'short', 'bright', 'dark', 'colorful', 'plain', 'smooth', 'rough',
    'quiet', 'noisy', 'happy', 'sad', 'angry', 'calm', 'curious', 'confused',
    'afraid', 'brave', 'honest', 'loyal', 'polite', 'rude', 'careful',
    'careless', 'funny', 'serious', 'shy', 'confident', 'proud', 'humble',
    'lazy', 'active', 'fast', 'slow', 'quick', 'patient', 'impatient'
  ];

  List<String> prepositions = [
    'to', 'in', 'on', 'at', 'with', 'about', 'for', 'from', 'under', 'over',
    'between', 'behind', 'beside', 'near', 'around', 'through', 'against',
    'before', 'after', 'during', 'along', 'by', 'within', 'without', 'beneath',
    'above', 'below', 'next to', 'in front of', 'behind', 'inside', 'outside',
    'onto', 'into', 'up', 'down', 'around', 'across', 'alongside', 'beside',
    'beyond', 'opposite', 'underneath', 'toward', 'towards', 'past', 'off',
    'throughout', 'upon', 'within', 'without', 'near', 'around', 'against',
    'besides', 'between', 'among', 'amongst', 'along', 'concerning', 'despite',
    'except', 'excluding', 'following', 'including', 'like', 'toward',
    'upon', 'within', 'without', 'according to', 'ahead of', 'apart from',
    'as for', 'as of', 'aside from', 'because of', 'due to', 'in addition to'
  ];



  List<String> words = [];
  List<String> correctSentence = [];
  List<String> userSentence = [];

  @override
  void initState() {
    super.initState();
    _generateRandomWords();
  }

  void _generateRandomWords() {
    words.clear();

    // اختيار كلمات عشوائية من القوائم
    String subject = subjects[Random().nextInt(subjects.length)];
    String verb = verbs[Random().nextInt(verbs.length)];
    String object = objects[Random().nextInt(objects.length)];
    String preposition = prepositions[Random().nextInt(prepositions.length)];
    String adjective1 = adjectives[Random().nextInt(adjectives.length)];
    String adjective2 = adjectives[Random().nextInt(adjectives.length)];
    String adverb = verbs[Random().nextInt(verb.length)];
    String conjunction = objects[Random().nextInt(objects.length)];
    String additionalWord1 = prepositions[Random().nextInt(prepositions.length)];
    String additionalWord2 = subjects[Random().nextInt(subjects.length)];

    // تكوين الجملة الصحيحة المكونة من 10 كلمات
    correctSentence = [
      subject,
      verb,
      adjective1,
      object,
      preposition,
      adjective2,
      adverb,
      conjunction,
      additionalWord1,
      additionalWord2
    ];

    // نسخ الكلمات إلى قائمة وتبديل ترتيبها
    words = List.from(correctSentence);
    words.shuffle();
  }

  void checkAnswer() {
    String userInput = userSentence.join(' ');
    String correctInput = correctSentence.join(' ');
    if (userInput == correctInput) {
      showDialog(
          context: context, builder: (_) => _buildDialog('إجابة صحيحة! 🎉'));
    } else {
      showDialog(
          context: context, builder: (_) => _buildDialog('إجابة خاطئة! ❌'));
    }
  }

  Widget _buildDialog(String message) {
    return AlertDialog(
      title: Text('نتيجة'),
      content: Text(message, style: TextStyle(fontSize: 18)),
      actions: [
        TextButton(
          child: Text('إغلاق'),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              userSentence.clear();
              _generateRandomWords();
            });
          },
        ),
      ],
    );
  }

  void resetGame() {
    setState(() {
      userSentence.clear();
      _generateRandomWords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'رتب الكلمات لتكوين جملة صحيحة:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: words.map((word) {
                return Draggable<String>(
                  data: word,
                  child: Chip(
                    label: Text(word),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                  feedback: Material(
                    color: Colors.transparent,
                    child: Chip(
                      label: Text(word),
                      backgroundColor: Colors.blueAccent,
                      padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                  ),
                  childWhenDragging: Chip(
                    label: Text(word),
                    backgroundColor: Colors.grey[300],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            DragTarget<String>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blueAccent, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      userSentence.isEmpty
                          ? 'اسحب الكلمات هنا'
                          : userSentence.join(' '),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
              onAccept: (data) {
                setState(() {
                  userSentence.add(data);
                  words.remove(data);
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: userSentence.isEmpty ? null : checkAnswer,
              style: ElevatedButton.styleFrom(
                padding:
                EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('تحقق من الإجابة'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetGame,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                backgroundColor: Colors.blue,
              ),
              child: Text('إعادة التشغيل',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
