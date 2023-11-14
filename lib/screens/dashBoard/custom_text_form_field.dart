import 'package:ddofinance/models/dashboard/month_breakdown.dart';
import 'package:ddofinance/models/dashboard/other_expenses.dart';
import 'package:ddofinance/models/dashboard/resource_cost.dart';
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/common_methods.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextFormField extends StatefulWidget {
  final int rowIndex;
  final OtherExpenseModel? expenseRowData;
  final ResourceCostModel? resourceRowData;
  final MonthBreakdownModel? monthBreakdownRowData;

  final int cellIndex;
  final String textFormFieldName;
  final int rowLength;
  final int colLength;

  const CustomTextFormField(
      {super.key,
      this.rowIndex = 0,
      required this.cellIndex,
      required this.textFormFieldName,
      required this.rowLength,
      required this.colLength,
      this.expenseRowData, this.resourceRowData, this.monthBreakdownRowData});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}
// dashboardAndProjectResourceCostData

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode textFocusNode;
  String valueData = '';
  @override
  void initState() {
    // TODO: implement initState
    textFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DashboardProvider>(context);
    final bool isAndroid = DeviceOS.isAndroid;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final theme = Theme.of(context);
    final ColorScheme colorTheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    final OutlineInputBorder customOutlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
          color:
          //(provider.isValidMonthBreakdown[widget.rowIndex]
              //  [widget.cellIndex])
              // ? colorTheme.onTertiaryContainer
              //:
              colorTheme.onPrimary,
          width: 1.0),
      borderRadius:
          BorderRadius.circular(4.0), // You can adjust the border radius
    );

    final textFieldStyle = (isAndroid)
        ? textTheme.titleMedium!.copyWith(
            fontSize: FontSizes.s14,
          )
        : (isMonitor)
            ? textTheme.titleMedium!.copyWith(
                fontSize: FontSizes.s20,
              )
            : (isLaptop)
                ? textTheme.titleMedium!.copyWith(
                    fontSize: FontSizes.s16,
                  )
                : textTheme.titleMedium!.copyWith(
                    fontSize: FontSizes.s16,
                  );

    return Focus(
        // focusNode: textFocusNode,
        onKey: CommonMethods.changeFormFieldFocus,
        child: Padding(
          padding:
              (widget.textFormFieldName == Labels.monthBreakdownTextField &&
                      widget.monthBreakdownRowData!.isSelect
                  // false
              )
                  ? const EdgeInsets.all(0)
                  : EdgeInsets.only(
                      left: Insets.s3,
                      top: Insets.s8,
                      bottom: Insets.s3,
                      right: Insets.s8),
          child: TextFormField(
            controller: (widget.textFormFieldName ==
                    Labels.monthBreakdownTextField)
                ? widget.monthBreakdownRowData!.monthValues[widget.cellIndex].controller
                : (widget.textFormFieldName == Labels.expenseMonthTextField)
                    ? widget.expenseRowData!.monthValues[widget.cellIndex].controller
                    : (widget.textFormFieldName ==
                            Labels.resourceMonthTextField)
                        ? widget.resourceRowData!.monthValues[widget.cellIndex].controller
                        : null,
            validator: TextFieldValidation.validateInput,
            onChanged: (value) {

              if (widget.textFormFieldName == Labels.monthBreakdownTextField) {
                widget.monthBreakdownRowData!.monthValues[widget.cellIndex].value = value;
              }

              if (widget.textFormFieldName == Labels.expenseMonthTextField) {
                widget.expenseRowData!.monthValues[widget.cellIndex].value = value;
              }

              if (widget.textFormFieldName == Labels.resourceMonthTextField) {
                widget.resourceRowData!.monthValues[widget.cellIndex].value = value;
              }
            },
            maxLength: 11,
            autofocus: true,
            readOnly:
                (Provider.of<ProjectsProvider>(context).toMoveNavigator) ? false : true,
            decoration: (widget.textFormFieldName ==
                        Labels.monthBreakdownTextField && //false
                    widget.monthBreakdownRowData!.isSelect
            )
                ? InputDecoration(
                    enabledBorder: customOutlineInputBorder,
                    counterText: '',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: (widget.monthBreakdownRowData!.monthValues[widget.cellIndex].isValid)
                          ?  colorTheme.onBackground
                          : colorTheme.onTertiaryContainer,
                    )),
                  )
                : const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
            style: textFieldStyle,
          ),
        ));
  }
}
