import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/models/users_list_model.dart';
import 'package:flutter_bloc/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class UsersListBloc {
  final Repository _repository = Repository();
  final _usersListFetcher = PublishSubject<UsersListModel>();

  Observable<UsersListModel> get usersList => _usersListFetcher.stream;

  Future<void> fetchUsersList(BuildContext context) async {
    final UsersListModel blockedUsersModel = await _repository.fetchUsersData(context);
    _usersListFetcher.sink.add(blockedUsersModel);
  }
}

final UsersListBloc bloc = UsersListBloc();
