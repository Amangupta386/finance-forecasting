import 'package:ddofinance/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/data/resources_cost_data.dart';
import 'package:ddofinance/providers/resources_cost/resources_cost_data_provider.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:ddofinance/utils/validators.dart';


/// A custom Flutter widget for displaying a table of resources cost with sorting functionality.

/// This widget takes a list of [ResourcesCostModel] and displays it in a DataTable.
class ResourcesCostDataTable extends StatelessWidget {

  ResourcesCostDataTable(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResourcesCostDataProvider provider = Provider.of<ResourcesCostDataProvider>(context);
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: deviceWidth > 1400 ? deviceWidth - 30 : null,
        child: GestureDetector(
          onTap: (){
            provider.tapHandler();
          },
          child: DataTable(

            //To render the columns of the data table using a list
              columns: List<DataColumn>.generate(
                tableLabels.length,
                (colIndex) => (colIndex == 0)
                    ? DataColumn(
                        label: Expanded(
                          child: Row(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: deviceWidth / 18),
                                child: Text(
                                  tableLabels[colIndex],
                                  style: textTheme
                                      .bodySmall
                                      ?.copyWith(color: colorTheme.onPrimary),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  provider.sortEmployeeId();
                                },
                                child: (provider.boolValue)
                                    ?  Icon(
                                        MaterialIcons.keyboardArrowDown,
                                        size: IconSizes.s18,
                                        color: colorTheme.onPrimary,
                                      )
                                    :  Icon(MaterialIcons.keyboardArrowUp,
                                        size: IconSizes.s18, color: colorTheme.onPrimary),
                              )
                            ],
                          ),
                        ),
                      )
                    : DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: Insets.s5),
                            child: Text(
                              tableLabels[colIndex],
                              style: textTheme
                                  .bodySmall
                                  ?.copyWith(color: colorTheme.onPrimary),
                            ),
                          ),
                        ),
                      ),
              ),

              //To render the rows of the data table using a list
              rows: List.generate(
                  provider.filtered.length,
                  (rowIndex) => DataRow(
                    onLongPress: (){
                      provider.tapHandler();
                    },
                      color: MaterialStateProperty.all(colorTheme.secondary),
                      mouseCursor: MaterialStateProperty.all(SystemMouseCursors.basic),
                      cells: [
                        DataCell(Text(
                          provider.filtered[rowIndex].eId,
                          style: textTheme
                              .bodyMedium
                              ?.copyWith(color: colorTheme.onSecondary),
                        )),
                        DataCell(Text(
                          provider.filtered[rowIndex].eName,
                          style: textTheme
                              .bodyMedium
                              ?.copyWith(color: colorTheme.onSecondary),
                        )),
                        DataCell(Text(
                          provider.filtered[rowIndex].designation,
                          style: textTheme
                              .bodyMedium
                              ?.copyWith(color: colorTheme.onSecondary),
                        )),
                        DataCell(Text(
                          provider.filtered[rowIndex].joiningDate,
                          style: textTheme
                              .bodyMedium
                              ?.copyWith(color: colorTheme.onSecondary),
                        )),
                        
                        //Calling a custom function to build the cells.
                        _buildDataCell(rowIndex, 0, theme, context),
                        _buildDataCell(rowIndex, 1, theme, context),
                        _buildDataCell(rowIndex, 2, theme, context),
                        _buildDataCell(rowIndex, 3, theme, context),
                      ]))
          ),
        ),
      ),
    );
  }

  /// A custom function which takes [rowIndex],[colIndex],[theme], [context] to build a data cell.
  DataCell _buildDataCell(int rowIndex, int colIndex, ThemeData theme, BuildContext context) {
    final colorTheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    ResourcesCostDataProvider provider = Provider.of<ResourcesCostDataProvider>(context);

    return DataCell(Padding(
      padding: EdgeInsets.only(left: Insets.s5),
      child: GestureDetector(
        onTap: () {
          provider.toggleList(rowIndex, colIndex);
        },
        child: Container(
          padding: EdgeInsets.all(Insets.s10),
          margin: EdgeInsets.all(Insets.s5),
          height: 48,
          width: 130,
          decoration: BoxDecoration(
              color: (provider.isSelectedList[rowIndex][colIndex])
                  ? colorTheme.secondary
                  : colorTheme.onInverseSurface,
              borderRadius: BorderRadius.circular(Insets.s4),
              border: Border.all(
                  width: Insets.scale, color:(provider.isValidList[rowIndex][colIndex])?colorTheme.error: colorTheme.onPrimary)),
          child: (provider.isSelectedList[rowIndex][colIndex])
              ? TextFormField(
            maxLength: 11,
            validator: TextFieldValidation.validateInput,
            onChanged: (newValue) {
              
              //Calling a method of provider to update the value of the cell with the new value.
              provider.updateDataCellValue(rowIndex, colIndex, newValue);
              
              //Calling a method of provider to show validation for a particular cell.
              provider.showValidation(
                  newValue,
                  rowIndex,
                  colIndex);
            },
            autofocus: true,
            initialValue: provider.showData(rowIndex, colIndex),
            style: textTheme
                .bodyMedium
                ?.copyWith(color: colorTheme.onSecondary),
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
          )
              : Text(
            
            //To display the data of a particular cell.
            provider.showData(rowIndex, colIndex),
            style:textTheme
                .bodyMedium
                ?.copyWith(color: colorTheme.onSecondary),
          ),
        ),
      ),
    ));
  }
}