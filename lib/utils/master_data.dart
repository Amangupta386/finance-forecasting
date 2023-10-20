import 'package:ddofinance/models/dashboard/add_row_other_expense.dart';
import 'package:ddofinance/models/dashboard/dashboard.dart';
import 'package:ddofinance/models/dashboard/dashboard_project_dropdown.dart';
import 'package:ddofinance/models/dashboard/other_expenses.dart';
import 'package:ddofinance/models/dashboard/resource_cost.dart';
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
        {
          "label": "Apr",
          "value": 1,
          "commentData":"message 1"
        },
        {
          "label": "May",
          "value": 2,
          "commentData":"message 2"
        },
        {
          "label": "Jun",
          "value": 3,
          "commentData":"message 3"
        },
        {
          "label": "Jul",
          "value": 4,
          "commentData":"message 4"
        },
        {
          "label": "Aug",
          "value": 5,
          "commentData":"message 5"
        },
        {
          "label": "Sept",
          "value": 6,
          "commentData":"message 6"
        },
        {
          "label": "Oct",
          "value": 7,
          "commentData":"message 7"
        },
        {
          "label": "Nov",
          "value": 8,
          "commentData":"message 8"
        },
        {
          "label": "Dec",
          "value": 9,
          "commentData":"message 9"
        },
        {
          "label": "Jan",
          "value": 10,
          "commentData":"message 10"
        },
        {
          "label": "Feb",
          "value": 11,
          "commentData":"message 11"
        },
        {
          "label": "Mar",
          "value": 12,
          "commentData":"message 12"
        }
      ]
    },
    {
      "label": "Actual Revenue",
      "monthValues": [
        {
          "label": "Apr",
          "value": 1,
          "commentData":"message 1"
        },
        {
          "label": "May",
          "value": 2,
          "commentData":"message 2"
        },
        {
          "label": "Jun",
          "value": 3,
          "commentData":"message 3"
        },
        {
          "label": "Jul",
          "value": 4,
          "commentData":"message 4"
        },
        {
          "label": "Aug",
          "value": 5,
          "commentData":"message 5"
        },
        {
          "label": "Sept",
          "value": 6,
          "commentData":"message 6"
        },
        {
          "label": "Oct",
          "value": 7,
          "commentData":"message 7"
        },
        {
          "label": "Nov",
          "value": 8,
          "commentData":"message 8"
        },
        {
          "label": "Dec",
          "value": 9,
          "commentData":"message 9"
        },
        {
          "label": "Jan",
          "value": 10,
          "commentData":"message 10"
        },
        {
          "label": "Feb",
          "value": 11,
          "commentData":"message 11"
        },
        {
          "label": "Mar",
          "value": 12,
          "commentData":"message 12"
        }
      ]
    },
    {
      "label": "Forecasted Collection",
      "monthValues": [
        {
          "label": "Apr",
          "value": 1,
          "commentData":"message 1"
        },
        {
          "label": "May",
          "value": 2,
          "commentData":"message 2"
        },
        {
          "label": "Jun",
          "value": 3,
          "commentData":"message 3"
        },
        {
          "label": "Jul",
          "value": 4,
          "commentData":"message 4"
        },
        {
          "label": "Aug",
          "value": 5,
          "commentData":"message 5"
        },
        {
          "label": "Sept",
          "value": 6,
          "commentData":"message 6"
        },
        {
          "label": "Oct",
          "value": 7,
          "commentData":"message 7"
        },
        {
          "label": "Nov",
          "value": 8,
          "commentData":"message 8"
        },
        {
          "label": "Dec",
          "value": 9,
          "commentData":"message 9"
        },
        {
          "label": "Jan",
          "value": 10,
          "commentData":"message 10"
        },
        {
          "label": "Feb",
          "value": 11,
          "commentData":"message 11"
        },
        {
          "label": "Mar",
          "value": 12,
          "commentData":"message 12"
        }
      ]
    },
    {
      "label": "Actual Collection",
      "monthValues": [
        {
          "label": "Apr",
          "value": 1,
          "commentData":"message 1"
        },
        {
          "label": "May",
          "value": 2,
          "commentData":"message 2"
        },
        {
          "label": "Jun",
          "value": 3,
          "commentData":"message 3"
        },
        {
          "label": "Jul",
          "value": 4,
          "commentData":"message 4"
        },
        {
          "label": "Aug",
          "value": 5,
          "commentData":"message 5"
        },
        {
          "label": "Sept",
          "value": 6,
          "commentData":"message 6"
        },
        {
          "label": "Oct",
          "value": 7,
          "commentData":"message 7"
        },
        {
          "label": "Nov",
          "value": 8,
          "commentData":"message 8"
        },
        {
          "label": "Dec",
          "value": 9,
          "commentData":"message 9"
        },
        {
          "label": "Jan",
          "value": 10,
          "commentData":"message 10"
        },
        {
          "label": "Feb",
          "value": 11,
          "commentData":"message 11"
        },
        {
          "label": "Mar",
          "value": 12,
          "commentData":"message 12"
        }
      ]
    },
    {
      "label": "Monthly Cost",
      "monthValues": [
        {
          "label": "Apr",
          "value": 1,
          "commentData":"message 1"
        },
        {
          "label": "May",
          "value": 2,
          "commentData":"message 2"
        },
        {
          "label": "Jun",
          "value": 3,
          "commentData":"message 3"
        },
        {
          "label": "Jul",
          "value": 4,
          "commentData":"message 4"
        },
        {
          "label": "Aug",
          "value": 5,
          "commentData":"message 5"
        },
        {
          "label": "Sept",
          "value": 6,
          "commentData":"message 6"
        },
        {
          "label": "Oct",
          "value": 7,
          "commentData":"message 7"
        },
        {
          "label": "Nov",
          "value": 8,
          "commentData":"message 8"
        },
        {
          "label": "Dec",
          "value": 9,
          "commentData":"message 9"
        },
        {
          "label": "Jan",
          "value": 10,
          "commentData":"message 10"
        },
        {
          "label": "Feb",
          "value": 11,
          "commentData":"message 11"
        },
        {
          "label": "Mar",
          "value": 12,
          "commentData":"message 12"
        }
      ]
    },
    {
      "label": "Monthly Deviation",
      "monthValues": [
        {
          "label": "Apr",
          "value": 1,
          "commentData":"message 1"
        },
        {
          "label": "May",
          "value": 2,
          "commentData":"message 2"
        },
        {
          "label": "Jun",
          "value": 3,
          "commentData":"message 3"
        },
        {
          "label": "Jul",
          "value": 4,
          "commentData":"message 4"
        },
        {
          "label": "Aug",
          "value": 5,
          "commentData":"message 5"
        },
        {
          "label": "Sept",
          "value": 6,
          "commentData":"message 6"
        },
        {
          "label": "Oct",
          "value": 7,
          "commentData":"message 7"
        },
        {
          "label": "Nov",
          "value": 8,
          "commentData":"message 8"
        },
        {
          "label": "Dec",
          "value": 9,
          "commentData":"message 9"
        },
        {
          "label": "Jan",
          "value": 10,
          "commentData":"message 10"
        },
        {
          "label": "Feb",
          "value": 11,
          "commentData":"message 11"
        },
        {
          "label": "Mar",
          "value": 12,
          "commentData":"message 12"
        }
      ]
    }
  ];
  static List<Map<String, Object>> resourceCostJSONData = [
    {
      "label": "Developer 1",
      "monthValues": [
        {"label": "APR", "value": 1},
        {"label": "MAY", "value": 2},
        {"label": "JUN", "value": 3},
        {"label": "JUL", "value": 4},
        {"label": "AUG", "value": 5},
        {"label": "SEPT", "value": 6},
        {"label": "OCT", "value": 7},
        {"label": "NOV", "value": 8},
        {"label": "DEC", "value": 9},
        {"label": "JAN", "value": 10},
        {"label": "FEB", "value": 11},
        {"label": "MAR", "value": 12}
      ]
    },
    {
      "label": "Developer 2",
      "monthValues": [
        {"label": "APR", "value": 11},
        {"label": "MAY", "value": "22"},
        {"label": "JUN", "value": "13"},
        {"label": "JUL", "value": "14"},
        {"label": "AUG", "value": "15"},
        {"label": "SEPT", "value": "16"},
        {"label": "OCT", "value": "17"},
        {"label": "NOV", "value": "18"},
        {"label": "DEC", "value": "19"},
        {"label": "JAN", "value": "20"},
        {"label": "FEB", "value": "11"},
        {"label": "MAR", "value": "12"}
      ]
    },
    {
      "label": "Developer 3",
      "monthValues": [
        {"label": "APR", "value": 1},
        {"label": "MAY", "value": "2"},
        {"label": "JUN", "value": "3"},
        {"label": "JUL", "value": "4"},
        {"label": "AUG", "value": "5"},
        {"label": "SEPT", "value": "6"},
        {"label": "OCT", "value": "7"},
        {"label": "NOV", "value": "8"},
        {"label": "DEC", "value": "9"},
        {"label": "JAN", "value": "10"},
        {"label": "FEB", "value": "11"},
        {"label": "MAR", "value": "12"}
      ]
    },
    {
      "label": "Developer 4",
      "monthValues": [
        {"label": "APR", "value": 1},
        {"label": "MAY", "value": "2"},
        {"label": "JUN", "value": "3"},
        {"label": "JUL", "value": "4"},
        {"label": "AUG", "value": "5"},
        {"label": "SEPT", "value": "6"},
        {"label": "OCT", "value": "7"},
        {"label": "NOV", "value": "8"},
        {"label": "DEC", "value": "9"},
        {"label": "JAN", "value": "10"},
        {"label": "FEB", "value": "11"},
        {"label": "MAR", "value": "12"}
      ]
    },
    {
      "label": "Developer 5",
      "monthValues": [
        {"label": "APR", "value": 1},
        {"label": "MAY", "value": "2"},
        {"label": "JUN", "value": "3"},
        {"label": "JUL", "value": "4"},
        {"label": "AUG", "value": "5"},
        {"label": "SEPT", "value": "6"},
        {"label": "OCT", "value": "7"},
        {"label": "NOV", "value": "8"},
        {"label": "DEC", "value": "9"},
        {"label": "JAN", "value": "10"},
        {"label": "FEB", "value": "11"},
        {"label": "MAR", "value": "12"}
      ]
    },
    {
      "label": "Developer 6",
      "monthValues": [
        {"label": "APR", "value": 1},
        {"label": "MAY", "value": "2"},
        {"label": "JUN", "value": "3"},
        {"label": "JUL", "value": "4"},
        {"label": "AUG", "value": "5"},
        {"label": "SEPT", "value": "6"},
        {"label": "OCT", "value": "7"},
        {"label": "NOV", "value": "8"},
        {"label": "DEC", "value": "9"},
        {"label": "JAN", "value": "10"},
        {"label": "FEB", "value": "11"},
        {"label": "MAR", "value": "12"}
      ]
    }
  ];
  static List<Map<String, Object>> otherExpenseJSONData = [
    {
      "label": "Food",
      "monthValues": [
        {
          "label": "apr",
          "value": 1
        },
        {
          "label": "May",
          "value": 2
        },
        {
          "label": "Jun",
          "value": 3
        },
        {
          "label": "Jul",
          "value": 4
        },
        {
          "label": "Aug",
          "value": 5
        },
        {
          "label": "Sept",
          "value": 6
        },
        {
          "label": "Oct",
          "value": 7
        },
        {
          "label": "Nov",
          "value": 8
        },
        {
          "label": "Dec",
          "value": 9
        },
        {
          "label": "Jan",
          "value": 10
        },
        {
          "label": "Feb",
          "value": 11
        },
        {
          "label": "Mar",
          "value": 12
        }
      ]
    },
    {
      "label": "Food",
      "monthValues": [
        {
          "label": "apr",
          "value": 1
        },
        {
          "label": "May",
          "value": 2
        },
        {
          "label": "Jun",
          "value": 3
        },
        {
          "label": "Jul",
          "value": 4
        },
        {
          "label": "Aug",
          "value": 5
        },
        {
          "label": "Sept",
          "value": 6
        },
        {
          "label": "Oct",
          "value": 7
        },
        {
          "label": "Nov",
          "value": 8
        },
        {
          "label": "Dec",
          "value": 9
        },
        {
          "label": "Jan",
          "value": 10
        },
        {
          "label": "Feb",
          "value": 11
        },
        {
          "label": "Mar",
          "value": 12
        }
      ]
    },
  ];
  static List<Map<String, Object>> dashboardAndProjectDropdownJSONData = [
    {
      "label": "Travel Expense",
      "value": 1
    },
    {
      "label": "Hotel Accomdation",
      "value": 2
    },
    {
      "label": "Food",
      "value": 3
    },
    {
      "label": "Team Meeting",
      "value": 4
    },
    {
      "label": "Team Lunch",
      "value": 5
    }
  ];
  static List<Map<String, Object>> addRowOtherExpenseJSONData = [{
    "label": "Food",
    "monthValues": [
      {
        "label": "apr",
        "value": 1
      },
      {
        "label": "May",
        "value": 2
      },
      {
        "label": "Jun",
        "value": 3
      },
      {
        "label": "Jul",
        "value": 4
      },
      {
        "label": "Aug",
        "value": 5
      },
      {
        "label": "Sept",
        "value": 6
      },
      {
        "label": "Oct",
        "value": 7
      },
      {
        "label": "Nov",
        "value": 8
      },
      {
        "label": "Dec",
        "value": 9
      },
      {
        "label": "Jan",
        "value": 10
      },
      {
        "label": "Feb",
        "value": 11
      },
      {
        "label": "Mar",
        "value": 12
      }
    ]
  }, {
    "label": "Food",
    "monthValues": [
      {
        "label": "apr",
        "value": 1
      },
      {
        "label": "May",
        "value": 2
      },
      {
        "label": "Jun",
        "value": 3
      },
      {
        "label": "Jul",
        "value": 4
      },
      {
        "label": "Aug",
        "value": 5
      },
      {
        "label": "Sept",
        "value": 6
      },
      {
        "label": "Oct",
        "value": 7
      },
      {
        "label": "Nov",
        "value": 8
      },
      {
        "label": "Dec",
        "value": 9
      },
      {
        "label": "Jan",
        "value": 10
      },
      {
        "label": "Feb",
        "value": 11
      },
      {
        "label": "Mar",
        "value": 12
      }
    ]
  }];

  static List<MonthBreakdownModel> dashboardAndProjectMonthlyData =
      MasterData.monthBreakdownJSONData
          .map((e) => MonthBreakdownModel.fromJson(e))
          .toList();

  static List<ResourceCostModel> dashboardAndProjectResourceCostData =
      MasterData.resourceCostJSONData
          .map((e) => ResourceCostModel.fromJson(e))
          .toList();

  static List<OtherExpenseModel> dashboardAndProjectOtherExpenseData =
  MasterData.otherExpenseJSONData
      .map((e) => OtherExpenseModel.fromJson(e))
      .toList();

  static List<DashboardAndProjectDropdown> dashboardAndProjectDropdownData = MasterData.dashboardAndProjectDropdownJSONData
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

  static List dashboardAndProjectDataTableChart = [

  ];

  /// OtherExpense DataTable

// Data of OtherExpense DataCells
  /// Resource Cost DataTable

// Data of Resource DataCells
  static List<String> dashboardAndProjectResourcesCost = [
    for (int i = 0; i < 100; i++) Labels.developerList[i]
  ];

  static List<String> dashboardAndProjectResourceTotalFYValue =
      List.generate(dashboardAndProjectResourcesCost.length, (_) => '0');

  static List<String> dashboardAndProjectResourceTotalYTDValue =
      List.generate(dashboardAndProjectResourcesCost.length, (_) => '0');

  static List<List<String>> dashboardAndProjectResourceDataCellValue =
      List.generate(
          dashboardAndProjectResourcesCost.length,
          (_) =>
              List.filled(dashboardAndProjectResourceTotalFYValue.length, '0'));

  static int expenseMonthDataRows = 2;
}
