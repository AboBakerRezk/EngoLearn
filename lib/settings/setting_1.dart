
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:mushaf25/settings/setting_2.dart';



class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  void updateLanguage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      ),
    );
  }
}

class AdditionalPage extends StatefulWidget {
  const AdditionalPage({Key? key}) : super(key: key);

  @override
  _AdditionalPageState createState() => _AdditionalPageState();
}
final GlobalKey<_SecondPageState> secondPageKey = GlobalKey<_SecondPageState>();
final GlobalKey<_AdditionalPageState> additionalPageKey = GlobalKey<_AdditionalPageState>();

class _AdditionalPageState extends State<AdditionalPage> {
  void updateLanguage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      ),
    );
  }
}
