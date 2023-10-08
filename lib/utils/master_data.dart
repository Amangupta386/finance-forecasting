import 'package:ddofinance/models/dashboard/dashboard.dart';
import 'package:ddofinance/models/navigation_rail_model.dart';
import 'package:ddofinance/models/resources/resources_model.dart';
import 'package:ddofinance/screens/dashBoard/custom_drop_down.dart';
import 'package:ddofinance/screens/dashBoard/dashboard_dropdown.dart';
import 'package:ddofinance/screens/dashBoard/dashboard_project_datatable.dart';
import 'package:ddofinance/screens/dashBoard/other_expense_data_row.dart';
import 'package:ddofinance/utils/constants/labels.dart';

import 'constants/images.dart';

class MasterData {
  static const List<NavigationRailModel> navigationRailItemData = [
    NavigationRailModel(
        toggleImage: Images.toggleDashboardIcon,
        label: Labels.dashboard,
        image: Images.dashboardIcon,
        route: '/dashboard',
        selectedIndex: 0,
        index: 0),
    NavigationRailModel(
        toggleImage: Images.toggleProjectIcon,
        label: Labels.projects,
        image: Images.projectIcon,
        route: '/projects',
        selectedIndex: 1,
        index: 1),
    NavigationRailModel(
        toggleImage: Images.toggleResourceIcon,
        label: Labels.resources,
        image: Images.resourceIcon,
        route: '/resources',
        selectedIndex: 2,
        index: 2),
    NavigationRailModel(
        toggleImage: Images.toggleResourceCostIcon,
        label: Labels.resourcesCost,
        image: Images.resourceCostIcon,
        route: '/resources_cost',
        selectedIndex: 3,
        index: 3),
  ];

  List<ResourcesModel> data = [
    ResourcesModel(
        employeeName: 'Pragati Sharma',
        clientName: 'Strategen',
        projectName: 'Strategen',
        startDate: '20/05/2023',
        endDate: '30/06/2023',
        resourceCost: 200),
    ResourcesModel(
        employeeName: 'Harish Sharma',
        clientName: 'City group',
        projectName: 'Shuttle Mobile App',
        startDate: '20/05/2023',
        endDate: '30/06/2023',
        resourceCost: 500),
    ResourcesModel(
        employeeName: 'Harish Sharma',
        clientName: 'AdFactors',
        projectName: 'ChatGPT',
        startDate: '20/05/2023',
        endDate: '30/06/2023',
        resourceCost: 500),
    ResourcesModel(
        employeeName: 'Raj Kumar',
        clientName: 'City group',
        projectName: 'Shuttle Mobile App',
        startDate: '20/05/2023',
        endDate: '30/06/2023',
        resourceCost: 520),
  ];


  static const List<Map<String, dynamic>> resourceTableColumnHeaders = [
    {
      'label': Labels.employeeName,
      'sort': true
    },
    {
      'label': Labels.clientName,
      'sort': false
    },
    {
      'label': Labels.projectName,
      'sort': false
    },
    {
      'label': Labels.startDate,
      'sort': false
    },
    {
      'label': Labels.endDate,
      'sort': false
    },
    {
      'label': Labels.resourceCost,
      'sort': true
    },
  ];

  //Projects screen table data
  static List<Map<String, dynamic>> projectTableColumnHeaders = [
    {
      'label': Labels.clientName,
      'sort': true
    },
    {
      'label': Labels.projectName,
      'sort': false
    },
    {
      'label': Labels.projectForecast,
      'sort': true
    },
    {
      'label': Labels.actualCost,
      'sort': true
    },
    {
      'label': Labels.status,
      'sort': true
    },
    {
      'label': Labels.action,
      'sort': false
    },
  ];
  static List<DataTableChartModel> dashboardAndProjectMonthlyTableData = List
      .generate(
    dashboardAndProjectMonthRowNames.length,
        (index) =>
        DataTableChartModel(
          index: index,
          forecastedRevenue: List.generate(
              dashboardAndProjectMonthColumnsNames.length, (index) => '0'),
          actualRevenue: List.generate(
              dashboardAndProjectMonthColumnsNames.length, (index) => '0'),
          forecastedCollection: List.generate(
              dashboardAndProjectMonthColumnsNames.length, (index) => '0'),
          actualCollection: List.generate(
              dashboardAndProjectMonthColumnsNames.length, (index) => '0'),
          monthlyCost: List.generate(
              dashboardAndProjectMonthColumnsNames.length, (index) => '0'),
          dottedLine1: List.generate(
              dashboardAndProjectMonthColumnsNames.length, (index) => '0'),
          monthlyDeviation: List.generate(
              dashboardAndProjectMonthColumnsNames.length, (index) => '0'),
          dottedLine2: List.generate(
              dashboardAndProjectMonthColumnsNames.length, (index) => '0'),
        ),
  );

