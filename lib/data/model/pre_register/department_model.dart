class DepartmentModel {
  List<Departments>? departments;

  DepartmentModel({this.departments});

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    if (json['departments'] != null) {
      departments = <Departments>[];
      json['departments'].forEach((v) {
        departments!.add(Departments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (departments != null) {
      data['departments'] = departments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Departments {
  String? id;
  String? name;
  String? descriptions;
  String? status;

  Departments({this.id, this.name, this.descriptions, this.status});

  Departments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    descriptions = json['descriptions'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['descriptions'] = descriptions;
    data['status'] = status;
    return data;
  }
}
