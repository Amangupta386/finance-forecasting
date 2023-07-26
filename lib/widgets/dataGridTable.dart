import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/string_constants.dart';

class DataTableWidget extends StatefulWidget {
  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  bool isHover = false;

  void selectRow(int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

  void onEnterEachComment(PointerEnterEvent event, int i, int index) {
    setState(() {
      eachComment[i][index] = !eachComment[i][index];
    });
  }

  void onExitEachComment(PointerExitEvent event, int i, int index) {
    setState(() {
      eachComment[i][index] = !eachComment[i][index];
    });
  }

  void onEnterImageBackgroundColor(PointerEnterEvent event, int index) {
    setState(() {
      onHoverIcon[index] = !onHoverIcon[index];
    });
  }

  void onExitImageBackgroundColor(PointerExitEvent details, int index) {
    setState(() {
      onHoverIcon[index] = false;
    });
  }

  bool enteringValue = true;
  List<TextEditingController> textControllers = [];
  static const String KEYNAME = 'name';

  @override
  void initState() {
    super.initState();
    // _loadDataFromLocalStorage();
    // Initialize the list of text controllers with empty controllers
    for (int i = 0; i < 12; i++) {
      textControllers.add(TextEditingController());
    }
  }

  void dispose() {
    // Dispose the text controllers to free up resources
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }
  //
  // void _loadDataFromLocalStorage() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   List<dynamic>? storedData = prefs.getStringList(KEYNAME);
  // }

  // Sample data

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Theme(
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ))),
            ),
            rows: List<DataRow>.generate(
              names.length,
              (index) => DataRow(
                cells: [
                  DataCell(Text(
                    names[index],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(51, 51, 51, 1)),
                  )),
                  DataCell(
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          totalList[0][index] = !totalList[0][index];
                        });
                      },
                      child: Container(
                        height: 48,
                        width: 100,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        child: (totalList[0][index])
                            ? Padding(
                                padding: const EdgeInsets.only(
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
                                decoration:
                                    InputDecoration(border: InputBorder.none),
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
                        });
                      },
                      child: Container(
                        height: 48,
                        width: 100,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        child: (totalList[1][index])
                            ? Padding(
                                padding: const EdgeInsets.only(
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
                                decoration:
                                    InputDecoration(border: InputBorder.none),
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
        ),
        Positioned(
          left: 425,
          child: Container(
            // color: Colors.red,
            width: 1200,
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.white),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: DataTable(
                    columnSpacing: 4,
                    columns: List<DataColumn>.generate(
                      monthsColumnsNames.length,
                      (index) => DataColumn(
                          label: Center(
                              widthFactor: 3.2,
                              child: Text(
                                monthsColumnsNames[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ))),
                    ),
                    rows: List<DataRow>.generate(
                      names.length,
                      (index) => DataRow(
                        cells: [
                          for (int i = 0; i < monthsColumnsNames.length; i++)
                            DataCell(
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      eachComment[i][index] =
                                          !eachComment[i][index];
                                    });
                                  },
                                  child: isSelected[index]
                                      ? Padding(
                                          padding: const EdgeInsets.all(2.5),
                                          child: TextFormField(
                                            autofocus: true,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder()),
                                            initialValue: '',
                                            onChanged: (value) {
                                              // controller.text = value;
                                            },
                                          ),
                                        )
                                      : MouseRegion(
                                          onEnter: (PointerEnterEvent event) {
                                            onEnterEachComment(event, i, index);
                                          },
                                          onExit: (PointerExitEvent event) {
                                            onExitEachComment(event, i, index);
                                          },
                                          child: Container(
                                              height: 48,
                                              width: 100,
                                              padding: const EdgeInsets.only(
                                                  left: 4,
                                                  right: 4,
                                                  top: 8,
                                                  bottom: 6),
                                              margin: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded( flex: 1,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        if (eachComment[i][index])
                                                          Icon(
                                                            Icons.note_add,
                                                            size: 12,
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      textFieldValue,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        )),
                            ),
                        ],
                        selected: isSelected[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 385,
          child: Stack(children: [
            Positioned(
              left: 40,
              child: Container(
                height: 350,
                width: 1,
                color: Colors.black,
              ),
            ),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: DataTable(
                  columnSpacing: 4,
                  columns: [DataColumn(label: Text(''))],
                  rows: List<DataRow>.generate(
                      5,
                      (index) => DataRow(cells: [
                            DataCell(
                              MouseRegion(
                                onEnter: (PointerEnterEvent event) {
                                  onEnterImageBackgroundColor(event, index);
                                },
                                onExit: (PointerExitEvent event) {
                                  onExitImageBackgroundColor(event, index);
                                },
                                child: CircleAvatar(
                                  child: IconButton(
                                      onPressed: () {
                                        selectRow(index);
                                      },
                                      icon: (isSelected[index])
                                          ? Image.asset(
                                              'assets/images/check-icon.png',
                                              height: 32,
                                              width: 32,
                                            )
                                          : Image.asset(
                                              'assets/images/edit-icon.png',
                                              height: 32,
                                              width: 32,
                                            )),
                                  backgroundColor: (isSelected[index])
                                      ? Color.fromRGBO(0, 50, 144, 1)
                                      : (onHoverIcon[index])
                                          ? Color.fromRGBO(0, 50, 144, 1)
                                          : Colors.white,
                                  radius: 16,
                                ),
                              ),
                            )
                          ]))),
            ),
          ]),
        ),
      ],
    );
  }
}
