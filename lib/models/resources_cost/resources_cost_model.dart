///Data model used for resources cost data table.
class ResourcesCostModel {
  String id;
  String employeeCode;
  String employeeName;
  String designationName;
  String joiningDate;
  String FK_WTT_Employee_ID;
  String monthlyCostComp1;
  String monthlyCostComp2;
  String monthlyCostComp3;
  String monthlyCostComp4;


  ///Calling the constructor of [ResourcesCostModel].
  ResourcesCostModel({
    required this.id,
    required this.employeeCode,
    required this.employeeName,
    required this.designationName,
    required this.joiningDate,
    required this.FK_WTT_Employee_ID,
    required this.monthlyCostComp1,
    required this.monthlyCostComp2,
    required this.monthlyCostComp3,
    required this.monthlyCostComp4,
  });


  /// Factory method for creating a ResourcesCostModel instance from a JSON map.
  factory ResourcesCostModel.fromJson(Map<String, dynamic> json) {
    return ResourcesCostModel(
      id: '${json['id']}',
      employeeCode: json['employeeCode'],
      employeeName: json['employeeName'],
      designationName: json['designationName'],
      joiningDate: json['joiningDate'],
      FK_WTT_Employee_ID: '${json['FK_WTT_Employee_ID']}',
      monthlyCostComp1: '${json['monthlyCostComp1']}',
      monthlyCostComp2: '${json['monthlyCostComp2']}',
      monthlyCostComp3: '${json['monthlyCostComp3']}',
      monthlyCostComp4: '${json['monthlyCostComp4']}',
    );
  }


  /// Converts this object to a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeCode': employeeCode,
      'employeeName': employeeName,
      'designationName': designationName,
      'joiningDate': joiningDate,
      'FK_WTT_Employee_ID': FK_WTT_Employee_ID,
      'monthlyCostComp1': monthlyCostComp1,
      'monthlyCostComp2': monthlyCostComp2,
      'monthlyCostComp3': monthlyCostComp3,
      'monthlyCostComp4': monthlyCostComp4,
    };
  }
}


class ChangedData {
  var id;
  final int FK_WTT_Employee_ID;
  final String monthlyCostComp1;
  final String monthlyCostComp2;
  final String monthlyCostComp3;
  final String monthlyCostComp4;
  final int? createdById;

  ChangedData({
    required this.id,
    required this.FK_WTT_Employee_ID,
    required this.monthlyCostComp1,
    required this.monthlyCostComp2,
    required this.monthlyCostComp3,
    required this.monthlyCostComp4,
    required this.createdById,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'FK_WTT_Employee_ID': FK_WTT_Employee_ID,
      'monthlyCostComp1': monthlyCostComp1,
      'monthlyCostComp2': monthlyCostComp2,
      'monthlyCostComp3': monthlyCostComp3,
      'monthlyCostComp4': monthlyCostComp4,
      'createdById': createdById,
    };
  }

}
