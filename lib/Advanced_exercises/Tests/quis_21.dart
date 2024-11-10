import 'package:flutter/material.dart';



class HomePage33 extends StatelessWidget {
  final List<Map<String, dynamic>> exercises = [
    {'title': 'تمرين ترتيب الكلمات', 'type': ExerciseType.sentenceConstruction},
    {'title': 'تمرين إكمال الجمل', 'type': ExerciseType.fillInTheBlanks},
    {'title': 'تمرين اختيار الصواب والخطأ', 'type': ExerciseType.trueFalse},
    {'title': 'تمرين تصحيح الأخطاء', 'type': ExerciseType.errorCorrection},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تمارين اللغة الإنجليزية')),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(exercises[index]['title']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExercisePage(type: exercises[index]['type']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

enum ExerciseType {
  sentenceConstruction,
  fillInTheBlanks,
  trueFalse,
  errorCorrection,
}

class ExercisePage extends StatelessWidget {
  final ExerciseType type;

  ExercisePage({required this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ExerciseType.sentenceConstruction:
        return SentenceConstructionExercise();
      case ExerciseType.fillInTheBlanks:
        return FillInTheBlanksExercise();
      case ExerciseType.trueFalse:
        return TrueFalseExercise();
      case ExerciseType.errorCorrection:
        return ErrorCorrectionExercise();
      default:
        return Container(); // Fallback
    }
  }
}

// تمرين ترتيب الكلمات


class SentenceConstructionExercise extends StatefulWidget {
  @override
  _SentenceConstructionExerciseState createState() =>
      _SentenceConstructionExerciseState();
}

class _SentenceConstructionExerciseState
    extends State<SentenceConstructionExercise> {

  // قائمة تحتوي على 1000 كلمة إنجليزية
  List<String> allWords12 = [
    'apple', 'banana', 'orange', 'city', 'beautiful', 'house', 'car', 'run', 'happy', 'sad',
    'dog', 'cat', 'ball', 'fast', 'slow', 'jump', 'sky', 'blue', 'green', 'sun',
    'moon', 'star', 'night', 'day', 'morning', 'evening', 'winter', 'summer', 'spring',
    'fall', 'rain', 'snow', 'wind', 'storm', 'river', 'lake', 'mountain', 'hill', 'valley',
    'ocean', 'beach', 'desert', 'forest', 'tree', 'flower', 'plant', 'leaf', 'garden', 'park',
    'road', 'street', 'highway', 'bridge', 'building', 'tower', 'apartment', 'office', 'school', 'university',
    'book', 'pen', 'pencil', 'paper', 'notebook', 'computer', 'phone', 'tablet', 'keyboard', 'mouse',
    'screen', 'window', 'door', 'chair', 'table', 'desk', 'bed', 'sofa', 'lamp', 'clock',
    'watch', 'calendar', 'shirt', 'pants', 'shoes', 'hat', 'gloves', 'scarf', 'coat', 'socks',
    'ring', 'necklace', 'bracelet', 'earrings', 'wallet', 'bag', 'purse', 'belt', 'sunglasses', 'umbrella',
    'knife', 'fork', 'spoon', 'plate', 'bowl', 'cup', 'glass', 'bottle', 'can', 'box',
    'bag', 'cart', 'basket', 'shelf', 'store', 'shop', 'mall', 'market', 'restaurant', 'cafe',
    'breakfast', 'lunch', 'dinner', 'meal', 'snack', 'food', 'drink', 'water', 'juice', 'milk',
    'coffee', 'tea', 'soda', 'beer', 'wine', 'chocolate', 'candy', 'cookie', 'cake', 'bread',
    'butter', 'cheese', 'egg', 'meat', 'fish', 'chicken', 'beef', 'pork', 'vegetable', 'fruit',
    'salad', 'soup', 'rice', 'pasta', 'pizza', 'sandwich', 'burger', 'fries', 'ice', 'cream',
    'sugar', 'salt', 'pepper', 'spice', 'oil', 'sauce', 'ketchup', 'mustard', 'vinegar', 'honey',
    'jam', 'cereal', 'oatmeal', 'pancake', 'waffle', 'bacon', 'sausage', 'ham', 'turkey', 'duck',
    'potato', 'tomato', 'onion', 'garlic', 'carrot', 'pepper', 'corn', 'bean', 'pea', 'broccoli',
    'spinach', 'lettuce', 'cabbage', 'cucumber', 'zucchini', 'squash', 'pumpkin', 'apple', 'banana', 'orange',
    'grape', 'lemon', 'lime', 'strawberry', 'blueberry', 'raspberry', 'cherry', 'peach', 'pear', 'plum',
    'pineapple', 'mango', 'papaya', 'kiwi', 'melon', 'watermelon', 'coconut', 'date', 'fig', 'olive',
    'almond', 'peanut', 'walnut', 'hazelnut', 'cashew', 'pistachio', 'nut', 'bean', 'seed', 'grain',
    'flour', 'sugar', 'salt', 'pepper', 'spice', 'herb', 'sauce', 'ketchup', 'mustard', 'vinegar',
    'honey', 'jam', 'butter', 'cheese', 'egg', 'meat', 'fish', 'chicken', 'beef', 'pork',
    'vegetable', 'fruit', 'salad', 'soup', 'rice', 'pasta', 'pizza', 'sandwich', 'burger', 'fries',
    'ice', 'cream', 'cake', 'cookie', 'pie', 'bread', 'toast', 'biscuit', 'cracker', 'muffin',
    'croissant', 'donut', 'bagel', 'brownie', 'pancake', 'waffle', 'syrup', 'butter', 'cheese', 'yogurt',
    'milk', 'cream', 'coffee', 'tea', 'juice', 'soda', 'water', 'beer', 'wine', 'cocktail',
    'whiskey', 'rum', 'vodka', 'gin', 'tequila', 'brandy', 'champagne', 'smoothie', 'shake', 'ice',
    'water', 'coffee', 'tea', 'milk', 'soda', 'juice', 'beer', 'wine', 'cocktail', 'smoothie',
    'shake', 'lemonade', 'chocolate', 'vanilla', 'strawberry', 'apple', 'banana', 'orange', 'grape', 'melon',
    'watermelon', 'peach', 'pear', 'plum', 'cherry', 'blueberry', 'raspberry', 'blackberry', 'kiwi', 'mango',
    'pineapple', 'papaya', 'coconut', 'date', 'fig', 'prune', 'raisin', 'grape', 'orange', 'lemon',
    'lime', 'grapefruit', 'strawberry', 'blueberry', 'blackberry', 'raspberry', 'banana', 'apple', 'cherry', 'peach',
    'plum', 'pear', 'kiwi', 'mango', 'pineapple', 'papaya', 'coconut', 'watermelon', 'melon', 'pumpkin',
    'zucchini', 'cucumber', 'carrot', 'tomato', 'onion', 'garlic', 'pepper', 'potato', 'sweet', 'potato',
    'corn', 'bean', 'pea', 'broccoli', 'spinach', 'lettuce', 'cabbage', 'cauliflower', 'mushroom', 'eggplant',
    'pepper', 'chili', 'jalapeno', 'habanero', 'poblano', 'serrano', 'cayenne', 'paprika', 'turmeric', 'ginger',
    'cinnamon', 'nutmeg', 'clove', 'anise', 'cardamom', 'coriander', 'cumin', 'fennel', 'dill', 'parsley',
    'cilantro', 'basil', 'oregano', 'thyme', 'rosemary', 'sage', 'lavender', 'peppermint', 'chamomile', 'lemongrass',
    'saffron', 'vanilla', 'chocolate', 'sugar', 'honey', 'maple', 'syrup', 'butter', 'cream', 'cheese',
    'yogurt', 'ice', 'cream', 'cake', 'cookie', 'pie', 'bread', 'toast', 'biscuit', 'cracker',
    'muffin', 'croissant', 'donut', 'bagel', 'brownie', 'pancake', 'waffle', 'syrup', 'coffee', 'tea',
    'juice', 'soda', 'water', 'beer', 'wine', 'cocktail', 'whiskey', 'rum', 'vodka', 'gin',
    'tequila', 'brandy', 'champagne', 'smoothie', 'shake', 'lemonade', 'chocolate', 'vanilla', 'strawberry', 'apple',
    'banana', 'orange', 'grape', 'melon', 'watermelon', 'peach', 'pear', 'plum', 'cherry', 'blueberry',
    'raspberry', 'blackberry', 'kiwi', 'mango', 'pineapple', 'papaya', 'coconut', 'date', 'fig', 'olive',
    'almond', 'peanut', 'walnut', 'hazelnut', 'cashew', 'pistachio', 'nut', 'bean', 'seed', 'grain',
    'flour', 'sugar', 'salt', 'pepper', 'spice', 'herb', 'sauce', 'ketchup', 'mustard', 'vinegar',
    'honey', 'jam', 'butter', 'cheese', 'egg', 'meat', 'fish', 'chicken', 'beef', 'pork',
    'vegetable', 'fruit', 'salad', 'soup', 'rice', 'pasta', 'pizza', 'sandwich', 'burger', 'fries',
    'ice', 'cream', 'cake', 'cookie', 'pie', 'bread', 'toast', 'biscuit', 'cracker', 'muffin',
    'croissant', 'donut', 'bagel', 'brownie', 'pancake', 'waffle', 'syrup', 'butter', 'cheese', 'yogurt',
    'milk', 'cream', 'coffee', 'tea', 'juice', 'soda', 'water', 'beer', 'wine', 'cocktail',
    'whiskey', 'rum', 'vodka', 'gin', 'tequila', 'brandy', 'champagne', 'smoothie', 'shake', 'ice'
    // أضف المزيد من الكلمات حسب الحاجة لتكملة العدد إلى 1000
  ];

  List<String> words = [];
  List<String> userSentence = [];

  @override
  void initState() {
    super.initState();
    _generateRandomWords();
  }

  // دالة لاختيار كلمات عشوائية من القائمة
  void _generateRandomWords() {
    allWords12.shuffle(); // خلط الكلمات
    words = allWords12.sublist(0, 6); // اختيار 6 كلمات عشوائية
  }

  void checkAnswer() {
    String userInput = userSentence.join(' ');
    // يمكنك تخصيص الجملة الصحيحة بناءً على الكلمات المختارة عشوائياً
    if (userInput == "I went to the park yesterday.") {
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
              _generateRandomWords(); // إعادة توليد كلمات جديدة عند إعادة المحاولة
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ترتيب الكلمات'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
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
                  words.remove(data); // إزالة الكلمة بعد إضافتها للجملة
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
            if (userSentence.isNotEmpty)
              TextButton(
                onPressed: () {
                  setState(() {
                    userSentence.clear();
                    _generateRandomWords(); // إعادة توليد كلمات جديدة
                  });
                },
                child: Text(
                  'إعادة المحاولة',
                  style: TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// تمرين إكمال الجمل
class FillInTheBlanksExercise extends StatefulWidget {
  @override
  _FillInTheBlanksExerciseState createState() => _FillInTheBlanksExerciseState();
}

class _FillInTheBlanksExerciseState extends State<FillInTheBlanksExercise> {
  String sentence = "She ___ to school every day.";
  List<String> options = ['go', 'goes', 'going'];
  String correctAnswer = 'goes';

  void checkAnswer(String answer) {
    if (answer == correctAnswer) {
      showDialog(context: context, builder: (_) => _buildDialog('إجابة صحيحة!'));
    } else {
      showDialog(context: context, builder: (_) => _buildDialog('إجابة خاطئة!'));
    }
  }

  Widget _buildDialog(String message) {
    return AlertDialog(
      title: Text('نتيجة'),
      content: Text(message),
      actions: [
        TextButton(
          child: Text('إغلاق'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إكمال الجمل')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(sentence),
          ...options.map((option) {
            return ElevatedButton(
              onPressed: () => checkAnswer(option),
              child: Text(option),
            );
          }).toList(),
        ],
      ),
    );
  }
}

// تمرين اختيار الصواب والخطأ
class TrueFalseExercise extends StatefulWidget {
  @override
  _TrueFalseExerciseState createState() => _TrueFalseExerciseState();
}

class _TrueFalseExerciseState extends State<TrueFalseExercise> {
  String sentence = "He don't like coffee.";
  bool isCorrect = false; // Should be true for correct answers

  void checkAnswer(bool answer) {
    if (answer == isCorrect) {
      showDialog(context: context, builder: (_) => _buildDialog('إجابة صحيحة!'));
    } else {
      showDialog(context: context, builder: (_) => _buildDialog('إجابة خاطئة!'));
    }
  }

  Widget _buildDialog(String message) {
    return AlertDialog(
      title: Text('نتيجة'),
      content: Text(message),
      actions: [
        TextButton(
          child: Text('إغلاق'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اختر الصواب أو الخطأ')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(sentence),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => checkAnswer(true),
                child: Text('صحيح'),
              ),
              ElevatedButton(
                onPressed: () => checkAnswer(false),
                child: Text('خطأ'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// تمرين تصحيح الأخطاء
class ErrorCorrectionExercise extends StatefulWidget {
  @override
  _ErrorCorrectionExerciseState createState() => _ErrorCorrectionExerciseState();
}

class _ErrorCorrectionExerciseState extends State<ErrorCorrectionExercise> {
  String sentence = "She have two cats.";
  String correctSentence = "She has two cats.";

  void showCorrection() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('تصحيح الخطأ'),
        content: Text('الصحيح هو: $correctSentence'),
        actions: [
          TextButton(
            child: Text('إغلاق'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تصحيح الأخطاء')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(sentence),
          ElevatedButton(onPressed: showCorrection, child: Text('عرض التصحيح')),
        ],
      ),
    );
  }
}
