class AddNewProject {
  final String id;
  final String? projectName;
  final String? description;
  final String? isActive;
  final String? locationCity;
  final String? locationCountry;
  final String? pocName;
  final String? pocNumber;
  final String? pocInvoice;
  final String? pocLegal;
  final String? projectType;
  final String? fkWttPaymentTermId;
  final String? paymentTerm;
  final String? fkWttCurrencyId;
  final String? currencyName;
  final String? currencySymbol;
  final String? phase;
  final String? fkWttCustomerId;
  final String? customerName;
  final String? fkWttBusinessUnitId;
  final String? buName;
  final String? buOwner;
  final String? purchaseOrder;
  final String? pocEmail;

  AddNewProject({
    required this.id,
    this.projectName,
    this.description,
    this.isActive,
    this.locationCity,
    this.locationCountry,
    this.pocName,
    this.pocNumber,
    this.pocInvoice,
    this.pocLegal,
    this.projectType,
    this.fkWttPaymentTermId,
    this.paymentTerm,
    this.fkWttCurrencyId,
    this.currencyName,
    this.currencySymbol,
    this.phase,
    this.fkWttCustomerId,
    this.customerName,
    this.fkWttBusinessUnitId,
    this.buName,
    this.buOwner,
    this.purchaseOrder,
    this.pocEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectName': projectName,
      'description': description,
      'isActive': isActive,
      'locationCity': locationCity,
      'locationCountry': locationCountry,
      'POC_name': pocName,
      'POC_number': pocNumber,
      'POC_Invoice': pocInvoice,
      'POC_Legal': pocLegal,
      'projectType': projectType,
      'FK_WTT_PaymentTerm_ID': fkWttPaymentTermId,
      'paymentTerm': paymentTerm,
      'FK_WTT_Currency_ID': fkWttCurrencyId,
      'currencyName': currencyName,
      'currencySymbol': currencySymbol,
      'phase': phase,
      'FK_WTT_Customer_ID': fkWttCustomerId,
      'customerName': customerName,
      'FK_WTT_BusinessUnit_ID': fkWttBusinessUnitId,
      'BU_Name': buName,
      'BU_Owner': buOwner,
      'purchaseOrder': purchaseOrder,
      'POC_email': pocEmail,
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
      pocName: json['POC_name'],
      pocNumber: json['POC_number'],
      pocInvoice: json['POC_Invoice'],
      pocLegal: json['POC_Legal'],
      projectType: json['projectType'],
      fkWttPaymentTermId: json['FK_WTT_PaymentTerm_ID'],
      paymentTerm: json['paymentTerm'],
      fkWttCurrencyId: json['FK_WTT_Currency_ID'],
      currencyName: json['currencyName'],
      currencySymbol: json['currencySymbol'],
      phase: json['phase'],
      fkWttCustomerId: json['FK_WTT_Customer_ID'],
      customerName: json['customerName'],
      fkWttBusinessUnitId: json['FK_WTT_BusinessUnit_ID'],
      buName: json['BU_Name'],
      buOwner: json['BU_Owner'],
      purchaseOrder: json['purchaseOrder'],
      pocEmail: json['POC_email'],
    );
  }
}

