import 'package:ddofinance/data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/theme/styles.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid({super.key});

  @override
  Widget build(BuildContext context) {
    ///To calculate the height and width of the device.
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    double deviceHeight = mQ.size.height;
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    return SizedBox(
      height: deviceHeight / 1.60,
      width: deviceWidth / 2.67,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: deviceWidth / 60,
          childAspectRatio: deviceWidth / deviceHeight,
          mainAxisSpacing: deviceHeight / 25,
        ),
        children: [
          ///To render the container and the data of the grid using a for loop.
          for (final i in gridData)
            Container(
              decoration: BoxDecoration(
                color: i.color,
                borderRadius: BorderRadius.circular(Insets.s08),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    i.key.toUpperCase(),
                    style: textTheme.bodyMedium?.copyWith(
                        color: colorTheme.onSurface,
                        fontSize: deviceWidth / 100),
                  ),
                  SizedBox(
                    height: deviceHeight / 38.75,
                  ),
                  Text(
                    i.value,
                    style: textTheme.titleLarge
                        ?.copyWith(fontSize: deviceWidth / 50),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
