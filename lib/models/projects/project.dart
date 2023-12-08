class ProjectModel {
  final int id;
  final int fkFinancialYearId;
  final String financialYearName;
  final String fkWttCustomerId;
  final String customerName;
  final int fkWttProjectId;
  final String projectName;
  final String forecast;
  final String actual;
  final String projectStatus;

  ProjectModel({
    required this.id,
    required this.fkFinancialYearId,
    required this.financialYearName,
    required this.fkWttCustomerId,
    required this.customerName,
    required this.fkWttProjectId,
    required this.projectName,
    required this.forecast,
    required this.actual,
    required this.projectStatus,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      fkFinancialYearId: json['FK_FinancialYear_ID'],
      financialYearName: json['financialYearName'],
      fkWttCustomerId: json['FK_WTT_Customer_ID'],
      customerName: json['customerName'],
      fkWttProjectId: json['FK_WTT_Project_ID'],
      projectName: json['projectName'],
      forecast: json['forecast'],
      actual: json['actual'],
      projectStatus: json['projectStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'FK_FinancialYear_ID': fkFinancialYearId,
      'financialYearName': financialYearName,
      'FK_WTT_Customer_ID': fkWttCustomerId,
      'customerName': customerName,
      'FK_WTT_Project_ID': fkWttProjectId,
      'projectName': projectName,
      'forecast': forecast,
      'actual': actual,
      'projectStatus': projectStatus,
    };
  }
}
