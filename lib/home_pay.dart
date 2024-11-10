import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:in_app_purchase/in_app_purchase.dart'; // مكتبة الشراء
import 'package:mushaf25/Advanced/Speaking/Speak_hom.dart';
import 'package:shared_preferences/shared_preferences.dart'; // لتخزين حالة الاشتراك محليًا
import 'package:connectivity/connectivity.dart'; // للتحقق من الاتصال بالإنترنت

// استيراد الصفحات الأخرى
import 'package:mushaf25/Advanced_exercises/Tests/quis_22.dart';
import 'package:mushaf25/Advanced_exercises/Tests/quis_home.dart';
import 'package:mushaf25/Advanced_exercises/Interactive_stories/storys_hom.dart';
import 'package:mushaf25/Advanced_exercises/tamarin120.dart';
import 'Advanced/Reading/read_home.dart';
import 'Foundational_lessons/sentence/sentence_e10.dart';
import 'Pages/profile.dart';
import 'Advanced/Listening/hom_listen.dart';
import 'Advanced/Writing/home_writing.dart';
import 'settings/setting_2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';


class HomePay extends StatefulWidget {
  @override
  _HomePayState createState() => _HomePayState();
}

class _HomePayState extends State<HomePay> with SingleTickerProviderStateMixin {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];
  bool _isSubscribed = false;
  bool _purchasePending = false;
  bool _couponApplied = false; // متغير يدل على تطبيق الكوبون
  String? nextBillingDate; // لإظهار تاريخ التجديد القادم
  final Color primaryColor = Color(0xFF13194E);

  // متغير لرمز الكوبون
  final TextEditingController _couponController = TextEditingController();
  String _couponMessage = '';

  @override
  void initState() {
    super.initState();

    // استعادة حالة الاشتراك من التخزين المحلي
    _getSubscriptionStatus();

    // استعادة حالة تطبيق الكوبون
    _getCouponAppliedStatus();

    // الاشتراك في تدفق المشتريات
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // التعامل مع الخطأ
    });

    _loadProducts();
  }

  Future<void> _getSubscriptionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSubscribed = prefs.getBool('isSubscribed') ?? false;
    });
  }

  Future<void> _setSubscriptionStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSubscribed', value);
  }

  Future<void> _getCouponAppliedStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _couponApplied = prefs.getBool('couponApplied') ?? false;
    });
  }

  Future<void> _setCouponApplied(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('couponApplied', value);
  }

  Future<void> _loadProducts() async {
    bool isConnected = await _checkInternetConnection();
    if (!isConnected) {
      _showErrorDialog('يرجى الاتصال بالإنترنت لعرض المنتجات.');
      return;
    }

    const Set<String> _kIds = {'writing_reading_and_listening2024'}; // تأكد من أن هذا المعرف مطابق للمنتج في المتجر
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(_kIds);

    if (response.notFoundIDs.isNotEmpty) {
      _showErrorDialog('المنتجات غير متوفرة في المتجر.');
      return;
    }

    setState(() {
      _products = response.productDetails;
    });
  }

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        setState(() {
          _purchasePending = true;
        });
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        setState(() {
          _purchasePending = false;
        });
        _showErrorDialog('حدث خطأ أثناء عملية الشراء: ${purchaseDetails.error?.message}');
      } else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
        bool valid = await _verifyPurchase(purchaseDetails);
        if (valid) {
          _deliverProduct(purchaseDetails);
        } else {
          _handleInvalidPurchase(purchaseDetails);
          return;
        }
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    return Future<bool>.value(true);
  }

  void _deliverProduct(PurchaseDetails purchaseDetails) async {
    setState(() {
      _isSubscribed = true;
      _purchasePending = false;
      nextBillingDate = "1 نوفمبر 2024"; // مثال لتاريخ التجديد
    });
    await _setSubscriptionStatus(true);
    _showSuccessDialog('تم الاشتراك بنجاح!');
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    _showErrorDialog('عملية شراء غير صحيحة.');
  }

  Future<void> makeInAppPurchase() async {
    if (_products.isEmpty) {
      _showErrorDialog('لا توجد منتجات متاحة للشراء حالياً.');
      return;
    }

    bool isConnected = await _checkInternetConnection();
    if (!isConnected) {
      _showErrorDialog('يرجى الاتصال بالإنترنت لإتمام عملية الشراء.');
      return;
    }

    final ProductDetails productDetails = _products.first;
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);

    setState(() {
      _purchasePending = true;
    });

    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('خطأ'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('موافق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('نجاح'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('موافق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSubscriptionStatus() {
    return _isSubscribed
        ? Text('أنت مشترك. تاريخ التجديد القادم: $nextBillingDate')
        : Text('أنت غير مشترك.');
  }

  void _applyCoupon() {
    if (_couponController.text == 'Ashraf_2024') {
      setState(() {
        _couponApplied = true; // تعيين المتغير كـ true عند تطبيق الكوبون
        _couponMessage = 'تم تطبيق الكوبون بنجاح!';
      });
      _setCouponApplied(true); // حفظ حالة الكوبون
    } else {
      setState(() {
        _couponMessage = 'الكوبون غير صالح.';
      });
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    _couponController.dispose(); // تأكد من تحرير الموارد
    super.dispose();
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 27, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // خلفية سوداء
      appBar: AppBar(
        title: Text(
          'رِحْلَةُ الأَلْفِ مِيلٍ تَبْدَأُ بِخُطْوَةٍ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: _isSubscribed || _couponApplied // عرض المحتوى إذا كان مشتركًا أو تم تطبيق الكوبون
                ? ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                if (_couponApplied) // إذا تم تطبيق الكوبون، يتم عرض رسالة
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'تم تطبيق الكوبون بنجاح. يمكنك الآن الوصول إلى المحتوى.',
                      style: TextStyle(color: Colors.green, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                _buildButton('الكتابة', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Writing()),
                  );
                }),
                SizedBox(height: 20),
                _buildButton('القراءة', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReadHome()),
                  );
                }),
                SizedBox(height: 20),
                _buildButton('الاستماع', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomListen()),
                  );
                }),
                SizedBox(height: 20),
                _buildButton('التحدث', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Speak_Home()),
                  );
                }),
              ],
            )
                :ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'يرجى الاشتراك للوصول إلى المحتوى.',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'احصل على 140 درس حصري عند الاشتراك.',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: _couponController,
                        decoration: InputDecoration(
                          labelText: 'ادخل رمز الكوبون',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _applyCoupon,
                      child: Text('تطبيق الكوبون'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _couponMessage,
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    _buildButton("""اترك من هنا""", () {
                      // استدعاء الشراء داخل التطبيق
                      makeInAppPurchase();
                    }),

                  ],
                ),
              ],
            )
          ),
          if (_purchasePending)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

