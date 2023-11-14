import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/services/local_storage_service.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class CommentBox extends StatefulWidget {
  final double xPosition;
  final double yPosition;

  const CommentBox({
    super.key,
    required this.xPosition,
    required this.yPosition,
  });

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<DashboardProvider>(context, listen: false);
    provider.monthBreakdownCommentTextController = List.generate(provider.dashboardAndProjectMonthBreakdownData.length, (rowIndex) {
      if (rowIndex >= 0 && rowIndex < 5) {
        return List.generate(provider.dashboardAndProjectMonthBreakdownData[rowIndex]
            .monthValues.length, (cellIndex) {
          return TextEditingController(
              text: provider.dashboardAndProjectMonthBreakdownData[rowIndex].monthValues[cellIndex].commentData);
        });
      } else if (rowIndex == 5 && rowIndex == 7) {
        return List.generate(provider.dashboardAndProjectMonthBreakdownData[rowIndex]
            .monthValues.length, (cellIndex) {
          return TextEditingController(text: '0');
        });
      } else {
        return List.generate(provider.dashboardAndProjectMonthBreakdownData[rowIndex]
            .monthValues.length, (cellIndex) {
          return TextEditingController(
              text: provider.dashboardAndProjectMonthBreakdownData[rowIndex].monthValues[cellIndex].commentData);
        });
      }
    });
    DashboardProjectLocalStorage.loadControllerValuesFromLocalStorage(context);
  }

  @override
  Widget build(BuildContext context) {
    var mQ = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorTheme = theme.colorScheme;
    DashboardProvider provider = Provider.of<DashboardProvider>(context);
    return Positioned(
      left:
          (widget.xPosition < 1230) ? widget.xPosition : widget.xPosition - 288,
      top: widget.yPosition,
      child: ShapeOfView(
        shape: BubbleShape(
          position: (widget.xPosition < 1230)
              ? BubblePosition.Left
              : BubblePosition.Right,
          arrowPositionPercent: 0.7,
          arrowHeight: 15,
          arrowWidth: 15,
        ),
        child: Container(
          margin: EdgeInsets.only(
              left: Insets.s25,
              right: (widget.xPosition < 1230) ? Insets.s15 : Insets.s30,
              top: Insets.s15,
              bottom: Insets.s15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.all(Insets.s10),
              decoration: (Provider.of<ProjectsProvider>(context).toMoveNavigator)
                  ? BoxDecoration(
                  border: Border.all(width: 1, color: colorTheme.onPrimary),
                  borderRadius: BorderRadius.circular(5))
                  : const BoxDecoration(),
              height: mQ.height / 6,
              width: mQ.width / 7,
              child:
              TextFormField(
                controller: provider.monthBreakdownCommentTextController[provider.commentRowIndex]
                [provider.commentColumnIndex],
                decoration: InputDecoration(
                    hintStyle:
                    TextStyle(fontSize: FontSizes.s16, color: colorTheme.onPrimary),
                    border: InputBorder.none,
                    hintText: Labels.addComment),
                onChanged: (value){
                  provider.dashboardAndProjectMonthBreakdownData[provider.commentRowIndex]
                      .monthValues[provider.commentColumnIndex].commentData = value;
                },
              ),
            ),
            if (Provider.of<ProjectsProvider>(context).toMoveNavigator)
              const SizedBox(
                height: 10,
              ),
            if (Provider.of<ProjectsProvider>(context).toMoveNavigator)
              TextButton(
                onPressed: (){
                  provider.closeCommentBox();
                  DashboardProjectLocalStorage.saveControllerValuesToLocalStorage(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(colorTheme.primary)),
                child: Text(
                  Labels.add,
                  style: TextStyle(color: colorTheme.secondary),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
