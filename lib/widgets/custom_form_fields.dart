import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:flutter/material.dart';

import '../models/dropdown.dart';

class CustomFormFields extends StatelessWidget {
  final String label;
  final List<DropDownModel> items;
  const CustomFormFields({super.key, required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    String? selectedValue = items[0].name;
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    double deviceHeight = mQ.size.height;
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
              color: colorTheme.onPrimary, fontSize: deviceWidth / 100),
        ),
        SizedBox(height: deviceHeight / 155),
        Container(
          decoration: BoxDecoration(
            color: colorTheme.secondary,
            borderRadius: BorderRadius.circular(Insets.s4),
          ),
          height: Sizes.s48,
          width: Sizes.s300,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(Insets.s4)),
                    borderSide: BorderSide(
                      width: Insets.s2,
                    ))),
            icon: FittedBox(
                child: Icon(MaterialIcons.keyboardArrowDown,
                    size: deviceWidth / 70.33)),
            value: selectedValue, style: textTheme.bodyMedium,
            isExpanded: true,
            items: items.map(
              (DropDownModel value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Text(
                    value.name,
                    style: textTheme.bodyMedium
                        ?.copyWith(fontSize: deviceWidth / 100),
                  ),
                );
              },
            ).toList(),
            onChanged: (value) {
              selectedValue = value;
            },
            // onSaved: (val) {
            //   // provider.setValue(val!);
            // },
          ),
        ),
      ],
    );
  }
}
