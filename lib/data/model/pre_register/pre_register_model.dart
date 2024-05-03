class AllPreRegisterModel {
  List<PreRegisters>? data;
  String? start;
  String? limit;
  int? total;

  AllPreRegisterModel({this.data, this.start, this.limit, this.total});

  AllPreRegisterModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PreRegisters>[];
      json['data'].forEach((v) {
        data!.add(PreRegisters.fromJson(v));
      });
    }
    start = json['start'].toString();
    limit = json['limit'].toString();
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (data != null) {
      json['data'] = data!.map((v) => v.toJson()).toList();
    }
    json['start'] = start;
    json['limit'] = limit;
    json['total'] = total;
    return json;
  }
}

class PreRegisters {
  String? id;
  String? visitorName;
  String? email;
  String? phone;
  String? empName;
  String? expectedDate;
  String? expectedTime;

  PreRegisters(
      {this.id,
      this.visitorName,
      this.email,
      this.phone,
      this.empName,
      this.expectedDate,
      this.expectedTime});

  PreRegisters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visitorName = json['visitor_name'];
    email = json['email'];
    phone = json['phone'];
    empName = json['emp_name'];
    expectedDate = json['expected_date'];
    expectedTime = json['expected_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['visitor_name'] = visitorName;
    data['email'] = email;
    data['phone'] = phone;
    data['emp_name'] = empName;
    data['expected_date'] = expectedDate;
    data['expected_time'] = expectedTime;
    return data;
  }
}
