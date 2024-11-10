import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../hom.dart';

class ProgressControlPage extends StatefulWidget {
  @override
  _ProgressControlPageState createState() => _ProgressControlPageState();
}

class _ProgressControlPageState extends State<ProgressControlPage> {
  // تعريف المتغيرات لتخزين مستويات التقدم
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

  @override
  void initState() {
    super.initState();
    loadSavedProgressData(); // تحميل البيانات المحفوظة عند بدء الصفحة
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Control Progress Levels and Bottle Fill Level"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Adjust Progress Levels:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // عناصر التحكم الخاصة بـ "Reading"
            Text("Reading"),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (readingProgressLevel > 0) {
                      setState(() {
                        readingProgressLevel -= 1;
                      });
                    }
                  },
                ),
                Expanded(
                  child: Slider(
                    min: 0,
                    max: 500.0,
                    divisions: 500,
                    label: readingProgressLevel.toString(),
                    value: readingProgressLevel.toDouble(),
                    onChanged: (double updatedValue) {
                      setState(() {
                        readingProgressLevel = updatedValue.toInt();
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (readingProgressLevel < 500) {
                      setState(() {
                        readingProgressLevel += 1;
                      });
                    }
                  },
                ),
              ],
            ),

            // عناصر التحكم الخاصة بـ "Listening"
            Text("Listening"),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (listeningProgressLevel > 0) {
                      setState(() {
                        listeningProgressLevel -= 1;
                      });
                    }
                  },
                ),
                Expanded(
                  child: Slider(
                    min: 0,
                    max: 500.0,
                    divisions: 500,
                    label: listeningProgressLevel.toString(),
                    value: listeningProgressLevel.toDouble(),
                    onChanged: (double updatedValue) {
                      setState(() {
                        listeningProgressLevel = updatedValue.toInt();
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (listeningProgressLevel < 500) {
                      setState(() {
                        listeningProgressLevel += 1;
                      });
                    }
                  },
                ),
              ],
            ),

            // عناصر التحكم الخاصة بـ "Writing"
            Text("Writing"),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (writingProgressLevel > 0) {
                      setState(() {
                        writingProgressLevel -= 1;
                      });
                    }
                  },
                ),
                Expanded(
                  child: Slider(
                    min: 0,
                    max: 500.0,
                    divisions: 500,
                    label: writingProgressLevel.toString(),
                    value: writingProgressLevel.toDouble(),
                    onChanged: (double updatedValue) {
                      setState(() {
                        writingProgressLevel = updatedValue.toInt();
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (writingProgressLevel < 500) {
                      setState(() {
                        writingProgressLevel += 1;
                      });
                    }
                  },
                ),
              ],
            ),

            // عناصر التحكم الخاصة بـ "Grammar"
            Text("Grammar"),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (grammarProgressLevel > 0) {
                      setState(() {
                        grammarProgressLevel -= 1;
                      });
                    }
                  },
                ),
                Expanded(
                  child: Slider(
                    min: 0,
                    max: 500.0,
                    divisions: 500,
                    label: grammarProgressLevel.toString(),
                    value: grammarProgressLevel.toDouble(),
                    onChanged: (double updatedValue) {
                      setState(() {
                        grammarProgressLevel = updatedValue.toInt();
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (grammarProgressLevel < 500) {
                      setState(() {
                        grammarProgressLevel += 1;
                      });
                    }
                  },
                ),
              ],
            ),

            // عناصر التحكم الخاصة بـ "Speaking"
            Text("Speaking"),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (speakingProgressLevel > 0) {
                      setState(() {
                        speakingProgressLevel -= 1;
                      });
                    }
                  },
                ),
                Expanded(
                  child: Slider(
                    min: 0,
                    max: 500.0,
                    divisions: 500,
                    label: speakingProgressLevel.toString(),
                    value: speakingProgressLevel.toDouble(),
                    onChanged: (double updatedValue) {
                      setState(() {
                        speakingProgressLevel = updatedValue.toInt();
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (speakingProgressLevel < 500) {
                      setState(() {
                        speakingProgressLevel += 1;
                      });
                    }
                  },
                ),
              ],
            ),

            Divider(),
            Text(
              "Adjust Bottle Fill Level:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // عناصر التحكم الخاصة بـ "Bottle Fill Level"
            Text("Bottle Fill Level"),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (bottleFillLevel > 0) {
                      setState(() {
                        bottleFillLevel -= 1;
                      });
                    }
                  },
                ),
                Expanded(
                  child: Slider(
                    min: 0,
                    max: 6000.0,
                    divisions: 6000,
                    label: bottleFillLevel.toString(),
                    value: bottleFillLevel.toDouble(),
                    onChanged: (double updatedValue) {
                      setState(() {
                        bottleFillLevel = updatedValue.toInt();
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (bottleFillLevel < 6000) {
                      setState(() {
                        bottleFillLevel += 1;
                      });
                    }
                  },
                ),
              ],
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // إظهار مؤشر التحميل قبل الحفظ
                showDialog(
                  context: buildContext,
                  barrierDismissible: false,
                  builder: (BuildContext dialogContext) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                // حفظ البيانات ثم إغلاق مربعات الحوار
                await saveProgressDataToPreferences();
                Navigator.pop(buildContext); // إغلاق مؤشر التحميل
                Navigator.pop(buildContext); // العودة إلى الصفحة السابقة
              },
              child: Text("Save and Refresh"),
            ),
          ],
        ),
      ),
    );
  }
}
