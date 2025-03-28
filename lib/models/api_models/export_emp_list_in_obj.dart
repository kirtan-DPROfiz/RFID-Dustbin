class ExportEmpListInObj {
  List<ScanLogs>? scanLogs;

  ExportEmpListInObj({this.scanLogs});

  ExportEmpListInObj.fromJson(Map<String, dynamic> json) {
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
  String? dustbinId;
  String? scanTime;

  ScanLogs({this.dustbinId, this.scanTime});

  ScanLogs.fromJson(Map<String, dynamic> json) {
    dustbinId = json['dustbin_id'];
    scanTime = json['scan_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dustbin_id'] = this.dustbinId;
    data['scan_time'] = this.scanTime;
    return data;
  }
}
