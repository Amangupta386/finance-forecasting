import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/providers/projects/edit_project_provider.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/validators.dart';


/// A widget for displaying a form input field with a label
class FormInputFields extends StatefulWidget {
  final bool enableTextField;
  final String label;
  String initialValue;

  /// Creates a [FormInputFields] widget.
  ///
  /// The label to display next to the input field.
  /// A boolean flag to determine if the text field is enabled.
  /// The initial value of the text field.
  /// A controller for the text editing of the input field.
  FormInputFields({
    Key? key,
    required this.enableTextField,
    required this.label,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<FormInputFields> createState() => _FormInputFieldsState();
}

class _FormInputFieldsState extends State<FormInputFields> {
  late TextEditingController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    EditProjectProvider provider = Provider.of<EditProjectProvider>(context);
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Insets.s10),
      child: Row(
        children: [
          SizedBox(
              width: deviceWidth / 8,
              child: (widget.enableTextField)
                  ? RichText(
                      text: TextSpan(
                        text: widget.label,
                        style: textTheme.bodyMedium!
                            .copyWith(color: colorTheme.onPrimary),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' *',
                            style: textTheme.bodyMedium!.copyWith(
                                fontSize: Insets.s20,
                                color: colorTheme.onTertiaryContainer),
                          ),
                        ],
                      ),
                    )
                  : Text(
                      widget.label,
                      style: textTheme.bodyMedium!
                          .copyWith(color: colorTheme.onPrimary),
                    )),
          SizedBox(
            width: deviceWidth / 25,
          ),
          SizedBox(
            height: 48,
            width: 300,
            child: TextFormField(
              validator: (value) {
                return (widget.enableTextField)
                    ? Validators.validateNumber(value)
                    : null;
              },
              style: (widget.enableTextField)
                  ? textTheme.bodyMedium
                  : textTheme.bodyMedium!.copyWith(color: colorTheme.onPrimary),
              enabled: widget.enableTextField,
              controller: controller,
              onSaved: (value) {
                if (widget.label == Labels.projectForecast) {
                  provider.projectForecast = value!;
                } else if (widget.label == Labels.projectActualCost) {
                  provider.actualCost = value!;
                }
              },
              decoration: const InputDecoration(
                  errorStyle: TextStyle(
                    height: 0.01,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                   )),
            ),
          )
        ],
      ),
    );
  }
}
