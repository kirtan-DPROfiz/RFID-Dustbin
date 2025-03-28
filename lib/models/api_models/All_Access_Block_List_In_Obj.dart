class AllAccessBlockListInObj {
  List<DustbinAssignments>? dustbinAssignments;

  AllAccessBlockListInObj({this.dustbinAssignments});

  AllAccessBlockListInObj.fromJson(Map<String, dynamic> json) {
    if (json['dustbin_assignments'] != null) {
      dustbinAssignments = <DustbinAssignments>[];
      json['dustbin_assignments'].forEach((v) {
        dustbinAssignments!.add(new DustbinAssignments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dustbinAssignments != null) {
      data['dustbin_assignments'] =
          this.dustbinAssignments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DustbinAssignments {
  String? cardId;
  String? empName;
  String? department;
  String? designation;
  String? dustbinId;
  String? location;

  DustbinAssignments(
      {this.cardId,
        this.empName,
        this.department,
        this.designation,
        this.dustbinId,
        this.location});

  DustbinAssignments.fromJson(Map<String, dynamic> json) {
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
