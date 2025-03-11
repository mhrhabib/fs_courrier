class SubZoneModel {
  bool? success;
  String? message;
  List<SubZone>? data;

  SubZoneModel({this.success, this.message, this.data});

  SubZoneModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubZone>[];
      json['data'].forEach((v) {
        data!.add(SubZone.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubZone {
  int? id;
  int? countryId;
  int? zoneId;
  String? name;
  String? position;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? stateId;

  SubZone({this.id, this.countryId, this.zoneId, this.name, this.position, this.status, this.createdAt, this.updatedAt, this.stateId});

  SubZone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    zoneId = json['zone_id'];
    name = json['name'];
    position = json['position'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_id'] = countryId;
    data['zone_id'] = zoneId;
    data['name'] = name;
    data['position'] = position;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['state_id'] = stateId;
    return data;
  }
}
