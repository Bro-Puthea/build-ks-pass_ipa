class ResponseModel {
  String? status;
  String? success;
  String? message;
  String? errors;
  String? id;

  ResponseModel(
      {this.status, this.success, this.message, this.errors, this.id});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    success = json['success'].toString();
    message = json['message'].toString();
    errors = json['errors'].toString();
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['message'] = message;
    data['errors'] = errors;
    data['id'] = id;
    return data;
  }
}
