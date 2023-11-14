// class AddNewProject {
//   final String id;
//   final String? sort;
//   final String? createdById;
//   final String? updatedById;
//   final String name;
//   final String? description;
//   final String? isActive;
//   final String? locationCity;
//   final String? locationCountry;
//   final String? POC_name;
//   final String? POC_number;
//   final String? POC_Invoice;
//   final String? POC_Legal;
//   final String? projectType;
//   final String? FK_WTT_PaymentTerm_ID;
//   final String? FK_WTT_Currency_ID;
//   final String? phase;
//   final String? FK_WTT_Customer_ID;
//   final String? FK_WTT_BusinessUnit_ID;
//   final String? purchaseOrder;
//   final String? POC_email;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   AddNewProject({
//     required this.id,
//      this.sort,
//      this.createdById,
//      this.updatedById,
//     required this.name,
//     this.description,
//      this.isActive,
//      this.locationCity,
//      this.locationCountry,
//      this.POC_name,
//      this.POC_number,
//     this.POC_Invoice,
//     this.POC_Legal,
//      this.projectType,
//      this.FK_WTT_PaymentTerm_ID,
//      this.FK_WTT_Currency_ID,
//     this.phase,
//      this.FK_WTT_Customer_ID,
//      this.FK_WTT_BusinessUnit_ID,
//     this.purchaseOrder,
//      this.POC_email,
//      this.createdAt,
//      this.updatedAt,
//   });
//
// // Convert the object to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'sort': sort,
//       'createdById': createdById,
//       'updatedById': updatedById,
//       'name': name,
//       'description': description,
//       'isActive': isActive,
//       'locationCity': locationCity,
//       'locationCountry': locationCountry,
//       'POC_name': POC_name,
//       'POC_number': POC_number,
//       'POC_Invoice': POC_Invoice,
//       'POC_Legal': POC_Legal,
//       'projectType': projectType,
//       'FK_WTT_PaymentTerm_ID': FK_WTT_PaymentTerm_ID,
//       'FK_WTT_Currency_ID': FK_WTT_Currency_ID,
//       'phase': phase,
//       'FK_WTT_Customer_ID': FK_WTT_Customer_ID,
//       'FK_WTT_BusinessUnit_ID': FK_WTT_BusinessUnit_ID,
//       'purchaseOrder': purchaseOrder,
//       'POC_email': POC_email,
//       'createdAt': createdAt!.toIso8601String(),
//       'updatedAt': updatedAt!.toIso8601String(),
//     };
//   }
//
//   // Create an instance from a JSON map
//   factory AddNewProject.fromJson(Map<String, dynamic> json) {
//     return AddNewProject(
//       id: json['id'],
//       sort: json['sort'],
//       createdById: json['createdById'],
//       updatedById: json['updatedById'],
//       name: json['name'],
//       description: json['description'],
//       isActive: json['isActive'],
//       locationCity: json['locationCity'],
//       locationCountry: json['locationCountry'],
//       POC_name: json['POC_name'],
//       POC_number: json['POC_number'],
//       POC_Invoice: json['POC_Invoice'],
//       POC_Legal: json['POC_Legal'],
//       projectType: json['projectType'],
//       FK_WTT_PaymentTerm_ID: json['FK_WTT_PaymentTerm_ID'],
//       FK_WTT_Currency_ID: json['FK_WTT_Currency_ID'],
//       phase: json['phase'],
//       FK_WTT_Customer_ID: json['FK_WTT_Customer_ID'],
//       FK_WTT_BusinessUnit_ID: json['FK_WTT_BusinessUnit_ID'],
//       purchaseOrder: json['purchaseOrder'],
//       POC_email: json['POC_email'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
// }

class AddNewProject {
  final String id;
  final String? projectName;
  final String? description;
  final String? isActive;
  final String? locationCity;
  final String? locationCountry;
  final String? POC_name;
  final String? POC_number;
  final String? POC_Invoice;
  final String? POC_Legal;
  final String? projectType;
  final String? FK_WTT_PaymentTerm_ID;
  final String? paymentTerm;
  final String? FK_WTT_Currency_ID;
  final String? currencyName;
  final String? currencySymbol;
  final String? phase;
  final String? FK_WTT_Customer_ID;
  final String? customerName;
  final String? FK_WTT_BusinessUnit_ID;
  final String? BU_Name;
  final String? BU_Owner;
  final String? purchaseOrder;
  final String? POC_email;

