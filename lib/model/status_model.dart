class StatusModel {
  Channel? channel;
  List<Feeds>? feeds;

  StatusModel({this.channel, this.feeds});

  StatusModel.fromJson(Map<dynamic, dynamic> json) {
    channel =
        json['channel'] != null ? Channel.fromJson(json['channel']) : null;
    if (json['feeds'] != null) {
      feeds = <Feeds>[];
      json['feeds'].forEach((v) {
        feeds!.add(Feeds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (channel != null) {
      data['channel'] = channel!.toJson();
    }
    if (feeds != null) {
      data['feeds'] = feeds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Channel {
  int? id;
  String? name;
  String? latitude;
  String? longitude;
  String? field1;
  String? field2;
  String? field3;
  String? createdAt;
  String? updatedAt;
  int? lastEntryId;

  Channel(
      {this.id,
      this.name,
      this.latitude,
      this.longitude,
      this.field1,
      this.field2,
      this.field3,
      this.createdAt,
      this.updatedAt,
      this.lastEntryId});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    field1 = json['field1'];
    field2 = json['field2'];
    field3 = json['field3'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastEntryId = json['last_entry_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['field1'] = field1;
    data['field2'] = field2;
    data['field3'] = field3;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_entry_id'] = lastEntryId;
    return data;
  }
}

class Feeds {
  String? createdAt;
  int? entryId;
  String? field1;
  String? field2;
  String? field3;

  Feeds({this.createdAt, this.entryId, this.field1, this.field2, this.field3});

  Feeds.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    entryId = json['entry_id'];
    field1 = json['field1'];
    field2 = json['field2'];
    field3 = json['field3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['entry_id'] = entryId;
    data['field1'] = field1;
    data['field2'] = field2;
    data['field3'] = field3;
    return data;
  }
}
