class VisitorsModel {
  List<Visitors>? data;
  String? start;
  String? limit;
  int? total;

  VisitorsModel({this.data, this.start, this.limit, this.total});

  VisitorsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Visitors>[];
      json['data'].forEach((v) {
        data!.add(Visitors.fromJson(v));
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

class Visitors {
  String? id;
  String? image;
  String? visitorId;
  String? visitorName;
  String? empName;
  String? checkIn;
  String? checkOut;
  String? status;
  String? block;
  String? phone;

  Visitors(
      {this.id,
      this.image,
      this.visitorId,
      this.visitorName,
      this.empName,
      this.checkIn,
      this.checkOut,
      this.status,
      this.block,
      this.phone});

  Visitors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    visitorId = json['visitor_id'];
    visitorName = json['visitor_name'];
    empName = json['emp_name'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    status = json['status'];
    block = json['block'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['image'] = image;
    data['visitor_id'] = visitorId;
    data['visitor_name'] = visitorName;
    data['emp_name'] = empName;
    data['check_in'] = checkIn;
    data['check_out'] = checkOut;
    data['status'] = status;
    data['block'] = block;
    data['phone'] = phone;
    return data;
  }
}

class AllowedModel {
  String? allowed;
  String? allowBy;
  String? name;

  AllowedModel({this.allowed, this.allowBy, this.name});

  AllowedModel.fromJson(Map<String, dynamic> json) {
    allowed = json['allowed'];
    allowBy = json['allow_by'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allowed'] = allowed;
    data['allow_by'] = allowBy;
    data['name'] = name;
    return data;
  }
}
