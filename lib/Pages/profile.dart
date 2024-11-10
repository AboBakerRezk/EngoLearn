import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mushaf25/hom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../control/control_profile.dart';
import '../settings/setting_2.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class UserProfileForm extends StatefulWidget {
  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveUserData(Map<String, dynamic> formData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', formData['name']);
    prefs.setString('age', formData['age']);
    prefs.setString('gender', formData['gender']);
    prefs.setStringList('english_goal', List<String>.from(formData['english_goal']));
    prefs.setString('education_level', formData['education_level']);
    prefs.setString('memory_type', formData['memory_type']);
    prefs.setString('english_level_reading', formData['english_level_reading']);
    prefs.setString('english_level_listening', formData['english_level_listening']);
    prefs.setString('english_level_speaking', formData['english_level_speaking']);
    prefs.setString('english_level_vocabulary', formData['english_level_vocabulary']);
    prefs.setString('english_level_grammar', formData['english_level_grammar']);
    if (_image != null) {
      prefs.setString('image_path', _image!.path);
    }
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _formKey.currentState?.patchValue({
        'name': prefs.getString('name') ?? '',
        'age': prefs.getString('age') ?? '',
        'gender': prefs.getString('gender') ?? 'Male',
        'english_goal': prefs.getStringList('english_goal') ?? [],
        'education_level': prefs.getString('education_level') ?? 'none',
        'memory_type': prefs.getString('memory_type') ?? 'visual',
        'english_level_reading': prefs.getString('english_level_reading') ?? 'A1',
        'english_level_listening': prefs.getString('english_level_listening') ?? 'A1',
        'english_level_speaking': prefs.getString('english_level_speaking') ?? 'A1',
        'english_level_vocabulary': prefs.getString('english_level_vocabulary') ?? 'A1',
        'english_level_grammar': prefs.getString('english_level_grammar') ?? 'A1',
      });
      if (prefs.getString('image_path') != null) {
        _image = File(prefs.getString('image_path')!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey, // استخدم FormBuilder هنا
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProfileImagePicker(),
              const SizedBox(height: 20),
              _buildCustomTextField(
                name: 'name',
                label: '${AppLocale.S20.getString(context)}',
              ),
              const SizedBox(height: 20),
              _buildCustomTextField(
                name: 'age',
                label: '${AppLocale.S38.getString(context)}',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              _buildCustomDropdown(
                name: 'gender',
                label: '${AppLocale.S23.getString(context)}',
                items: _getGenderItems(),
              ),
              const SizedBox(height: 20),
              _buildCustomCheckboxGroup(
                name: 'english_goal',
                label: '${AppLocale.S21.getString(context)}',
                options: _getEnglishGoalOptions(),
              ),
              const SizedBox(height: 20),
              _buildCustomDropdown(
                name: 'education_level',
                label: '${AppLocale.S22.getString(context)}',
                items: _getEducationLevelItems(),
              ),
              const SizedBox(height: 20),
              _buildMemoryTypeRadioGroup(),
              const SizedBox(height: 20),
              _buildEnglishLevelDropdown(
                name: 'english_level_reading',
                label: 'مستوى القراءة في الإنجليزية',
              ),
              const SizedBox(height: 20),
              _buildEnglishLevelDropdown(
                name: 'english_level_listening',
                label: 'مستوى الاستماع في الإنجليزية',
              ),
              const SizedBox(height: 20),
              _buildEnglishLevelDropdown(
                name: 'english_level_speaking',
                label: 'مستوى التحدث في الإنجليزية',
              ),
              const SizedBox(height: 20),
              _buildEnglishLevelDropdown(
                name: 'english_level_vocabulary',
                label: 'مستوى المفردات في الإنجليزية',
              ),
              const SizedBox(height: 20),
              _buildEnglishLevelDropdown(
                name: 'english_level_grammar',
                label: 'مستوى القواعد في الإنجليزية',
              ),
              const SizedBox(height: 30),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildEnglishLevelDropdown({
    required String name,
    required String label,
  }) {
    return SizedBox(
      width: double.infinity,
      child: FormBuilderDropdown(
        name: name,
        decoration: _getInputDecoration(label),
        dropdownColor: const Color(0xFF13194E),
        style: const TextStyle(color: Colors.white, fontSize: 20),
        items: _getEnglishLevelItems(),
        validator: (value) => value == null ? 'يرجى اختيار $label.' : null,
      ),
    );
  }

  List<DropdownMenuItem<String>> _getEnglishLevelItems() {
    return [
      DropdownMenuItem(value: 'A1', child: Text('A1')),
      DropdownMenuItem(value: 'A2', child: Text('A2')),
      DropdownMenuItem(value: 'B1', child: Text('B1')),
      DropdownMenuItem(value: 'B2', child: Text('B2')),
      DropdownMenuItem(value: 'C1', child: Text('C1')),
      DropdownMenuItem(value: 'C2', child: Text('C2')),
    ];
  }
  Widget _buildProfileImagePicker() {
    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: CircleAvatar(
          radius: 70,
          backgroundColor: const Color(0xFF1A237E),
          backgroundImage: _image != null ? FileImage(_image!) : null,
          child: _image == null
              ? const Icon(Icons.add_a_photo, color: Colors.white, size: 40)
              : null,
        ),
      ),
    );
  }

  Widget _buildCustomTextField({
    required String name,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return SizedBox(
      width: double.infinity,
      child: FormBuilderTextField(
        name: name,
        keyboardType: keyboardType,
        decoration: _getInputDecoration(label),
        style: const TextStyle(color: Colors.white, fontSize: 20),
        validator: (value) => _textFieldValidator(name, value),
      ),
    );
  }

  Widget _buildCustomDropdown({
    required String name,
    required String label,
    required List<DropdownMenuItem<String>> items,
  }) {
    return SizedBox(
      width: double.infinity,
      child: FormBuilderDropdown(
        name: name,
        decoration: _getInputDecoration(label),
        dropdownColor: const Color(0xFF13194E),
        style: const TextStyle(color: Colors.white, fontSize: 20),
        items: items,
        validator: (value) => value == null ? 'يرجى اختيار $label.' : null,
      ),
    );
  }

  Widget _buildCustomCheckboxGroup({
    required String name,
    required String label,
    required List<FormBuilderFieldOption<String>> options,
  }) {
    return SizedBox(
      width: double.infinity,
      child: FormBuilderCheckboxGroup(
        name: name,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        options: options,
        controlAffinity: ControlAffinity.leading,
        activeColor: Colors.white,
        checkColor: Colors.grey,
        validator: (value) => (value == null || value.isEmpty) ? 'يرجى اختيار هدف واحد على الأقل.' : null,
      ),
    );
  }

  Widget _buildMemoryTypeRadioGroup() {
    return FormBuilderRadioGroup(
      name: 'memory_type',
      decoration: InputDecoration(
        labelText: '${AppLocale.S6.getString(context)}',
        labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      options: [
        FormBuilderFieldOption(value: 'visual', child: Text('${AppLocale.S8.getString(context)}', style: TextStyle(color: Colors.white))),
        FormBuilderFieldOption(value: 'auditory', child: Text('${AppLocale.S10.getString(context)}', style: TextStyle(color: Colors.white))),
      ],
      activeColor: Colors.white,
      validator: (value) => value == null ? 'يرجى اختيار نوع الذاكرة.' : null,
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: 200,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            final formData = _formKey.currentState?.value;
            _saveUserData(formData!);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserPlanPage()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('يرجى ملء جميع الحقول بشكل صحيح'),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF13194E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.white, width: 2),
          ),
        ),
        child:  Text(
          '${AppLocale.S39.getString(context)} ',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  InputDecoration _getInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
      filled: true,
      fillColor: const Color(0xFF13194E),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      enabledBorder: _getBorder(),
      focusedBorder: _getBorder(),
    );
  }

  OutlineInputBorder _getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.white, width: 2),
    );
  }

  List<DropdownMenuItem<String>> _getGenderItems() {
    return [
      DropdownMenuItem(value: 'Male', child: Text('${AppLocale.S46.getString(context)}')),
      DropdownMenuItem(value: 'Female', child: Text('${AppLocale.S47.getString(context)}')),
    ];
  }

  List<DropdownMenuItem<String>> _getEducationLevelItems() {
    return [
      DropdownMenuItem(value: 'none', child: Text('${AppLocale.S12.getString(context)}')),
      DropdownMenuItem(value: 'high_school', child: Text('${AppLocale.S13.getString(context)}')),
      DropdownMenuItem(value: 'bachelor', child: Text('${AppLocale.S14.getString(context)}')),
      DropdownMenuItem(value: 'master', child: Text('${AppLocale.S15.getString(context)}')),
      DropdownMenuItem(value: 'phd', child: Text('${AppLocale.S16.getString(context)}')),
    ];
  }

  List<FormBuilderFieldOption<String>> _getEnglishGoalOptions() {
    return [
      FormBuilderFieldOption(value: 'study', child: Text('${AppLocale.S75_study.getString(context)}')),
      FormBuilderFieldOption(value: 'work', child: Text('${AppLocale.S75_work.getString(context)}')),
      FormBuilderFieldOption(value: 'travel', child: Text('${AppLocale.S75_travel.getString(context)}')),
      FormBuilderFieldOption(value: 'personal_interest', child: Text('${AppLocale.S40.getString(context)}')),
    ];
  }

  String? _textFieldValidator(String name, String? value) {
    if (name == 'age') {
      final age = int.tryParse(value ?? '') ?? 0;
      if (age < 10 || age > 60) return 'يجب أن يكون العمر بين 10 و 60 سنة.';
    } else if (name == 'name') {
      if (value == null || value.length < 3) return 'يجب أن يحتوي الاسم على 3 أحرف على الأقل.';
    }
    return null;
  }
}






