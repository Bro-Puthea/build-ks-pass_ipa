class EmployeesModel {
  List<Employees>? employees;
  String? start;
  String? limit;
  int? total;

  EmployeesModel({this.employees, this.start, this.limit, this.total});

  EmployeesModel.fromJson(Map<String, dynamic> json) {
    if (json['employees'] != null) {
      employees = <Employees>[];
      json['employees'].forEach((v) {
        employees!.add(Employees.fromJson(v));
      });
    }
    start = json['start'].toString();
    limit = json['limit'].toString();
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employees != null) {
      data['employees'] = employees!.map((v) => v.toJson()).toList();
    }
    data['start'] = start;
    data['limit'] = limit;
    data['total'] = total;
    return data;
  }
}

class Employees {
  String? id;
  String? image;
  String? fullName;
  String? email;
  String? phone;
  String? joinDate;
  String? status;
  String? departmentId;

  Employees(
      {this.id,
      this.image,
      this.fullName,
      this.email,
      this.phone,
      this.joinDate,
      this.status,
      this.departmentId});

  Employees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    fullName = json['FullName'];
    email = json['email'];
    phone = json['phone'];
    joinDate = json['join_date'];
    status = json['status'];
    departmentId = json['department_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['FullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['join_date'] = joinDate;
    data['status'] = status;
    data['department_id'] = departmentId;
    return data;
  }
}
