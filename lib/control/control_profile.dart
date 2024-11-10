


import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../hom.dart';
import '../settings/setting_2.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class UserPlanPage extends StatefulWidget {
  @override
  _UserPlanPageState createState() => _UserPlanPageState();
}

class _UserPlanPageState extends State<UserPlanPage> {
  String name = '';
  String age = '';
  String gender = '';
  List<String> englishGoal = [];
  String educationLevel = '';
  String memoryType = '';
  String? imagePath;

  // الحقول الجديدة لمستويات اللغة الإنجليزية
  String englishLevelReading = 'A1';
  String englishLevelListening = 'A1';
  String englishLevelSpeaking = 'A1';
  String englishLevelVocabulary = 'A1';
  String englishLevelGrammar = 'A1';
  String englishLevelWriting = 'A1';

  List<String> learningPlan = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // دالة لتحميل بيانات المستخدم والخطة التعليمية
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      age = prefs.getString('age') ?? '';
      gender = prefs.getString('gender') ?? '';
      englishGoal = prefs.getStringList('english_goal') ?? [];
      educationLevel = prefs.getString('education_level') ?? '';
      memoryType = prefs.getString('memory_type') ?? '';
      imagePath = prefs.getString('image_path');

      // تحميل المستويات المخصصة للمهارات اللغوية
      englishLevelReading = prefs.getString('english_level_reading') ?? 'A1';
      englishLevelListening = prefs.getString('english_level_listening') ?? 'A1';
      englishLevelSpeaking = prefs.getString('english_level_speaking') ?? 'A1';
      englishLevelVocabulary = prefs.getString('english_level_vocabulary') ?? 'A1';
      englishLevelGrammar = prefs.getString('english_level_grammar') ?? 'A1';
      englishLevelWriting = prefs.getString('english_level_writing') ?? 'A1';

