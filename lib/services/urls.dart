class Urls {
  static const baseUrl = 'http://ddofinanceapi.walkingtree.tech';
}
class EndPoints{
  static const loginUrl = '${Urls.baseUrl}/login';
  static const financialYear='${Urls.baseUrl}/financialyear';
  static const businessUnit='${Urls.baseUrl}/businessunit';
  static const client='${Urls.baseUrl}/customer';
  static const project='${Urls.baseUrl}/project';
  static const projectCost='${Urls.baseUrl}/projectcost';
  static const resourcesCost = '${Urls.baseUrl}/resourcecost';
  static const postResourcesCost = '${Urls.baseUrl}/resourcecost';
  static const resourcesAllocation='${Urls.baseUrl}/projectresourcescost';
  static const getExpenseCategorySubcategory='${Urls.baseUrl}/expenseCategories?tree=true';
  static const postExpenseCategorySubcategory='${Urls.baseUrl}/expenseCategories';
}

