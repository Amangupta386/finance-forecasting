import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_form_fields.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    double deviceHeight = mQ.size.height;
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    return FittedBox(
      child: Container(
        alignment: Alignment.center,
        height: deviceHeight/4.93,
        width: deviceWidth/1.006,
        padding: EdgeInsets.all(deviceHeight/64),
        decoration: BoxDecoration(
          color: colorTheme.outlineVariant,
          borderRadius: BorderRadius.circular(Insets.s08),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomFormFields(label: Labels.financialYear, items: Provider.of<DashboardProvider>(context).dropDownItems1,),
            SizedBox(width: deviceWidth/64,),
            CustomFormFields(label: Labels.bu, items: Provider.of<DashboardProvider>(context).dropDownItems2),
            SizedBox(width: deviceWidth/64,),
            CustomFormFields(label: Labels.client, items: Provider.of<DashboardProvider>(context).dropDownItems3),
            SizedBox(width: deviceWidth/64,),
            CustomFormFields(label: Labels.project, items: Provider.of<DashboardProvider>(context).dropDownItems4),
            SizedBox(width: deviceWidth/64,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Insets.s4),
              ),
              padding: EdgeInsets.only(top: deviceWidth/80),
              height: deviceHeight/11.39,
              width: deviceWidth/16,
              child: TextButton(
                onPressed: (){},
                style: theme.textButtonTheme.style,
                child: Text(Labels.show, style: textTheme.bodySmall?.copyWith(color: colorTheme.secondary, fontSize: deviceWidth/100,)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}