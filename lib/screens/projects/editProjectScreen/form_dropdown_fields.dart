import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/providers/projects/edit_project_provider.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import '../../../models/dropdown.dart';

/// A widget representing a dropdown form field with a label.
class FormDropdownFields extends StatefulWidget {
  String? selectedValue;

  final List<DropDownModel> items;

  final String label;

  /// Creates a [FormDropdownFields] widget.
  ///
  /// The [label] is the text label for the dropdown field.
  /// The [selectedValue] is the initially selected value.
  /// The [items] is a list of items to be displayed in the dropdown.
  FormDropdownFields({
    Key? key,
    required this.label,
     this.selectedValue,
    required this.items,
  }) : super(key: key);

  @override
  State<FormDropdownFields> createState() => _FormDropdownFieldState();
}

class _FormDropdownFieldState extends State<FormDropdownFields> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EditProjectProvider>(context);
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    final theme = Theme.of(context);
    final textTheme=theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;
    return Padding(
        padding: EdgeInsets.symmetric(vertical: Insets.s10),
        child: Row(children: [
          SizedBox(
              width: deviceWidth / 8,
              child: Text(
                widget.label,
                style: textTheme.bodyMedium!.copyWith(color: colorTheme.onPrimary),
              )),
          SizedBox(
            width: deviceWidth / 25,
          ),
          SizedBox(
            height: 48,
            width: 300,
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                        width: 2,
                      ))),
              icon: const Icon(MaterialIcons.keyboardArrowDown),
              value: widget.selectedValue,
              items: widget.items.map(
                    (DropDownModel value) {
                  return DropdownMenuItem<String>(
                    value: value.name,
                    child: Text(
                      value.name,
                      style: textTheme.bodyMedium,
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  widget.selectedValue = value!;
                });
              },
              onSaved: (val) {
                /// Add the selected value to the provider's data.
                // provider.addSelectedValues.add(widget.selectedValue!);
              },
            ),
          )
        ]));
  }
}
