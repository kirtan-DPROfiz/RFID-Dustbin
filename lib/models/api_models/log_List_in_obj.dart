class LogListInObj {
  String? cardId;
  String? empName;
  String? department;
  String? designation;

  LogListInObj({this.cardId, this.empName, this.department, this.designation});

  LogListInObj.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    empName = json['emp_name'];
    department = json['department'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_id'] = this.cardId;
    data['emp_name'] = this.empName;
    data['department'] = this.department;
    data['designation'] = this.designation;
    return data;
  }
}