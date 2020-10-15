import 'package:flutter_boiler_plate/model/response/pagination.dart';

class UserResponse {
  List<User> users;
  Pagination pagination;

  UserResponse({this.pagination, this.users});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        users: json["data"] == null
            ? null
            : List<User>.from(json["data"].map((x) => User.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );
}

class User {
  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        avatar: json["profile_img"] == null ? null : json["profile_img"],
      );
}
