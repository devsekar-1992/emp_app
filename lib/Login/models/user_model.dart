class UserModel {
  late User user;
  late String token;

  UserModel({required this.user, required this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = (json['user'] != null ? new User.fromJson(json['user']) : null)!;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  late int id = 0;
  late String firstName;
  late String lastName;
  late String primaryNumber;
  late String email;
  late Null emailVerifiedAt;
  late int departmentId;
  late String createdAt;
  late String updatedAt;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.primaryNumber,
      required this.email,
      this.emailVerifiedAt,
      required this.departmentId,
      required this.createdAt,
      required this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    primaryNumber = json['primary_number'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    departmentId = json['department_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['primary_number'] = this.primaryNumber;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['department_id'] = this.departmentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
