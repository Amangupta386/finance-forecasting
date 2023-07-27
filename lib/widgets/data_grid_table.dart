
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Constants/string_constants.dart';

class DataTableWidget extends StatefulWidget {
  final ScrollController scrollController;
  const DataTableWidget({super.key, required this.scrollController});

  @override
  // ignore: library_private_types_in_public_api
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  late int indexEachCell;
  late int indexTotalFY;
  late int indexTotalYTD;
  bool isLeftButtonEnabled = false;
  bool isRightButtonEnabled = true;

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          totalList[0][indexEachCell] = true;
          totalList[1][indexEachCell] = true;
        });
      },
      child: Stack(
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
                            indexEachCell = index;
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
                                  decoration:
                                      const InputDecoration(border: InputBorder.none),
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
                            indexEachCell = index;
                            indexTotalYTD = 1;
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
                                  decoration:
                                      const InputDecoration(border: InputBorder.none),
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
            child: SizedBox(
              // color: Colors.red,
              width: 1200,
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.white),
                child: SingleChildScrollView(
                  controller: widget.scrollController,
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
                                  style: const TextStyle(fontSize: 16),
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
                                              decoration: const InputDecoration(
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
                                                margin: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(5)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Expanded( flex: 1,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(0),
                                                          child: (eachComment[i][index])?Container(
                                                            alignment: Alignment.topRight,
                                                            child: const Icon(
                                                              Icons.note_add,
                                                              size: 15,
                                                            ),
                                                          ):Container(),
                                                        ),
                                                      ),
                                                      const Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          textFieldValue,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                          textAlign: TextAlign.left,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
                  child: Divider(thickness: 1,),
                  height: 350,
                  width: 1,
                  color: Color.fromRGBO(198, 198, 198, 1.0),
                ),
              ),
              Theme(
                data:
                    Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: DataTable(
                    columnSpacing: 4,
                    columns: const [DataColumn(label: Text(''))],
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
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3), // Adjust the shadow color and opacity
                                          spreadRadius: 1, // Adjust the spread radius of the shadow
                                          blurRadius: 3, // Adjust the blur radius of the shadow
                                          offset: Offset(0, 1), // Adjust the shadow's position (x, y)
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: (isSelected[index])
                                          ? const Color.fromRGBO(0, 50, 144, 1)
                                          : (onHoverIcon[index])
                                              ? const Color.fromRGBO(0, 50, 144, 1)
                                              : Colors.white,
                                      radius: 16,
                                      child: GestureDetector(
                                          onTap: () {
                                            selectRow(index);
                                          },
                                          child: (isSelected[index])
                                              ? SvgPicture.asset('assets/images/check-icon.svg')
                                              : SvgPicture.asset('assets/images/edit-icon.svg')),
                                    ),
                                  ),
                                ),
                              )
                            ]))),
              ),
            ]),
          ),
        ],
      ),

    );
  }
}