class UserProfileDisplay extends StatefulWidget {
  @override
  _UserProfileDisplayState createState() => _UserProfileDisplayState();
}

class _UserProfileDisplayState extends State<UserProfileDisplay> {
  String? _name;
  String? _age;
  String? _gender;
  List<String>? _englishGoal;
  String? _educationLevel;
  String? _memoryType;
  File? _image;

  // متغيرات النقاط
  double grammarPoints = 0;
  double lessonPoints = 0;
  double studyHoursPoints = 0;
  double listeningPoints = 0;
  double speakingPoints = 0;
  double readingPoints = 0;
  double writingPoints = 0;
  double exercisePoints = 0;
  double sentenceFormationPoints = 0;
  double gamePoints =  0; // نقاط الألعاب (9 ألعاب)

  // إجمالي النقاط بحد أقصى مليون نقطة
  double maxPoints = 1000000;

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

  // تحديد الألقاب بناءً على النقاط
  String get userRank {
    if (totalPoints < 20000) {
      return "مبتدئ";
    } else if (totalPoints < 100000) {
      return "متعلم";
    } else if (totalPoints < 300000) {
      return "متوسط";
    } else if (totalPoints < 600000) {
      return "متعلم متقدم";
    } else if (totalPoints < 900000) {
      return "خبير";
    } else {
      return "متمرس";
    }
  }

