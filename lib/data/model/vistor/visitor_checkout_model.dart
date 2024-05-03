import '../selected_item_model.dart';

class VisitorCheckoutModel {
  DataCheckIn? data;
  List<SelectedItemModel>? cardId;
  List<SelectedItemModel>? notify;
  String? message;
  bool? status;

  VisitorCheckoutModel(
      {this.data, this.cardId, this.notify, this.message, this.status});

  VisitorCheckoutModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataCheckIn.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
    if (json['card_id'] != null) {
      cardId = <SelectedItemModel>[];
      json['card_id'].forEach((v) {
        cardId!.add(SelectedItemModel.fromJson(v));
      });
    }
    if (json['notify'] != null) {
      notify = <SelectedItemModel>[];
      json['notify'].forEach((v) {
        notify!.add(SelectedItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (cardId != null) {
      data['card_id'] = cardId!.map((v) => v.toJson()).toList();
    }
    if (notify != null) {
      data['notify'] = notify!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class DataCheckIn {
  String? id;
  String? preRegisterCode;
  String? firstName;
  String? lastName;
  String? visitorName;
  String? visitorNumber;
  String? gender;
  String? email;
  String? phone;
  String? nationalIdentification;
  String? empId;
  String? departmentId;
  String? notifyDepartmentId;
  String? purpose;
  String? companyName;
  String? vehicleNumber;
  String? address;
  String? createdAt;
  String? expectedDate;
  String? expectedTime;
  String? status;
  String? qrcodeImage;
  String? empName;
  String? departmentName;
  String? isTypeOfId;
  String? typeOfId;
  String? typeOfIdNumber;
  String? isVisitorCard;
  String? image;
  String? checkIn;
  String? checkOut;
  String? block;
  String? visitorCode;
  bool? isSecurity;
  bool? isCheckIn;
  String? allowed;
  String? allowBy;

  DataCheckIn(
      {this.id,
      this.preRegisterCode,
      this.firstName,
      this.lastName,
      this.visitorName,
      this.visitorNumber,
      this.gender,
      this.email,
      this.phone,
      this.nationalIdentification,
      this.empId,
      this.departmentId,
      this.notifyDepartmentId,
      this.purpose,
      this.companyName,
      this.vehicleNumber,
      this.address,
      this.createdAt,
      this.expectedDate,
      this.expectedTime,
      this.status,
      this.qrcodeImage,
      this.empName,
      this.departmentName,
      this.isTypeOfId,
      this.typeOfId,
      this.typeOfIdNumber,
      this.isVisitorCard,
      this.checkIn,
      this.image,
      this.block,
      this.checkOut,
      this.visitorCode,
      this.isSecurity = true,
      this.isCheckIn = true,
      this.allowed,
      this.allowBy});

  DataCheckIn.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    preRegisterCode = json['pre_register_code'].toString();
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    visitorName = json['visitor_name'].toString();
    visitorNumber = json['visitor_number'].toString();
    gender = json['gender'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    nationalIdentification = json['national_identification'].toString();
    empId = json['emp_id'].toString();
    departmentId = json['department_id'].toString();
    notifyDepartmentId = json['notify_department_id'].toString();
    purpose = json['purpose'].toString();
    companyName = json['company_name'].toString();
    vehicleNumber = json['vehicle_number'].toString();
    address = json['address'].toString();
    createdAt = json['created_at'].toString();
    expectedDate = json['expected_date'].toString();
    expectedTime = json['expected_time'].toString();
    status = json['status'].toString();
    qrcodeImage = json['qrcode_image'].toString();
    empName = json['emp_name'].toString();
    departmentName = json['department_name'].toString();
    isTypeOfId = json['is_type_of_id'].toString();
    typeOfId = json['type_of_id'].toString();
    typeOfIdNumber = json['type_of_id_number'].toString();
    isVisitorCard = json['is_visitor_card'].toString();
    image = json['image'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    block = json['block'];
    visitorCode = json['visitor_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pre_register_code'] = preRegisterCode;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['visitor_name'] = visitorName;
    data['visitor_number'] = visitorNumber;
    data['gender'] = gender;
    data['email'] = email;
    data['phone'] = phone;
    data['national_identification'] = nationalIdentification;
    data['emp_id'] = empId;
    data['department_id'] = departmentId;
    data['notify_department_id'] = notifyDepartmentId;
    data['purpose'] = purpose;
    data['company_name'] = companyName;
    data['vehicle_number'] = vehicleNumber;
    data['address'] = address;
    data['created_at'] = createdAt;
    data['expected_date'] = expectedDate;
    data['expected_time'] = expectedTime;
    data['status'] = status;
    data['qrcode_image'] = qrcodeImage;
    data['emp_name'] = empName;
    data['department_name'] = departmentName;
    data['is_type_of_id'] = isTypeOfId;
    data['type_of_id'] = typeOfId;
    data['type_of_id_number'] = typeOfIdNumber;
    data['is_visitor_card'] = isVisitorCard;
    data['image'] = image;
    data['check_in'] = checkIn;
    data['check_out'] = checkOut;
    data['block'] = block;
    data['visitor_code'] = visitorCode;
    return data;
  }
}
