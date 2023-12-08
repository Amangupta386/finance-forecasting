import 'package:collection/collection.dart';
import 'package:ddofinance/models/dashboard/dropdown.dart';
import 'package:ddofinance/models/dashboard/other_expenses.dart';
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/dashBoard/category_sub_category_alertbox.dart';
import 'package:ddofinance/services/local_storage_service.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/widgets/loaders/all_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDropdown extends StatelessWidget {
  final OtherExpenseModel rowsData;
  const CustomDropdown({super.key, required this.rowsData});

  @override
  Widget build(BuildContext context) {
    GlobalKey widgetKey = GlobalKey();
    final theme = Theme.of(context);
    final ColorScheme colorTheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    final bool isAndroid = DeviceOS.isAndroid;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    final DashboardProvider provider = Provider.of<DashboardProvider>(context);

    if ((Provider.of<ProjectsProvider>(context).toMoveNavigator == true)) {
      return Container(
        margin: EdgeInsets.all(Insets.s4),
        width: 164,
        height: 48,
        padding: EdgeInsets.all(Insets.s2),
        decoration: BoxDecoration(
          border: Border.all(color: colorTheme.onPrimary),
          borderRadius: BorderRadius.circular(Insets.s4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                softWrap: true,
                rowsData.label,
                style: (isAndroid)
                    ? textTheme.titleMedium!.copyWith(fontSize: FontSizes.s7)
                    : (isMonitor || isLaptop)
                        ? textTheme.titleMedium!.copyWith(
                            fontSize: FontSizes.s12,
                          )
                        : (isTablet)
                            ? textTheme.titleMedium!.copyWith(
                                fontSize: FontSizes.s12,
                              )
                            : textTheme.titleMedium!.copyWith(
                                fontSize: FontSizes.s10,
                              ),
              ),
            ),
            GestureDetector(
              onTapDown: (details) {
                provider.showingDropDown(details, context, rowsData, widgetKey);
              },
              child: Icon(
                key: widgetKey,
                rowsData.isDropdownIndexOpen
                    ? MaterialIcons.keyboardArrowDown
                    : MaterialIcons.keyboardArrowUp,
                color: colorTheme.onPrimary,
              ),
            )
          ],
        ),
      );
    } else {
      return Text(rowsData.label);
    }
  }
}

class DropDown extends StatefulWidget {
  final OtherExpenseModel rowData;
  const DropDown({super.key, required this.rowData});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  GlobalKey widgetKey = GlobalKey();


  List<SubCategory> getFilteredSubCategoryOptions() {
    return [
      ...provider.categorySubcategoryData.map((e) => e.children!).flattened
    ].where((option) {
      return option.name
          .toLowerCase()
          .contains(Labels.searchCategoryQuery.toLowerCase());
    }).toList();
  }

  List<ExpenseCategoryAndSubCategory> getFilteredCategoryOptions() {
    return provider.categorySubcategoryData.where((option) {
      return option.name!
          .toLowerCase()
          .contains(Labels.searchCategoryQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size mQ = MediaQuery.of(context).size;
    DashboardProvider provider = Provider.of<DashboardProvider>(context);
    final theme = Theme.of(context);
    final ColorScheme colorTheme = theme.colorScheme;
    final bool isAndroid = DeviceScreen.isLargePhone(context);
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final bool isTablet = DeviceScreen.isTablet(context);
    return FutureBuilder(
      future: provider.categorySubCategoryList(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Container(
            width: mQ.width / 7,
            height: mQ.width / 6,
            margin: EdgeInsets.only(top: Insets.s5),
            decoration: BoxDecoration(
              border: Border.all(color: colorTheme.onPrimary),
              borderRadius: BorderRadius.circular(Insets.s4),
              color: colorTheme.secondary,
            ),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: EdgeInsets.all(Insets.s10),
                  child: Material(
                    child: TextField(
                      onChanged: (query) {
                        Labels.searchCategoryQuery = query;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          hintText: Labels.search,
                          border: const OutlineInputBorder()),
                    ),
                  ),
                ),
                ...getFilteredCategoryOptions().mapIndexed((index, option) {
                  return Column(
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(Insets.s10),
                          child: GestureDetector(
                            onTap: () {
                              try{
                                provider.selectedCategoryId = option.id!;
                              }catch(e){
                                throw'Error !!! $e';
                              }
                              provider.selectedCategoryValue = option.name!;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CategorySubcategoryAlert(widgetList: [
                                    const Text(
                                      "Enter Sub Categories",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(provider.selectedCategoryValue),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(onSaved: (value) {
                                      provider.addSubCategoryDropdown(value!, provider.selectedCategoryId);
                                    }),
                                  ], formKey: _formKey1);
                                },
                              );
                            },
                            child: RichText(
                                text: TextSpan(
                                    text: option.name!,
                                    style: (isAndroid)
                                        ? theme.textTheme.titleMedium!.copyWith(
                                        fontSize: FontSizes.s7,
                                        color: colorTheme.onPrimary)
                                        : (isMonitor || isLaptop)
                                        ? theme.textTheme.titleMedium!.copyWith(
                                        fontSize: FontSizes.s18,
                                        color: colorTheme.onPrimary)
                                        : (isTablet)
                                        ? theme.textTheme.titleMedium!
                                        .copyWith(
                                        fontSize: FontSizes.s12,
                                        color: colorTheme.onPrimary)
                                        : theme.textTheme.titleMedium!
                                        .copyWith(
                                        fontSize: FontSizes.s10,
                                        color: colorTheme.onPrimary),
                                    children: const [
                                      TextSpan(
                                        text: ' (+)',
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ])),
                          )),
                      ...option.children!.map((option) {
                        return GestureDetector(
                          onTap: () =>
                              provider.selectOption(option.name, widget.rowData),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(
                                left: Insets.s30,
                                right: Insets.s10,
                                top: Insets.s10,
                                bottom: Insets.s10),
                            child: Column(
                              children: [
                                Text(
                                  option.name,
                                  style: (isAndroid)
                                      ? theme.textTheme.titleMedium!
                                      .copyWith(fontSize: FontSizes.s7)
                                      : (isMonitor || isLaptop)
                                      ? theme.textTheme.titleMedium!.copyWith(
                                    fontSize: FontSizes.s16,
                                  )
                                      : (isTablet)
                                      ? theme.textTheme.titleMedium!.copyWith(
                                    fontSize: FontSizes.s12,
                                  )
                                      : theme.textTheme.titleMedium!.copyWith(
                                    fontSize: FontSizes.s10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                }),
                if (Labels.searchCategoryQuery != '' &&
                    getFilteredCategoryOptions().isEmpty)
                  ...getFilteredSubCategoryOptions().map((option) {
                    return GestureDetector(
                      onTap: () => provider.selectOption(option.name, widget.rowData),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(
                                left: Insets.s30,
                                right: Insets.s10,
                                top: Insets.s10,
                                bottom: Insets.s10),
                            child: Text(
                              option.name,
                              style: TextStyle(
                                  fontSize: FontSizes.s16,
                                  color: colorTheme.onBackground),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CategorySubcategoryAlert(widgetList: [
                            const Text(
                              "Enter a Category",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(onSaved: (value) {
                              provider.addCategoryDropdown(value!);
                            }),
                          ], formKey: _formKey);
                        },
                      );
                      setState(() {});
                    },
                    child: const Text(
                      'Add Category',
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
          );
        }
        else{
          return CircularLoader();
        }
      },
    );
  }
}
