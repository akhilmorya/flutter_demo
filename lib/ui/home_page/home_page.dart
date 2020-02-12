import 'package:flutter/material.dart';
import 'package:flutter_bloc/ui/home_page/home_page_bottom.dart';
import 'package:flutter_bloc/utils/size_config.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: HomePageBottom(),  
    );
  }
}