  // زيادة النقاط (مثال)
  void increasePoints(String category, double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      switch (category) {
        case 'grammar':
          grammarPoints += amount;
          prefs.setDouble('grammarPoints', grammarPoints);
          break;
        case 'lessons':
          lessonPoints += amount;
          prefs.setDouble('lessonPoints', lessonPoints);
          break;
        case 'studyHours':
          studyHoursPoints += amount;
          prefs.setDouble('studyHoursPoints', studyHoursPoints);
          break;
        case 'listening':
          listeningPoints += amount;
          prefs.setDouble('listeningPoints', listeningPoints);
          break;
        case 'speaking':
          speakingPoints += amount;
          prefs.setDouble('speakingPoints', speakingPoints);
          break;
        case 'reading':
          readingPoints += amount;
          prefs.setDouble('readingPoints', readingPoints);
          break;
        case 'writing':
          writingPoints += amount;
          prefs.setDouble('writingPoints', writingPoints);
          break;
        case 'exercises':
          exercisePoints += amount;
          prefs.setDouble('exercisePoints', exercisePoints);
          break;
        case 'sentenceFormation':
          sentenceFormationPoints += amount;
          prefs.setDouble('sentenceFormationPoints', sentenceFormationPoints);
          break;
        case 'games':
          gamePoints += amount;
          prefs.setDouble('gamePoints', gamePoints);
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name');
      _age = prefs.getString('age');
      _gender = prefs.getString('gender');
      _englishGoal = prefs.getStringList('english_goal');
      _educationLevel = prefs.getString('education_level');
      _memoryType = prefs.getString('memory_type');
      final imagePath = prefs.getString('image_path');
      if (imagePath != null) {
        _image = File(imagePath);
      }

      // تحميل النقاط من SharedPreferences أو استخدام القيم الافتراضية
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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    double padding = screenWidth * 0.04;
    double avatarRadius = screenWidth * 0.15;
    double fontSizeTitle = screenWidth * 0.05;
    double fontSizeContent = screenWidth * 0.04;
    double buttonFontSize = screenWidth * 0.04;
    double iconSize = screenWidth * 0.06;

    return Scaffold(
      backgroundColor: Color(0xFF0D47A1),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // استدعاء دالة زيادة النقاط
      //     increasePoints('grammar', 22500); // مثال على زيادة 500 نقطة في قسم القواعد
      //   },
      //   backgroundColor: Colors.blue, // لون الزر
      //   child: Icon(Icons.add, color: Colors.white), // أيقونة الزر
      // ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildUserInfoSection(
                  avatarRadius: avatarRadius,
                  fontSizeTitle: fontSizeTitle,
                  fontSizeContent: fontSizeContent,
                ),
                SizedBox(height: screenHeight * 0.02),

                // قسم المؤشرات الإحصائية
                _buildStatisticsSection(screenWidth),

                SizedBox(height: screenHeight * 0.02),

                // أزرار التنقل
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserPlanPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 140),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white, width: 2), // إضافة الحواف البيضاء
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(FontAwesomeIcons.map, color: Colors.white, size: iconSize),
                      SizedBox(width: 10),
                      Text(
                        'الخطة التعليمية',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: buttonFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DeveloperAndReviewerPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 170),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white, width: 2), // إضافة الحواف البيضاء
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(FontAwesomeIcons.code, color: Colors.white, size: iconSize),
                      SizedBox(width: 10),
                      Text(
                        'المطور',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: buttonFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoSection({
    required double avatarRadius,
    required double fontSizeTitle,
    required double fontSizeContent,
  }) {
    return Card(
      color: Color(0xFF1A237E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white, width: 2),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileImage(avatarRadius),
            SizedBox(height: 20),
            _buildInfoRow('الاسم', _name, fontSizeTitle, fontSizeContent),
            _buildInfoRow('الهدف من تعلم الإنجليزية', _englishGoal?.join(", "), fontSizeTitle, fontSizeContent),
            _buildInfoRow('المستوى التعليمي', _educationLevel, fontSizeTitle, fontSizeContent),
            _buildInfoRow('نوع الذاكرة', _memoryType, fontSizeTitle, fontSizeContent),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(double avatarRadius) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
      },
      child: Container(
        width: avatarRadius * 2, // القطر يعادل ضعف نصف القطر
        height: avatarRadius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: _image != null
                ? FileImage(_image!)
                : AssetImage('assets/df.png') as ImageProvider,
            fit: BoxFit.cover,
          ),
          color: Color(0xFF1A237E),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value, double fontSizeTitle, double fontSizeContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSizeTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: Text(
              value ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSizeContent,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildStatisticsSection(double screenWidth) {
    return Card(
      color: Colors.white, // خلفية بيضاء لقسم المؤشرات الإحصائية
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey, width: 1), // حواف خفيفة
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'المؤشرات الإحصائية',
              style: TextStyle(
                color: Color(0xFF0D47A1), // لون النص بالأزرق الغامق ليتناسب مع الخلفية البيضاء
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'إجمالي النقاط: ${totalPoints.toInt()}',
              style: TextStyle(
                color: Color(0xFF0D47A1), // لون النص بالأزرق الغامق
                fontSize: screenWidth * 0.04,
              ),
            ),
            Text(
              'اللقب: $userRank',
              style: TextStyle(
                color: Color(0xFF0D47A1), // لون النص بالأزرق الغامق
                fontSize: screenWidth * 0.04,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 400, // تعديل الارتفاع حسب الحاجة
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 1000,
                    verticalInterval: 1,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 100000, // ضبط الفواصل حسب الحاجة
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${(value / 1000).toInt()}k',
                            style: TextStyle(color: Colors.black, fontSize: 10), // لون النص الأسود ليتناسب مع الخلفية البيضاء
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 1:
                              return Text('قواعد', style: TextStyle(color: Colors.black, fontSize: 10));
                            case 2:
                              return Text('استماع', style: TextStyle(color: Colors.black, fontSize: 10));
                            case 3:
                              return Text('تحدث', style: TextStyle(color: Colors.black, fontSize: 10));
                            case 4:
                              return Text('قراءة', style: TextStyle(color: Colors.black, fontSize: 10));
                            case 5:
                              return Text('كتابة', style: TextStyle(color: Colors.black, fontSize: 10));
                            case 6:
                              return Text('تمارين', style: TextStyle(color: Colors.black, fontSize: 10));
                            case 7:
                              return Text('تكوين جمل', style: TextStyle(color: Colors.black, fontSize: 10));
                            case 8:
                              return Text('ألعاب', style: TextStyle(color: Colors.black, fontSize: 10));
                            default:
                              return Text('');
                          }
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey), // حواف رمادية
                  ),
                  minX: 1,
                  maxX: 8,
                  minY: 0,
                  maxY: 1000000, // تعديل الحد الأقصى للنقاط
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(1, grammarPoints),
                        FlSpot(2, listeningPoints),
                        FlSpot(3, speakingPoints),
                        FlSpot(4, readingPoints),
                        FlSpot(5, writingPoints),
                        FlSpot(6, exercisePoints),
                        FlSpot(7, sentenceFormationPoints),
                        FlSpot(8, gamePoints),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لا يمكن فتح الرابط')),
      );
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}










// تأكد من إنشاء صفحة SettingsScreen أو استيرادها إذا كانت موجودة بالفعل


class DeveloperAndReviewerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarRadius = screenWidth * 0.15;
    double fontSizeTitle = screenWidth * 0.05;
    double fontSizeContent = screenWidth * 0.04;
    double buttonFontSize = screenWidth * 0.04;
    double iconSize = screenWidth * 0.06;
    double padding = screenWidth * 0.04;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
      ),
      backgroundColor: Color(0xFF0D47A1),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildDeveloperInfoSection(
                  avatarRadius: avatarRadius,
                  fontSizeTitle: fontSizeTitle,
                  fontSizeContent: fontSizeContent,
                  buttonFontSize: buttonFontSize,
                  iconSize: iconSize,
                ),
                SizedBox(height: 20),
                _buildAdditionalInfoSection(
                  avatarRadius: avatarRadius,
                  fontSizeTitle: fontSizeTitle,
                  fontSizeContent: fontSizeContent,
                  buttonFontSize: buttonFontSize,
                  iconSize: iconSize,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeveloperInfoSection({
    required double avatarRadius,
    required double fontSizeTitle,
    required double fontSizeContent,
    required double buttonFontSize,
    required double iconSize,
  }) {
    return Card(
      color: Color(0xFF1A237E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white, width: 2),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundImage: AssetImage('assets/b2.jpg'),
              backgroundColor: Color(0xFF1A237E),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _launchURL("https://wa.me/message/O5DCTAFLWWRTB1");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(FontAwesomeIcons.code, color: Colors.white, size: iconSize),
                  SizedBox(width: 10),
                  Text(
                    'تم التطوير بواسطة: أبو بكر',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: buttonFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              """تعلم الإنجليزية بطريقة تفاعلية وشاملة مع Engo Learn! يساعدك على تحسين مهارات القراءة، الكتابة، والاستماع، من خلال دروس شاملة وتمارين لكل درس. يحتوي التطبيق على 9 ألعاب ممتعة لحفظ الكلمات الجديدة بسهولة، بالإضافة إلى تعليم قواعد اللغة الإنجليزية بشكل مميز.""",
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSizeContent,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              """✨  أنا مطور تطبيقات ومواقع متمرس، أعمل على تحسين وتطوير تطبيقاتي بشكل يومي لضمان أفضل تجربة للمستخدمين.

إذا واجهتك أي مشكلة أو كان لديك أي استفسار حول التطبيق، فلا تتردد في التواصل معي. أنا هنا للمساعدة وسأكون سعيدًا بتلبية احتياجاتك!

📩 لنتعاون معًا!""",
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSizeContent,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: iconSize),
                  onPressed: () {
                    _launchURL('https://wa.me/message/O5DCTAFLWWRTB1');
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white, size: iconSize),
                  onPressed: () {
                    _launchURL('https://www.facebook.com/profile.php?id=61552252281045&mibextid=ZbWKwL');
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.tiktok, color: Colors.white, size: iconSize),
                  onPressed: () {
                    _launchURL('https://www.tiktok.com/@abobakr2024?_t=8q7PxH0KQk6&_r=1');
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoSection({
    required double avatarRadius,
    required double fontSizeTitle,
    required double fontSizeContent,
    required double buttonFontSize,
    required double iconSize,
  }) {
    double screenWidth = 0; // غير مستخدم في هذا السياق
    double fontSize = 0; // غير مستخدم في هذا السياق

    return Card(
      color: Color(0xFF1A237E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white, width: 2),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundImage: AssetImage('assets/u.jpg'),
              backgroundColor: Color(0xFF1A237E),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _launchURL("https://wa.me/partnercontact");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(FontAwesomeIcons.language, color: Colors.white, size: iconSize),
                  SizedBox(width: 10),
                  Text(
                    'تمت المراجعة بواسطة: Mr/Mohamed Hassan ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14, // يمكنك تعديل الحجم حسب الحاجة
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              """مترجم ويُدرس كورسات تأسيس في اللغة الإنجليزية.""",
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSizeContent,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "لأي استفسار أو مشكلة في التطبيق، تواصل معنا:",
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSizeContent,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: iconSize),
                  onPressed: () {
                    _launchURL('https://wa.me/qr/KKXVOO45HETBJ1');
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white, size: iconSize),
                  onPressed: () {
                    _launchURL('https://www.facebook.com/profile.php?id=100007256430785&mibextid=ZbWKwL');
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) {
      // Ignoring SnackBar as this is StatelessWidget, يمكنك تحويل الصفحة إلى StatefulWidget إذا كنت ترغب في عرض SnackBar
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
