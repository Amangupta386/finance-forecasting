import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/common_methods.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:ddofinance/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextFormField extends StatefulWidget {
  final int rowIndex;
  final int cellIndex;
  final String textFormFieldName;
  final int rowLength;
  final int colLength;

  CustomTextFormField(
      {super.key,
      required this.rowIndex,
      required this.cellIndex,
      required this.textFormFieldName,
      required this.rowLength,
      required this.colLength});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}
// dashboardAndProjectResourceCostData

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode textFocusNode;
  @override
  void initState() {
    // TODO: implement initState
    var provider = Provider.of<DashboardProvider>(context, listen: false);
    if (widget.textFormFieldName == Labels.monthBreakdownTextField) {
      provider.monthBreakdownTextController =
          List.generate(widget.rowLength, (rowIndex) {
        if (rowIndex >= 0 && rowIndex < 5) {
          return List.generate(widget.colLength, (cellIndex) {
            return TextEditingController(
                text: MasterData.dashboardAndProjectMonthlyData[rowIndex]
                    .monthValues?[cellIndex].value
                    .toString());
          });
        } else if (rowIndex == 5 && rowIndex == 7) {
          return List.generate(widget.colLength, (cellIndex) {
            return TextEditingController(text: '0');
          });
        } else {
          return List.generate(widget.colLength, (cellIndex) {
            return TextEditingController(
                text: MasterData.dashboardAndProjectMonthlyData[5]
                    .monthValues?[cellIndex].value
                    .toString());
          });
        }
      });
    }
    // dashboardAndProjectOtherExpenseData
    if (widget.textFormFieldName == Labels.expenseMonthTextField) {
      provider.otherExpenseTextController =
          List.generate(widget.rowLength, (rowIndex) {
        return List.generate(widget.colLength, (cellIndex) {
          return TextEditingController(
              text: MasterData.dashboardAndProjectOtherExpenseData[rowIndex]
                  .monthValues?[cellIndex].value
                  .toString());
        });
      });
    }

    if (widget.textFormFieldName == Labels.resourceMonthTextField) {
      provider.resourceCostTextController =
          List.generate(widget.rowLength, (rowIndex) {
        return List.generate(widget.colLength, (cellIndex) {
          return TextEditingController(
              text: MasterData.dashboardAndProjectResourceCostData[rowIndex]
                  .monthValues?[cellIndex].value
                  .toString());
        });
      });
    }

    if (widget.textFormFieldName == Labels.addRowExpenseMonthTextField) {
      provider.addRowOtherExpenseTextController = List.generate(
          widget.rowLength,
          (rowIndex) => List.generate(
                widget.colLength,
                (cellIndex) => TextEditingController(
                    text: provider
                        .addRowOtherExpenseData[rowIndex].monthValues[cellIndex].value
                        .toString()),
              ));
    }
    textFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<DashboardProvider>(context, listen: false);

    final bool isAndroid = DeviceOS.isAndroid;
    final bool isMonitor = DeviceScreen.isMonitor(context);
    final bool isLaptop = DeviceScreen.isLargeScreen(context);
    final theme = Theme.of(context);
    final ColorScheme colorTheme = theme.colorScheme;
    final OutlineInputBorder customOutlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
          color: //(provider.isValidMonthBreakdown[widget.rowIndex]
                //  [widget.cellIndex])
             // ? colorTheme.onTertiaryContainer
              //:
        colorTheme.onPrimary,
          width: 1.0),
      borderRadius:
          BorderRadius.circular(4.0), // You can adjust the border radius
    );

    final textFieldStyle = (isAndroid)
        ? theme.textTheme.titleMedium!.copyWith(
            fontSize: FontSizes.s14,
          )
        : (isMonitor)
            ? theme.textTheme.titleMedium!.copyWith(
                fontSize: FontSizes.s20,
              )
            : (isLaptop)
                ? theme.textTheme.titleMedium!.copyWith(
                    fontSize: FontSizes.s16,
                  )
                : theme.textTheme.titleMedium!.copyWith(
                    fontSize: FontSizes.s16,
                  );

    return Focus(
        focusNode: textFocusNode,
        onKey: CommonMethods.changeFormFieldFocus,
        child: Padding(
          padding: //(provider.isSelect[widget.rowIndex])
              //? const EdgeInsets.all(0)
            //  :
            EdgeInsets.only(
                  left: Insets.s3,
                  top: Insets.s8,
                  bottom: Insets.s3,
                  right: Insets.s8),
          child: TextFormField(
            controller: (widget.textFormFieldName ==
                    Labels.monthBreakdownTextField)
                ? provider.monthBreakdownTextController[widget.rowIndex]
                    [widget.cellIndex]
                : (widget.textFormFieldName == Labels.expenseMonthTextField)
                    ? provider.otherExpenseTextController[widget.rowIndex]
                        [widget.cellIndex]
                    : (widget.textFormFieldName ==
                            Labels.resourceMonthTextField)
                        ? provider.resourceCostTextController[widget.rowIndex]
                            [widget.cellIndex]
                        : (widget.textFormFieldName ==
                                Labels.addRowExpenseMonthTextField)
                            ? provider.addRowOtherExpenseTextController[
                                widget.rowIndex][widget.cellIndex]
                            : null,
            validator: TextFieldValidation.validateInput,
            onChanged: (value) {
              provider.showValidation(value, widget.rowIndex, widget.cellIndex,
                  widget.textFormFieldName);

              if (widget.textFormFieldName == Labels.monthBreakdownTextField) {
                provider.dashboardAndProjectMonthTextValue[widget.rowIndex]
                    [widget.cellIndex] = value;
              } else if (widget.textFormFieldName ==
                  Labels.expenseMonthTextField) {
                provider.dashboardAndProjectExpenseMonthValue[widget.rowIndex]
                    [widget.cellIndex] = value;
              } else if (widget.textFormFieldName ==
                  Labels.resourceMonthTextField) {
                MasterData.dashboardAndProjectResourceDataCellValue[
                    widget.rowIndex][widget.cellIndex] = value;
              }
              // else if (widget.textFormFieldName ==
              //     Labels.addRowExpenseMonthTextField) {
              //   provider.dashboardAndProjectAddRowExpenseMonthValue[
              //       widget.rowIndex][widget.cellIndex] = value;
              // }

              provider.calculateSum(value, widget.rowLength, widget.colLength,
                  widget.textFormFieldName);
            },
            maxLength: 11,
            textInputAction: TextInputAction.next,
            autofocus: true,
            readOnly:
                (Provider.of<ProjectsProvider>(context).toMove) ? false : true,
            decoration: //(provider.isSelect[widget.rowIndex])
                // ? InputDecoration(
                //     enabledBorder: customOutlineInputBorder,
                //     counterText: '',
                //     focusedBorder: const OutlineInputBorder(
                //         borderSide: BorderSide(
                //       // color: (provider.isValidMonthBreakdown[widget.rowIndex]
                //       //         [widget.cellIndex])
                //       //     ? colorTheme.onTertiaryContainer
                //       //     : colorTheme.onBackground,
                //     )),
                //   )
                // :
            const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
            style: textFieldStyle,
          ),
        ));
  }
}
