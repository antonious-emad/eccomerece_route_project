class ChangePasswordMessageModel {
  ChangePasswordMessageModel({
    this.message,
    this.user,
    this.token,
  });

  ChangePasswordMessageModel.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }
  String? message;
  User? user;
  String? token;
}

class User {
  User({
    this.name,
    this.email,
    this.role,
  });

  User.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }
  String? name;
  String? email;
  String? role;
}
