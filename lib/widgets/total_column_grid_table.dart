import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/string_constants.dart';

class TotalColumnGridTable extends StatefulWidget {
   int indexEachCellData = 0;
    int  indexTotalFYData = 0;
    int   indexTotalYTData = 0;
   TotalColumnGridTable({Key? key, required this.indexEachCellData, required this.indexTotalFYData, required this.indexTotalYTData}) : super(key: key);

  @override
  State<TotalColumnGridTable> createState() => _TotalColumnGridTableState();
}

class _TotalColumnGridTableState extends State<TotalColumnGridTable> {
  late int indexEachCell;
  late int indexTotalFY;
  late int indexTotalYTD;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: DataTable(
        columnSpacing: 4,
        columns: List<DataColumn>.generate(
          columnTitles.length,
              (index) => DataColumn(
              label: Center(
                  widthFactor: 1.5,
                  child: Text(
                    columnTitles[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ))),
        ),
        rows: List<DataRow>.generate(
          names.length,
              (index) => DataRow(
            cells: [
              DataCell(Text(
                names[index],
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(51, 51, 51, 1)),
              )),
              DataCell(
                GestureDetector(
                  onTap: () {
                    setState(() {
                      totalList[0][index] = !totalList[0][index];
                      widget.indexTotalFYData = index;
                      indexTotalFY = 0;
                    });
                  },
                  child: Container(
                    height: 48,
                    width: 100,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    child: (totalList[0][index])
                        ? const Padding(
                      padding: EdgeInsets.only(
                          left: 4.0,
                          right: 4.0,
                          bottom: 10.0,
                          top: 8.0),
                      child: Text(
                        textFieldValue,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                        : TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none),
                      // initialValue: name,
                      onChanged: (value) {
                        // controller.text = value;
                      },
                    ),
                  ),
                ),
              ),
              DataCell(
                GestureDetector(
                  onTap: () {
                    setState(() {
                      totalList[1][index] = !totalList[1][index];
                      widget.indexEachCellData = index;
                      widget.indexTotalYTData = 1;
                    });
                  },
                  child: Container(
                    height: 48,
                    width: 100,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    child: (totalList[1][index])
                        ? const Padding(
                      padding: EdgeInsets.only(
                          left: 4.0,
                          right: 4.0,
                          bottom: 10.0,
                          top: 8.0),
                      child: Text(
                        textFieldValue,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                        : TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none),
                      // initialValue: name,
                      onChanged: (value) {
                        // controller.text = value;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
