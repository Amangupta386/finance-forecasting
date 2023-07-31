
import 'package:flutter/material.dart';
import '../Constants/string_constants.dart';
import '../widgets/data_grid_icon_table.dart';
import '../widgets/month_grid_table.dart';
import '../widgets/total_column_grid_table.dart';

class DataTableWidget extends StatefulWidget {
  final ScrollController scrollController;
  const DataTableWidget({super.key, required this.scrollController});

  @override
  // ignore: library_private_types_in_public_api
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {

   var indexEachCell=0;
   var indexTotalFY=0;
   var indexTotalYTD = 0;


  void _toggleVisibility(int row, int col) {
    // Toggle the visibility of the container in the clicked cell
    setState(() {
      cellVisibility[row][col] = !cellVisibility[row][col];
    });
  }

  bool enteringValue = true;
  List<TextEditingController> textControllers = [];

  // static const String KEYNAME = 'name';

  @override
  void initState() {
    super.initState();
    // _loadDataFromLocalStorage();
    // Initialize the list of text controllers with empty controllers
    for (int i = 0; i < 12; i++) {
      textControllers.add(TextEditingController());
    }
  }

  // void dispose() {
  //   // Dispose the text controllers to free up resources
  //   for (var controller in textControllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }
  //
  // void _loadDataFromLocalStorage() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   List<dynamic>? storedData = prefs.getStringList(KEYNAME);
  // }

  // Sample data

   void selectRow(int index) {
     setState(() {
       isSelected[index] = !isSelected[index];
     });
   }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          totalList[0][indexEachCell] = true;
          totalList[1][indexEachCell] = true;
        });
      },
      child: Stack(
        children: [
          TotalColumnGridTable(indexEachCellData:indexEachCell, indexTotalFYData:indexTotalFY, indexTotalYTData:indexTotalFY),
           MonthGridTable(scrollController: widget.scrollController,),
          Positioned(
            left: 385,
            child: Stack(children: [
              Positioned(
                left: 40,
                child: Container(
                  height: 350,
                  width: 1,
                  color: const Color.fromRGBO(198, 198, 198, 1.0),
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
              ),
              GridIconTable(selectedRow: selectRow,),
            ]),
          ),
        ],
      ),
    );
  }
}
