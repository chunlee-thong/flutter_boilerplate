class LoginResponse {
  LoginResponse({
    this.status,
    this.message,
    this.data,
    this.token,
  });

  int status;
  String message;
  Data data;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
        "token": token == null ? null : token,
      };
}

class Data {
  Data({
    this.signinMethod,
    this.verify,
    this.role,
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.profileImg,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.location,
  });

  String signinMethod;
  bool verify;
  String role;
  int id;
  String name;
  String email;
  String phoneNumber;
  String profileImg;
  String password;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  Location location;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        signinMethod:
            json["signin_method"] == null ? null : json["signin_method"],
        verify: json["verify"] == null ? null : json["verify"],
        role: json["role"] == null ? null : json["role"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        profileImg: json["profile_img"] == null ? null : json["profile_img"],
        password: json["password"] == null ? null : json["password"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "signin_method": signinMethod == null ? null : signinMethod,
        "verify": verify == null ? null : verify,
        "role": role == null ? null : role,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "profile_img": profileImg == null ? null : profileImg,
        "password": password == null ? null : password,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
        "location": location == null ? null : location.toJson(),
      };
}

class Location {
  Location({
    this.id,
    this.latitude,
    this.longitude,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  double latitude;
  double longitude;
  String address;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["_id"] == null ? null : json["_id"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        address: json["address"] == null ? null : json["address"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "address": address == null ? null : address,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
      };
}