      // استرجاع الخطة المحفوظة إن وجدت، وإلا إنشاء خطة جديدة
      learningPlan = prefs.getStringList('learning_plan') ?? _generateLearningPlan();
    });
  }

  // دالة لحفظ الخطة التعليمية
  Future<void> _saveLearningPlan() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('learning_plan', learningPlan);
  }

  // دالة لإنشاء الخطة التعليمية بناءً على البيانات المدخلة
  List<String> _generateLearningPlan() {
    List<String> plan = [];

    // تحويل العمر إلى رقم
    int userAge = int.tryParse(age) ?? 0;
    int studyHoursPerDay = 1;
    int daysPerWeek = 5;
    int exerciseTime = 15; // بالدقائق

    // تخصيص عدد الساعات والأيام بناءً على المستوى التعليمي
    if (educationLevel == 'none') {
      studyHoursPerDay = 1;
      daysPerWeek = 3;
      plan.add('ابدأ بتعلم الأساسيات مثل الأبجدية والقواعد البسيطة.');
      plan.add('استخدم الألعاب والأنشطة التفاعلية لتأسيس مهارات اللغة.');
      plan.add('شاهد فيديوهات تعليمية قصيرة لجعل التعلم ممتعاً.');
      plan.add('تحدث مع أصدقاء أو أفراد العائلة لتحسين المهارات.');
      plan.add('خصص وقتًا يوميًا للعب ألعاب تعليمية لتعزيز الفهم.');
    } else if (educationLevel == 'primary_school') {
      studyHoursPerDay = 1;
      daysPerWeek = 4;
      plan.add('استخدم مواد تعليمية مبسطة مع صور ورسوم للمساعدة في الفهم.');
      plan.add('تابع دروسًا يومية قصيرة لتقوية المفردات والنطق.');
      plan.add('ابدأ بقراءة كتب أطفال مصورة لتحسين القراءة.');
      plan.add('قم بكتابة جمل قصيرة حول مواضيع تحبها.');
      plan.add('اشترك في برامج تعليمية تفاعلية لتسريع التعلم.');
    } else if (educationLevel == 'high_school') {
      studyHoursPerDay = 2;
      daysPerWeek = 5;
      plan.add('ركز على مواد تعليمية متوسطة المستوى لتطوير المهارات.');
      plan.add('تمرن على كتابة ملاحظات وملخصات لتحسين الكتابة.');
      plan.add('اقرأ مقالات حول مواضيع تحبها لتعزيز المفردات.');
      plan.add('مارس التحدث بتقليد مقاطع من الأفلام أو الأغاني.');
      plan.add('حاول حل تمارين الكتابة على الإنترنت.');
    } else if (educationLevel == 'bachelor') {
      studyHoursPerDay = 2;
      daysPerWeek = 5;
      plan.add('ابدأ بتعزيز مهارات الكتابة الأكاديمية باستخدام مواد متقدمة.');
      plan.add('اشترك في منتديات نقاش باللغة الإنجليزية لتحسين التحدث.');
      plan.add('اقرأ مقالات علمية لزيادة المفردات الأكاديمية.');
      plan.add('سجل أفكارك اليومية في مذكرة لتقوية الطلاقة الكتابية.');
      plan.add('شاهد أفلامًا بدون ترجمة لتحسين الاستماع.');
    } else if (educationLevel == 'master' || educationLevel == 'phd') {
      studyHoursPerDay = 2;
      daysPerWeek = 6;
      plan.add('تعمق في الدراسات المتقدمة، مثل الأدب الإنجليزي أو اللغة التخصصية.');
      plan.add('شارك في دورات متقدمة لتحسين مهارات البحث والكتابة.');
      plan.add('اطلع على مقالات علمية محكمة واستخدمها في تمارين القراءة.');
      plan.add('انضم إلى مجموعات دراسة أكاديمية لتبادل الأفكار.');
      plan.add('قم بتقديم عروض تقديمية باللغة الإنجليزية بشكل منتظم.');
    }

    // تخصيص الخطة بناءً على مستوى القراءة
    if (englishLevelReading == 'A1') {
      plan.add('ابدأ بقراءة قصص بسيطة للأطفال ومقالات سهلة مع صور.');
      studyHoursPerDay = studyHoursPerDay < 2 ? studyHoursPerDay + 1 : 2;
      daysPerWeek += 1;
      plan.add('تدرب على القراءة بصوت عالٍ لتحسين الطلاقة وزيادة الثقة.');
      plan.add('استخدم تطبيقات تعليمية تقدم نصوصًا بمستويات بسيطة مع تمارين مصاحبة.');
    } else if (englishLevelReading == 'B1') {
      plan.add('اقرأ مقالات قصيرة وأخبار يومية مع تمارين مفردات لتعزيز الفهم.');
      plan.add('اشترك في برامج قراءة يومية تُرسل لك مقالات تناسب مستواك.');
      plan.add('حاول قراءة الروايات المترجمة لتحسين الفهم.');
      plan.add('استخدم القواميس التفاعلية لفهم الكلمات الجديدة.');
    } else if (englishLevelReading == 'C1') {
      plan.add('قم بقراءة نصوص أدبية متقدمة ومقالات أكاديمية لتحسين الفهم النقدي.');
      studyHoursPerDay = studyHoursPerDay < 2 ? studyHoursPerDay + 1 : 2;
      plan.add('شارك في نوادي قراءة لتبادل الأفكار حول النصوص.');
      plan.add('حاول كتابة تلخيص لكل مقال تقرأه.');
    }

    // تخصيص الخطة بناءً على مستوى الاستماع
    if (englishLevelListening == 'A1') {
      plan.add('استمع إلى مقاطع صوتية قصيرة مثل القصص المسموعة للمبتدئين.');
      studyHoursPerDay = studyHoursPerDay < 2 ? studyHoursPerDay + 1 : 2;
      exerciseTime += 10;
      plan.add('كرر الاستماع إلى نفس المقطع عدة مرات للحصول على فهم أفضل.');
      plan.add('حاول متابعة المسلسلات الكرتونية للأطفال بدون ترجمة.');
      plan.add('قم بتسجيل ما تسمعه ثم قراءته بصوت عالٍ.');
    } else if (englishLevelListening == 'B1') {
      plan.add('استمع إلى برامج إذاعية وبودكاست متوسطة الصعوبة.');
      plan.add('حاول تلخيص ما استمعت إليه بكتابة ملخص.');
      plan.add('شارك في مجموعات تبادل الملفات الصوتية لتحسين الاستماع.');
    } else if (englishLevelListening == 'C1') {
      plan.add('استمع إلى محاضرات ومقاطع صوتية معقدة لتحسين فهم المحادثات المتقدمة.');
      plan.add('شارك في مجموعات محادثة لتحسين الاستماع التفاعلي.');
      plan.add('استمع إلى الأفلام الوثائقية والمقاطع الأكاديمية لتعزيز المصطلحات المتخصصة.');
    }

    // تخصيص الخطة بناءً على مستوى التحدث
    if (englishLevelSpeaking == 'A1') {
      plan.add('تدرب على الحوارات البسيطة، مثل تقديم نفسك وسؤال الآخرين.');
      daysPerWeek += 1;
      plan.add('استخدم تطبيقات المحادثة لتحسين النطق والمفردات.');
      plan.add('تحدث مع شريك لتحسين مهارات الحوار اليومي.');
    } else if (englishLevelSpeaking == 'B2') {
      plan.add('شارك في تمارين التحدث لتحسين الطلاقة والنطق.');
      plan.add('سجل نفسك أثناء التحدث واستمع إلى التسجيل لتحسين النطق.');
      plan.add('احضر دروس المحادثة الجماعية لتطوير الطلاقة.');
    } else if (englishLevelSpeaking == 'C1') {
      plan.add('انخرط في مناقشات معقدة وتعلم تقديم الحجج المعقدة.');
      plan.add('تدرب على إلقاء العروض التقديمية باللغة الإنجليزية.');
    }

    // تخصيص الخطة بناءً على مستوى الكتابة
    if (englishLevelWriting == 'A1') {
      plan.add('ابدأ بكتابة جمل بسيطة مع التركيز على تركيب الجمل الأساسية.');
      studyHoursPerDay = studyHoursPerDay < 2 ? studyHoursPerDay + 1 : 2;
      plan.add('تدرب على كتابة الرسائل القصيرة.');
      plan.add('قم بإنشاء دفتر يوميات لكتابة الأفكار اليومية.');
    } else if (englishLevelWriting == 'B2') {
      plan.add('تدرب على كتابة مقالات وتقارير قصيرة مع التركيز على التراكيب المعقدة.');
      plan.add('قم بكتابة مذكرات يومية باللغة الإنجليزية.');
    } else if (englishLevelWriting == 'C1') {
      plan.add('ركز على كتابة أبحاث ومقالات متقدمة.');
      daysPerWeek += 1;
      plan.add('استخدم مفردات متقدمة لإثراء كتاباتك.');
      plan.add('قم بتطوير أسلوبك الكتابي من خلال قراءة المقالات المتقدمة.');
    }

    // إضافة توصيات حول عدد ساعات التعلم وعدد الأيام والوقت المخصص للتمارين
    plan.add('ننصح بـ ${studyHoursPerDay} ساعة تعلم يومياً، ${daysPerWeek} أيام في الأسبوع.');
    plan.add('خصص حوالي ${exerciseTime} دقيقة للتمارين اليومية.');

    // حفظ وتحديث الخطة
    learningPlan = plan;
    _saveLearningPlan();

    return plan;
  }

  // دالة مساعدة لتحديد النشاط اليومي بناءً على اليوم
  String _getDailyActivity(int day) {
    switch (day % 4) {
      case 0:
        return 'قراءة';
      case 1:
        return 'كتابة';
      case 2:
        return 'استماع';
      default:
        return 'تحدث';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF13194E),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileImage(),
           // SizedBox(height: 10),
          //  _buildUserInfo(),
            SizedBox(height: 30),
            _buildLearningPlan(),
            SizedBox(height: 30),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: CircleAvatar(
        radius: 70,
        backgroundColor: const Color(0xFF1A237E),
        backgroundImage: imagePath != null ? FileImage(File(imagePath!)) : null,
        child: imagePath == null
            ? const Icon(Icons.account_circle, color: Colors.white, size: 70)
            : null,
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('الاسم', name),
        _buildInfoRow('العمر', age),
        _buildInfoRow('الجنس', gender == 'Male' ? 'ذكر' : 'أنثى'),
        _buildInfoRow('المستوى التعليمي', _getEducationLevelText()),
        _buildInfoRow('نوع الذاكرة', memoryType == 'visual' ? 'بصرية' : 'سمعية'),
      ],
    );
  }

  String _getEducationLevelText() {
    switch (educationLevel) {
      case 'none':
        return 'بدون تعليم';
      case 'primary_school':
        return 'ابتدائي';
      case 'high_school':
        return 'ثانوي';
      case 'bachelor':
        return 'بكالوريوس';
      case 'master':
        return 'ماجستير';
      case 'phd':
        return 'دكتوراه';
      default:
        return '';
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningPlan() {
    return Card(
      color: Color(0xFF1A237E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'خطة تعلم اللغة الإنجليزية:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            for (var item in learningPlan) _buildPlanItem(item),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: 200,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => WaterBottleTask()), // استبدل HomePage بالصفحة الرئيسية الخاصة بك
                (Route<dynamic> route) => false,
          );

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF13194E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.white, width: 2),
          ),
        ),
        child: Text(
          'التالي',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPlanItem(String item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              item,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}




