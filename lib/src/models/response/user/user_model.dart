import '../pagination.dart';

class UserResponse {
  List<UserModel> users;
  final Pagination? pagination;

  UserResponse({this.pagination, required this.users});

  bool get hasMoreData => pagination != null ? users.length < pagination!.totalItems : false;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        users: json["data"] == null ? [] : List<UserModel>.from(json["data"].map((x) => UserModel.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
      );
}

class UserModel {
  UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"] == null ? null : json["_id"],
        email: json["email"] == null ? null : json["email"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        avatar: json["profile_img"] == null ? null : json["profile_img"],
      );
}
