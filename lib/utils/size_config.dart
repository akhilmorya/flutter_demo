import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;
  
  static double guidelineBaseWidth = 375;
  static double guidelineBaseHeight = 667;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    
    _safeAreaHorizontal = _mediaQueryData.padding.left + 
      _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
      _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth -
      _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight -
      _safeAreaVertical) / 100;
  }

  double scaleHorizontal(double size){
    return screenWidth / guidelineBaseWidth * size;    
  }
  
  double scaleVerticle(double size){
    return screenHeight / guidelineBaseHeight * size;   
  }

  double scaleVH(double size){

    return size;
  }

  bool isNotchDevice () {
    return _mediaQueryData.size.height >= 812.0;
  } 
  
}