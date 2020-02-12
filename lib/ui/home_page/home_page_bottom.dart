import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/models/users_list_model.dart';
import 'package:flutter_bloc/blocs/users_list_bloc.dart';
import 'package:flutter_bloc/ui/widgets/custom_button.dart';
import 'package:flutter_bloc/ui/widgets/custom_image_widget.dart';
import 'package:flutter_bloc/ui/widgets/custom_list_tile.dart';
import 'package:flutter_bloc/utils/constants.dart' as constants;
import 'package:flutter_bloc/utils/images_constants.dart' as imageConstants;
import 'package:flutter_bloc/utils/color_constants.dart' as colorConstants;
import 'package:flutter_bloc/utils/string_constants.dart' as stringConstants;
import 'package:flutter_bloc/utils/size_config.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePageBottom extends StatefulWidget {
  HomePageBottom();
  @override
  _HomePageBottomState createState() => _HomePageBottomState();
}

class _HomePageBottomState extends State<HomePageBottom> {
  PanelController sc = new PanelController();
  bool isPanelDraggable;
  final couponTextController = TextEditingController();
  double maxheight;
  User userData;
  String dateText;
  String timingText;
  String addressText;
  String nameText;
  String cityText;
  @override
  void initState() {
    super.initState();
    bloc.fetchUsersList(context);
    variablInit();
  }

  void variablInit(){
    isPanelDraggable = false;
    maxheight = 0;
    dateText = '';
    timingText = '';
    addressText = '';
    nameText = '';
    cityText = '';
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      backdropOpacity: 0.5,
      backdropColor: Colors.grey,
      onPanelClosed: () => {
        bloc.fetchUsersList(context),
      },
      controller: sc,
      isDraggable: isPanelDraggable,
      minHeight: 0,
      maxHeight: maxheight,
      renderPanelSheet: false,
      panel: _scrollingList(), // scrolling panel widget
      collapsed: null,
      body: Container(
        color: colorConstants.APP_PRIMARY,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 40,
                bottom: 50,
                left: 30,
                right: 30,
              ),
              margin: EdgeInsets.only(top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomImageWidget(image: imageConstants.menuIcon_str),
                    Text(
                      stringConstants.APP_TITLE,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: colorConstants.WHITE,
                        fontFamily: constants.GILROY_SEMI_BOLD,
                        fontSize: SizeConfig().scaleVerticle(18),
                      ),
                    )
                  ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig().scaleHorizontal(30)),
              child: Text(
                stringConstants.TODAYS_TITLE,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: colorConstants.WHITE,
                  fontWeight: FontWeight.w200,
                  fontFamily: constants.GILROY_LIGHT,
                  fontSize: SizeConfig().scaleVerticle(35),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30,
                bottom: SizeConfig().isNotchDevice()
                    ? MediaQuery.of(context).size.height * 0.116
                    : SizeConfig().scaleVerticle(60),
              ),
              child: Text(
                stringConstants.ORDERS_TEXT,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  letterSpacing: 0.2,
                  color: colorConstants.WHITE,
                  fontFamily: constants.GILROY_BOLD,
                  fontSize: SizeConfig().scaleVerticle(35),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.598,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  color: colorConstants.WHITE,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(30.0),
                      topRight: const Radius.circular(30.0))),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig().scaleVerticle(40),
                        left: SizeConfig().scaleHorizontal(25),
                        right: SizeConfig().scaleHorizontal(25)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ordeCount(), //Widget showing awaiting orders
                        Row(
                          children: <Widget>[
                            Text(
                              stringConstants.ALL_TEXT,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: colorConstants.BLACK,
                                fontFamily: constants.GILROY_SEMI_BOLD,
                                fontSize: SizeConfig().scaleVerticle(19),
                              ),
                            ),
                            CustomImageWidget(
                                image: imageConstants.iconLocation_str),
                          ],
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<UsersListModel>(
                    stream: bloc.usersList,
                    builder: (BuildContext context,
                        AsyncSnapshot<UsersListModel> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Text(stringConstants.NO_DATA);
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.done:
                        case ConnectionState.active:
                          if (snapshot.hasError) {
                            return Text(
                                stringConstants.errorText(snapshot.error));
                          } else {
                            List<User> users = snapshot.data.users;

                            return Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: ListView.builder(
                                  itemCount: users.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      child: CustomListTile(
                                        user: users[index],
                                        index: index,
                                        isDetailView: false,
                                      ),
                                      onTap: () => {
                                        setState(
                                          () => {
                                            dateText = users[index].date,
                                            timingText = users[index].timing,
                                            cityText = users[index].city,
                                            addressText = users[index].address,
                                            nameText = users[index].name,
                                            isPanelDraggable = true,
                                            maxheight = MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                1,
                                          },
                                        ),
                                        sc.open(), // opens the scrollingList
                                      },
                                    );
                                  },
                                ));
                          }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scrollingList() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        color: colorConstants.BLACK.withOpacity(0.25),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.height * 1,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
                color: colorConstants.WHITE,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(30.0),
                    topRight: const Radius.circular(30.0))),
            child: Column(
              children: <Widget>[
                paddingWidget(20.0),
                CustomImageWidget(image: imageConstants.closePullDown_str),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig().scaleVerticle(20),
                      horizontal: SizeConfig().scaleHorizontal(20)),
                  child: Text(
                    stringConstants.TAKE_OVER_TEXT,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: colorConstants.BLACK,
                      fontFamily: constants.GILROY_SEMI_BOLD,
                      fontSize: SizeConfig().isNotchDevice()
                          ? SizeConfig().scaleVerticle(18)
                          : SizeConfig().scaleVerticle(20),
                    ),
                  ),
                ),
                CustomListTile(
                  leadingIcon: imageConstants.calender_str,
                  leadingText: stringConstants.FIXED_DATE_TEXT,
                  trailingText: timingText,
                  isDetailView: true,
                ),
                CustomListTile(
                  leadingIcon: imageConstants.mapMarker_str,
                  leadingText: addressText,
                  trailingText: cityText,
                  isDetailView: true,
                ),
                CustomListTile(
                  leadingIcon: imageConstants.person_str,
                  leadingText: nameText,
                  trailingText: dateText,
                  isDetailView: true,
                ),
                paddingWidget(15.0),
                CustomButton(
                    context: context,
                    onTap: () {
                      sc.close();
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ordeCount() {
    return StreamBuilder<UsersListModel>(
      stream: bloc.usersList,
      builder: (context, AsyncSnapshot<UsersListModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text(
              stringConstants.AWAITING_ORDERS_TEXT,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: colorConstants.BLACK,
                fontFamily: constants.GILROY_SEMI_BOLD,
                fontSize: SizeConfig().scaleVerticle(19),
              ),
            );
            break;
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            break;
          case ConnectionState.active:
            if (snapshot.hasError) {
              return Text(stringConstants.errorText(snapshot.error));
            } else {
              List<User> users = snapshot.data.users;
              return Text(
                stringConstants.AWAITING_ORDERS_TEXT + '${users.length}',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: colorConstants.BLACK,
                  fontFamily: constants.GILROY_SEMI_BOLD,
                  fontSize: SizeConfig().scaleVerticle(20),
                ),
              );
            }
            break;
          case ConnectionState.done:
            break;
        }
      },
    );
  }

  dynamic paddingWidget(double height) {
    return SizedBox(
      height: SizeConfig().scaleVerticle(height),
    );
  }
}
