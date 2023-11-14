import 'package:ddofinance/models/dashboard/dropdown.dart';
import 'package:ddofinance/models/navigation_rail_model.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'constants/images.dart';

class MasterData {
  static const List<NavigationRailModel> navigationRailItemData = [
    NavigationRailModel(
        toggleImage: Images.toggleDashboardIcon,
        label: Labels.railDashboard,
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

  static const List<Map<String, dynamic>> resourceTableColumnHeaders = [
    {'label': Labels.employeeName, 'sort': true},
    {'label': Labels.clientName, 'sort': false},
    {'label': Labels.projectName, 'sort': false},
    {'label': Labels.startDate, 'sort': false},
    {'label': Labels.endDate, 'sort': false},
    {'label': Labels.resourceCost, 'sort': true},
  ];

  //Projects screen table data
  static List<Map<String, dynamic>> projectTableColumnHeaders = [
    {'label': Labels.clientName, 'sort': true},
    {'label': Labels.projectName, 'sort': false},
    {'label': Labels.projectForecast, 'sort': true},
    {'label': Labels.actualCost, 'sort': true},
    {'label': Labels.status, 'sort': true},
    {'label': Labels.action, 'sort': false},
  ];

  static List<Map<String, Object>> monthBreakdownJSONData = [
    {
      "label": "Forecasted Revenue",
      "monthValues": [
        {"label": "Apr", "value": 0, "commentData": "message 1"},
        {"label": "May", "value": 0, "commentData": "message 2"},
        {"label": "Jun", "value": 0, "commentData": "message 3"},
        {"label": "Jul", "value": 0, "commentData": "message 4"},
        {"label": "Aug", "value": 0, "commentData": "message 5"},
        {"label": "Sept", "value": 0, "commentData": "message 6"},
        {"label": "Oct", "value": 0, "commentData": "message 7"},
        {"label": "Nov", "value": 0, "commentData": "message 8"},
        {"label": "Dec", "value": 0, "commentData": "message 9"},
        {"label": "Jan", "value": 0, "commentData": "message 10"},
        {"label": "Feb", "value": 0, "commentData": "message 11"},
        {"label": "Mar", "value": 0, "commentData": "message 12"}
      ]
    },
    {
      "label": "Actual Revenue",
      "monthValues": [
        {"label": "Apr", "value": 0, "commentData": "message 1"},
        {"label": "May", "value": 0, "commentData": "message 2"},
        {"label": "Jun", "value": 0, "commentData": "message 3"},
        {"label": "Jul", "value": 0, "commentData": "message 4"},
        {"label": "Aug", "value": 0, "commentData": "message 5"},
        {"label": "Sept", "value": 0, "commentData": "message 6"},
        {"label": "Oct", "value": 0, "commentData": "message 7"},
        {"label": "Nov", "value": 0, "commentData": "message 8"},
        {"label": "Dec", "value": 0, "commentData": "message 9"},
        {"label": "Jan", "value": 0, "commentData": "message 10"},
        {"label": "Feb", "value": 0, "commentData": "message 11"},
        {"label": "Mar", "value": 0, "commentData": "message 12"}
      ]
    },
    {
      "label": "Forecasted Collection",
      "monthValues": [
        {"label": "Apr", "value": 0, "commentData": "message 1"},
        {"label": "May", "value": 0, "commentData": "message 2"},
        {"label": "Jun", "value": 0, "commentData": "message 3"},
        {"label": "Jul", "value": 0, "commentData": "message 4"},
        {"label": "Aug", "value": 0, "commentData": "message 5"},
        {"label": "Sept", "value": 0, "commentData": "message 6"},
        {"label": "Oct", "value": 0, "commentData": "message 7"},
        {"label": "Nov", "value": 0, "commentData": "message 8"},
        {"label": "Dec", "value": 0, "commentData": "message 9"},
        {"label": "Jan", "value": 0, "commentData": "message 10"},
        {"label": "Feb", "value": 0, "commentData": "message 11"},
        {"label": "Mar", "value": 0, "commentData": "message 12"}
      ]
    },
    {
      "label": "Actual Collection",
      "monthValues": [
        {"label": "Apr", "value": 0, "commentData": "message 1"},
        {"label": "May", "value": 0, "commentData": "message 2"},
        {"label": "Jun", "value": 0, "commentData": "message 3"},
        {"label": "Jul", "value": 0, "commentData": "message 4"},
        {"label": "Aug", "value": 0, "commentData": "message 5"},
        {"label": "Sept", "value": 0, "commentData": "message 6"},
        {"label": "Oct", "value": 0, "commentData": "message 7"},
        {"label": "Nov", "value": 0, "commentData": "message 8"},
        {"label": "Dec", "value": 0, "commentData": "message 9"},
        {"label": "Jan", "value": 0, "commentData": "message 10"},
        {"label": "Feb", "value": 0, "commentData": "message 11"},
        {"label": "Mar", "value": 0, "commentData": "message 12"}
      ]
    },
    {
      "label": "Monthly Cost",
      "monthValues": [
        {"label": "Apr", "value": 0, "commentData": "message 1"},
        {"label": "May", "value": 0, "commentData": "message 2"},
        {"label": "Jun", "value": 0, "commentData": "message 3"},
        {"label": "Jul", "value": 0, "commentData": "message 4"},
        {"label": "Aug", "value": 0, "commentData": "message 5"},
        {"label": "Sept", "value": 0, "commentData": "message 6"},
        {"label": "Oct", "value": 0, "commentData": "message 7"},
        {"label": "Nov", "value": 0, "commentData": "message 8"},
        {"label": "Dec", "value": 0, "commentData": "message 9"},
        {"label": "Jan", "value": 0, "commentData": "message 10"},
        {"label": "Feb", "value": 0, "commentData": "message 11"},
        {"label": "Mar", "value": 0, "commentData": "message 12"}
      ]
    },
    {
      "label": "Monthly Deviation",
      "monthValues": [
        {"label": "Apr", "value": 0, "commentData": "message 1"},
        {"label": "May", "value": 0, "commentData": "message 2"},
        {"label": "Jun", "value": 0, "commentData": "message 3"},
        {"label": "Jul", "value": 0, "commentData": "message 4"},
        {"label": "Aug", "value": 0, "commentData": "message 5"},
        {"label": "Sept", "value": 0, "commentData": "message 6"},
        {"label": "Oct", "value": 0, "commentData": "message 7"},
        {"label": "Nov", "value": 0, "commentData": "message 8"},
        {"label": "Dec", "value": 0, "commentData": "message 9"},
        {"label": "Jan", "value": 0, "commentData": "message 10"},
        {"label": "Feb", "value": 0, "commentData": "message 11"},
        {"label": "Mar", "value": 0, "commentData": "message 12"}
      ]
    },
  ];
  static List<Map<String, Object>> resourceCostJSONData = [
    {
      "label": "Developer 1",
      "monthValues": [
        {"label": "APR", "value": 0},
        {"label": "MAY", "value": 0},
        {"label": "JUN", "value": 0},
        {"label": "JUL", "value": 0},
        {"label": "AUG", "value": 0},
        {"label": "SEPT", "value": 0},
        {"label": "OCT", "value": 0},
        {"label": "NOV", "value": 0},
        {"label": "DEC", "value": 0},
        {"label": "JAN", "value": 0},
        {"label": "FEB", "value": 0},
        {"label": "MAR", "value": 0}
      ]
    },
    {
      "label": "Developer 2",
      "monthValues": [
        {"label": "APR", "value": 0},
        {"label": "MAY", "value": 0},
        {"label": "JUN", "value": 0},
        {"label": "JUL", "value": 0},
        {"label": "AUG", "value": 0},
        {"label": "SEPT", "value": 0},
        {"label": "OCT", "value": 0},
        {"label": "NOV", "value": 0},
        {"label": "DEC", "value": 0},
        {"label": "JAN", "value": 0},
        {"label": "FEB", "value": 0},
        {"label": "MAR", "value": 0}
      ]
    },
    {
      "label": "Developer 3",
      "monthValues": [
        {"label": "APR", "value": 0},
        {"label": "MAY", "value": 0},
        {"label": "JUN", "value": 0},
        {"label": "JUL", "value": 0},
        {"label": "AUG", "value": 0},
        {"label": "SEPT", "value": 0},
        {"label": "OCT", "value": 0},
        {"label": "NOV", "value": 0},
        {"label": "DEC", "value": 0},
        {"label": "JAN", "value": 0},
        {"label": "FEB", "value": 0},
        {"label": "MAR", "value": 0}
      ]
    },
    {
      "label": "Developer 4",
      "monthValues": [
        {"label": "APR", "value": 0},
        {"label": "MAY", "value": 0},
        {"label": "JUN", "value": 0},
        {"label": "JUL", "value": 0},
        {"label": "AUG", "value": 0},
        {"label": "SEPT", "value": 0},
        {"label": "OCT", "value": 0},
        {"label": "NOV", "value": 0},
        {"label": "DEC", "value": 0},
        {"label": "JAN", "value": 0},
        {"label": "FEB", "value": 0},
        {"label": "MAR", "value": 0}
      ]
    },
    {
      "label": "Developer 5",
      "monthValues": [
        {"label": "APR", "value": 0},
        {"label": "MAY", "value": 0},
        {"label": "JUN", "value": 0},
        {"label": "JUL", "value": 0},
        {"label": "AUG", "value": 0},
        {"label": "SEPT", "value": 0},
        {"label": "OCT", "value": 0},
        {"label": "NOV", "value": 0},
        {"label": "DEC", "value": 0},
        {"label": "JAN", "value": 0},
        {"label": "FEB", "value": 0},
        {"label": "MAR", "value": 0}
      ]
    },
    {
      "label": "Developer 6",
      "monthValues": [
        {"label": "APR", "value": 0},
        {"label": "MAY", "value": 0},
        {"label": "JUN", "value": 0},
        {"label": "JUL", "value": 0},
        {"label": "AUG", "value": 0},
        {"label": "SEPT", "value": 0},
        {"label": "OCT", "value": 0},
        {"label": "NOV", "value": 0},
        {"label": "DEC", "value": 0},
        {"label": "JAN", "value": 0},
        {"label": "FEB", "value": 0},
        {"label": "MAR", "value": 0}
      ]
    }
  ];
  static List<Map<String, Object>> otherExpenseJSONData = [
    {
      "label": "Food",
      "monthValues": [
        {"label": "apr", "value": 0},
        {"label": "May", "value": 0},
        {"label": "Jun", "value": 0},
        {"label": "Jul", "value": 0},
        {"label": "Aug", "value": 0},
        {"label": "Sept", "value": 0},
        {"label": "Oct", "value": 0},
        {"label": "Nov", "value": 0},
        {"label": "Dec", "value": 0},
        {"label": "Jan", "value": 0},
        {"label": "Feb", "value": 0},
        {"label": "Mar", "value": 0}
      ]
    },
    {
      "label": "Food",
      "monthValues": [
        {"label": "apr", "value": 0},
        {"label": "May", "value": 0},
        {"label": "Jun", "value": 0},
        {"label": "Jul", "value": 0},
        {"label": "Aug", "value": 0},
        {"label": "Sept", "value": 0},
        {"label": "Oct", "value": 0},
        {"label": "Nov", "value": 0},
        {"label": "Dec", "value": 0},
        {"label": "Jan", "value": 0},
        {"label": "Feb", "value": 0},
        {"label": "Mar", "value": 0}
      ]
    },
  ];
  static List<Map<String, Object>> dashboardAndProjectDropdownJSONData = [
    {"label": "Travel Expense", "value": 1},
    {"label": "Hotel Accommodation", "value": 2},
    {"label": "Food", "value": 3},
    {"label": "Team Meeting", "value": 4},
    {"label": "Team Lunch", "value": 5}
  ];

  static List<DashboardAndProjectDropdown> dashboardAndProjectDropdownData =
      MasterData.dashboardAndProjectDropdownJSONData
          .map((e) => DashboardAndProjectDropdown.fromJson(e))
          .toList();

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

  static List dashboardAndProjectDataTableChart = [];

  /// OtherExpense DataTable

// Data of OtherExpense DataCells
  /// Resource Cost DataTable

// Data of Resource DataCells

  static int expenseMonthDataRows = 2;
}
