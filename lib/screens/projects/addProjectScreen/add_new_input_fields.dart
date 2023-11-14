import 'package:ddofinance/providers/projects/add_new_projects_provider.dart';
import 'package:ddofinance/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:provider/provider.dart';

/// A widget for displaying a form input field with a label
class AddNewFormInputFields extends StatefulWidget {
  final bool enableTextField;
  final String label;
  String? initialValue;

  /// Creates a [AddNewFormInputFields] widget.
  ///
  /// The label to display next to the input field.
  /// A boolean flag to determine if the text field is enabled.
  /// The initial value of the text field.
  /// A controller for the text editing of the input field.
  AddNewFormInputFields(
      {Key? key,
      required this.label,
      required this.enableTextField,
      this.initialValue})
      : super(key: key);

  @override
  State<AddNewFormInputFields> createState() => _AddNewFormInputFieldsState();
}

class _AddNewFormInputFieldsState extends State<AddNewFormInputFields> {
  @override
  Widget build(BuildContext context) {
    AddProjectProvider provider = Provider.of<AddProjectProvider>(context);
    MediaQueryData mQ = MediaQuery.of(context);
    ThemeData theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Insets.s10),
      child: Row(
        children: [
          SizedBox(
              width: mQ.size.width / 8,
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
            width: mQ.size.width / 25,
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
                controller: (provider.clearTextFormFields)
                    ? TextEditingController(text: widget.initialValue)
                    : TextEditingController(text: ''),
                enabled: widget.enableTextField,
                onSaved: (value) {
                  if (widget.label == 'Project Forecast') {
                    provider.projectForecast = value!;
                  } else if (widget.label == 'Actual Cost') {
                    provider.actualCost = value!;
                  }
                },
                style: (widget.enableTextField)
                    ? Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: colorTheme.onBackground)
                    : Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color.fromRGBO(109, 109, 109, 1)),
                decoration: const InputDecoration(
                    errorStyle: TextStyle(
                      height: 0.01,
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    )),
              )),
          // if (provider.errorText != null && widget.enableTextField)
          //   Container(
          //       padding: const EdgeInsets.only(left: 8),
          //       child: Text(
          //         provider.errorText!,
          //         style: TextStyle(color: colorTheme.error),
          //       ))
        ],
      ),
    );
  }
}
