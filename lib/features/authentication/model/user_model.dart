class UserModel {
  late String _fullName;
  late String _phoneNumber;
  late String _emailAddress;
  late String _createdTime;

  UserModel(
      {required fullName,
      required phoneNumber,
      required emailAddress,
      required createdTime}) {
    _fullName = fullName;
    _phoneNumber = phoneNumber;
    _emailAddress = emailAddress;
    _createdTime = createdTime;

  }
  UserModel.fromJson(Map<String, dynamic> json) {
    _fullName = json['fullName'];
    _phoneNumber = json['phoneNumber'];
    _emailAddress = json['emailAddress'];
    _createdTime = json['createdTime'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['fullName'] = _fullName;
    data['phoneNumber'] = _phoneNumber;
    data['emailAddress'] = _emailAddress;
    data['createdTime'] = _createdTime;
    return data;
  }
}
