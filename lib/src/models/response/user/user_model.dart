import '../../pagination.dart';

class UserListResponse extends PaginationResponse<UserModel> {
  UserListResponse({
    required List<UserModel> data,
    required Pagination pagination,
  }) : super(
          totalRecord: pagination.totalItems,
          data: data,
        );

  factory UserListResponse.fromJson(Map<String, dynamic>? json) {
    return UserListResponse(
      data: json?["data"] == null ? [] : List<UserModel>.from(json?["data"]!.map((x) => UserModel.fromJson(x))),
      pagination: Pagination.fromJson(json?["pagination"]),
    );
  }
}

class UserModel {
  UserModel({
    required this.id,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImg,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.phoneNumber,
  });

  final String id;
  final String? role;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? profileImg;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? phoneNumber;

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    return UserModel(
      id: json?["_id"],
      role: json?["role"],
      firstName: json?["first_name"],
      lastName: json?["last_name"],
      email: json?["email"],
      profileImg: json?["profile_img"],
      createdAt: json?["createdAt"] == null ? null : DateTime.parse(json?["createdAt"]),
      updatedAt: json?["updatedAt"] == null ? null : DateTime.parse(json?["updatedAt"]),
      v: json?["__v"],
      phoneNumber: json?["phone_number"],
    );
  }
}
