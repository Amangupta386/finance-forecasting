import 'package:ddofinance/utils/constants/labels.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';

class GoBack extends StatefulWidget {
  const GoBack({super.key});

  @override
  State<GoBack> createState() => _GoBackState();
}

class _GoBackState extends State<GoBack> {
  bool isHovering = false;

  ///To give hovering effect to the text.
  void giveEffect(PointerEvent e) {
    setState(() {
      setState(() {
        isHovering = !isHovering;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    return MouseRegion(
      onEnter: giveEffect,
      onExit: giveEffect,
      child: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: SizedBox(
            width: deviceWidth / 18,
            child: Row(
              children: [
                Icon(MaterialIcons.arrowBack,
                    size: deviceWidth / 90,
                    color: (isHovering)
                        ? colorTheme.onBackground
                        : colorTheme.onPrimary),
                SizedBox(
                  width: deviceWidth / 320,
                ),
                Text(Labels.goBack,
                    style: (isHovering)
                        ? textTheme.titleSmall?.copyWith(
                            fontSize: deviceWidth / 100,
                            color: colorTheme.onBackground,
                            decoration: TextDecoration.underline)
                        : textTheme.titleSmall?.copyWith(
                            fontSize: deviceWidth / 100,
                            color: colorTheme.onPrimary)),
              ],
            ),
          )),
    );
  }
}
