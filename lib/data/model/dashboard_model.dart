import 'vistor/vistors_model.dart';

class DashboardModel {
  String? totalVisitors;
  String? totalPreRegister;
  List<Visitors>? visitors;
  String? start;
  String? limit;
  String? total;

  DashboardModel(
      {this.totalVisitors,
      this.totalPreRegister,
      this.visitors,
      this.start,
      this.limit,
      this.total});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    totalVisitors = json['total_visitors'].toString();
    totalPreRegister = json['total_pre_register'].toString();
    if (json['visitors'] != null) {
      visitors = <Visitors>[];
      json['visitors'].forEach((v) {
        visitors!.add(Visitors.fromJson(v));
      });
    }
    start = json['start'].toString();
    limit = json['limit'].toString();
    total = json['total'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_visitors'] = totalVisitors;
    data['total_pre_register'] = totalPreRegister;
    if (visitors != null) {
      data['visitors'] = visitors!.map((v) => v.toJson()).toList();
    }
    data['start'] = start;
    data['limit'] = limit;
    data['total'] = total;
    return data;
  }
}
