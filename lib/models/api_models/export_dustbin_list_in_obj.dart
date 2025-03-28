class ExportDustbinListInObj {
  List<ScanLogs>? scanLogs;

  ExportDustbinListInObj({this.scanLogs});

  ExportDustbinListInObj.fromJson(Map<String, dynamic> json) {
    if (json['scan_logs'] != null) {
      scanLogs = <ScanLogs>[];
      json['scan_logs'].forEach((v) {
        scanLogs!.add(new ScanLogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.scanLogs != null) {
      data['scan_logs'] = this.scanLogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScanLogs {
  String? cardId;
  String? empName;
  String? department;
  String? scanTime;

  ScanLogs({this.cardId, this.empName, this.department, this.scanTime});

  ScanLogs.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    empName = json['emp_name'];
    department = json['department'];
    scanTime = json['scan_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_id'] = this.cardId;
    data['emp_name'] = this.empName;
    data['department'] = this.department;
    data['scan_time'] = this.scanTime;
    return data;
  }
}
