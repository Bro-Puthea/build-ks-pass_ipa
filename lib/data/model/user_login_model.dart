class UserLoginModel {
  String? message;
  String? status;
  User? data;

  UserLoginModel({this.message, this.status, this.data});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? lastIpAddress;
  String? ipAddress;
  String? username;
  String? password;
  String? salt;
  String? email;
  String? activationCode;
  String? forgottenPasswordCode;
  String? forgottenPasswordTime;
  String? rememberCode;
  String? createdOn;
  String? lastLogin;
  String? active;
  String? firstName;
  String? lastName;
  String? phone;
  String? imageUrl;
  String? gender;
  String? groupId;
  String? groupName;
  String? joinDate;
  String? status;
  String? departmentId;
  String? designationId;
  String? about;
  String? qrcodeImage;
  String? address;
  String? empName;
  String? empId;
  String? departmentName;

  User({
    this.id,
    this.lastIpAddress,
    this.ipAddress,
    this.username,
    this.password,
    this.salt,
    this.email,
    this.activationCode,
    this.forgottenPasswordCode,
    this.forgottenPasswordTime,
    this.rememberCode,
    this.createdOn,
    this.lastLogin,
    this.active,
    this.firstName,
    this.lastName,
    this.phone,
    this.imageUrl,
    this.gender,
    this.groupId,
    this.groupName,
    this.joinDate,
    this.status,
    this.departmentId,
    this.designationId,
    this.about,
    this.qrcodeImage,
    this.address,
    this.empName,
    this.empId,
    this.departmentName,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastIpAddress = json['last_ip_address'];
    ipAddress = json['ip_address'];
    username = json['username'];
    password = json['password'];
    salt = json['salt'];
    email = json['email'];
    activationCode = json['activation_code'];
    forgottenPasswordCode = json['forgotten_password_code'];
    forgottenPasswordTime = json['forgotten_password_time'];
    rememberCode = json['remember_code'];
    createdOn = json['created_on'];
    lastLogin = json['last_login'];
    active = json['active'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    imageUrl = json['image_url'];
    gender = json['gender'];
    groupId = json['group_id'];
    groupName = json['group_name'];
    joinDate = json['join_date'];
    status = json['status'];
    departmentId = json['department_id'];
    designationId = json['designation_id'];
    about = json['about'];
    qrcodeImage = json['qrcode_image'];
    address = json['address'];
    empName = json['emp_name'];
    empId = json['emp_id'];
    departmentName = json['department_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['last_ip_address'] = lastIpAddress;
    data['ip_address'] = ipAddress;
    data['username'] = username;
    data['password'] = password;
    data['salt'] = salt;
    data['email'] = email;
    data['activation_code'] = activationCode;
    data['forgotten_password_code'] = forgottenPasswordCode;
    data['forgotten_password_time'] = forgottenPasswordTime;
    data['remember_code'] = rememberCode;
    data['created_on'] = createdOn;
    data['last_login'] = lastLogin;
    data['active'] = active;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['image_url'] = imageUrl;
    data['gender'] = gender;
    data['group_id'] = groupId;
    data['group_name'] = groupName;
    data['join_date'] = joinDate;
    data['status'] = status;
    data['department_id'] = departmentId;
    data['designation_id'] = designationId;
    data['about'] = about;
    data['qrcode_image'] = qrcodeImage;
    data['address'] = address;
    data['emp_name'] = empName;
    data['emp_id'] = empId;
    data['department_name'] = departmentName;
    return data;
  }
}
