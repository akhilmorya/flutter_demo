class UsersListModel {
  List<User> users = new List<User>();

  UsersListModel.fromJson(Map<String, dynamic> parsedJson) {
    User user;
    for (var userJson in parsedJson['users']) {
      user = new User(
        name: userJson['name'],
        id: userJson['id'],
        city: userJson['city'],
        address: userJson['address'],
        date: userJson['date'],
        timing: userJson['timing'],
      );
      users.add(user);
    }
  }
  
}

class User {
  String name;
  int id;
  String city;
  String address;
  String date;
  String timing;

  User({ this.name, this.id, this.address, this.city, this.date, this.timing });
}

