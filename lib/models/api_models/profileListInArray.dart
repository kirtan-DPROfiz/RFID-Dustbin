class ProfileListInArray {
  String? empName;
  String? email;

  ProfileListInArray({this.empName, this.email});

  ProfileListInArray.fromJson(Map<String, dynamic> json) {
    empName = json['emp_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_name'] = this.empName;
    data['email'] = this.email;
    return data;
  }
}
