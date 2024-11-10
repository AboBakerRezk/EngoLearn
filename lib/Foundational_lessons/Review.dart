// الكلمات المستخدمة في الألعاب
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


import '../../../settings/setting_2.dart';

final List<List<List<String>>> allWords = [
  [
    ['live', 'يعيش'],
    ['nothing', 'لا شيء'],
    ['period', 'فترة'],
    ['physics', 'فيزياء'],
    ['plan', 'خطة'],
  ],
  [
    ['store', 'متجر'],
    ['tax', 'ضريبة'],
    ['analysis', 'تحليل'],
    ['cold', 'بارد'],
    ['commercial', 'تجاري'],
  ],
  [
    ['directly', 'مباشرة'],
    ['full', 'ممتلئ'],
    ['involved', 'متورط'],
    ['itself', 'ذاته'],
    ['low', 'منخفض'],
  ],
  [
    ['old', 'قديم'],
    ['policy', 'سياسة'],
    ['political', 'سياسي'],
    ['purchase', 'شراء'],
    ['series', 'سلسلة'],
  ],
  [
    ['the', 'ال'],
    ['of', 'من'],
    ['and', 'و'],
    ['to', 'إلى'],
    ['a', 'أ'],
  ],
  [
    ['in', 'في'],
    ['is', 'هو'],
    ['you', 'أنت'],
    ['are', 'تكون'],
    ['for', 'لـ'],
  ],
  [
    ['that', 'أن'],
    ['or', 'أو'],
    ['it', 'هو'],
    ['as', 'مثل'],
    ['be', 'يكون'],
  ],
  [
    ['on', 'على'],
    ['your', 'لك'],
    ['with', 'مع'],
    ['can', 'يستطيع'],
    ['have', 'لديك'],
  ],
  [
    ['this', 'هذا'],
    ['an', 'أ'],
    ['by', 'بواسطة'],
    ['not', 'ليس'],
    ['but', 'لكن'],
  ],
  [
    ['at', 'في'],
    ['from', 'من'],
    ['I', 'أنا'],
    ['they', 'هم'],
    ['more', 'أكثر'],
  ],
  [
    ['will', 'سوف'],
    ['if', 'إذا'],
    ['some', 'بعض'],
    ['there', 'هناك'],
    ['what', 'ماذا'],
  ],
  [
    ['about', 'حول'],
    ['which', 'التي'],
    ['when', 'متى'],
    ['one', 'واحد'],
    ['their', 'لهم'],
  ],
  [
    ['all', 'الكل'],
    ['also', 'أيضاً'],
    ['how', 'كيف'],
    ['many', 'كثير'],
    ['do', 'افعل'],
  ],
  [
    ['has', 'لديه'],
    ['most', 'معظم'],
    ['people', 'الناس'],
    ['other', 'آخر'],
    ['time', 'وقت'],
  ],
  [
    ['so', 'لذلك'],
    ['was', 'كان'],
    ['we', 'نحن'],
    ['these', 'هؤلاء'],
    ['may', 'قد'],
  ],
  [
    ['like', 'مثل'],
    ['use', 'يستخدم'],
    ['into', 'إلى'],
    ['than', 'من'],
    ['up', 'أعلى'],
  ],
  [
    ['out', 'خارج'],
    ['who', 'من'],
    ['them', 'هم'],
    ['make', 'يصنع'],
    ['because', 'لأن'],
  ],
  [
    ['such', 'مثل'],
    ['through', 'عبر'],
    ['get', 'يحصل على'],
    ['work', 'عمل'],
    ['even', 'حتى'],
  ],
  [
    ['different', 'مختلف'],
    ['its', 'له'],
    ['no', 'لا'],
    ['our', 'لنا'],
    ['new', 'جديد'],
  ],
  [
    ['film', 'فيلم'],
    ['just', 'فقط'],
    ['only', 'فقط'],
    ['see', 'يرى'],
    ['used', 'مستخدم'],
  ],
  [
    ['good', 'جيد'],
    ['water', 'ماء'],
    ['been', 'كان'],
    ['need', 'يحتاج'],
    ['should', 'ينبغي'],
  ],
  [
    ['very', 'جداً'],
    ['any', 'أي'],
    ['history', 'تاريخ'],
    ['often', 'غالباً'],
    ['way', 'طريق'],
  ],
  [
    ['well', 'حسناً'],
    ['art', 'فن'],
    ['know', 'يعرف'],
    ['were', 'كانوا'],
    ['then', 'ثم'],
  ],
  [
    ['my', 'لي'],
    ['first', 'أول'],
    ['would', 'سوف'],
    ['money', 'مال'],
    ['each', 'كل'],
  ],
  [
    ['over', 'على'],
    ['world', 'العالم'],
    ['information', 'معلومات'],
    ['map', 'خريطة'],
    ['find', 'جد'],
  ],
  [
    ['where', 'أين'],
    ['much', 'كثير'],
    ['take', 'خذ'],
    ['two', 'اثنان'],
    ['want', 'تريد'],
  ],
  [
    ['important', 'مهم'],
    ['family', 'أسرة'],
    ['those', 'أولئك'],
    ['example', 'مثال'],
    ['while', 'بينما'],
  ],
  [
    ['he', 'هو'],
    ['look', 'ينظر'],
    ['government', 'حكومة'],
    ['before', 'قبل'],
    ['help', 'مساعدة'],
  ],
  [
    ['between', 'بين'],
    ['go', 'اذهب'],
    ['own', 'خاص'],
    ['however', 'ومع ذلك'],
    ['business', 'عمل'],
  ],
  [
    ['us', 'لنا'],
    ['great', 'عظيم'],
    ['his', 'له'],
    ['being', 'يجري'],
    ['another', 'آخر'],
  ],
  [
    ['health', 'صحة'],
    ['same', 'نفس'],
    ['study', 'دراسة'],
    ['why', 'لماذا'],
    ['few', 'قليل'],
  ],
  [
    ['game', 'لعبة'],
    ['might', 'ربما'],
    ['think', 'يفكر'],
    ['free', 'حر'],
    ['too', 'جداً'],
  ],
  [
    ['had', 'كان'],
    ['hi', 'مرحبا'],
    ['right', 'حق'],
    ['still', 'ما زال'],
    ['system', 'نظام'],
  ],
  [
    ['after', 'بعد'],
    ['computer', 'حاسوب'],
    ['best', 'الأفضل'],
    ['must', 'يجب'],
    ['her', 'لها'],
  ],
  [
    ['life', 'حياة'],
    ['since', 'منذ'],
    ['could', 'استطاع'],
    ['does', 'يفعل'],
    ['now', 'الآن'],
  ],
  [
    ['during', 'أثناء'],
    ['learn', 'تعلم'],
    ['around', 'حول'],
    ['usually', 'عادة'],
    ['form', 'شكل'],
  ],
  [
    ['meat', 'لحم'],
    ['air', 'هواء'],
    ['day', 'يوم'],
    ['place', 'مكان'],
    ['become', 'يصبح'],
  ],
  [
    ['number', 'رقم'],
    ['public', 'عام'],
    ['read', 'قرأ'],
    ['keep', 'احتفظ'],
    ['part', 'جزء'],
  ],
  [
    ['start', 'بداية'],
    ['year', 'عام'],
    ['every', 'كل'],
    ['field', 'حقل'],
    ['large', 'كبير'],
  ],
  [
    ['once', 'مرة واحدة'],
    ['available', 'متاح'],
    ['down', 'أسفل'],
    ['give', 'يعطي'],
    ['fish', 'سمك'],
  ],
  [
    ['human', 'بشري'],
    ['both', 'كلا'],
    ['local', 'محلي'],
    ['sure', 'بالتأكيد'],
    ['something', 'شيء ما'],
  ],
  [
    ['without', 'بدون'],
    ['come', 'يأتي'],
    ['me', 'أنا'],
    ['back', 'خلف'],
    ['better', 'أفضل'],
  ],
  [
    ['general', 'عام'],
    ['process', 'معالجة'],
    ['she', 'هي'],
    ['heat', 'حرارة'],
    ['thanks', 'شكراً'],
  ],
  [
    ['specific', 'محدد'],
    ['enough', 'كافٍ'],
    ['long', 'طويل'],
    ['lot', 'قطعة أرض'],
    ['hand', 'يد'],
  ],
  [
    ['data', 'بيانات'],
    ['feel', 'يشعر'],
    ['high', 'مرتفع'],
    ['off', 'إيقاف'],
    ['point', 'نقطة'],
  ],
  [
    ['type', 'نوع'],
    ['whether', 'سواء'],
    ['food', 'طعام'],
    ['understanding', 'فهم'],
    ['here', 'هنا'],
  ],
  [
    ['home', 'الصفحة الرئيسية'],
    ['certain', 'مؤكد'],
    ['economy', 'اقتصاد'],
    ['little', 'قليل'],
    ['theory', 'نظرية'],
  ],
  [
    ['tonight', 'هذه الليلة'],
    ['law', 'قانون'],
    ['put', 'وضع'],
    ['under', 'تحت'],
    ['value', 'قيمة'],
  ],
  [
    ['data', 'بيانات'],
    ['feel', 'يشعر'],
    ['high', 'مرتفع'],
    ['off', 'إيقاف'],
    ['point', 'نقطة'],
  ],
  [
    ['type', 'نوع'],
    ['whether', 'سواء'],
    ['food', 'طعام'],
    ['understanding', 'فهم'],
    ['here', 'هنا'],
  ],
  [
    ['home', 'الصفحة الرئيسية'],
    ['certain', 'مؤكد'],
    ['economy', 'اقتصاد'],
    ['little', 'قليل'],
    ['theory', 'نظرية'],
  ],
  [
    ['tonight', 'هذه الليلة'],
    ['law', 'قانون'],
    ['put', 'وضع'],
    ['under', 'تحت'],
    ['value', 'قيمة'],
  ],
  [
    ['always', 'دائماً'],
    ['body', 'جسم'],
    ['common', 'شائع'],
    ['market', 'سوق'],
    ['set', 'جلس'],
  ],
  [
    ['bird', 'طائر'],
    ['guide', 'مرشد'],
    ['provide', 'تزود'],
    ['change', 'تغيير'],
    ['interest', 'فائدة'],
  ],
  [
    ['literature', 'أدب'],
    ['sometimes', 'أحياناً'],
    ['problem', 'مشكلة'],
    ['say', 'يقول'],
    ['next', 'التالي'],
  ],
  [
    ['create', 'ينشئ'],
    ['simple', 'بسيط'],
    ['software', 'برمجيات'],
    ['state', 'حالة'],
    ['together', 'سوياً'],
  ],
  [
    ['control', 'مراقبة'],
    ['knowledge', 'معرفة'],
    ['power', 'قوة'],
    ['radio', 'راديو'],
    ['ability', 'قدرة'],
  ],
  [
    ['basic', 'أساسي'],
    ['course', 'دورة'],
    ['economics', 'اقتصاديات'],
    ['hard', 'صعب'],
    ['add', 'إضافة'],
  ],
  [
    ['company', 'شركة'],
    ['known', 'معروف'],
    ['love', 'حب'],
    ['past', 'الماضي'],
    ['price', 'سعر'],
  ],
  [
    ['size', 'حجم'],
    ['away', 'بعيد'],
    ['big', 'كبير'],
    ['internet', 'إنترنت'],
    ['possible', 'ممكن'],
  ],
  [
    ['television', 'تلفزيون'],
    ['three', 'ثلاثة'],
    ['understand', 'يفهم'],
    ['various', 'متنوع'],
    ['yourself', 'نفسك'],
  ],
  [
    ['card', 'بطاقة'],
    ['difficult', 'صعب'],
    ['including', 'بما في ذلك'],
    ['list', 'قائمة'],
    ['mind', 'عقل'],
  ],
  [
    ['particular', 'خاص'],
    ['real', 'حقيقي'],
    ['science', 'علم'],
    ['trade', 'تجارة'],
    ['consider', 'يعتبر'],
  ],
  [
    ['either', 'إما'],
    ['library', 'مكتبة'],
    ['likely', 'من المحتمل'],
    ['nature', 'طبيعة'],
    ['fact', 'حقيقة'],
  ],
  [
    ['line', 'خط'],
    ['product', 'منتج'],
    ['care', 'رعاية'],
    ['group', 'مجموعة'],
    ['idea', 'فكرة'],
  ],
  [
    ['risk', 'خطر'],
    ['several', 'عدة'],
    ['someone', 'شخص ما'],
    ['temperature', 'درجة الحرارة'],
    ['united', 'متحد'],
  ],
  [
    ['word', 'كلمة'],
    ['fat', 'دهون'],
    ['force', 'قوة'],
    ['key', 'مفتاح'],
    ['light', 'ضوء'],
  ],
  [
    ['simply', 'ببساطة'],
    ['today', 'اليوم'],
    ['training', 'تدريب'],
    ['until', 'حتى'],
    ['major', 'رائد'],
  ],
  [
    ['name', 'اسم'],
    ['personal', 'شخصي'],
    ['school', 'مدرسة'],
    ['top', 'أعلى'],
    ['current', 'حالي'],
  ],
  [
    ['generally', 'عموماً'],
    ['historical', 'تاريخي'],
    ['investment', 'استثمار'],
    ['left', 'يسار'],
    ['national', 'وطني'],
  ],
  [
    ['amount', 'كمية'],
    ['level', 'مستوى'],
    ['order', 'طلب'],
    ['practice', 'ممارسة'],
    ['research', 'بحث'],
  ],
  [
    ['sense', 'إحساس'],
    ['service', 'خدمة'],
    ['area', 'منطقة'],
    ['cut', 'قطع'],
    ['hot', 'حار'],
  ],
  [
    ['instead', 'بدلاً'],
    ['least', 'الأقل'],
    ['natural', 'طبيعي'],
    ['physical', 'بدني'],
    ['piece', 'قطعة'],
  ],
  [
    ['show', 'يظهر'],
    ['society', 'مجتمع'],
    ['try', 'محاولة'],
    ['check', 'تحقق'],
    ['choose', 'اختر'],
  ],
  [
    ['develop', 'طور'],
    ['second', 'ثاني'],
    ['useful', 'مفيد'],
    ['web', 'شبكة'],
    ['activity', 'نشاط'],
  ],
  [
    ['boss', 'رئيس'],
    ['short', 'قصير'],
    ['story', 'قصة'],
    ['call', 'مكالمة'],
    ['industry', 'صناعة'],
  ],
  [
    ['last', 'الأخير'],
    ['media', 'وسائل الإعلام'],
    ['mental', 'عقلي'],
    ['move', 'تحرك'],
    ['pay', 'يدفع'],
  ],
  [
    ['sport', 'رياضة'],
    ['thing', 'شيء'],
    ['actually', 'فعلياً'],
    ['against', 'ضد'],
    ['far', 'بعيد'],
  ],
  [
    ['fun', 'مرح'],
    ['house', 'منزل'],
    ['let', 'دع'],
    ['page', 'صفحة'],
    ['remember', 'تذكر'],
  ],
  [
    ['term', 'مصطلح'],
    ['test', 'اختبار'],
    ['within', 'داخل'],
    ['along', 'على طول'],
    ['answer', 'إجابة'],
  ],
  [
    ['increase', 'زيادة'],
    ['oven', 'فرن'],
    ['quite', 'إلى حد كبير'],
    ['scared', 'خائف'],
    ['single', 'غير مرتبط'],
  ],
  [
    ['sound', 'صوت'],
    ['again', 'مرة أخرى'],
    ['community', 'مجتمع'],
    ['definition', 'تعريف'],
    ['focus', 'تركيز'],
  ],
  [
    ['individual', 'فرد'],
    ['matter', 'شيء'],
    ['safety', 'سلامة'],
    ['turn', 'دور'],
    ['everything', 'كل شيء'],
  ],
  [
    ['kind', 'طيب'],
    ['quality', 'جودة'],
    ['soil', 'تربة'],
    ['ask', 'يطلب'],
    ['board', 'مجلس'],
  ],
  [
    ['this', 'هذا'],
    ['an', 'أ'],
    ['by', 'بواسطة'],
    ['not', 'ليس'],
    ['but', 'لكن'],
  ],
  [
    ['at', 'في'],
    ['from', 'من'],
    ['I', 'أنا'],
    ['they', 'هم'],
    ['more', 'أكثر'],
  ],
  [
    ['will', 'سوف'],
    ['if', 'إذا'],
    ['some', 'بعض'],
    ['there', 'هناك'],
    ['what', 'ماذا'],
  ],
  [
    ['about', 'حول'],
    ['which', 'التي'],
    ['when', 'متى'],
    ['one', 'واحد'],
    ['their', 'لهم'],
  ],
  [
    ['management', 'إدارة'],
    ['open', 'افتح'],
    ['player', 'لاعب'],
    ['range', 'نطاق'],
    ['rate', 'معدل'],
  ],
  [
    ['reason', 'سبب'],
    ['travel', 'سفر'],
    ['variety', 'تنوع'],
    ['video', 'فيديو'],
    ['week', 'أسبوع'],
  ],
  [
    ['above', 'أعلى'],
    ['according', 'وفقاً'],
    ['cook', 'يطبخ'],
    ['determine', 'تحديد'],
    ['future', 'مستقبل'],
  ],
  [
    ['site', 'موقع'],
    ['alternative', 'بديل'],
    ['demand', 'طلب'],
    ['ever', 'أبداً'],
    ['exercise', 'ممارسة الرياضة'],
  ],
  [
    ['following', 'التالي'],
    ['image', 'صورة'],
    ['quickly', 'بسرعة'],
    ['special', 'خاص'],
    ['working', 'عمل'],
  ],
  [
    ['case', 'قضية'],
    ['cause', 'سبب'],
    ['coast', 'ساحل'],
    ['probably', 'محتمل'],
    ['security', 'أمن'],
  ],
  [
    ['TRUE', 'صحيح'],
    ['whole', 'كامل'],
    ['action', 'عمل'],
    ['age', 'عمر'],
    ['among', 'بين'],
  ],
  [
    ['bad', 'سيئ'],
    ['boat', 'قارب'],
    ['country', 'بلد'],
    ['dance', 'رقص'],
    ['exam', 'امتحان'],
  ],
  [
    ['excuse', 'عذر'],
    ['grow', 'ينمو'],
    ['movie', 'فيلم'],
    ['organization', 'منظمة'],
    ['record', 'سجل'],
  ],
  [
    ['result', 'نتيجة'],
    ['section', 'قسم'],
    ['across', 'عبر'],
    ['already', 'سابقاً'],
    ['below', 'أسفل'],
  ],
  [
    ['building', 'بناء'],
    ['mouse', 'فأر'],
    ['allow', 'يسمح'],
    ['cash', 'نقدي'],
    ['class', 'فصل دراسي'],
  ],
  [
    ['clear', 'واضح'],
    ['dry', 'جاف'],
    ['easy', 'سهل'],
    ['emotional', 'عاطفي'],
    ['equipment', 'معدات'],
  ],
];
// الصفحة الأولى: لعبة اختيار الكلمة الصحيحة
final List<Map<String, String>> allWords2 = [
// المجموعة الأولى
  {'word': 'live', 'translation': 'يعيش', 'image': '🏠'}, // منزل للدلالة على "يعيش"
  {'word': 'nothing', 'translation': 'لا شيء', 'image': '⭕'}, // دائرة للدلالة على "لا شيء"
  {'word': 'period', 'translation': 'فترة', 'image': '⏳'}, // ساعة رملية للدلالة على "فترة"
  {'word': 'physics', 'translation': 'فيزياء', 'image': '🔬'}, // مجهر للدلالة على "فيزياء"
  {'word': 'plan', 'translation': 'خطة', 'image': '📝'}, // ورقة وقلم للدلالة على "خطة"

// المجموعة الثانية
  {'word': 'store', 'translation': 'متجر', 'image': '🏬'}, // متجر للدلالة على "متجر"
  {'word': 'tax', 'translation': 'ضريبة', 'image': '💰'}, // كيس نقود للدلالة على "ضريبة"
  {'word': 'analysis', 'translation': 'تحليل', 'image': '📊'}, // رسم بياني للدلالة على "تحليل"
  {'word': 'cold', 'translation': 'بارد', 'image': '❄️'}, // ندفة ثلج للدلالة على "بارد"
  {'word': 'commercial', 'translation': 'تجاري', 'image': '📺'}, // تلفاز للدلالة على "تجاري"

// المجموعة الثالثة
  {'word': 'directly', 'translation': 'مباشرة', 'image': '➡️'}, // سهم يمين للدلالة على "مباشرة"
  {'word': 'full', 'translation': 'ممتلئ', 'image': '🍲'}, // طبق ممتلئ للدلالة على "ممتلئ"
  {'word': 'involved', 'translation': 'متورط', 'image': '🌀'}, // دوامة للدلالة على "متورط"
  {'word': 'itself', 'translation': 'ذاته', 'image': '🧑‍🦰'}, // شخص للدلالة على "ذاته"
  {'word': 'low', 'translation': 'منخفض', 'image': '⬇️'}, // سهم لأسفل للدلالة على "منخفض"

// المجموعة الرابعة
  {'word': 'old', 'translation': 'قديم', 'image': '👴'}, // رجل مسن للدلالة على "قديم"
  {'word': 'policy', 'translation': 'سياسة', 'image': '📜'}, // وثيقة للدلالة على "سياسة"
  {'word': 'political', 'translation': 'سياسي', 'image': '🏛️'}, // مبنى حكومي للدلالة على "سياسي"
  {'word': 'purchase', 'translation': 'شراء', 'image': '🛒'}, // عربة تسوق للدلالة على "شراء"
  {'word': 'series', 'translation': 'سلسلة', 'image': '📚'}, // مجموعة كتب للدلالة على "سلسلة"

// المجموعة الخامسة
  {'word': 'the', 'translation': 'ال', 'image': '📜'}, // وثيقة للدلالة على "ال"
  {'word': 'of', 'translation': 'من', 'image': '➡️'}, // سهم للدلالة على "من"
  {'word': 'and', 'translation': 'و', 'image': '➕'}, // علامة زائد للدلالة على "و"
  {'word': 'to', 'translation': 'إلى', 'image': '➡️'}, // سهم للدلالة على "إلى"
  {'word': 'a', 'translation': 'أ', 'image': '🔠'}, // رمز الحروف للدلالة على "أ"

// المجموعة السادسة
  {'word': 'in', 'translation': 'في', 'image': '🏠'}, // منزل للدلالة على "في"
  {'word': 'is', 'translation': 'هو', 'image': '✔️'}, // علامة تحقق للدلالة على "هو"
  {'word': 'you', 'translation': 'أنت', 'image': '🫵'}, // إشارة للدلالة على "أنت"
  {'word': 'are', 'translation': 'تكون', 'image': '✔️'}, // علامة تحقق للدلالة على "تكون"
  {'word': 'for', 'translation': 'لـ', 'image': '➡️'}, // سهم للدلالة على "لـ"

// المجموعة السابعة
  {'word': 'that', 'translation': 'أن', 'image': '💬'}, // فقاعة حوار للدلالة على "أن"
  {'word': 'or', 'translation': 'أو', 'image': '➖'}, // علامة سالب للدلالة على "أو"
  {'word': 'it', 'translation': 'هو', 'image': '🔄'}, // رمز إعادة التدوير للدلالة على "هو"
  {'word': 'as', 'translation': 'مثل', 'image': '💡'}, // مصباح للدلالة على "مثل"
  {'word': 'be', 'translation': 'يكون', 'image': '🚶‍♂️'}, // شخص يمشي للدلالة على "يكون"

// المجموعة الثامنة
  {'word': 'on', 'translation': 'على', 'image': '🟩'}, // مربع للدلالة على "على"
  {'word': 'your', 'translation': 'لك', 'image': '🫵'}, // إشارة للدلالة على "لك"
  {'word': 'with', 'translation': 'مع', 'image': '🤝'}, // مصافحة للدلالة على "مع"
  {'word': 'can', 'translation': 'يستطيع', 'image': '🛠️'}, // أدوات للدلالة على "يستطيع"
  {'word': 'have', 'translation': 'لديك', 'image': '🛍️'}, // حقيبة تسوق للدلالة على "لديك"

// المجموعة التاسعة
  {'word': 'this', 'translation': 'هذا', 'image': '👆'}, // إشارة للدلالة على "هذا"
  {'word': 'an', 'translation': 'أ', 'image': '🔡'}, // رمز الحروف للدلالة على "أ"
  {'word': 'by', 'translation': 'بواسطة', 'image': '📦'}, // صندوق للدلالة على "بواسطة"
  {'word': 'not', 'translation': 'ليس', 'image': '❌'}, // علامة إكس للدلالة على "ليس"
  {'word': 'but', 'translation': 'لكن', 'image': '⚖️'}, // ميزان للدلالة على "لكن"

// المجموعة العاشرة
  {'word': 'at', 'translation': 'في', 'image': '📍'}, // دبوس موقع للدلالة على "في"
  {'word': 'from', 'translation': 'من', 'image': '↗️'}, // سهم للدلالة على "من"
  {'word': 'I', 'translation': 'أنا', 'image': '🙋'}, // شخص يرفع يده للدلالة على "أنا"
  {'word': 'they', 'translation': 'هم', 'image': '👥'}, // أشخاص للدلالة على "هم"
  {'word': 'more', 'translation': 'أكثر', 'image': '➕'}, // زائد للدلالة على "أكثر"

// المجموعة الحادية عشرة
  {'word': 'will', 'translation': 'سوف', 'image': '🗓️'}, // تقويم للدلالة على "سوف"
  {'word': 'if', 'translation': 'إذا', 'image': '❓'}, // علامة استفهام للدلالة على "إذا"
  {'word': 'some', 'translation': 'بعض', 'image': '🧮'}, // عداد للدلالة على "بعض"
  {'word': 'there', 'translation': 'هناك', 'image': '📍'}, // دبوس موقع للدلالة على "هناك"
  {'word': 'what', 'translation': 'ماذا', 'image': '❔'}, // علامة استفهام للدلالة على "ماذا"

// المجموعة الثانية عشرة
  {'word': 'about', 'translation': 'حول', 'image': '🔄'}, // سهم دائري للدلالة على "حول"
  {'word': 'which', 'translation': 'التي', 'image': '🖐️'}, // يد للدلالة على "التي"
  {'word': 'when', 'translation': 'متى', 'image': '⏰'}, // ساعة للدلالة على "متى"
  {'word': 'one', 'translation': 'واحد', 'image': '1️⃣'}, // الرقم 1 للدلالة على "واحد"
  {'word': 'their', 'translation': 'لهم', 'image': '👤'}, // شخص للدلالة على "لهم"

// المجموعة الثالثة عشرة
  {'word': 'all', 'translation': 'الكل', 'image': '🌐'}, // كرة أرضية للدلالة على "الكل"
  {'word': 'also', 'translation': 'أيضاً', 'image': '➕'}, // زائد للدلالة على "أيضاً"
  {'word': 'how', 'translation': 'كيف', 'image': '❓'}, // علامة استفهام للدلالة على "كيف"
  {'word': 'many', 'translation': 'كثير', 'image': '🔢'}, // رمز أرقام للدلالة على "كثير"
  {'word': 'do', 'translation': 'افعل', 'image': '✅'}, // علامة صح للدلالة على "افعل"

// المجموعة الرابعة عشرة
  {'word': 'has', 'translation': 'لديه', 'image': '🛠️'}, // أدوات للدلالة على "لديه"
  {'word': 'most', 'translation': 'معظم', 'image': '📊'}, // رسم بياني للدلالة على "معظم"
  {'word': 'people', 'translation': 'الناس', 'image': '👥'}, // أشخاص للدلالة على "الناس"
  {'word': 'other', 'translation': 'آخر', 'image': '➡️'}, // سهم للدلالة على "آخر"
  {'word': 'time', 'translation': 'وقت', 'image': '⏳'}, // ساعة رملية للدلالة على "وقت"
// المجموعة الخامسة عشرة
  {'word': 'so', 'translation': 'لذلك', 'image': '↘️'}, // سهم للدلالة على "لذلك"
  {'word': 'was', 'translation': 'كان', 'image': '🕒'}, // ساعة للدلالة على "كان"
  {'word': 'we', 'translation': 'نحن', 'image': '👥'}, // أشخاص للدلالة على "نحن"
  {'word': 'these', 'translation': 'هؤلاء', 'image': '👆'}, // إشارة للدلالة على "هؤلاء"
  {'word': 'may', 'translation': 'قد', 'image': '❓'}, // علامة استفهام للدلالة على "قد"

// المجموعة السادسة عشرة
  {'word': 'like', 'translation': 'مثل', 'image': '👍'}, // علامة إعجاب للدلالة على "مثل"
  {'word': 'use', 'translation': 'يستخدم', 'image': '🛠️'}, // أدوات للدلالة على "يستخدم"
  {'word': 'into', 'translation': 'إلى', 'image': '➡️'}, // سهم للدلالة على "إلى"
  {'word': 'than', 'translation': 'من', 'image': '⚖️'}, // ميزان للدلالة على "من"
  {'word': 'up', 'translation': 'أعلى', 'image': '⬆️'}, // سهم للأعلى للدلالة على "أعلى"

// المجموعة السابعة عشرة
  {'word': 'out', 'translation': 'خارج', 'image': '🚪'}, // باب للدلالة على "خارج"
  {'word': 'who', 'translation': 'من', 'image': '❓'}, // علامة استفهام للدلالة على "من"
  {'word': 'them', 'translation': 'هم', 'image': '👥'}, // أشخاص للدلالة على "هم"
  {'word': 'make', 'translation': 'يصنع', 'image': '🏗️'}, // رافعة للدلالة على "يصنع"
  {'word': 'because', 'translation': 'لأن', 'image': '💡'}, // مصباح للدلالة على "لأن"

// المجموعة الثامنة عشرة
  {'word': 'such', 'translation': 'مثل', 'image': '📋'}, // قائمة للدلالة على "مثل"
  {'word': 'through', 'translation': 'عبر', 'image': '➡️'}, // سهم للدلالة على "عبر"
  {'word': 'get', 'translation': 'يحصل على', 'image': '📥'}, // صندوق للدلالة على "يحصل على"
  {'word': 'work', 'translation': 'عمل', 'image': '🏢'}, // مبنى للدلالة على "عمل"
  {'word': 'even', 'translation': 'حتى', 'image': '↔️'}, // سهم مزدوج للدلالة على "حتى"

// المجموعة التاسعة عشرة
  {'word': 'different', 'translation': 'مختلف', 'image': '🔀'}, // رمز للدلالة على "مختلف"
  {'word': 'its', 'translation': 'له', 'image': '📄'}, // وثيقة للدلالة على "له"
  {'word': 'no', 'translation': 'لا', 'image': '❌'}, // علامة إكس للدلالة على "لا"
  {'word': 'our', 'translation': 'لنا', 'image': '👥'}, // أشخاص للدلالة على "لنا"
  {'word': 'new', 'translation': 'جديد', 'image': '🆕'}, // رمز جديد للدلالة على "جديد"

// المجموعة العشرون
  {'word': 'film', 'translation': 'فيلم', 'image': '🎬'}, // كلاكيت للدلالة على "فيلم"
  {'word': 'just', 'translation': 'فقط', 'image': '🕒'}, // ساعة للدلالة على "فقط"
  {'word': 'only', 'translation': 'فقط', 'image': '🟢'}, // دائرة خضراء للدلالة على "فقط"
  {'word': 'see', 'translation': 'يرى', 'image': '👀'}, // عين للدلالة على "يرى"
  {'word': 'used', 'translation': 'مستخدم', 'image': '🔄'}, // سهم إعادة تدوير للدلالة على "مستخدم"

// المجموعة الحادية والعشرون
  {'word': 'good', 'translation': 'جيد', 'image': '👍'}, // إشارة إعجاب للدلالة على "جيد"
  {'word': 'water', 'translation': 'ماء', 'image': '💧'}, // قطرة ماء للدلالة على "ماء"
  {'word': 'been', 'translation': 'كان', 'image': '🕒'}, // ساعة للدلالة على "كان"
  {'word': 'need', 'translation': 'يحتاج', 'image': '🛠️'}, // أدوات للدلالة على "يحتاج"
  {'word': 'should', 'translation': 'ينبغي', 'image': '✅'}, // علامة صح للدلالة على "ينبغي"

// المجموعة الثانية والعشرون
  {'word': 'very', 'translation': 'جداً', 'image': '💯'}, // مئة للدلالة على "جداً"
  {'word': 'any', 'translation': 'أي', 'image': '🔄'}, // سهم إعادة تدوير للدلالة على "أي"
  {'word': 'history', 'translation': 'تاريخ', 'image': '📜'}, // وثيقة للدلالة على "تاريخ"
  {'word': 'often', 'translation': 'غالباً', 'image': '🔄'}, // سهم دائري للدلالة على "غالباً"
  {'word': 'way', 'translation': 'طريق', 'image': '🛣️'}, // طريق للدلالة على "طريق"

// المجموعة الثالثة والعشرون
  {'word': 'well', 'translation': 'حسناً', 'image': '👍'}, // إشارة إعجاب للدلالة على "حسناً"
  {'word': 'art', 'translation': 'فن', 'image': '🎨'}, // لوحة فنية للدلالة على "فن"
  {'word': 'know', 'translation': 'يعرف', 'image': '📘'}, // كتاب للدلالة على "يعرف"
  {'word': 'were', 'translation': 'كانوا', 'image': '🕒'}, // ساعة للدلالة على "كانوا"
  {'word': 'then', 'translation': 'ثم', 'image': '➡️'}, // سهم للدلالة على "ثم"

// المجموعة الرابعة والعشرون
  {'word': 'my', 'translation': 'لي', 'image': '🙋'}, // شخص يرفع يده للدلالة على "لي"
  {'word': 'first', 'translation': 'أول', 'image': '1️⃣'}, // الرقم 1 للدلالة على "أول"
  {'word': 'would', 'translation': 'سوف', 'image': '📅'}, // تقويم للدلالة على "سوف"
  {'word': 'money', 'translation': 'مال', 'image': '💰'}, // كيس نقود للدلالة على "مال"
  {'word': 'each', 'translation': 'كل', 'image': '🔢'}, // أرقام للدلالة على "كل"

// المجموعة الخامسة والعشرون
  {'word': 'over', 'translation': 'على', 'image': '⬆️'}, // سهم للأعلى للدلالة على "على"
  {'word': 'world', 'translation': 'العالم', 'image': '🌍'}, // الكرة الأرضية للدلالة على "العالم"
  {'word': 'information', 'translation': 'معلومات', 'image': 'ℹ️'}, // رمز المعلومات للدلالة على "معلومات"
  {'word': 'map', 'translation': 'خريطة', 'image': '🗺️'}, // خريطة للدلالة على "خريطة"
  {'word': 'find', 'translation': 'جد', 'image': '🔍'}, // عدسة مكبرة للدلالة على "جد"

// المجموعة السادسة والعشرون
  {'word': 'where', 'translation': 'أين', 'image': '📍'}, // دبوس موقع للدلالة على "أين"
  {'word': 'much', 'translation': 'كثير', 'image': '🔢'}, // أرقام للدلالة على "كثير"
  {'word': 'take', 'translation': 'خذ', 'image': '🤲'}, // يدين للدلالة على "خذ"
  {'word': 'two', 'translation': 'اثنان', 'image': '2️⃣'}, // الرقم 2 للدلالة على "اثنان"
  {'word': 'want', 'translation': 'تريد', 'image': '❤️'}, // قلب للدلالة على "تريد"

// المجموعة السابعة والعشرون
  {'word': 'important', 'translation': 'مهم', 'image': '‼️'}, // علامة تعجب للدلالة على "مهم"
  {'word': 'family', 'translation': 'أسرة', 'image': '👨‍👩‍👧‍👦'}, // عائلة للدلالة على "أسرة"
  {'word': 'those', 'translation': 'أولئك', 'image': '👥'}, // أشخاص للدلالة على "أولئك"
  {'word': 'example', 'translation': 'مثال', 'image': '📋'}, // قائمة للدلالة على "مثال"
  {'word': 'while', 'translation': 'بينما', 'image': '⏳'}, // ساعة رملية للدلالة على "بينما"

// المجموعة الثامنة والعشرون
  {'word': 'he', 'translation': 'هو', 'image': '👤'}, // شخص للدلالة على "هو"
  {'word': 'look', 'translation': 'ينظر', 'image': '👀'}, // عين للدلالة على "ينظر"
  {'word': 'government', 'translation': 'حكومة', 'image': '🏛️'}, // مبنى حكومي للدلالة على "حكومة"
  {'word': 'before', 'translation': 'قبل', 'image': '⏮️'}, // سهم رجوع للدلالة على "قبل"
  {'word': 'help', 'translation': 'مساعدة', 'image': '🤝'}, // مصافحة للدلالة على "مساعدة"
// المجموعة التاسعة والعشرون
  {'word': 'between', 'translation': 'بين', 'image': '↔️'}, // سهم مزدوج للدلالة على "بين"
  {'word': 'go', 'translation': 'اذهب', 'image': '➡️'}, // سهم يمين للدلالة على "اذهب"
  {'word': 'own', 'translation': 'خاص', 'image': '🛡️'}, // درع للدلالة على "خاص"
  {'word': 'however', 'translation': 'ومع ذلك', 'image': '⚖️'}, // ميزان للدلالة على "ومع ذلك"
  {'word': 'business', 'translation': 'عمل', 'image': '💼'}, // حقيبة للدلالة على "عمل"

// المجموعة الثلاثون
  {'word': 'us', 'translation': 'لنا', 'image': '👥'}, // أشخاص للدلالة على "لنا"
  {'word': 'great', 'translation': 'عظيم', 'image': '🌟'}, // نجمة للدلالة على "عظيم"
  {'word': 'his', 'translation': 'له', 'image': '👤'}, // شخص للدلالة على "له"
  {'word': 'being', 'translation': 'يجري', 'image': '🔄'}, // رمز إعادة التدوير للدلالة على "يجري"
  {'word': 'another', 'translation': 'آخر', 'image': '➡️'}, // سهم للدلالة على "آخر"

// المجموعة الحادية والثلاثون
  {'word': 'health', 'translation': 'صحة', 'image': '❤️'}, // قلب للدلالة على "صحة"
  {'word': 'same', 'translation': 'نفس', 'image': '🔁'}, // رمز التكرار للدلالة على "نفس"
  {'word': 'study', 'translation': 'دراسة', 'image': '📚'}, // كتب للدلالة على "دراسة"
  {'word': 'why', 'translation': 'لماذا', 'image': '❓'}, // علامة استفهام للدلالة على "لماذا"
  {'word': 'few', 'translation': 'قليل', 'image': '🔢'}, // رمز الأرقام للدلالة على "قليل"

// المجموعة الثانية والثلاثون
  {'word': 'game', 'translation': 'لعبة', 'image': '🎮'}, // عصا تحكم للدلالة على "لعبة"
  {'word': 'might', 'translation': 'ربما', 'image': '❓'}, // علامة استفهام للدلالة على "ربما"
  {'word': 'think', 'translation': 'يفكر', 'image': '💭'}, // سحابة تفكير للدلالة على "يفكر"
  {'word': 'free', 'translation': 'حر', 'image': '🕊️'}, // حمامة للدلالة على "حر"
  {'word': 'too', 'translation': 'جداً', 'image': '💯'}, // مئة للدلالة على "جداً"

// المجموعة الثالثة والثلاثون
  {'word': 'had', 'translation': 'كان', 'image': '🕒'}, // ساعة للدلالة على "كان"
  {'word': 'hi', 'translation': 'مرحبا', 'image': '👋'}, // يد ملوحة للدلالة على "مرحبا"
  {'word': 'right', 'translation': 'حق', 'image': '✔️'}, // علامة تحقق للدلالة على "حق"
  {'word': 'still', 'translation': 'ما زال', 'image': '⏳'}, // ساعة رملية للدلالة على "ما زال"
  {'word': 'system', 'translation': 'نظام', 'image': '💻'}, // حاسوب للدلالة على "نظام"

// المجموعة الرابعة والثلاثون
  {'word': 'after', 'translation': 'بعد', 'image': '➡️'}, // سهم يمين للدلالة على "بعد"
  {'word': 'computer', 'translation': 'حاسوب', 'image': '💻'}, // حاسوب للدلالة على "حاسوب"
  {'word': 'best', 'translation': 'الأفضل', 'image': '🏆'}, // كأس للدلالة على "الأفضل"
  {'word': 'must', 'translation': 'يجب', 'image': '✅'}, // علامة تحقق للدلالة على "يجب"
  {'word': 'her', 'translation': 'لها', 'image': '👧'}, // فتاة للدلالة على "لها"

// المجموعة الخامسة والثلاثون
  {'word': 'life', 'translation': 'حياة', 'image': '🌱'}, // نبتة للدلالة على "حياة"
  {'word': 'since', 'translation': 'منذ', 'image': '📅'}, // تقويم للدلالة على "منذ"
  {'word': 'could', 'translation': 'استطاع', 'image': '💪'}, // عضلة للدلالة على "استطاع"
  {'word': 'does', 'translation': 'يفعل', 'image': '⚙️'}, // ترس للدلالة على "يفعل"
  {'word': 'now', 'translation': 'الآن', 'image': '⏰'}, // ساعة للدلالة على "الآن"

// المجموعة السادسة والثلاثون
  {'word': 'during', 'translation': 'أثناء', 'image': '⏳'}, // ساعة رملية للدلالة على "أثناء"
  {'word': 'learn', 'translation': 'تعلم', 'image': '📘'}, // كتاب للدلالة على "تعلم"
  {'word': 'around', 'translation': 'حول', 'image': '🔄'}, // سهم دائري للدلالة على "حول"
  {'word': 'usually', 'translation': 'عادة', 'image': '🕒'}, // ساعة للدلالة على "عادة"
  {'word': 'form', 'translation': 'شكل', 'image': '📐'}, // مسطرة للدلالة على "شكل"

// المجموعة السابعة والثلاثون
  {'word': 'meat', 'translation': 'لحم', 'image': '🍖'}, // قطعة لحم للدلالة على "لحم"
  {'word': 'air', 'translation': 'هواء', 'image': '🌬️'}, // رياح للدلالة على "هواء"
  {'word': 'day', 'translation': 'يوم', 'image': '🌞'}, // شمس للدلالة على "يوم"
  {'word': 'place', 'translation': 'مكان', 'image': '📍'}, // دبوس موقع للدلالة على "مكان"
  {'word': 'become', 'translation': 'يصبح', 'image': '🔄'}, // سهم متحرك للدلالة على "يصبح"

// المجموعة الثامنة والثلاثون
  {'word': 'number', 'translation': 'رقم', 'image': '🔢'}, // أرقام للدلالة على "رقم"
  {'word': 'public', 'translation': 'عام', 'image': '🏢'}, // مبنى للدلالة على "عام"
  {'word': 'read', 'translation': 'قرأ', 'image': '📖'}, // كتاب مفتوح للدلالة على "قرأ"
  {'word': 'keep', 'translation': 'احتفظ', 'image': '📦'}, // صندوق للدلالة على "احتفظ"
  {'word': 'part', 'translation': 'جزء', 'image': '🔩'}, // قطعة معدنية للدلالة على "جزء"

// المجموعة التاسعة والثلاثون
  {'word': 'start', 'translation': 'بداية', 'image': '🚦'}, // إشارة مرور للدلالة على "بداية"
  {'word': 'year', 'translation': 'عام', 'image': '📅'}, // تقويم للدلالة على "عام"
  {'word': 'every', 'translation': 'كل', 'image': '🔄'}, // سهم دائري للدلالة على "كل"
  {'word': 'field', 'translation': 'حقل', 'image': '🌾'}, // حقل للدلالة على "حقل"
  {'word': 'large', 'translation': 'كبير', 'image': '🔲'}, // مربع كبير للدلالة على "كبير"

// المجموعة الأربعون
  {'word': 'once', 'translation': 'مرة واحدة', 'image': '1️⃣'}, // الرقم 1 للدلالة على "مرة واحدة"
  {'word': 'available', 'translation': 'متاح', 'image': '🟢'}, // دائرة خضراء للدلالة على "متاح"
  {'word': 'down', 'translation': 'أسفل', 'image': '⬇️'}, // سهم للأسفل للدلالة على "أسفل"
  {'word': 'give', 'translation': 'يعطي', 'image': '🤲'}, // يدين للدلالة على "يعطي"
  {'word': 'fish', 'translation': 'سمك', 'image': '🐟'}, // سمكة للدلالة على "سمك"
// المجموعة الحادية والأربعون
  {'word': 'human', 'translation': 'بشري', 'image': '🧑'}, // شخص للدلالة على "بشري"
  {'word': 'both', 'translation': 'كلا', 'image': '🤝'}, // مصافحة للدلالة على "كلا"
  {'word': 'local', 'translation': 'محلي', 'image': '🏘️'}, // مباني للدلالة على "محلي"
  {'word': 'sure', 'translation': 'بالتأكيد', 'image': '✔️'}, // علامة تحقق للدلالة على "بالتأكيد"
  {'word': 'something', 'translation': 'شيء ما', 'image': '❓'}, // علامة استفهام للدلالة على "شيء ما"

// المجموعة الثانية والأربعون
  {'word': 'without', 'translation': 'بدون', 'image': '🚫'}, // علامة ممنوع للدلالة على "بدون"
  {'word': 'come', 'translation': 'يأتي', 'image': '👣'}, // آثار أقدام للدلالة على "يأتي"
  {'word': 'me', 'translation': 'أنا', 'image': '🙋'}, // شخص للدلالة على "أنا"
  {'word': 'back', 'translation': 'خلف', 'image': '🔙'}, // سهم رجوع للدلالة على "خلف"
  {'word': 'better', 'translation': 'أفضل', 'image': '👍'}, // علامة إعجاب للدلالة على "أفضل"

// المجموعة الثالثة والأربعون
  {'word': 'general', 'translation': 'عام', 'image': '🏢'}, // مبنى للدلالة على "عام"
  {'word': 'process', 'translation': 'معالجة', 'image': '⚙️'}, // ترس للدلالة على "معالجة"
  {'word': 'she', 'translation': 'هي', 'image': '👧'}, // فتاة للدلالة على "هي"
  {'word': 'heat', 'translation': 'حرارة', 'image': '🔥'}, // نار للدلالة على "حرارة"
  {'word': 'thanks', 'translation': 'شكراً', 'image': '🙏'}, // يدان متشابكتان للدلالة على "شكراً"

// المجموعة الرابعة والأربعون
  {'word': 'specific', 'translation': 'محدد', 'image': '🎯'}, // هدف للدلالة على "محدد"
  {'word': 'enough', 'translation': 'كافٍ', 'image': '👌'}, // إشارة موافقة للدلالة على "كافٍ"
  {'word': 'long', 'translation': 'طويل', 'image': '📏'}, // مسطرة للدلالة على "طويل"
  {'word': 'lot', 'translation': 'قطعة أرض', 'image': '🏞️'}, // حقل للدلالة على "قطعة أرض"
  {'word': 'hand', 'translation': 'يد', 'image': '✋'}, // يد للدلالة على "يد"

// المجموعة الخامسة والأربعون
  {'word': 'data', 'translation': 'بيانات', 'image': '💾'}, // قرص مرن للدلالة على "بيانات"
  {'word': 'feel', 'translation': 'يشعر', 'image': '❤️'}, // قلب للدلالة على "يشعر"
  {'word': 'high', 'translation': 'مرتفع', 'image': '⬆️'}, // سهم للأعلى للدلالة على "مرتفع"
  {'word': 'off', 'translation': 'إيقاف', 'image': '⏹️'}, // زر إيقاف للدلالة على "إيقاف"
  {'word': 'point', 'translation': 'نقطة', 'image': '📍'}, // دبوس موقع للدلالة على "نقطة"

// المجموعة السادسة والأربعون
  {'word': 'type', 'translation': 'نوع', 'image': '🔠'}, // حروف للدلالة على "نوع"
  {'word': 'whether', 'translation': 'سواء', 'image': '❓'}, // علامة استفهام للدلالة على "سواء"
  {'word': 'food', 'translation': 'طعام', 'image': '🍲'}, // طبق طعام للدلالة على "طعام"
  {'word': 'understanding', 'translation': 'فهم', 'image': '🧠'}, // دماغ للدلالة على "فهم"
  {'word': 'here', 'translation': 'هنا', 'image': '📍'}, // دبوس موقع للدلالة على "هنا"

// المجموعة السابعة والأربعون
  {'word': 'home', 'translation': 'الصفحة الرئيسية', 'image': '🏠'}, // منزل للدلالة على "الصفحة الرئيسية"
  {'word': 'certain', 'translation': 'مؤكد', 'image': '✔️'}, // علامة تحقق للدلالة على "مؤكد"
  {'word': 'economy', 'translation': 'اقتصاد', 'image': '💹'}, // رسم بياني للدلالة على "اقتصاد"
  {'word': 'little', 'translation': 'قليل', 'image': '🔹'}, // نقطة صغيرة للدلالة على "قليل"
  {'word': 'theory', 'translation': 'نظرية', 'image': '📖'}, // كتاب للدلالة على "نظرية"

// المجموعة الثامنة والأربعون
  {'word': 'tonight', 'translation': 'هذه الليلة', 'image': '🌙'}, // قمر للدلالة على "هذه الليلة"
  {'word': 'law', 'translation': 'قانون', 'image': '⚖️'}, // ميزان للدلالة على "قانون"
  {'word': 'put', 'translation': 'وضع', 'image': '📦'}, // صندوق للدلالة على "وضع"
  {'word': 'under', 'translation': 'تحت', 'image': '⬇️'}, // سهم للأسفل للدلالة على "تحت"
  {'word': 'value', 'translation': 'قيمة', 'image': '💰'}, // كيس نقود للدلالة على "قيمة"

// المجموعة التاسعة والأربعون
  {'word': 'always', 'translation': 'دائماً', 'image': '🔁'}, // سهم إعادة تكرار للدلالة على "دائماً"
  {'word': 'body', 'translation': 'جسم', 'image': '👤'}, // شخص للدلالة على "جسم"
  {'word': 'common', 'translation': 'شائع', 'image': '🌍'}, // كرة أرضية للدلالة على "شائع"
  {'word': 'market', 'translation': 'سوق', 'image': '🏪'}, // متجر للدلالة على "سوق"
  {'word': 'set', 'translation': 'جلس', 'image': '🪑'}, // كرسي للدلالة على "جلس"

// المجموعة الخمسون
  {'word': 'bird', 'translation': 'طائر', 'image': '🐦'}, // طائر للدلالة على "طائر"
  {'word': 'guide', 'translation': 'مرشد', 'image': '🧭'}, // بوصلة للدلالة على "مرشد"
  {'word': 'provide', 'translation': 'تزود', 'image': '📦'}, // صندوق للدلالة على "تزود"
  {'word': 'change', 'translation': 'تغيير', 'image': '🔄'}, // سهم دائري للدلالة على "تغيير"
  {'word': 'interest', 'translation': 'فائدة', 'image': '💰'}, // كيس نقود للدلالة على "فائدة"
// المجموعة الحادية والخمسون
  {'word': 'literature', 'translation': 'أدب', 'image': '📚'}, // كتب للدلالة على "أدب"
  {'word': 'sometimes', 'translation': 'أحياناً', 'image': '🔄'}, // سهم دائري للدلالة على "أحياناً"
  {'word': 'problem', 'translation': 'مشكلة', 'image': '⚠️'}, // علامة تحذير للدلالة على "مشكلة"
  {'word': 'say', 'translation': 'يقول', 'image': '💬'}, // فقاعة حوار للدلالة على "يقول"
  {'word': 'next', 'translation': 'التالي', 'image': '➡️'}, // سهم للدلالة على "التالي"

// المجموعة الثانية والخمسون
  {'word': 'create', 'translation': 'ينشئ', 'image': '🛠️'}, // أدوات للدلالة على "ينشئ"
  {'word': 'simple', 'translation': 'بسيط', 'image': '👌'}, // إشارة موافقة للدلالة على "بسيط"
  {'word': 'software', 'translation': 'برمجيات', 'image': '💻'}, // حاسوب للدلالة على "برمجيات"
  {'word': 'state', 'translation': 'حالة', 'image': '🏛️'}, // مبنى حكومي للدلالة على "حالة"
  {'word': 'together', 'translation': 'سوياً', 'image': '🤝'}, // مصافحة للدلالة على "سوياً"

// المجموعة الثالثة والخمسون
  {'word': 'control', 'translation': 'مراقبة', 'image': '🎮'}, // جهاز تحكم للدلالة على "مراقبة"
  {'word': 'knowledge', 'translation': 'معرفة', 'image': '📖'}, // كتاب مفتوح للدلالة على "معرفة"
  {'word': 'power', 'translation': 'قوة', 'image': '💪'}, // عضلة للدلالة على "قوة"
  {'word': 'radio', 'translation': 'راديو', 'image': '📻'}, // راديو للدلالة على "راديو"
  {'word': 'ability', 'translation': 'قدرة', 'image': '⚙️'}, // ترس للدلالة على "قدرة"

// المجموعة الرابعة والخمسون
  {'word': 'basic', 'translation': 'أساسي', 'image': '🧱'}, // طوبة للدلالة على "أساسي"
  {'word': 'course', 'translation': 'دورة', 'image': '🎓'}, // قبعة تخرج للدلالة على "دورة"
  {'word': 'economics', 'translation': 'اقتصاديات', 'image': '📊'}, // رسم بياني للدلالة على "اقتصاديات"
  {'word': 'hard', 'translation': 'صعب', 'image': '💪'}, // عضلة للدلالة على "صعب"
  {'word': 'add', 'translation': 'إضافة', 'image': '➕'}, // زائد للدلالة على "إضافة"

// المجموعة الخامسة والخمسون
  {'word': 'company', 'translation': 'شركة', 'image': '🏢'}, // مبنى للدلالة على "شركة"
  {'word': 'known', 'translation': 'معروف', 'image': '🌟'}, // نجمة للدلالة على "معروف"
  {'word': 'love', 'translation': 'حب', 'image': '❤️'}, // قلب للدلالة على "حب"
  {'word': 'past', 'translation': 'الماضي', 'image': '🕒'}, // ساعة للدلالة على "الماضي"
  {'word': 'price', 'translation': 'سعر', 'image': '💰'}, // كيس نقود للدلالة على "سعر"

// المجموعة السادسة والخمسون
  {'word': 'size', 'translation': 'حجم', 'image': '📏'}, // مسطرة للدلالة على "حجم"
  {'word': 'away', 'translation': 'بعيد', 'image': '➡️'}, // سهم للدلالة على "بعيد"
  {'word': 'big', 'translation': 'كبير', 'image': '🔲'}, // مربع كبير للدلالة على "كبير"
  {'word': 'internet', 'translation': 'إنترنت', 'image': '🌐'}, // كرة أرضية للدلالة على "إنترنت"
  {'word': 'possible', 'translation': 'ممكن', 'image': '👌'}, // إشارة موافقة للدلالة على "ممكن"

// المجموعة السابعة والخمسون
  {'word': 'television', 'translation': 'تلفزيون', 'image': '📺'}, // تلفاز للدلالة على "تلفزيون"
  {'word': 'three', 'translation': 'ثلاثة', 'image': '3️⃣'}, // الرقم 3 للدلالة على "ثلاثة"
  {'word': 'understand', 'translation': 'يفهم', 'image': '🧠'}, // دماغ للدلالة على "يفهم"
  {'word': 'various', 'translation': 'متنوع', 'image': '🔀'}, // رمز التنويع للدلالة على "متنوع"
  {'word': 'yourself', 'translation': 'نفسك', 'image': '🧍'}, // شخص للدلالة على "نفسك"

// المجموعة الثامنة والخمسون
  {'word': 'card', 'translation': 'بطاقة', 'image': '💳'}, // بطاقة للدلالة على "بطاقة"
  {'word': 'difficult', 'translation': 'صعب', 'image': '💪'}, // عضلة للدلالة على "صعب"
  {'word': 'including', 'translation': 'بما في ذلك', 'image': '➕'}, // زائد للدلالة على "بما في ذلك"
  {'word': 'list', 'translation': 'قائمة', 'image': '📋'}, // قائمة للدلالة على "قائمة"
  {'word': 'mind', 'translation': 'عقل', 'image': '🧠'}, // دماغ للدلالة على "عقل"

// المجموعة التاسعة والخمسون
  {'word': 'particular', 'translation': 'خاص', 'image': '🎯'}, // هدف للدلالة على "خاص"
  {'word': 'real', 'translation': 'حقيقي', 'image': '💡'}, // مصباح للدلالة على "حقيقي"
  {'word': 'science', 'translation': 'علم', 'image': '🔬'}, // مجهر للدلالة على "علم"
  {'word': 'trade', 'translation': 'تجارة', 'image': '💼'}, // حقيبة للدلالة على "تجارة"
  {'word': 'consider', 'translation': 'يعتبر', 'image': '🤔'}, // وجه يفكر للدلالة على "يعتبر"

// المجموعة الستون
  {'word': 'either', 'translation': 'إما', 'image': '🔄'}, // سهم دائري للدلالة على "إما"
  {'word': 'library', 'translation': 'مكتبة', 'image': '📚'}, // كتب للدلالة على "مكتبة"
  {'word': 'likely', 'translation': 'من المحتمل', 'image': '❓'}, // علامة استفهام للدلالة على "من المحتمل"
  {'word': 'nature', 'translation': 'طبيعة', 'image': '🌳'}, // شجرة للدلالة على "طبيعة"
  {'word': 'fact', 'translation': 'حقيقة', 'image': '✔️'}, // علامة تحقق للدلالة على "حقيقة"

// المجموعة الحادية والستون
  {'word': 'line', 'translation': 'خط', 'image': '📏'}, // مسطرة للدلالة على "خط"
  {'word': 'product', 'translation': 'منتج', 'image': '📦'}, // صندوق للدلالة على "منتج"
  {'word': 'care', 'translation': 'رعاية', 'image': '🤲'}, // يدين للدلالة على "رعاية"
  {'word': 'group', 'translation': 'مجموعة', 'image': '👥'}, // أشخاص للدلالة على "مجموعة"
  {'word': 'idea', 'translation': 'فكرة', 'image': '💡'}, // مصباح للدلالة على "فكرة"
// المجموعة الثانية والستون
  {'word': 'risk', 'translation': 'خطر', 'image': '⚠️'}, // علامة تحذير للدلالة على "خطر"
  {'word': 'several', 'translation': 'عدة', 'image': '🔢'}, // أرقام للدلالة على "عدة"
  {'word': 'someone', 'translation': 'شخص ما', 'image': '🧑'}, // شخص للدلالة على "شخص ما"
  {'word': 'temperature', 'translation': 'درجة الحرارة', 'image': '🌡️'}, // مقياس حرارة للدلالة على "درجة الحرارة"
  {'word': 'united', 'translation': 'متحد', 'image': '🤝'}, // مصافحة للدلالة على "متحد"

// المجموعة الثالثة والستون
  {'word': 'word', 'translation': 'كلمة', 'image': '📝'}, // ورقة للدلالة على "كلمة"
  {'word': 'fat', 'translation': 'دهون', 'image': '🥓'}, // قطعة لحم للدلالة على "دهون"
  {'word': 'force', 'translation': 'قوة', 'image': '💪'}, // عضلة للدلالة على "قوة"
  {'word': 'key', 'translation': 'مفتاح', 'image': '🔑'}, // مفتاح للدلالة على "مفتاح"
  {'word': 'light', 'translation': 'ضوء', 'image': '💡'}, // مصباح للدلالة على "ضوء"

// المجموعة الرابعة والستون
  {'word': 'simply', 'translation': 'ببساطة', 'image': '👌'}, // إشارة موافقة للدلالة على "ببساطة"
  {'word': 'today', 'translation': 'اليوم', 'image': '📅'}, // تقويم للدلالة على "اليوم"
  {'word': 'training', 'translation': 'تدريب', 'image': '🏋️‍♂️'}, // شخص يرفع أثقال للدلالة على "تدريب"
  {'word': 'until', 'translation': 'حتى', 'image': '⏳'}, // ساعة رملية للدلالة على "حتى"
  {'word': 'major', 'translation': 'رائد', 'image': '🌟'}, // نجمة للدلالة على "رائد"

// المجموعة الخامسة والستون
  {'word': 'name', 'translation': 'اسم', 'image': '📛'}, // شارة اسم للدلالة على "اسم"
  {'word': 'personal', 'translation': 'شخصي', 'image': '👤'}, // شخص للدلالة على "شخصي"
  {'word': 'school', 'translation': 'مدرسة', 'image': '🏫'}, // مدرسة للدلالة على "مدرسة"
  {'word': 'top', 'translation': 'أعلى', 'image': '🔝'}, // سهم للأعلى للدلالة على "أعلى"
  {'word': 'current', 'translation': 'حالي', 'image': '📅'}, // تقويم للدلالة على "حالي"

// المجموعة السادسة والستون
  {'word': 'generally', 'translation': 'عموماً', 'image': '🌍'}, // الكرة الأرضية للدلالة على "عموماً"
  {'word': 'historical', 'translation': 'تاريخي', 'image': '📜'}, // وثيقة للدلالة على "تاريخي"
  {'word': 'investment', 'translation': 'استثمار', 'image': '💼'}, // حقيبة للدلالة على "استثمار"
  {'word': 'left', 'translation': 'يسار', 'image': '⬅️'}, // سهم لليسار للدلالة على "يسار"
  {'word': 'national', 'translation': 'وطني', 'image': '🏛️'}, // مبنى حكومي للدلالة على "وطني"

// المجموعة السابعة والستون
  {'word': 'amount', 'translation': 'كمية', 'image': '📦'}, // صندوق للدلالة على "كمية"
  {'word': 'level', 'translation': 'مستوى', 'image': '📊'}, // رسم بياني للدلالة على "مستوى"
  {'word': 'order', 'translation': 'طلب', 'image': '📋'}, // قائمة للدلالة على "طلب"
  {'word': 'practice', 'translation': 'ممارسة', 'image': '⚽'}, // كرة للدلالة على "ممارسة"
  {'word': 'research', 'translation': 'بحث', 'image': '🔍'}, // عدسة مكبرة للدلالة على "بحث"

// المجموعة الثامنة والستون
  {'word': 'sense', 'translation': 'إحساس', 'image': '💭'}, // فقاعة تفكير للدلالة على "إحساس"
  {'word': 'service', 'translation': 'خدمة', 'image': '🛠️'}, // أدوات للدلالة على "خدمة"
  {'word': 'area', 'translation': 'منطقة', 'image': '📍'}, // دبوس موقع للدلالة على "منطقة"
  {'word': 'cut', 'translation': 'قطع', 'image': '✂️'}, // مقص للدلالة على "قطع"
  {'word': 'hot', 'translation': 'حار', 'image': '🔥'}, // نار للدلالة على "حار"

// المجموعة التاسعة والستون
  {'word': 'instead', 'translation': 'بدلاً', 'image': '🔄'}, // سهم إعادة تدوير للدلالة على "بدلاً"
  {'word': 'least', 'translation': 'الأقل', 'image': '➖'}, // ناقص للدلالة على "الأقل"
  {'word': 'natural', 'translation': 'طبيعي', 'image': '🌳'}, // شجرة للدلالة على "طبيعي"
  {'word': 'physical', 'translation': 'بدني', 'image': '💪'}, // عضلة للدلالة على "بدني"
  {'word': 'piece', 'translation': 'قطعة', 'image': '🧩'}, // قطعة أحجية للدلالة على "قطعة"

// المجموعة السبعون
  {'word': 'show', 'translation': 'يظهر', 'image': '👁️'}, // عين للدلالة على "يظهر"
  {'word': 'society', 'translation': 'مجتمع', 'image': '🌍'}, // الكرة الأرضية للدلالة على "مجتمع"
  {'word': 'try', 'translation': 'محاولة', 'image': '⚒️'}, // مطرقة للدلالة على "محاولة"
  {'word': 'check', 'translation': 'تحقق', 'image': '✔️'}, // علامة تحقق للدلالة على "تحقق"
  {'word': 'choose', 'translation': 'اختر', 'image': '🖱️'}, // فأرة حاسوب للدلالة على "اختر"

// المجموعة الحادية والسبعون
  {'word': 'develop', 'translation': 'طور', 'image': '⚙️'}, // ترس للدلالة على "طور"
  {'word': 'second', 'translation': 'ثاني', 'image': '2️⃣'}, // الرقم 2 للدلالة على "ثاني"
  {'word': 'useful', 'translation': 'مفيد', 'image': '🔧'}, // مفتاح ربط للدلالة على "مفيد"
  {'word': 'web', 'translation': 'شبكة', 'image': '🌐'}, // الكرة الأرضية للدلالة على "شبكة"
  {'word': 'activity', 'translation': 'نشاط', 'image': '🏃‍♂️'}, // شخص يركض للدلالة على "نشاط"

// المجموعة الثانية والسبعون
  {'word': 'boss', 'translation': 'رئيس', 'image': '👔'}, // ربطة عنق للدلالة على "رئيس"
  {'word': 'short', 'translation': 'قصير', 'image': '📏'}, // مسطرة قصيرة للدلالة على "قصير"
  {'word': 'story', 'translation': 'قصة', 'image': '📖'}, // كتاب مفتوح للدلالة على "قصة"
  {'word': 'call', 'translation': 'مكالمة', 'image': '📞'}, // سماعة هاتف للدلالة على "مكالمة"
  {'word': 'industry', 'translation': 'صناعة', 'image': '🏭'}, // مصنع للدلالة على "صناعة"

// المجموعة الثالثة والسبعون
  {'word': 'last', 'translation': 'الأخير', 'image': '⏳'}, // ساعة رملية للدلالة على "الأخير"
  {'word': 'media', 'translation': 'وسائل الإعلام', 'image': '📰'}, // جريدة للدلالة على "وسائل الإعلام"
  {'word': 'mental', 'translation': 'عقلي', 'image': '🧠'}, // دماغ للدلالة على "عقلي"
  {'word': 'move', 'translation': 'تحرك', 'image': '🏃'}, // شخص يركض للدلالة على "تحرك"
  {'word': 'pay', 'translation': 'يدفع', 'image': '💳'}, // بطاقة للدلالة على "يدفع"

// المجموعة الرابعة والسبعون
  {'word': 'sport', 'translation': 'رياضة', 'image': '⚽'}, // كرة قدم للدلالة على "رياضة"
  {'word': 'thing', 'translation': 'شيء', 'image': '❓'}, // علامة استفهام للدلالة على "شيء"
  {'word': 'actually', 'translation': 'فعلياً', 'image': '✅'}, // علامة تحقق للدلالة على "فعلياً"
  {'word': 'against', 'translation': 'ضد', 'image': '🔄'}, // سهم معارض للدلالة على "ضد"
  {'word': 'far', 'translation': 'بعيد', 'image': '🌍'}, // كرة أرضية للدلالة على "بعيد"

// المجموعة الخامسة والسبعون
  {'word': 'fun', 'translation': 'مرح', 'image': '🎉'}, // زينة حفلة للدلالة على "مرح"
  {'word': 'house', 'translation': 'منزل', 'image': '🏠'}, // منزل للدلالة على "منزل"
  {'word': 'let', 'translation': 'دع', 'image': '👌'}, // إشارة موافقة للدلالة على "دع"
  {'word': 'page', 'translation': 'صفحة', 'image': '📄'}, // ورقة للدلالة على "صفحة"
  {'word': 'remember', 'translation': 'تذكر', 'image': '🧠'}, // دماغ للدلالة على "تذكر"
// المجموعة السادسة والسبعون
  {'word': 'term', 'translation': 'مصطلح', 'image': '📜'}, // وثيقة للدلالة على "مصطلح"
  {'word': 'test', 'translation': 'اختبار', 'image': '📝'}, // ورقة وقلم للدلالة على "اختبار"
  {'word': 'within', 'translation': 'داخل', 'image': '🏠'}, // منزل للدلالة على "داخل"
  {'word': 'along', 'translation': 'على طول', 'image': '➡️'}, // سهم للدلالة على "على طول"
  {'word': 'answer', 'translation': 'إجابة', 'image': '✅'}, // علامة تحقق للدلالة على "إجابة"

// المجموعة السابعة والسبعون
  {'word': 'increase', 'translation': 'زيادة', 'image': '📈'}, // سهم صاعد للدلالة على "زيادة"
  {'word': 'oven', 'translation': 'فرن', 'image': '🍞'}, // رغيف خبز للدلالة على "فرن"
  {'word': 'quite', 'translation': 'إلى حد كبير', 'image': '🔊'}, // مكبر صوت للدلالة على "إلى حد كبير"
  {'word': 'scared', 'translation': 'خائف', 'image': '😨'}, // وجه خائف للدلالة على "خائف"
  {'word': 'single', 'translation': 'غير مرتبط', 'image': '1️⃣'}, // الرقم 1 للدلالة على "غير مرتبط"

// المجموعة الثامنة والسبعون
  {'word': 'sound', 'translation': 'صوت', 'image': '🔊'}, // مكبر صوت للدلالة على "صوت"
  {'word': 'again', 'translation': 'مرة أخرى', 'image': '🔁'}, // سهم إعادة تكرار للدلالة على "مرة أخرى"
  {'word': 'community', 'translation': 'مجتمع', 'image': '🌍'}, // كرة أرضية للدلالة على "مجتمع"
  {'word': 'definition', 'translation': 'تعريف', 'image': '📖'}, // كتاب مفتوح للدلالة على "تعريف"
  {'word': 'focus', 'translation': 'تركيز', 'image': '🎯'}, // هدف للدلالة على "تركيز"

// المجموعة التاسعة والسبعون
  {'word': 'individual', 'translation': 'فرد', 'image': '🧑'}, // شخص للدلالة على "فرد"
  {'word': 'matter', 'translation': 'شيء', 'image': '⚙️'}, // ترس للدلالة على "شيء"
  {'word': 'safety', 'translation': 'سلامة', 'image': '🦺'}, // سترة أمان للدلالة على "سلامة"
  {'word': 'turn', 'translation': 'دور', 'image': '🔄'}, // سهم دوران للدلالة على "دور"
  {'word': 'everything', 'translation': 'كل شيء', 'image': '🌍'}, // كرة أرضية للدلالة على "كل شيء"

// المجموعة الثمانون
  {'word': 'kind', 'translation': 'طيب', 'image': '💖'}, // قلب للدلالة على "طيب"
  {'word': 'quality', 'translation': 'جودة', 'image': '🎖️'}, // ميدالية للدلالة على "جودة"
  {'word': 'soil', 'translation': 'تربة', 'image': '🌱'}, // نبتة للدلالة على "تربة"
  {'word': 'ask', 'translation': 'يطلب', 'image': '🙋'}, // شخص يرفع يده للدلالة على "يطلب"
  {'word': 'board', 'translation': 'مجلس', 'image': '👥'}, // مجموعة أشخاص للدلالة على "مجلس"

// المجموعة الحادية والثمانون
  {'word': 'clear', 'translation': 'واضح', 'image': '🪟'}, // نافذة للدلالة على "واضح"
  {'word': 'dry', 'translation': 'جاف', 'image': '🌵'}, // صبار للدلالة على "جاف"
  {'word': 'easy', 'translation': 'سهل', 'image': '👌'}, // إشارة موافقة للدلالة على "سهل"
  {'word': 'emotional', 'translation': 'عاطفي', 'image': '💔'}, // قلب مكسور للدلالة على "عاطفي"
  {'word': 'equipment', 'translation': 'معدات', 'image': '🛠️'}, // أدوات للدلالة على "معدات"

];


