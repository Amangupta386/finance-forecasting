class ProjectsModel {
  int id;
  int? index;
  String clientName;
  String projectName;
  final int projectForecast;
  final int actualCost;
  final String status;
  final String action;
  ProjectsModel(
      {
        required this.id,
        this.index,
        required this.clientName,
        required this.projectName,
        required this.projectForecast,
        required this.actualCost,
        required this.status,
        required this.action,
      });

  /// Converts this object to a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'clientName': clientName,
      'projectName': projectName,
      'projectForecast': projectForecast,
      'actualCost': actualCost,
      'status': status,
      'action': action,
    };
  }

  /// Creates a [ProjectsModel] object from a JSON map.
  factory ProjectsModel.fromJson(Map<String, dynamic> json) {
    return ProjectsModel(
      id: json['id'],
      clientName: json['clientName'],
      projectName: json['projectName'],
      projectForecast: json['projectForecast'],
      actualCost: json['actualCost'],
      status: json['status'],
      action: json['action'],
    );
  }
}