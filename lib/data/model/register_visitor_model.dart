class RegisterVisitorModel {
  String? fname;
  String? lname;
  String? visitorId;
  String? phone;
  String? email;
  String? gender;
  String? companyName;
  String? nationalIdentification;
  String? empId;
  String? purpose;
  String? address;
  String? status;
  String? block;
  String? createdAt;
  String? image;

  RegisterVisitorModel(
      {this.fname,
      this.lname,
      this.visitorId,
      this.phone,
      this.email,
      this.gender,
      this.companyName,
      this.nationalIdentification,
      this.empId,
      this.purpose,
      this.address,
      this.status,
      this.block,
      this.createdAt,
      this.image});

  RegisterVisitorModel.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    lname = json['lname'];
    visitorId = json['visitor_id'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    companyName = json['company_name'];
    nationalIdentification = json['national_identification'];
    empId = json['emp_id'];
    purpose = json['purpose'];
    address = json['address'];
    status = json['status'];
    block = json['block'];
    createdAt = json['created_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['visitor_id'] = this.visitorId;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['company_name'] = this.companyName;
    data['national_identification'] = this.nationalIdentification;
    data['emp_id'] = this.empId;
    data['purpose'] = this.purpose;
    data['address'] = this.address;
    data['status'] = this.status;
    data['block'] = this.block;
    data['created_at'] = this.createdAt;
    data['image'] = this.image;
    return data;
  }
}
