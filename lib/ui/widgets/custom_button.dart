import 'package:flutter/material.dart';
import 'package:flutter_bloc/utils/constants.dart' as constants;
import 'package:flutter_bloc/utils/color_constants.dart' as colorConstants;
import 'package:flutter_bloc/utils/string_constants.dart' as stringConstants;
import 'package:flutter_bloc/utils/size_config.dart';

class CustomButton extends StatelessWidget {
  BuildContext context;
  VoidCallback onTap;
  CustomButton({this.context, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: SizeConfig().scaleVerticle(56),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: colorConstants.GREY.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(7, 7), // changes position of shadow
            ),
          ],
          color: colorConstants.APP_PRIMARY,
          borderRadius: new BorderRadius.circular(13.0),
        ),
        child: Center(
          child: Text(
            stringConstants.CONFIRM_TEXT,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: colorConstants.WHITE,
              fontFamily: constants.GILROY_SEMI_BOLD,
              fontSize: SizeConfig().scaleVerticle(18),
            ),
          ),
        ),
      ),
      onTap: () {
        onTap();   //callback to close the scrolling list
      },
    );
  }
}
