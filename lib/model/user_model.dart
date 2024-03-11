class UserModel {
  String? token;

  UserModel({this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

class UserList {
  String? name;
  String? surname;
  String? email;
  String? username;

  UserList({this.name, this.surname, this.email, this.username});

  UserList._({
    required this.name,
    required this.surname,
    required this.email,
    required this.username,
  });

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      username: json['username'],
    );
  }

  static List<UserList> fromJsonList(List<dynamic> json) {
    return json.map((item) {
      return UserList(
        name: item['name'] as String?,
        surname: item['surname'] as String?,
        email: item['email'] as String?,
        username: item['username'] as String?,
      );
    }).toList();
  }


  /*UserList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['email'] = this.email;
    data['username'] = this.username;
    return data;
  }*/
}