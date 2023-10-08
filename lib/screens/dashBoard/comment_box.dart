import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';


class CommentBox extends StatelessWidget {
  final double xPosition;
  final double yPosition;

  CommentBox({
    Key? key,
    required this.xPosition,
    required this.yPosition,
  }) : super(key: key);

  String message = 'message';

  @override
  Widget build(BuildContext context) {
    DashboardProvider provider = Provider.of<DashboardProvider>(context);
    var mQ = MediaQuery.of(context).size;
    return Positioned(
      left:
          (xPosition < 1230) ? xPosition : xPosition - 288,
      top: yPosition,
      child: ShapeOfView(
        shape: BubbleShape(
          position: (xPosition < 1230)
              ? BubblePosition.Left
              : BubblePosition.Right,
          arrowPositionPercent: 0.7,
          arrowHeight: 15,
          arrowWidth: 15,
        ),
        child: Container(
          margin: EdgeInsets.only(
              left: Insets.s25,
              right: (xPosition < 1230) ? Insets.s15 : Insets.s30,
              top: Insets.s15,
              bottom: Insets.s15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.all(Insets.s10),
              decoration:  (Provider.of<ProjectsProvider>(context).toMove)
                  ?BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: kGrey),
                  borderRadius: BorderRadius.circular(5)):BoxDecoration(),
              height: mQ.height / 6,
              width: mQ.width / 7,
              child: (!Provider.of<ProjectsProvider>(context).toMove)
                  ? Text(message)
                  : TextField(
                      decoration: InputDecoration(
                          hintStyle:
                              TextStyle(fontSize: FontSizes.s16, color: kGrey),
                          border: InputBorder.none,
                          hintText: Labels.addComment),
                    ),
            ),
            if (Provider.of<ProjectsProvider>(context).toMove)
              SizedBox(
                height: 10,
              ),
            if (Provider.of<ProjectsProvider>(context).toMove)
              TextButton(
                onPressed: provider.closeCommentBox,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kViolet)),
                child: Text(
                  Labels.add,
                  style: const TextStyle(color: kWhite),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
