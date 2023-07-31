import 'package:flutter/material.dart';

import '../util/colors.dart';

class GoBack extends StatefulWidget {
  const GoBack({Key? key}) : super(key: key);

  @override
  State<GoBack> createState() => _GoBackState();
}

class _GoBackState extends State<GoBack> {
  bool isHovering = false;

  void giveEffect(PointerEvent e) {
    setState(() {
      setState(() {
        isHovering = !isHovering;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return MouseRegion(
      onEnter: giveEffect,
      onExit: giveEffect,
      child: GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Icon(Icons.arrow_back_rounded,
                  color: (isHovering) ? kBlack : Colors.grey),
              const SizedBox(
                width: 5,
              ),
              Text('Go Back',
                  style: (isHovering)
                      ? theme.textTheme.titleSmall?.copyWith(
                          fontSize: 16,
                          color: kBlack,
                          decoration: TextDecoration.underline)
                      : theme.textTheme.titleSmall
                          ?.copyWith(fontSize: 16, color: kLightGrey)),
            ],
          )),
    );
  }
}