  AddNewProject({
    required this.id,
      this.projectName,
    this.description,
    this.isActive,
     this.locationCity,
     this.locationCountry,
    this.POC_name,
    this.POC_number,
    this.POC_Invoice,
    this.POC_Legal,
    this.projectType,
    this.FK_WTT_PaymentTerm_ID,
     this.paymentTerm,
    this.FK_WTT_Currency_ID,
    this.currencyName,
     this.currencySymbol,
    this.phase,
    this.FK_WTT_Customer_ID,
     this.customerName,
    this.FK_WTT_BusinessUnit_ID,
     this.BU_Name,
     this.BU_Owner,
    this.purchaseOrder,
    this.POC_email,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectName': projectName,
      'description': description,
      'isActive': isActive,
      'locationCity': locationCity,
      'locationCountry': locationCountry,
      'POC_name': POC_name,
      'POC_number': POC_number,
      'POC_Invoice': POC_Invoice,
      'POC_Legal': POC_Legal,
      'projectType': projectType,
      'FK_WTT_PaymentTerm_ID': FK_WTT_PaymentTerm_ID,
      'paymentTerm': paymentTerm,
      'FK_WTT_Currency_ID': FK_WTT_Currency_ID,
      'currencyName': currencyName,
      'currencySymbol': currencySymbol,
      'phase': phase,
      'FK_WTT_Customer_ID': FK_WTT_Customer_ID,
      'customerName': customerName,
      'FK_WTT_BusinessUnit_ID': FK_WTT_BusinessUnit_ID,
      'BU_Name': BU_Name,
      'BU_Owner': BU_Owner,
      'purchaseOrder': purchaseOrder,
      'POC_email': POC_email,
    };
  }

  factory AddNewProject.fromJson(Map<String, dynamic> json) {
    return AddNewProject(
      id: json['id'],
      projectName: json['projectName'],
      description: json['description'],
      isActive: json['isActive'],
      locationCity: json['locationCity'],
      locationCountry: json['locationCountry'],
      POC_name: json['POC_name'],
      POC_number: json['POC_number'],
      POC_Invoice: json['POC_Invoice'],
      POC_Legal: json['POC_Legal'],
      projectType: json['projectType'],
      FK_WTT_PaymentTerm_ID: json['FK_WTT_PaymentTerm_ID'],
      paymentTerm: json['paymentTerm'],
      FK_WTT_Currency_ID: json['FK_WTT_Currency_ID'],
      currencyName: json['currencyName'],
      currencySymbol: json['currencySymbol'],
      phase: json['phase'],
      FK_WTT_Customer_ID: json['FK_WTT_Customer_ID'],
      customerName: json['customerName'],
      FK_WTT_BusinessUnit_ID: json['FK_WTT_BusinessUnit_ID'],
      BU_Name: json['BU_Name'],
      BU_Owner: json['BU_Owner'],
      purchaseOrder: json['purchaseOrder'],
      POC_email: json['POC_email'],
    );
  }
}

//
// class ProjectSummary {
//   final String id;
//   final String? projectName;
//
//   ProjectSummary(AddNewProject project)
//       : id = project.id,
//         projectName = project.projectName;
//
//   factory ProjectSummary.fromJson(Map<String, dynamic> json) {
//     return ProjectSummary(
//       AddNewProject(
//         id: json['id'],
//         projectName: json['projectName'],
//         description: json['description'],
//         isActive: json['isActive'],
//         locationCity: json['locationCity'],
//         locationCountry: json['locationCountry'],
//         POC_name: json['POC_name'],
//         POC_number: json['POC_number'],
//         POC_Invoice: json['POC_Invoice'],
//         POC_Legal: json['POC_Legal'],
//         projectType: json['projectType'],
//         FK_WTT_PaymentTerm_ID: json['FK_WTT_PaymentTerm_ID'],
//         paymentTerm: json['paymentTerm'],
//         FK_WTT_Currency_ID: json['FK_WTT_Currency_ID'],
//         currencyName: json['currencyName'],
//         currencySymbol: json['currencySymbol'],
//         phase: json['phase'],
//         FK_WTT_Customer_ID: json['FK_WTT_Customer_ID'],
//         customerName: json['customerName'],
//         FK_WTT_BusinessUnit_ID: json['FK_WTT_BusinessUnit_ID'],
//         BU_Name: json['BU_Name'],
//         BU_Owner: json['BU_Owner'],
//         purchaseOrder: json['purchaseOrder'],
//         POC_email: json['POC_email'],
//       ),
//     );
//   }
// }