class HomePay2 extends StatefulWidget {
  @override
  _HomePay2State createState() => _HomePay2State();
}

class _HomePay2State extends State<HomePay> with SingleTickerProviderStateMixin {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];
  bool _isSubscribed = false;
  bool _purchasePending = false;
  String? nextBillingDate;  // لإظهار تاريخ التجديد القادم

  final Color primaryColor = Color(0xFF13194E);

  @override
  void initState() {
    super.initState();

    // استعادة حالة الاشتراك من التخزين المحلي
    _getSubscriptionStatus();

    // الاشتراك في تدفق المشتريات
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // التعامل مع الخطأ
    });

    _loadProducts();
  }

  Future<void> _getSubscriptionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSubscribed = prefs.getBool('isSubscribed') ?? false;
    });
  }

  Future<void> _setSubscriptionStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSubscribed', value);
  }

  Future<void> _loadProducts() async {
    bool isConnected = await _checkInternetConnection();
    if (!isConnected) {
      // عرض رسالة تفيد بعدم وجود اتصال بالإنترنت
      _showErrorDialog('يرجى الاتصال بالإنترنت لعرض المنتجات.');
      return;
    }

    const Set<String> _kIds = {'writing_reading_and_listening2024'}; // تأكد من أن هذا المعرف مطابق للمنتج في المتجر
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(_kIds);

    if (response.notFoundIDs.isNotEmpty) {
      // التعامل مع المنتجات غير الموجودة
      _showErrorDialog('المنتجات غير متوفرة في المتجر.');
      return;
    }

    setState(() {
      _products = response.productDetails;
    });
  }

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  // متابعة تحديثات الشراء داخل التطبيق
  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        setState(() {
          _purchasePending = true;
        });
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        setState(() {
          _purchasePending = false;
        });
        _showErrorDialog('حدث خطأ أثناء عملية الشراء: ${purchaseDetails.error?.message}');
      } else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
        bool valid = await _verifyPurchase(purchaseDetails);
        if (valid) {
          _deliverProduct(purchaseDetails);
        } else {
          _handleInvalidPurchase(purchaseDetails);
          return;
        }
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    // التحقق من صحة الشراء (يمكنك إضافة التحقق من الخادم هنا)
    return Future<bool>.value(true);
  }

  void _deliverProduct(PurchaseDetails purchaseDetails) async {
    setState(() {
      _isSubscribed = true;
      _purchasePending = false;
      nextBillingDate = "1 نوفمبر 2024";  // مثال لتاريخ التجديد
    });
    await _setSubscriptionStatus(true);
    _showSuccessDialog('تم الاشتراك بنجاح!');
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // التعامل مع الشراء غير الصحيح
    _showErrorDialog('عملية شراء غير صحيحة.');
  }

  // تنفيذ عملية الشراء داخل التطبيق
  Future<void> makeInAppPurchase() async {
    if (_products.isEmpty) {
      _showErrorDialog('لا توجد منتجات متاحة للشراء حالياً.');
      return;
    }

    bool isConnected = await _checkInternetConnection();
    if (!isConnected) {
      _showErrorDialog('يرجى الاتصال بالإنترنت لإتمام عملية الشراء.');
      return;
    }

    final ProductDetails productDetails = _products.first;
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);

    setState(() {
      _purchasePending = true;
    });

    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('خطأ'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('موافق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('نجاح'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('موافق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSubscriptionStatus() {
    return _isSubscribed
        ? Text('أنت مشترك. تاريخ التجديد القادم: $nextBillingDate')
        : Text('أنت غير مشترك.');
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 27, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // خلفية سوداء
      appBar: AppBar(
        title: Text(
          'رِحْلَةُ الأَلْفِ مِيلٍ تَبْدَأُ بِخُطْوَةٍ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            // شرط إذا كان المستخدم مشتركًا، يظهر المحتوى، وإلا تظهر رسالة الدفع
            child: _isSubscribed
                ? ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildButton('${AppLocale.S35.getString(context)}', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Writing()),
                  );
                }),
                SizedBox(height: 20),
                _buildButton('${AppLocale.S120.getString(context)}', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReadHome()),
                  );
                }),
                SizedBox(height: 20),
                _buildButton('${AppLocale.S121.getString(context)}', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomListen()),
                  );
                }),
                SizedBox(height: 20),
                _buildButton('${AppLocale.S125.getString(context)}', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Speak_Home()),
                  );
                }),
              ],
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'يرجى الاشتراك للوصول إلى المحتوى.',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'احصل على 125 درس حصري عند الاشتراك.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                _buildButton('اشترك الآن بـ 500 جنيه شهريًا', () {
                  // استدعاء الشراء داخل التطبيق
                  makeInAppPurchase();
                }),
              ],
            ),

          ),
          if (_purchasePending)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
