/// A class representing the resources Information.
class ResourcesModel{
  final String employeeName;
  final String clientName;
  final String projectName;
  final String startDate;
  final String endDate;
  final int resourceCost;

  /// Constructor for creating a [ResourcesModel] instance.
  ResourcesModel( {required this.employeeName, required this.clientName, required this.projectName,required this.startDate,required this.endDate,required this.resourceCost,});

  /// Convert the [ResourcesModel] to a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'employeeName': employeeName,
      'clientName': clientName,
      'projectName': projectName,
      'startDate': startDate,
      'endDate': endDate,
      'resourceCost': resourceCost,
    };
  }

  /// Factory method to create a [ResourcesModel] instance from JSON data.
  factory ResourcesModel.fromJson(Map<String, dynamic> json) {
    return ResourcesModel(
      clientName: json['clientName'],
      projectName: json['projectName'],
      employeeName: json['employeeName'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      resourceCost: json['resourceCost'],
    );
  }
}