class VisitorParam {
  String? visitorId;
  String? visitorName;
  String? visitorNumber;
  String? fistName;
  String? lastName;
  String? phone;
  String? email;
  String? gender;
  String? companyName;
  String? imageUrl;
  String? nationalId;
  String? employeeId;
  String? purpose;
  String? address;
  String? employeeName;
  String? empFile;
  String? departmentId;
  String? vehicleNumber;
  String? isTypeOfId;
  String? isVisitorCard;
  String? typeOfId;
  String? typeOfIdNumber;
  String? cardId;
  String? notifyTo;
  String? preRegisterId;

  VisitorParam(
      {this.visitorId,
      this.visitorName,
      this.visitorNumber,
      this.fistName,
      this.lastName,
      this.phone,
      this.email,
      this.gender,
      this.companyName,
      this.nationalId,
      this.employeeId,
      this.employeeName,
      this.purpose,
      this.address,
      this.imageUrl,
      this.empFile,
      this.departmentId,
      this.vehicleNumber,
      this.isTypeOfId,
      this.isVisitorCard,
      this.typeOfId,
      this.typeOfIdNumber,
      this.cardId,
      this.notifyTo,
      this.preRegisterId});

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['visitor_name'] = visitorName ?? '';
    data['visitor_number'] = visitorNumber ?? '';
    data['visitor_id'] = visitorId ?? '';
    data['first_name'] = fistName ?? '';
    data['last_name'] = lastName ?? '';
    data['phone'] = phone ?? "";
    data['email'] = email ?? '';
    data['gender'] = gender ?? "";
    data['company_name'] = companyName ?? "";
    data['national_iden_no'] = nationalId ?? '';
    data['emp_id'] = employeeId ?? "";
    data['purpose'] = purpose ?? "";
    data['address'] = address ?? "";
    data['emp_file'] = empFile ?? '';
    data['emp_name'] = employeeName ?? '';
    data['department_id'] = departmentId ?? '';
    data['vehicle_number'] = vehicleNumber ?? '';
    data['is_type_of_id'] = isTypeOfId ?? '';
    data['is_visitor_card'] = isVisitorCard ?? '';
    data['type_of_id'] = typeOfId ?? '';
    data['type_of_id_number'] = typeOfIdNumber ?? '';
    data['card_id'] = cardId ?? '';
    data['notify_to'] = notifyTo ?? '';
    data['pre_register_id'] = preRegisterId ?? '';
    return data;
  }
}
