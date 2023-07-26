import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'data_grid_table.dart';

class MonthByMonthBreakDown extends StatefulWidget {
  const MonthByMonthBreakDown({Key? key}) : super(key: key);

  @override
  State<MonthByMonthBreakDown> createState() => _MonthByMonthBreakDownState();
}

class _MonthByMonthBreakDownState extends State<MonthByMonthBreakDown> {
  ScrollController _scrollController = ScrollController();
  bool isLeftButtonEnabled = false;
  bool isRightButtonEnabled = true;

  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollPosition);
  }


  void _scrollToLeft() {
    _scrollController.animateTo(_scrollController.offset - 100,
    duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _scrollToRight() {
    _scrollController.animateTo(_scrollController.offset + 100,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
  void _checkScrollPosition() {
    setState(() {
      // Check if the scroll offset is greater than zero, which means the DataTable is scrolled to the left.
      isLeftButtonEnabled = _scrollController.offset > 0;
      // Check if the scroll offset reaches the maximum extent, which means the DataTable is scrolled to the right.
      isRightButtonEnabled =
          _scrollController.offset < _scrollController.position.maxScrollExtent;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('MONTH BY MONTH BREAKDOWN',
                    style: TextStyle(
                        color: Color.fromRGBO(2, 50, 144, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: isLeftButtonEnabled ? _scrollToLeft : null,
                      child: CircleAvatar(
                        backgroundColor: (isLeftButtonEnabled)?Color.fromRGBO(2,50,144, 1):Color.fromRGBO(221, 221, 221, 1),
                        radius: 16,
                        child: SvgPicture.asset(
                            'assets/images/left-arrow-icon.svg'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: isRightButtonEnabled ? _scrollToRight : null,
                      child: CircleAvatar(
                        backgroundColor: (isRightButtonEnabled)?Color.fromRGBO(2,50,144, 1):Color.fromRGBO(221, 221, 221, 1),
                        radius: 16,
                        child: SvgPicture.asset(
                            'assets/images/right-arrow-icon.svg'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: 1,
          ),
          Container(
            child: DataTableWidget(scrollController: _scrollController,),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 1,
          )
        ],
      ),
    );
  }
}
