import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import '../Constants/string_constants.dart';

class MonthGridTable extends StatefulWidget {
  final ScrollController scrollController;
  const MonthGridTable({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<MonthGridTable> createState() => _MonthGridTableState();
}

class _MonthGridTableState extends State<MonthGridTable> {
  bool openDialog = false;
  bool isLeftButtonEnabled = false;
  bool isRightButtonEnabled = true;
  void onEnterEachBlock(PointerEnterEvent event, int i, int index) {
    setState(() {
      eachBlock[i][index] = !eachBlock[i][index];
    });
  }

  void onExitEachBlock(PointerExitEvent event, int i, int index) {
    setState(() {
      eachBlock[i][index] = !eachBlock[i][index];
    });
  }

  void onEnterEachBlockIcon(PointerEnterEvent event, int i, int index) {
    setState(() {
      eachComment[i][index] = !eachComment[i][index];
    });
  }

  void onExitEachBlockIcon(PointerExitEvent event, int i, int index) {
    setState(() {
      eachComment[i][index] = !eachComment[i][index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: Stack(children: [
                DataTable(
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
                                    eachBlock[i][index] = !eachBlock[i][index];
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
                                          onEnterEachBlock(event, i, index);
                                        },
                                        onExit: (PointerExitEvent event) {
                                          onExitEachBlock(event, i, index);
                                        },
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                15,
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
                                                  Expanded(
                                                    flex: 1,
                                                    child: (eachBlock[i][index])
                                                        ? Container(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: MouseRegion(
                                                              onEnter:
                                                                  (PointerEnterEvent
                                                                      event) {
                                                                onEnterEachBlockIcon(
                                                                    event,
                                                                    i,
                                                                    index);
                                                              },
                                                              onExit:
                                                                  (PointerExitEvent
                                                                      event) {
                                                                onExitEachBlockIcon(
                                                                    event,
                                                                    i,
                                                                    index);
                                                              },
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    openDialog =
                                                                        !openDialog;
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .note_add,
                                                                  size: 16,
                                                                  color: (eachComment[
                                                                              i][
                                                                          index])
                                                                      ? const Color
                                                                              .fromRGBO(
                                                                          98,
                                                                          96,
                                                                          96,
                                                                          1.0)
                                                                      : const Color
                                                                              .fromRGBO(
                                                                          185,
                                                                          177,
                                                                          177,
                                                                          1.0),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
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
                if (openDialog)
                  ShapeOfView(
                    shape: BubbleShape(
                      position: BubblePosition.Left,
                      arrowPositionPercent: 0.7,
                      arrowHeight: 20,
                      arrowWidth: 15,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 35, top: 10, right: 15),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            height: 126,
                            width: 252,
                            child: const TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Add Comment'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              openDialog = false;
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      5), // Set the radius here
                                  color: Color.fromRGBO(0, 43, 123,
                                      1), // Optional background color
                                ),
                                margin: EdgeInsets.only(
                                    left: 35, top: 10, bottom: 10),
                                padding: const EdgeInsets.all(10),
                                height: 41,
                                width: 69,
                                child: const Text(
                                  'Add',
                                  style: TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.none,
                                      color: Colors.white),
                                )),
                          )
                        ]),
                  ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
