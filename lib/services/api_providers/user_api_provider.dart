import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/models/users_list_model.dart';

class UserApiProvider {
  Future<UsersListModel> getUsers(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/data/user_data.json");
    return UsersListModel.fromJson(json.decode(data));
  }
}

final UserApiProvider userApiProvider = UserApiProvider();
