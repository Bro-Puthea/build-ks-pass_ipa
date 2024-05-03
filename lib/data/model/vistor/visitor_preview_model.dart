class VisitorsPreviewModel {
  String? id;
  String? fullName;
  String? phone;
  String? email;
  String? image;
  String? empName;
  String? purpose;
  String? companyName;
  String? nationalIdentification;
  String? createdAt;
  String? checkIn;
  String? checkOut;
  String? address;
  String? status;
  String? gender;
  String? visitorName;
  String? departmentName;
  String? vehicleNumber;
  String? visitorCode;

  VisitorsPreviewModel(
      {this.id,
      this.fullName,
      this.phone,
      this.email,
      this.image,
      this.empName,
      this.purpose,
      this.companyName,
      this.nationalIdentification,
      this.createdAt,
      this.checkIn,
      this.checkOut,
      this.gender,
      this.address,
      this.status,
      this.visitorName,
      this.departmentName,
      this.vehicleNumber,
      this.visitorCode});

  VisitorsPreviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    empName = json['emp_name'];
    purpose = json['purpose'];
    companyName = json['company_name'];
    nationalIdentification = json['national_identification'];
    createdAt = json['created_at'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    address = json['address'];
    status = json['status'];
    gender = json['gender'];
    visitorName = json['visitor_name'];
    departmentName = json['department_name'];
    vehicleNumber = json['vehicle_number'];
    visitorCode = json['visitor_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    data['emp_name'] = empName;
    data['purpose'] = purpose;
    data['company_name'] = companyName;
    data['national_identification'] = nationalIdentification;
    data['created_at'] = createdAt;
    data['check_in'] = checkIn;
    data['check_out'] = checkOut;
    data['address'] = address;
    data['gender'] = gender;
    data['status'] = status;
    data['visitor_name'] = visitorName;
    data['department_name'] = departmentName;
    data['vehicle_number'] = vehicleNumber;
    data['visitor_code'] = visitorCode;
    return data;
  }
}
