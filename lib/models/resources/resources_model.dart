

/// A class representing the resources Information.
class ResourcesModel{
  final String id;
  final String employeeId;
  final String employeeCode;
  final String employeeName;
  final String clientId;
  final String clientName;
  final String projectId;
  final String projectName;
  final String startDate;
  final String endDate;
  final String resourceCost;

  /// Constructor for creating a [ResourcesModel] instance.
  ResourcesModel(  {required this.id,required this.employeeId,required this.employeeCode,required this.clientId,required this.projectId,required this.employeeName, required this.clientName, required this.projectName,required this.startDate,required this.endDate,required this.resourceCost,});

  /// Factory method to create a [ResourcesModel] instance from JSON data.
  factory ResourcesModel.fromJson(Map<String, dynamic> json) {
    return ResourcesModel(
      id: json['id'],
      employeeId: json['employeeId'],
      employeeCode: json['employeeCode'],
      employeeName: json['employeeName'],
      clientId: json['clientId'],
      clientName: json['clientName'],
      projectId: json['projectId'],
      projectName: json['projectName'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      resourceCost: json['resourceCost'].toString(),
    );
  }
}