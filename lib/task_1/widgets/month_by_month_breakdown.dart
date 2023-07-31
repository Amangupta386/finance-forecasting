import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../parentWidget/data_grid_table.dart';

class MonthByMonthBreakDown extends StatefulWidget {
  const MonthByMonthBreakDown({Key? key}) : super(key: key);

  @override
  State<MonthByMonthBreakDown> createState() => _MonthByMonthBreakDownState();
}

class _MonthByMonthBreakDownState extends State<MonthByMonthBreakDown> {
  final ScrollController scrollController = ScrollController();
  bool isLeftButtonEnabled = false;
  bool isRightButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_checkScrollPosition);
  }

  void _scrollToLeft() {
    scrollController.animateTo(scrollController.offset - 100,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _scrollToRight() {
    scrollController.animateTo(scrollController.offset + 100,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _checkScrollPosition() {
    setState(() {
      // Check if the scroll offset is greater than zero, which means the DataTable is scrolled to the left.
      isLeftButtonEnabled = scrollController.offset > 0;
      // Check if the scroll offset reaches the maximum extent, which means the DataTable is scrolled to the right.
      isRightButtonEnabled =
          scrollController.offset < scrollController.position.maxScrollExtent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('MONTH BY MONTH BREAKDOWN',
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
                        backgroundColor: (isLeftButtonEnabled)
                            ? const Color.fromRGBO(2, 50, 144, 1)
                            : const Color.fromRGBO(221, 221, 221, 1),
                        radius: 16,
                        child: SvgPicture.asset(
                            'assets/images/left-arrow-icon.svg'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: isRightButtonEnabled ? _scrollToRight : null,
                      child: CircleAvatar(
                        backgroundColor: (isRightButtonEnabled)
                            ? const Color.fromRGBO(2, 50, 144, 1)
                            : const Color.fromRGBO(221, 221, 221, 1),
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
          const Divider(
            indent: 10,
            endIndent: 10,
            thickness: 1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.1,
            width: MediaQuery.of(context).size.width / 1,
            child: DataTableWidget(
              scrollController: scrollController,
            ),
          )
        ],
      ),
    );
  }
}
