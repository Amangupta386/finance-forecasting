import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Constants/string_constants.dart';

class GridIconTable extends StatefulWidget {
  final Function(int index) selectedRow;
  const GridIconTable({Key? key, required this.selectedRow}) : super(key: key);

  @override
  State<GridIconTable> createState() => _GridIconTableState();
}



class _GridIconTableState extends State<GridIconTable> {

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



  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(dividerColor: Colors.transparent),
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
                            color: Colors.black.withOpacity(0.3),
                            // Adjust the shadow color and opacity
                            spreadRadius: 1,
                            // Adjust the spread radius of the shadow
                            blurRadius: 3,
                            // Adjust the blur radius of the shadow
                            offset: const Offset(0,
                                1), // Adjust the shadow's position (x, y)
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          widget.selectedRow(index);
                        },
                        child: CircleAvatar(
                          backgroundColor: (isSelected[index])
                              ? const Color.fromRGBO(
                              0, 50, 144, 1)
                              : (onHoverIcon[index])
                              ? const Color.fromRGBO(
                              0, 50, 144, 1)
                              : Colors.white,
                          radius: 16,
                          child: (isSelected[index])
                              ? SvgPicture.asset(
                              'assets/images/check-icon.svg')
                              : SvgPicture.asset(
                              'assets/images/edit-icon.svg'),
                        ),
                      ),
                    ),
                  ),
                )
              ]))),
    );
  }
}