class WordsPage extends StatefulWidget {
  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final FlutterTts _flutterTts = FlutterTts();
  final Color primaryColor = Color(0xFF13194E);

  // هنا البيانات المأخوذة


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    _flutterTts.setLanguage('en-US');  // تعيين اللغة الافتراضية
  }

  @override
  void dispose() {
    _controller.dispose();
    _flutterTts.stop();  // تأكد من إيقاف الصوت عند التخلص من الـ widget
    super.dispose();
  }

  // دالة لتشغيل الصوت باستخدام Flutter TTS
  Future<void> playPronunciation(String word) async {
    try {
      await _flutterTts.speak(word);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to play audio.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // بناء البطاقة لكل كلمتين
  Widget _buildWordRow(List<String> wordPair1, List<String> wordPair2) {
    return FadeTransition(
      opacity: _animation,
      child: Row(
        children: [
          Expanded(
            child: Card(
              color: primaryColor,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            wordPair1[0],
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.volume_up, color: Colors.blue, size: 30),
                          onPressed: () {
                            playPronunciation(wordPair1[0]);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      wordPair1[1],
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              color: primaryColor,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            wordPair2[0],
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.volume_up, color: Colors.blue, size: 30),
                          onPressed: () {
                            playPronunciation(wordPair2[0]);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      wordPair2[1],
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: allWords.length,
          itemBuilder: (context, index) {
            // تأكد من أن عدد الكلمات في المجموعة مزدوج لتجنب الأخطاء
            List<List<String>> currentWords = allWords[index];
            List<Widget> wordRows = [];
            for (int i = 0; i < currentWords.length; i += 2) {
              if (i + 1 < currentWords.length) {
                wordRows.add(_buildWordRow(currentWords[i], currentWords[i + 1]));
              }
            }
            return Column(
              children: wordRows,
            );
          },
        ),
      ),
    );
  }
}



class translation26 extends StatefulWidget {
  @override
  _translation26State createState() => _translation26State();
}

class _translation26State extends State<translation26>
    with SingleTickerProviderStateMixin {
  int _currentWordIndex = 0;
  int currentPage = 0;
  int score = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E);

  @override
  void initState() {
    super.initState();
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

  List<List<String>> getWords() {
    // تسترجع قائمة الكلمات لكل صفحة
    return allWords[currentPage];
  }

  List<String> getWordOptions(String correctWord) {
    // تنشئ الخيارات وتخلطها
    List<String> options = [...getWords().map((e) => e[0])];
    options.shuffle();
    return [correctWord, options[0], options[1]]..shuffle();
  }

  void checkAnswer(bool isCorrect) {
    // تتحقق من الإجابة وتحدث النقاط والصفحة الحالية
    setState(() {
      if (isCorrect) {
        score += 10;
      } else {
        score -= 5;
      }

      if (_currentWordIndex < getWords().length - 1) {
        _currentWordIndex++;
      } else {
        _currentWordIndex = 0;
        if (currentPage < allWords.length - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }
      }
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

  @override
  Widget build(BuildContext context) {
    List<List<String>> words = getWords();
    String correctWord = words[_currentWordIndex][0];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '${AppLocale.S88.getString(context)}',
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
                '${AppLocale.S89.getString(context)}:',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                words[_currentWordIndex][1],
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              SizedBox(height: 30),
              ...getWordOptions(correctWord).map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _buildButton(option, option == correctWord),
                );
              }).toList(),
              SizedBox(height: 30),
              Text(
                '${AppLocale.S87.getString(context)}: $score',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}










class translationd26 extends StatefulWidget {
  @override
  _translationd26State createState() => _translationd26State();
}

class _translationd26State extends State<translationd26>
    with SingleTickerProviderStateMixin {
  int _currentWordIndex = 0;
  int currentPage = 0;
  int score = 0;
  int streak = 0;
  int timeElapsed = 0; // وقت اللعب بدون حدود
  List<String> sessions = []; // قائمة لحفظ الجلسات
  Timer? timer;
  late SharedPreferences prefs;

  late AnimationController _controller;
  late Animation<double> _animation;
  final Color primaryColor = Color(0xFF13194E);

  @override
  void initState() {
    super.initState();
    _initPrefs(); // تهيئة SharedPreferences
    startTimer();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  // تهيئة SharedPreferences وجلب الجلسات المحفوظة
  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      sessions = prefs.getStringList('sessions') ?? []; // جلب الجلسات أو تعيين قائمة فارغة
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeElapsed++; // زيادة الوقت بدون حدود
      });
    });
  }

  // إضافة الجلسة إلى القائمة وحفظها باستخدام SharedPreferences
  Future<void> _saveSession(int finalScore) async {
    String session = 'Score: $finalScore, Time: $timeElapsed seconds';
    sessions.add(session);
    await prefs.setStringList('sessions', sessions);
  }

  // عرض الجلسات المحفوظة في Dialog
  void showSessionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Previous Sessions'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sessions[index]),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('${AppLocale.S93.getString(context)}'),
            ),
          ],
        );
      },
    );
  }

  List<List<String>> getWords() {
    return allWords[currentPage];
  }

  List<String> getWordOptions(String correctWord) {
    List<String> options = [...getWords().map((e) => e[0])];
    options.shuffle();
    return [correctWord, options[0], options[1]]..shuffle();
  }

  // التحقق من الإجابة وتحديث النقاط
  void checkAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        score += 10;
        streak++;
        if (streak % 5 == 0) {
          score += 20;
        }
      } else {
        score -= 5;
        streak = 0;
      }

      // تحديث السؤال
      if (_currentWordIndex < getWords().length - 1) {
        _currentWordIndex++;
      } else {
        _currentWordIndex = 0;
        if (currentPage < allWords.length - 1) {
          currentPage++;
        } else {
          currentPage = 0; // إعادة التدوير
        }
      }

      // حفظ الجلسة بعد كل إجابة صحيحة أو خاطئة
      _saveSession(score);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> words = getWords();
    String correctWord = words[_currentWordIndex][0];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '${AppLocale.S88.getString(context)}', // 'لعبة اختيار الكلمة الصحيحة'
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: showSessionsDialog, // عرض الجلسات السابقة
          ),
        ],
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
                '${AppLocale.S89.getString(context)}:', // 'اختر الكلمة الصحيحة'
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                words[_currentWordIndex][1],
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                '${AppLocale.S90.getString(context)}: $timeElapsed ${AppLocale.S91.getString(context)}', // عرض الوقت المنقضي
                style: TextStyle(fontSize: 24, color: Colors.red),
              ),
              SizedBox(height: 30),
              ...getWordOptions(correctWord).map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: FadeTransition(
                    opacity: _animation,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      onPressed: () {
                        checkAnswer(option == correctWord);
                      },
                      child: Text(
                        option,
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }).toList(),
              SizedBox(height: 30),
              Text(
                '${AppLocale.S87.getString(context)}: $score', // 'النتيجة'
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel(); // إيقاف المؤقت عند الخروج من الصفحة
    _controller.dispose();
    super.dispose();
  }
}



