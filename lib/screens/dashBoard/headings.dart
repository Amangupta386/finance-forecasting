import 'package:ddofinance/screens/dashBoard/save_and_cancel_button.dart';
import 'package:ddofinance/screens/dashBoard/scrolling_icons.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/utils/device_screens/screen_size.dart';
import 'package:flutter/material.dart';

class Headings extends StatefulWidget {
  final bool isCollapsed;
  final String headingText;
  final ScrollController scrollerController;
  const Headings(
      {super.key,
      required this.isCollapsed,
      required this.headingText,
      required this.scrollerController});

  @override
  State<Headings> createState() => _HeadingsState();
}

class _HeadingsState extends State<Headings> {
  bool isLeftButtonEnabled = false;
  bool isRightButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    widget.scrollerController.addListener(_checkScrollPosition);
  }

  void _scrollToLeft() {
    widget.scrollerController.animateTo(widget.scrollerController.offset - 100,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _scrollToRight() {
    widget.scrollerController.animateTo(widget.scrollerController.offset + 100,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _checkScrollPosition() {
    setState(() {
      // Check if the scroll offset is greater than zero, which means the DataTable is scrolled to the left.
      isLeftButtonEnabled = widget.scrollerController.offset > 0;
      // Check if the scroll offset reaches the maximum extent, which means the DataTable is scrolled to the right.
      isRightButtonEnabled = widget.scrollerController.offset <
          widget.scrollerController.position.maxScrollExtent;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Size mQ = MediaQuery.of(context).size;
    final double deviceWidth = mQ.width;
    final bool isAndroid = DeviceOS.isAndroid;
    final ColorScheme colorTheme = theme.colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: EdgeInsets.all(deviceWidth / 100),
            child: Text(
              (isAndroid &&
                          widget.headingText == Labels.monthByMonthBreakdown ||
                      mQ.width < 600 &&
                          widget.headingText == Labels.monthByMonthBreakdown)
                  ? Labels.monthByMonthBreakDownAndroid
                  : widget.headingText,
              style: TextStyle(
                  color: colorTheme.primary,
                  fontSize: ScreenSize.getFontSize(
                      largeFontSize: deviceWidth / 70,
                      mediumFontSize: deviceWidth / 55,
                      smallFontSize: deviceWidth / 40)),
            )),
        if (!widget.isCollapsed) SaveAndCancel(title: widget.headingText),
        Flexible(child: SizedBox(width: deviceWidth)),
        ScrollingIcons(
          isLeftButtonActive: isLeftButtonEnabled,
          isRightButtonActive: isRightButtonEnabled,
          scrollToLeftFunction: _scrollToLeft,
          scrollToRightFunction: _scrollToRight,
        ),
      ],
    );
  }
}