  static List<Map<String, dynamic>> projectsData = [
    {
      'clientName': 'Strategen',
      'ProjectName': 'Strategen',
      'ProjectForecast': '\$35890',
      'ActualCost': '\$32800',
      'status': 'In-Progress'
    },
    {
      'clientName': 'CGC-CPT',
      'ProjectName': 'Shuttle Mobile App',
      'ProjectForecast': '\$1,20,500',
      'ActualCost': '\$1,99,230',
      'status': 'In-Progress'
    },
    {
      'clientName': 'AdFactors',
      'ProjectName': 'ChatGPT',
      'ProjectForecast': '\$14,420',
      'ActualCost': '\$14,420',
      'status': 'Completed'
    },
    {
      'clientName': 'Scaled Foundations',
      'ProjectName': 'Files Management Application',
      'ProjectForecast': '\$8,185',
      'ActualCost': '\$8,185',
      'status': 'In-Progress'
    },
  ];

  /// Common Data of all the tables
  static const List<String> dashboardAndProjectTotalColumnTitles = [
    Labels.blankString,
    Labels.totalFY,
    Labels.totalYTD,
    Labels.blankString,
  ];

  static const List<String> dashboardAndProjectTotalColumnTitlesResponsive = [
    Labels.blankString,
    Labels.totalFYResponsive,
    Labels.totalYTDResponsive,
    Labels.blankString,
  ];

  static const List dashboardAndProjectMonthColumnsNames = [
    Labels.april,
    Labels.may,
    Labels.june,
    Labels.july,
    Labels.august,
    Labels.september,
    Labels.october,
    Labels.november,
    Labels.december,
    Labels.january,
    Labels.february,
    Labels.march
  ];

  /// Month By Month BreakDown Datatable

  static const List dashboardAndProjectMonthRowNames = [
    Labels.forecastedRevenue,
    Labels.actualRevenue,
    Labels.forecastedCollection,
    Labels.actualCollection,
    Labels.monthlyCost,
    Labels.blankString,
    Labels.monthlyDeviation,
    Labels.blankString,
  ];

  static const List dashboardAndProjectMonthRowNamesResponsive = [
    Labels.forecastedRevenueResponsive,
    Labels.actualRevenueResponsive,
    Labels.forecastedCollectionResponsive,
    Labels.actualCollectionResponsive,
    Labels.monthlyCostResponsive,
    Labels.blankString,
    Labels.monthlyDeviationResponsive,
    Labels.blankString,
  ];

  static List<String> dashboardAndProjectDropdownOptions = [
    Labels.travelExpense,
    Labels.hotelAccommodation,
    Labels.dropDownInitialValue[0],
    Labels.teamMeeting,
    Labels.teamLunch,
  ];

  static List dashboardAndProjectDataTableChart = [
    DashboardDropDown(),
    DashboardProjectDatatable(
      headingText: Labels.monthByMonthBreakdown,
      firstColRowLength: dashboardAndProjectMonthRowNames.length,
    ),
    DashboardProjectDatatable(
      headingText: Labels.otherExpense,
      firstColRowLength: dashboardAndProjectExpenseTotalDataRows.length,
    ),
    DashboardProjectDatatable(
      headingText: Labels.resourceCostHeading,
      firstColRowLength: dashboardAndProjectResourcesCost.length,
    ),
  ];

// Data of DataCells

  /// OtherExpense DataTable

// Data of OtherExpense DataCells
  static List<CustomDropdown> dashboardAndProjectExpenseList = [
    for (int i = 0; i < 100; i++) CustomDropdown(index: i)
  ];

  // static List<String> dashboardAndProjectExpenseTotalFYValue = List.generate(
  //     dashboardAndProjectExpenseList.length, (_) => '0');
  // static List<String> dashboardAndProjectExpenseTotalYTDValue = List.generate(
  //     dashboardAndProjectExpenseList.length, (_) => '0');
  //
  // static List<List<String>> expenseDataCellValue = List.generate(
  //     dashboardAndProjectExpenseList.length, (_) =>
  //     List.filled(dashboardAndProjectExpenseTotalFYValue.length, '0'));


  /// Resource Cost DataTable

// Data of Resource DataCells
  static List<String> dashboardAndProjectResourcesCost = [
    for (int i = 0; i < 100; i++) Labels.developerList[i]
  ];

  static List<String>dashboardAndProjectResourceTotalFYValue = List.generate(
      dashboardAndProjectResourcesCost.length, (_) => '0');

  static List<String> dashboardAndProjectResourceTotalYTDValue = List.generate(
      dashboardAndProjectResourcesCost.length, (_) => '0');

  static List<List<String>> dashboardAndProjectResourceDataCellValue = List
      .generate(
      dashboardAndProjectResourcesCost.length, (_) =>
      List.filled(dashboardAndProjectResourceTotalFYValue.length, '0'));

}