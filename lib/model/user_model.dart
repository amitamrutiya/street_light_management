class UserModel {
  late String _name;
  late String _phone;
  late String _email;
  String _createdTime = DateTime.now().toIso8601String();
  late String _photo_url;
  late String _uid;

  UserModel(
      {required uid,
      required name,
      required phone,
      required email,
      photo_url = ""}) {
    _name = name;
    _phone = phone;
    _email = email;
    _uid = uid;
    _photo_url = photo_url;
  }
  UserModel.fromJson(Map<String, dynamic> json) {
    _uid = json['uid'];
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
    _createdTime = json['createdTime'];
    _photo_url = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = _name;
    data['phone'] = _phone;
    data['email'] = _email;
    data['createdTime'] = _createdTime;
    data['photo_url'] = _photo_url;
    return data;
  }
}
