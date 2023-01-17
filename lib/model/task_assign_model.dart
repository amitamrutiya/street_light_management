class TaskAssignModel {
  late String _lightId;
  late String _assignDate;
  late String _deadlineDate;
  late String _engineerName;
  late String _description;

  TaskAssignModel(
      {required lightId,
      required assignDate,
      required deadlineDate,
      required engineerName,
      required description}) {
    _lightId = lightId;
    _assignDate = assignDate;
    _deadlineDate = deadlineDate;
    _engineerName = engineerName;
    _description = description;
  }
  TaskAssignModel.fromJson(Map<String, dynamic> json) {
    _lightId = json['lightId'];
    _assignDate = json['assignDate'];
    _deadlineDate = json['deadlineDate'];
    _engineerName = json['engineerName'];
    _description = json['description'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['lightId'] = _lightId;
    data['assignDate'] = _assignDate;
    data['deadlineDate'] = _deadlineDate;
    data['engineerName'] = _engineerName;
    data['description'] = _description;
    return data;
  }
}