// الصفحة الثانية: لعبة ملء الفراغات


class FillInTheBlanksPage26 extends StatefulWidget {
  @override
  _FillInTheBlanksPage26State createState() => _FillInTheBlanksPage26State();
}

class _FillInTheBlanksPage26State extends State<FillInTheBlanksPage26>
    with SingleTickerProviderStateMixin {
  int score = 0;
  int level = 1;
  int correctAnswersInLevel = 0;
  int _currentSentenceIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E);

  // قائمة الكلمات (allWords)

  @override
  void initState() {
    super.initState();
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

  // دالة لتوليد جملة عشوائية باستخدام كلمات من allWords
  Map<String, dynamic> generateRandomSentence() {
    Random random = Random();

    // اختيار كلمات عشوائية من قائمة allWords
    List<String> subject = allWords[1][random.nextInt(allWords[1].length)];
    List<String> verb = allWords[2][random.nextInt(allWords[2].length)];
    List<String> preposition = allWords[3][random.nextInt(allWords[3].length)];

    // بناء الجملة
    String sentence = '${subject[0]} _____ ${preposition[0]}.';
    String correctWord = verb[0];

    return {'sentence': sentence, 'correctWord': correctWord};
  }

  // دالة لتوليد خيارات عشوائية للكلمات
  List<String> getWordOptions(String correctWord) {
    List<String> options = [];
    for (var list in allWords) {
      options.addAll(list.map((e) => e[0]));
    }
    options.remove(correctWord); // إزالة الكلمة الصحيحة من الخيارات
    options.shuffle(); // خلط الكلمات
    return [correctWord, options[0], options[1]]..shuffle();
  }

  // دالة للتحقق من الإجابة الصحيحة
  void checkAnswer(String option, String correctWord) {
    setState(() {
      if (option == correctWord) {
        score += 10;
        correctAnswersInLevel++;
        if (correctAnswersInLevel % 5 == 0) {
          level++;
          correctAnswersInLevel = 0;
        }
      } else {
        score -= 5;
      }

      // التبديل إلى الجملة التالية
      if (_currentSentenceIndex < 10) {
        _currentSentenceIndex++;
      } else {
        showGameOverDialog();
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${AppLocale.S81.getString(context)}'),
          content: Text('${AppLocale.S98.getString(context)} $score\n${AppLocale.Ss98.getString(context)} $level'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetGame(); // إعادة تعيين اللعبة
              },
              child: Text('${AppLocale.S99.getString(context)}'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      score = 0;
      _currentSentenceIndex = 0;
      level = 1;
      correctAnswersInLevel = 0;
    });
  }

  Widget _buildButton(String option, bool isCorrect) {
    return FadeTransition(
      opacity: _animation,
      child: ElevatedButton(
        onPressed: () {
          checkAnswer(option, option == isCorrect ? option : '');
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

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentSentence = generateRandomSentence();
    String sentence = currentSentence['sentence'];
    String correctWord = currentSentence['correctWord'];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '${AppLocale.S94.getString(context)}',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: primaryColor,
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
                '${AppLocale.S95.getString(context)}',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                sentence.replaceAll('_____', '_____'),
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              SizedBox(height: 30),
              ...getWordOptions(correctWord).map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _buildButton(option, option == correctWord),
                );
              }).toList(),
              SizedBox(height: 30),
              Text(
                '${AppLocale.S87.getString(context)}: $score',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// الصفحة الرابعه: لعبة  خمن


class MatchWordToImagePage26 extends StatefulWidget {
  @override
  _MatchWordToImagePage26State createState() => _MatchWordToImagePage26State();
}

class _MatchWordToImagePage26State extends State<MatchWordToImagePage26>
    with SingleTickerProviderStateMixin {
  int score = 0;
  int currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E); // اللون الأساسي

  @override
  void initState() {
    super.initState();
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

  // دالة لاختيار كلمة وصورتها الصحيحة
  Map<String, String> getCurrentWordAndImage() {
    if (currentIndex < allWords2.length) {
      return allWords2[currentIndex];
    } else {
      // إعادة التدوير إلى أول كلمة بعد نهاية القائمة
      currentIndex = 0;
      return allWords2[currentIndex];
    }
  }

  // دالة لتحديد خيارات الكلمات
  List<String> getWordOptions(String correctWord) {
    List<String> options = allWords2.map((e) => e['word']!).toList();
    options.remove(correctWord); // إزالة الكلمة الصحيحة من الخيارات
    options.shuffle(); // خلط الكلمات

    // اختيار أول خيارين بعد الخلط
    List<String> selectedOptions = options.take(2).toList();

    // إضافة الكلمة الصحيحة وإعادة الخلط
    selectedOptions.add(correctWord);
    selectedOptions.shuffle();

    return selectedOptions;
  }

  void checkAnswer(String selectedOption, String correctWord) {
    setState(() {
      if (selectedOption == correctWord) {
        score += 10;
      } else {
        score -= 5;
      }

      // الانتقال إلى الكلمة التالية
      currentIndex = (currentIndex + 1) % allWords2.length; // إعادة التدوير
    });
  }

  void resetGame() {
    setState(() {
      score = 0;
      currentIndex = 0;
    });
  }

  Widget _buildButton(String option, String correctWord) {
    return FadeTransition(
      opacity: _animation,
      child: ElevatedButton(
        onPressed: () {
          checkAnswer(option, correctWord); // تأكد من تمرير correctWord الصحيح
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

  @override
  Widget build(BuildContext context) {
    Map<String, String> currentWordAndImage = getCurrentWordAndImage();
    String correctWord = currentWordAndImage['word']!;
    String image = currentWordAndImage['image']!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '${AppLocale.S101.getString(context)}',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: primaryColor,
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
                '${AppLocale.S102.getString(context)}',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              // عرض الصورة المرتبطة بالكلمة
              Text(
                image,
                style: TextStyle(fontSize: 100, color: Colors.white),
              ),
              SizedBox(height: 30),
              // عرض خيارات الكلمات
              ...getWordOptions(correctWord).map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _buildButton(option, correctWord), // تمرير correctWord هنا
                );
              }).toList(),
              SizedBox(height: 30),
              Text(
                '${AppLocale.S103.getString(context)}: $score',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// الصفحة الخامسه: لعبة رتب الكلمة


class RearrangeLettersPage26 extends StatefulWidget {
  @override
  _RearrangeLettersPage26State createState() => _RearrangeLettersPage26State();
}

class _RearrangeLettersPage26State extends State<RearrangeLettersPage26>
    with SingleTickerProviderStateMixin {
  int score = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _textController = TextEditingController();
  String feedbackMessage = ''; // رسالة المستخدم
  final Color primaryColor = Color(0xFF13194E); // اللون الأساسي

  // الكلمات والمرادفات

  late int outerIndex;
  late int innerIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    // اختيار كلمة عشوائية عند البداية
    _chooseRandomWord();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _chooseRandomWord() {
    // اختيار قائمة عشوائية داخلية ثم اختيار كلمة عشوائية من هذه القائمة
    outerIndex = Random().nextInt(allWords.length);
    innerIndex = Random().nextInt(allWords[outerIndex].length);
  }

  String shuffledWord(String word) {
    List<String> letters = word.split('')..shuffle();
    return letters.join();
  }

  void checkAnswer(String input, String correctWord) {
    setState(() {
      if (input.trim() == correctWord) {
        score += 10;
        feedbackMessage = '${AppLocale.S106.getString(context)}';
      } else {
        score -= 5;
        feedbackMessage = '${AppLocale.S107.getString(context)}';
      }

      // اختيار كلمة جديدة عشوائياً
      _chooseRandomWord();
      _textController.clear(); // مسح النص بعد الإجابة
      _controller.reset(); // إعادة تعيين الأنيميشن
      _controller.forward();
    });
  }

  Widget _buildTextField(String shuffled) {
    return FadeTransition(
      opacity: _animation,
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '${AppLocale.S105.getString(context)}',
        ),
        onSubmitted: (input) {
          checkAnswer(input, allWords[outerIndex][innerIndex][0]);
        },
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String correctWord = allWords[outerIndex][innerIndex][0]; // الكلمة الصحيحة
    String shuffled = shuffledWord(correctWord);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '${AppLocale.S108.getString(context)}',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: primaryColor,
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
                '${AppLocale.S109.getString(context)}',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                shuffled,
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
              SizedBox(height: 30),
              _buildTextField(shuffled),
              SizedBox(height: 20),
              Text(
                '${AppLocale.S103.getString(context)}: $score',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                feedbackMessage,
                style: TextStyle(
                    fontSize: 22, color: feedbackMessage == '${AppLocale.S106.getString(context)}'
                    ? Colors.green : Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}// الصفحة السادسة: لعبة اختيار الكلمة

class MemoryGamePage26 extends StatefulWidget {
  @override
  _MemoryGamePage26State createState() => _MemoryGamePage26State();
}

class _MemoryGamePage26State extends State<MemoryGamePage26> with SingleTickerProviderStateMixin {
  List<Map<String, String>> wordPairs = [];
  List<String> shuffledWords = [];
  List<bool> flipped = [];
  int? firstIndex;
  int? secondIndex;
  int score = 0;
  String difficulty = 'سهل'; // مستوى الصعوبة الافتراضي

  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    // تحويل البيانات إلى شكل زوج من الكلمات
    for (var group in allWords) {
      for (var pair in group) {
        wordPairs.add({'english': pair[0], 'arabic': pair[1]});
      }
    }

    resetGame();
  }

  void resetGame() {
    shuffledWords = [];
    flipped = [];
    firstIndex = null;
    secondIndex = null;
    score = 0;

    // خلط أزواج الكلمات قبل الاختيار
    wordPairs.shuffle();

    // تحديد عدد الأزواج بناءً على مستوى الصعوبة
    int pairsCount = getPairsCountByDifficulty();

    // اختيار الأزواج المناسبة بعد الخلط
    List<Map<String, String>> selectedPairs = wordPairs.take(pairsCount).toList();

    for (var pair in selectedPairs) {
      shuffledWords.add(pair['english']!);
      shuffledWords.add(pair['arabic']!);
    }

    shuffledWords.shuffle(); // خلط الكلمات بعد إضافتها
    flipped = List<bool>.filled(shuffledWords.length, false);
  }

  int getPairsCountByDifficulty() {
    switch (difficulty) {
      case 'سهل':
        return 5; // 5 أزواج
      case 'متوسط':
        return 10; // 10 أزواج
      case 'صعب':
        return 15; // 15 زوجاً
      default:
        return 5;
    }
  }

  void flipCard(int index) {
    setState(() {
      flipped[index] = true;

      if (firstIndex == null) {
        firstIndex = index;
      } else if (secondIndex == null) {
        secondIndex = index;

        Timer(Duration(seconds: 1), () {
          checkMatch();
        });
      }
    });
  }

  void checkMatch() {
    if (firstIndex != null && secondIndex != null) {
      String firstWord = shuffledWords[firstIndex!];
      String secondWord = shuffledWords[secondIndex!];

      bool isMatch = false;

      for (var pair in wordPairs) {
        if ((firstWord == pair['english'] && secondWord == pair['arabic']) ||
            (firstWord == pair['arabic'] && secondWord == pair['english'])) {
          isMatch = true;
          break;
        }
      }

      setState(() {
        if (!isMatch) {
          flipped[firstIndex!] = false;
          flipped[secondIndex!] = false;
        } else {
          score += 10;
        }

        // تحقق إذا انتهى اللاعب من جميع البطاقات
        if (flipped.every((isFlipped) => isFlipped)) {
          // إعادة مزج البطاقات والبدء من جديد
          resetGame();
        }

        firstIndex = null;
        secondIndex = null;
      });
    }
  }

  void selectDifficulty(String selectedDifficulty) {
    setState(() {
      difficulty = selectedDifficulty;
      resetGame(); // إعادة ضبط اللعبة بناءً على مستوى الصعوبة
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('لعبة الذاكرة - مطابقة الكلمات',style: TextStyle(color: Colors.white),),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white, // تغيير لون الأيقونات بما في ذلك النقاط الثلاث إلى الأبيض
        ),
        actions: [
          PopupMenuButton<String>(

            onSelected: selectDifficulty,
            color: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem(

                value: 'سهل',
                child: Text('${AppLocale.S111.getString(context)}'),
              ),
              PopupMenuItem(
                value: 'متوسط',
                child: Text('${AppLocale.S112.getString(context)}'),
              ),
              PopupMenuItem(
                value: 'صعب',
                child: Text('${AppLocale.S113.getString(context)}'),
              ),
            ],
          ),
        ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: shuffledWords.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (!flipped[index] && firstIndex != index && secondIndex == null) {
                        flipCard(index);
                      }
                    },
                    child: FadeTransition(
                      opacity: _animation,
                      child: Card(
                        color: flipped[index] ? Colors.blue[200] : primaryColor,
                        child: Center(
                          child: Text(
                            flipped[index] ? shuffledWords[index] : '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                '${AppLocale.S96.getString(context)}: $score',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: resetGame,
                child: Text('${AppLocale.S99.getString(context)}'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class WordShootingGame26 extends StatefulWidget {
  @override
  _WordShootingGame26State createState() => _WordShootingGame26State();
}

class _WordShootingGame26State extends State<WordShootingGame26> {

  Random random = Random();
  List<_Word> words = [];
  int score = 0;
  String currentTranslation = '';
  bool gameRunning = true;
  Timer? spawnTimer;
  Timer? moveTimer;
  String difficulty = 'سهل'; // مستوى الصعوبة الافتراضي
  double wordSpeed = 2; // سرعة الكلمة الافتراضية

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    adjustDifficultySettings();
    spawnTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (gameRunning) {
        spawnWord();
      }
    });

    moveTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (gameRunning) {
        moveWords();
      }
    });

    nextTranslation();
  }

  void adjustDifficultySettings() {
    // تحديد سرعة الكلمات وعدد النقاط بناءً على مستوى الصعوبة
    if (difficulty == 'سهل') {
      wordSpeed = 2;
    } else if (difficulty == 'متوسط') {
      wordSpeed = 4;
    } else if (difficulty == 'صعب') {
      wordSpeed = 6;
    }
  }

  void spawnWord() {
    setState(() {
      int groupIndex = random.nextInt(allWords.length);
      int wordIndex = random.nextInt(allWords[groupIndex].length);
      String englishWord = allWords[groupIndex][wordIndex][0]; // استخراج الكلمة الإنجليزية
      double startY = random.nextDouble() * MediaQuery.of(context).size.height / 2;

      words.add(_Word(
        word: englishWord,
        positionX: 0,
        positionY: startY,
      ));
    });
  }

  void nextTranslation() {
    int groupIndex = random.nextInt(allWords.length);
    int wordIndex = random.nextInt(allWords[groupIndex].length);
    setState(() {
      currentTranslation = allWords[groupIndex][wordIndex][1]; // استخراج الترجمة العربية
    });
  }

  void removeWord(_Word word) {
    setState(() {
      words.remove(word);
    });
  }

  void checkWord(_Word word) {
    for (var group in allWords) {
      for (var pair in group) {
        if (pair[0] == word.word && pair[1] == currentTranslation) {
          setState(() {
            score += 10;
            removeWord(word);
            nextTranslation(); // انتقال إلى الترجمة التالية
          });
          return;
        }
      }
    }
    setState(() {
      score -= 5; // خسارة نقاط إذا اختار الكلمة الخاطئة
      removeWord(word);
    });
  }

  void moveWords() {
    setState(() {
      // استخدام حلقة for التقليدية لتجنب خطأ التعديل المتزامن
      for (int i = words.length - 1; i >= 0; i--) {
        words[i].positionX += wordSpeed; // تحريك الكلمات بناءً على مستوى الصعوبة

        if (words[i].positionX > MediaQuery.of(context).size.width / 2 - 50) {
          words.removeAt(i); // إزالة الكلمة إذا خرجت عن الشاشة
        }
      }
    });
  }

  void changeDifficulty(String newDifficulty) {
    setState(() {
      difficulty = newDifficulty;
      adjustDifficultySettings();
    });
  }

  @override
  void dispose() {
    spawnTimer?.cancel();
    moveTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double halfWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        iconTheme: IconThemeData(
          color: Colors.white, // تغيير لون الأيقونات بما في ذلك النقاط الثلاث إلى الأبيض
        ),
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,

            onSelected: changeDifficulty,
            itemBuilder: (BuildContext context) {
              return {'${AppLocale.S111.getString(context)}', '${AppLocale.S112.getString(context)}', '${AppLocale.S113.getString(context)}'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // النصف الأيسر: الترجمة العربية الثابتة
          Container(
            width: halfWidth,
            color: Colors.blue[50],
            child: Center(
              child: Text(
                currentTranslation,
                style: TextStyle(fontSize: 32, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // النصف الأيمن: الكلمات الإنجليزية المتحركة
          Container(
            width: halfWidth,
            color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  right: 10,
                  child: Text(
                    '${AppLocale.S96.getString(context)}: $score',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                ...words.map((word) {
                  return Positioned(
                    top: word.positionY,
                    left: word.positionX,
                    child: GestureDetector(
                      onTap: () {
                        checkWord(word);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: Colors.blue[400],
                        child: Text(
                          word.word,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Word {
  String word;
  double positionX;
  double positionY;

  _Word({
    required this.word,
    required this.positionX,
    required this.positionY,
  });
}


class QuickMatchGame26 extends StatefulWidget {
  @override
  _QuickMatchGame26State createState() => _QuickMatchGame26State();
}

class _QuickMatchGame26State extends State<QuickMatchGame26> {

  List<String> englishWords = [];
  List<String> arabicWords = [];
  Map<String, bool> matchedPairs = {};
  int score = 0;
  int totalWords = 6; // عدد الكلمات العشوائية التي نريد عرضها
  bool gameFinished = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      // اختيار عدد عشوائي من الكلمات من allWords
      var random = Random();
      List<List<String>> selectedPairs = [];

      // دمج جميع الكلمات في قائمة واحدة واختيار 5 منها بشكل عشوائي
      var flatList = allWords.expand((pairList) => pairList).toList();
      while (selectedPairs.length < totalWords) {
        var randomPair = flatList[random.nextInt(flatList.length)];
        if (!selectedPairs.contains(randomPair)) {
          selectedPairs.add(randomPair);
        }
      }

      // فصل الكلمات الإنجليزية والعربية
      englishWords = selectedPairs.map((pair) => pair[0]).toList();
      arabicWords = selectedPairs.map((pair) => pair[1]).toList();
      englishWords.shuffle();
      arabicWords.shuffle();
      matchedPairs = {};
      score = 0;
      gameFinished = false;
    });
  }

  void onDragEnd(String englishWord, String arabicWord) {
    setState(() {
      for (var wordList in allWords) {
        for (var pair in wordList) {
          if (pair[0] == englishWord && pair[1] == arabicWord) {
            matchedPairs[englishWord] = true;
            score += 10;
            if (matchedPairs.length == totalWords) {
              gameFinished = true;
            }
            return;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              SizedBox(height: 20),
              Row(
                children: [
                  // الكلمات الإنجليزية التي يمكن سحبها
                  Expanded(
                    child: Column(
                      children: englishWords.map((englishWord) {
                        return Draggable<String>(
                          data: englishWord,
                          child: Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(16),
                            color: matchedPairs[englishWord] == true
                                ? Colors.green
                                : Colors.blue[200],
                            child: Text(
                              englishWord,
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                          feedback: Material(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              color: Colors.blue[200],
                              child: Text(
                                englishWord,
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          childWhenDragging: Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(16),
                            color: Colors.grey,
                            child: Text(
                              englishWord,
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(width: 20),
                  // الكلمات العربية
                  Expanded(
                    child: Column(
                      children: arabicWords.map((arabicWord) {
                        return DragTarget<String>(
                          onAccept: (englishWord) {
                            onDragEnd(englishWord, arabicWord);
                          },
                          builder: (context, candidateData, rejectedData) {
                            return Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(16),
                              color: Colors.orange[200],
                              child: Text(
                                arabicWord,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // عرض النقاط
              Text(
                '${AppLocale.S87.getString(context)}: $score',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              if (gameFinished)
                ElevatedButton(
                  onPressed: startGame,
                  child: Text(' ${AppLocale.S99.getString(context)}'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
class ListeningGame26 extends StatefulWidget {
  @override
  _ListeningGame26State createState() => _ListeningGame26State();
}

class _ListeningGame26State extends State<ListeningGame26>
    with SingleTickerProviderStateMixin {
  int _currentWordIndex = 0;
  int currentPage = 0;
  int score = 0;
  int pressCount = 0; // متغير لتعقب عدد مرات الضغط
  late AnimationController _controller;
  late Animation<double> _animation;
  final Color primaryColor = Color(0xFF13194E);
  FlutterTts flutterTts = FlutterTts();
  String userInput = '';
  bool isCorrect = false;
  bool isGameStarted = false;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    _generateRandomWord();
  }

  @override
  void dispose() {
    _controller.dispose();
    flutterTts.stop();
    super.dispose();
  }

  List<List<String>> getWords() {
    // دمج جميع الكلمات من كل الصفحات في قائمة واحدة
    List<List<String>> mergedWords = [];
    for (var page in allWords) {
      mergedWords.addAll(page);
    }
    return mergedWords;
  }

  List<int> _usedWords = []; // لتتبع الكلمات التي تم استخدامها

  void _generateRandomWord() {
    setState(() {
      Random random = Random();
      List<List<String>> allAvailableWords = getWords(); // الحصول على جميع الكلمات

      // التحقق إذا تم استخدام جميع الكلمات
      if (_usedWords.length == allAvailableWords.length) {
        _usedWords.clear(); // إعادة ضبط الكلمات المستخدمة عندما نمر على كل الكلمات
      }

      // التأكد من اختيار كلمة جديدة
      do {
        _currentWordIndex = random.nextInt(allAvailableWords.length);
      } while (_usedWords.contains(_currentWordIndex));

      _usedWords.add(_currentWordIndex); // إضافة الكلمة المختارة إلى قائمة الكلمات المستخدمة
      userInput = '';
      isCorrect = false;
      isGameStarted = true;
      pressCount = 0; // إعادة تعيين عدد الضغطات عند الانتقال إلى كلمة جديدة
    });
  }

  Future<void> _speakWord(String word) async {
    double speechRate;

    // تعيين سرعة الكلام بناءً على عدد مرات الضغط
    if (pressCount == 0) {
      speechRate = 1.0; // سرعة طبيعية
    } else if (pressCount == 1) {
      speechRate = 0.75; // أبطأ
    } else {
      speechRate = 0.5; // أكثر بطئًا
    }

    await flutterTts.setSpeechRate(speechRate); // تعيين سرعة الكلام
    await flutterTts.speak(word); // التحدث بالكلمة

    // تحديث عدد الضغطات
    setState(() {
      pressCount = (pressCount + 1) % 3; // العودة إلى السرعة الطبيعية بعد 3 ضغطات
    });
  }

  void _checkAnswer() {
    String correctWord = getWords()[_currentWordIndex][0];
    setState(() {
      if (userInput.trim().toLowerCase() == correctWord.toLowerCase()) {
        isCorrect = true;
        score += 10;
        _generateRandomWord();
      } else {
        isCorrect = false;
        score -= 5;
      }
    });
  }

  Widget _buildInputField() {
    return FadeTransition(
      opacity: _animation,
      child: TextField(
        onChanged: (value) {
          userInput = value;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'اكتب الكلمة هنا...',
        ),
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return FadeTransition(
      opacity: _animation,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String correctWord = getWords()[_currentWordIndex][0];
    String translatedWord = getWords()[_currentWordIndex][1];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'لعبة الاستماع',
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
                'الكلمة بالعربية:',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                translatedWord,
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              SizedBox(height: 30),
              _buildButton('استمع للكلمة', () => _speakWord(correctWord)),
              SizedBox(height: 30),
              _buildInputField(),
              SizedBox(height: 20),
              _buildButton('تحقق', _checkAnswer),
              SizedBox(height: 20),
              if (isCorrect)
                Text(
                  'إجابة صحيحة!',
                  style: TextStyle(fontSize: 26, color: Colors.green),
                )
              else if (userInput.isNotEmpty)
                Text(
                  'إجابة خاطئة، حاول مجددًا.',
                  style: TextStyle(fontSize: 26, color: Colors.red),
                ),
              SizedBox(height: 30),
              Text(
                'النقاط: $score',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 20),
              _buildButton('كلمة أخرى', _generateRandomWord),
            ],
          ),
        ),
      ),
    );
  }
}




class SpeechPage26s extends StatefulWidget {
  @override
  _SpeechPage26sState createState() => _SpeechPage26sState();
}

class _SpeechPage26sState extends State<SpeechPage26s> with SingleTickerProviderStateMixin {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isListening = false;
  String _spokenText = "";
  String _targetText = "";
  int _currentWordIndex = 0;
  int currentPage = 0;
  int score = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final Color primaryColor = Color(0xFF13194E);


  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    _targetText = allWords[currentPage][_currentWordIndex][0]; // تعيين الكلمة الأولى
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _spokenText = val.recognizedWords;
              _isListening = false;
              _checkResult();
            });
          },
          localeId: 'en_US', // Ensure you are using the correct parameter name
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _checkResult() {
    String spoken = _spokenText.toLowerCase().trim();
    String target = _targetText.toLowerCase().trim();

    // إزالة المسافات الزائدة
    spoken = spoken.replaceAll(RegExp(r'\s+'), ' ');

    // تقسيم النص المنطوق إلى كلمات
    List<String> spokenWords = spoken.split(' ');

    // التحقق إذا كانت جميع الكلمات هي نفس الكلمة المستهدفة
    bool allWordsMatch = spokenWords.every((word) => word == target);

    if (allWordsMatch) {
      setState(() {
        score += 10;
      });
    } else {
      setState(() {
        score -= 5;
      });
    }
  }

  // الانتقال إلى الكلمة التالية
  void _nextWord() {
    setState(() {
      if (_currentWordIndex < allWords[currentPage].length - 1) {
        _currentWordIndex++;
      } else {
        _currentWordIndex = 0;
        if (currentPage < allWords.length - 1) {
          currentPage++;
        } else {
          currentPage = 0; // إعادة التعيين إذا انتهت القائمة
        }
      }
      _targetText = allWords[currentPage][_currentWordIndex][0]; // تحديث الكلمة التالية
    });
  }

  void _speakText() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(_targetText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'التحدث',
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
                'قل الكلمة التالية:',
                style: TextStyle(fontSize: 26, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                _targetText, // الكلمة المطلوبة
                style: TextStyle(fontSize: 32, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              FadeTransition(
                opacity: _animation,
                child: ElevatedButton(
                  onPressed: _listen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    _isListening ? 'التحدث...' : 'ابدأ التحدث',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              FadeTransition(
                opacity: _animation,
                child: ElevatedButton(
                  onPressed: _speakText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    'استمع إلى الكلمة',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              FadeTransition(
                opacity: _animation,
                child: ElevatedButton(
                  onPressed: _nextWord, // الانتقال إلى الكلمة التالية
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    'الكلمة التالية',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'الكلام المنطوق:',
                style: TextStyle(fontSize: 26, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                _spokenText,
                style: TextStyle(fontSize: 32, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                'النقاط: $score',
                style: TextStyle(fontSize: 26, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
