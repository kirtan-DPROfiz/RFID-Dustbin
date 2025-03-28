class DustBinListInArray {
   String? dustbinId;
   String? location;

  DustBinListInArray({this.dustbinId, this.location});

  DustBinListInArray.fromJson(Map<String, dynamic> json) {
    dustbinId = json['dustbin_id'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dustbin_id'] = this.dustbinId;
    data['location'] = this.location;
    return data;
  }



}
