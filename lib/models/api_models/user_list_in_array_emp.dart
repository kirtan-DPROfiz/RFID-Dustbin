/*class UserListInArrayEmp {
  String? cardId;
  String? empName;
  String? department;
  String? designation;
  String? email;
  String? role;

  UserListInArrayEmp(
      {this.cardId,
      this.empName,
      this.department,
      this.designation,
      this.email,
      this.role});

  UserListInArrayEmp.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    empName = json['emp_name'];
    department = json['department'];
    designation = json['designation'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_id'] = this.cardId;
    data['emp_name'] = this.empName;
    data['department'] = this.department;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}*/


class UserListInArrayEmp {
  String? cardId;
  String? empName;
  String? department;
  String? designation;
  String? email;
  String? role;
  String? dustbinId;

  UserListInArrayEmp(
      {this.cardId,
        this.empName,
        this.department,
        this.designation,
        this.email,
        this.role,
        this.dustbinId});

  UserListInArrayEmp.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    empName = json['emp_name'];
    department = json['department'];
    designation = json['designation'];
    email = json['email'];
    role = json['role'];
    dustbinId = json['dustbin_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_id'] = this.cardId;
    data['emp_name'] = this.empName;
    data['department'] = this.department;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['role'] = this.role;
    data['dustbin_id'] = this.dustbinId;
    return data;
  }
}
