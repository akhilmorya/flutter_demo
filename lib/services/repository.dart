import 'dart:async';

// import 'package:bar_tinder/src/models/api_error.dart';
// import 'package:bar_tinder/src/models/api_response.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/models/users_list_model.dart';
import 'package:flutter_bloc/services/api_providers/user_api_provider.dart';

class Repository {

  Future<UsersListModel> fetchUsersData(BuildContext context) => userApiProvider.getUsers(context);

}
