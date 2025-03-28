class DustbinAccessListInObj {
  List<Assignments>? assignments;

  DustbinAccessListInObj({this.assignments});

  DustbinAccessListInObj.fromJson(Map<String, dynamic> json) {
    if (json['assignments'] != null) {
      assignments = <Assignments>[];
      json['assignments'].forEach((v) {
        assignments!.add(new Assignments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.assignments != null) {
      data['assignments'] = this.assignments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Assignments {
  String? cardId;
  String? empName;
  String? department;
  String? designation;
  String? dustbinId;
  String? location;

  Assignments(
      {this.cardId,
      this.empName,
      this.department,
      this.designation,
      this.dustbinId,
      this.location});

  Assignments.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    empName = json['emp_name'];
    department = json['department'];
    designation = json['designation'];
    dustbinId = json['dustbin_id'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_id'] = this.cardId;
    data['emp_name'] = this.empName;
    data['department'] = this.department;
    data['designation'] = this.designation;
    data['dustbin_id'] = this.dustbinId;
    data['location'] = this.location;
    return data;
  }
}

