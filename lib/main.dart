import 'package:flutter/material.dart';
import 'package:flutter_bloc/ui/home_page/home_page.dart';
import 'package:flutter_bloc/utils/constants.dart' as Constants;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.MATERIAL_APP_TITLE,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: Constants.APP_TITLE),
    );
  }
}