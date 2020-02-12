import 'package:flutter/material.dart';
import 'package:flutter_bloc/models/users_list_model.dart';
import 'package:flutter_bloc/ui/widgets/custom_image_widget.dart';
import 'package:flutter_bloc/utils/color_constants.dart' as colorConstants;
import 'package:flutter_bloc/utils/constants.dart' as constants;
import 'package:flutter_bloc/utils/images_constants.dart' as imageConstants;
import 'package:flutter_bloc/utils/size_config.dart';

class CustomListTile extends StatelessWidget {
  User user;
  int index;
  bool isDetailView;
  String leadingText;
  String trailingText;
  String leadingIcon;
  CustomListTile(
      {this.user,
      this.index,
      this.isDetailView,
      this.leadingIcon,
      this.leadingText,
      this.trailingText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isDetailView ? 0 : SizeConfig().scaleVerticle(10),
        horizontal: isDetailView ? SizeConfig().scaleHorizontal(40) : 0,
      ),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              bottomLeft: const Radius.circular(10.0))),
      height: isDetailView
          ? MediaQuery.of(context).size.height * 0.12
          : MediaQuery.of(context).size.height * 0.1,
      child: isDetailView ? detailListTile() : showCityListTile(),
    );
  }

  Widget detailListTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: colorConstants.GREY.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(5, 5), // changes position of shadow
              ),
            ],
          ),
          child: CustomImageWidget(image: leadingIcon),
        ),
        Expanded(
          child: Container(
              padding: new EdgeInsets.only(
                left: SizeConfig().scaleHorizontal(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$leadingText",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: colorConstants.GREY,
                      fontFamily: constants.GILROY_SEMI_BOLD,
                      fontSize: SizeConfig().scaleVerticle(17),
                    ),
                  ),
                  Text(
                    "$trailingText",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: colorConstants.BLACK,
                      fontFamily: constants.GILROY_MEDIUM_BOLD,
                      fontSize: SizeConfig().scaleVerticle(17),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget showCityListTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: SizeConfig().scaleHorizontal(5)),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: colorConstants.GREY.withOpacity(0.3),

                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(5, 5), // changes position of shadow
              ),
            ],
          ),
          child: CustomImageWidget(
              image: index == 0
                  ? imageConstants.activeListItem_str
                  : imageConstants.inactiveListItem_str),
        ),
        Expanded(
          child: Container(
              padding: new EdgeInsets.only(
                left: SizeConfig().scaleHorizontal(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${user.name}",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: colorConstants.GREY,
                      fontFamily: constants.GILROY_SEMI_BOLD,
                      fontSize: SizeConfig().scaleVerticle(15),
                    ),
                  ),
                  Text(
                    "${user.date}",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: colorConstants.BLACK,
                      fontFamily: constants.GILROY_MEDIUM_BOLD,
                      fontSize: SizeConfig().scaleVerticle(15),
                    ),
                  ),
                ],
              )),
        ),
        Container(
          padding: new EdgeInsets.only(right: SizeConfig().scaleHorizontal(10)),
          child: Text(
            "${user.city}",
            style: TextStyle(
              letterSpacing: SizeConfig().isNotchDevice() ? -0.4 : 0,
              decoration: TextDecoration.none,
              color: index == 0
                  ? colorConstants.APP_PINK
                  : colorConstants.APP_PRIMARY,
              fontFamily: constants.GILROY_BOLD,
              fontSize: SizeConfig().isNotchDevice()
                  ? SizeConfig().scaleVerticle(17)
                  : SizeConfig().scaleVerticle(18),
            ),
          ),
        ),
      ],
    );
  }
}
