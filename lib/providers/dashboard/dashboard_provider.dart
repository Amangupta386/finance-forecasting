import 'package:ddofinance/models/dashboard/month_breakdown.dart';
import 'package:ddofinance/models/dashboard/other_expenses.dart';
import 'package:ddofinance/models/dashboard/resource_cost.dart';
import 'package:ddofinance/models/dropdown.dart';
import 'package:ddofinance/providers/navigation_rail_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/repository/dashboard/drop_down.dart';
import 'package:ddofinance/routing/app_router.dart';
import 'package:ddofinance/services/local_storage_service.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

///A provider class used for dashboard details.
class DashboardProvider extends ChangeNotifier {
  /// Dash Board Data


  late Map<String, List<DropDownModel>> dropDownData;
  List<DropDownModel> dropDownData1 = [];
  List<DropDownModel> dropDownData2 = [];
  List<DropDownModel> dropDownData3 = [];
  List<DropDownModel> dropDownData4 = [];

  String? selectedValue = 'Item 1';

  void addingDropDownValues() async {
    dropDownData = await DropDownRepository().dropDownRepository();
    dropDownData1 = dropDownData['result 1']!;
    dropDownData2 = dropDownData['result 2']!;
    dropDownData3 = dropDownData['result 3']!;
    dropDownData4 = dropDownData['result 4']!;
    notifyListeners();
  }

  void setValue(String value) {
    selectedValue = value;
    notifyListeners();
  }

  Future<void> navigationSelection(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    NavigationRailProvider navigationRailProvider =
    Provider.of<NavigationRailProvider>(context, listen: false);
    if (prefs.getBool('toMove')! == false) {
      navigationRailProvider.toggleSelected(0, null);
    } else {
      navigationRailProvider.toggleSelected(1, null);
    }
    notifyListeners();
  }
  /// Month By Month Break Down Data Table
  double boxPositionX = 0;
  double boxPositionY = 0;
  bool toggleCommentBox = false;

  //hovering on Icons for comment Box.
  late int commentRowIndex;
  late int commentColumnIndex;

  void openCommentBox(BuildContext context, TapDownDetails details,
      int rowIndex, int cellIndex) {
    commentRowIndex = rowIndex;
    commentColumnIndex = cellIndex;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    toggleCommentBox = true;
    boxPositionX = (isMonitor)
        ? localOffset.dx + 496
        : (isLaptop)
        ? localOffset.dx + 240
        : (isTablet)
        ? localOffset.dx + 238
        : localOffset.dx + 235;
    boxPositionY = (isMonitor)
        ? localOffset.dy - 28
        : (isLaptop)
        ? (!Provider.of<ProjectsProvider>(context, listen: false).toMoveNavigator)
        ? localOffset.dy -5
        : localOffset.dy - 30
        : (isTablet)
        ? localOffset.dy - 20
        : localOffset.dy - 20;
    notifyListeners();
  }


  late List<List<TextEditingController>> monthBreakdownCommentTextController;
  void closeCommentBox() {
    toggleCommentBox = false;
    notifyListeners();
  }

  List<ResourceCostModel> dashboardAndProjectResourceCostData = MasterData
      .resourceCostJSONData
      .map((e) => ResourceCostModel.fromJson(e))
      .toList();


  /// Other Expense Data Table
  //Table Dropdown
  String searchQuery = '';
  double _dropDownPositionX = 0;
  double _dropDownPositionY = 0;
  get getDropDownPositionX => _dropDownPositionX;
  get getDropDownPositionY => _dropDownPositionY;
  set setDropDownPositionX(double x) => _dropDownPositionX = x;
  set setDropDownPositionY(double y) => _dropDownPositionY = y;
  int dropdownIndex = 0;

  void showingDropDown(TapDownDetails details, BuildContext context,
      OtherExpenseModel rowData, GlobalKey widgetKey) {
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    rowData.isDropdownIndexOpen = !rowData.isDropdownIndexOpen;

    dropdownIndex = rowData.customDropDown.index;
    RenderBox renderBox = widgetKey.currentContext?.findRenderObject() as RenderBox;
    Offset widgetPosition = renderBox.localToGlobal(Offset.zero);
    _dropDownPositionX =
    (isMonitor) ? widgetPosition.dy + 30 : widgetPosition.dy - 25;
    _dropDownPositionY = (isMonitor)
        ? widgetPosition.dx - 130
        : (isLaptop)
        ? widgetPosition.dx - 313
        : widgetPosition.dx - 35;


    notifyListeners();
  }

  void selectOption(
      String option,
      OtherExpenseModel rowData,

      ) {
    rowData.label = option;
    rowData.isDropdownIndexOpen = false;
    var provider = Provider.of<DashboardProvider>(rootNavigatorKey.currentState!.context,  listen: false);
    provider.dashboardAndProjectOtherExpenseModelData[rowData.customDropDown.index].label = option;
    notifyListeners();
  }
  int addRowIndex = 1;
  List<OtherExpenseModel> dashboardAndProjectOtherExpenseData = MasterData
      .otherExpenseJSONData
      .map((e) => OtherExpenseModel.fromJson(e))
      .toList();

  List<MonthBreakdownModel> dashboardAndProjectMonthBreakdownData = [
    for (int index = 0; index < MasterData.monthBreakdownJSONData.length; index++)
      ...[ MonthBreakdownModel.fromJson({...MasterData.monthBreakdownJSONData[index], 'isDottedLine': false}),

        if (index == 4 || index == 5)
          MonthBreakdownModel.fromJson(
              {...MasterData.monthBreakdownJSONData[index], 'isDottedLine': true})
      ],
  ].toList();

  void updateDashboardAndProjectMonthBreakdownData() async{
    var prefs = await SharedPreferences.getInstance();
   if(prefs.getString(Labels.resourceCostKey) != null){
     List<MonthBreakdownModel> data = await DashboardProjectLocalStorage.getMonthBreakdownData();
     if(data.isNotEmpty) {
       dashboardAndProjectMonthBreakdownData = data;
     }
     dashboardAndProjectResourceCostData = await DashboardProjectLocalStorage.getResourceCostData();
     dashboardAndProjectOtherExpenseModelData = await DashboardProjectLocalStorage.getOtherExpenseData();
   }
    notifyListeners();
  }

  List<OtherExpenseModel> dashboardAndProjectOtherExpenseModelData = [];
  List<ResourceCostModel> dashboardAndProjectResourcesCostData = MasterData
      .resourceCostJSONData
      .map((e) => ResourceCostModel.fromJson(e))
      .toList();

  List<OtherExpenseModel> addExpensesRow() {
    OtherExpenseModel model = OtherExpenseModel.fromJson({
      for (int index = 0; index < MasterData.otherExpenseJSONData.length; index++)
        ...MasterData.otherExpenseJSONData[index],
      "index": dashboardAndProjectOtherExpenseModelData.length
    });
    dashboardAndProjectOtherExpenseModelData.add(model);
    return dashboardAndProjectOtherExpenseModelData;
  }

  void lastRowBar(String headingText) {
    (headingText == Labels.otherExpense) ? addExpensesRow() : showMoreRows();
    notifyListeners();
  }

  int visibleRowCount = 3;
  void showMoreRows() {
    visibleRowCount += 3;
    notifyListeners();
  }
}
