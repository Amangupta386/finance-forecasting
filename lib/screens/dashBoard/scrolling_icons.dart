import 'package:ddofinance/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScrollingIcons extends StatelessWidget {
  final bool isLeftButtonActive;
  final bool isRightButtonActive;
  final VoidCallback scrollToLeftFunction;
  final VoidCallback scrollToRightFunction;
  const ScrollingIcons(
      {super.key,
      required this.isLeftButtonActive,
      required this.isRightButtonActive,
      required this.scrollToLeftFunction,
      required this.scrollToRightFunction});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorTheme = theme.colorScheme;

    return Row(
      children: [
        GestureDetector(
          onTap: isLeftButtonActive ? scrollToLeftFunction : null,
          child: CircleAvatar(
            backgroundColor: (isLeftButtonActive)
                ? colorTheme.primary
                : colorTheme.onPrimary,
            radius: 16,
            child: SvgPicture.asset(Images.leftArrowIcon),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: isRightButtonActive ? scrollToRightFunction : null,
          child: CircleAvatar(
            backgroundColor: (isRightButtonActive)
                ? colorTheme.primary
                : colorTheme.onPrimary,
            radius: 16,
            child: SvgPicture.asset(Images.rightArrowIcon),
          ),
        ),
      ],
    );
  }
}
