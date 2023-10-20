import 'package:ddofinance/models/dashboard/dashboard_project_dropdown.dart';
import 'package:ddofinance/models/dashboard/other_expenses.dart';
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CustomDropdown extends StatelessWidget {
  final int index;
  final String selectedValue;
  CustomDropdown({super.key, required this.index, required this.selectedValue});

  GlobalKey widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    DashboardProvider provider = Provider.of<DashboardProvider>(context, listen: true);
    final theme = Theme.of(context);
    final bool isAndroid = DeviceOS.isAndroid;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    return (Provider.of<ProjectsProvider>(context).toMove == true)? Container(
      margin: EdgeInsets.all(Insets.s4),
      width: 164,
      height: 48,
      padding: EdgeInsets.all(Insets.s4),
      decoration: BoxDecoration(
        border: Border.all(color: kGrey),
        borderRadius: BorderRadius.circular(Insets.s4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              softWrap:true,
              provider.dropDownInitialValue[index!],
              style: (isAndroid)
                  ? theme.textTheme.titleMedium!
                      .copyWith(fontSize: FontSizes.s7)
                  : (isMonitor || isLaptop)
                      ? theme.textTheme.titleMedium!.copyWith(
                          fontSize: FontSizes.s14,
                        )
                      : (isTablet)
                          ? theme.textTheme.titleMedium!.copyWith(
                              fontSize: FontSizes.s12,
                            )
                          : theme.textTheme.titleMedium!.copyWith(
                              fontSize: FontSizes.s10,
                            ),
            ),
          ),
          GestureDetector(
            onTapDown: (details) {
              provider.showingDropDown(
                  details, context, index!, widgetKey);
            },
            child: Icon(
              key: widgetKey,
              provider.isDropdownIndexOpen[index!]
                  ? MaterialIcons.keyboardArrowDown
                  : MaterialIcons.keyboardArrowUp,
              color: kGrey,
            ),
          ),
        ],
      ),
    ): Text(provider.dropDownInitialValue[index!],);
  }
}

class DropDown extends StatefulWidget {
  final int index;
  const DropDown({Key? key, required this.index}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  GlobalKey widgetKey = GlobalKey();

  int index = 0;

  List<DashboardAndProjectDropdown> getFilteredOptions() {
    index = 0;
    return MasterData.dashboardAndProjectDropdownData.where((option) {
      return option.label
          .toLowerCase()
          .contains(Labels.searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size mQ = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final bool isAndroid = DeviceScreen.isLargePhone(context);
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    DashboardProvider provider = Provider.of<DashboardProvider>(context, listen: false);
    return Container(
      width: mQ.width / 7.5,
      height: mQ.width / 6,
      margin: EdgeInsets.only(top: Insets.s5),
      decoration: BoxDecoration(
        border: Border.all(color: kGrey),
        borderRadius: BorderRadius.circular(Insets.s4),
        color: kWhite,
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(Insets.s10),
            child: Material(
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    Labels.searchQuery = query;
                  });
                },
                decoration: const InputDecoration(
                    hintText: 'Search', border: OutlineInputBorder()),
              ),
            ),
          ),
          ...getFilteredOptions().map((option) {
            if(widget.index == 0 || widget.index ==1){
              MasterData.dashboardAndProjectOtherExpenseData[widget.index].label = option.label;
            }
            index++;
            return (index == 1 || index == 4)
                ? Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(Insets.s10),
                    child: Text(
                      option.label,
                      style: (isAndroid)
                          ? theme.textTheme.titleMedium!
                              .copyWith(fontSize: FontSizes.s7)
                          : (isMonitor || isLaptop)
                              ? theme.textTheme.titleMedium!.copyWith(
                                  fontSize: FontSizes.s18,
                                )
                              : (isTablet)
                                  ? theme.textTheme.titleMedium!.copyWith(
                                      fontSize: FontSizes.s12,
                                    )
                                  : theme.textTheme.titleMedium!.copyWith(
                                      fontSize: FontSizes.s10,
                                    ),
                    ),
                  )
                : GestureDetector(
                    onTap: () => provider.selectOption(option.label, widget.index),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(
                          left: Insets.s30,
                          right: Insets.s10,
                          top: Insets.s10,
                          bottom: Insets.s10),
                      child: Text(
                        option.label,
                        style: TextStyle(
                            fontSize: FontSizes.s16,
                            // fontWeight: FontWeight.bold,
                            color: kBlack),
                      ),
                    ),
                  );
          }).toList(),
        ],
      ),
    );
  }
}
