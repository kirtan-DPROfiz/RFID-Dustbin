class AuditListInObj {
  List<AuditLogs>? auditLogs;

  AuditListInObj({this.auditLogs});

  AuditListInObj.fromJson(Map<String, dynamic> json) {
    if (json['audit_logs'] != null) {
      auditLogs = <AuditLogs>[];
      json['audit_logs'].forEach((v) {
        auditLogs!.add(new AuditLogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.auditLogs != null) {
      data['audit_logs'] = this.auditLogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AuditLogs {
  String? eventDate;
  String? event;

  AuditLogs({this.eventDate, this.event});

  AuditLogs.fromJson(Map<String, dynamic> json) {
    eventDate = json['event_date'];
    event = json['event'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_date'] = this.eventDate;
    data['event'] = this.event;
    return data;
  }
}