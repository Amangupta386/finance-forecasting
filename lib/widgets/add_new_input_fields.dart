

import 'package:ddofinance/providers/projects/add_new_projects_provider.dart';
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
    // print('${widget.initialValue}  ayutfhjtrfydjtfyjrtyfshii');
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
                    )
          ),
          SizedBox(
            width: mQ.size.width / 25,
          ),
          SizedBox(
            height: 48,
            width: 300,
            child: TextFormField(
              validator: (widget.enableTextField)
                  ? (value) {
                      if (value!.isEmpty) {
                        return 'This field  is required';
                      }
                      return null;
                    }
                  : null,
              controller: (provider.clearTextFormFields)
                  ? TextEditingController(text: widget.initialValue)
                  : TextEditingController(text: ''),
              //  initialValue: widget.initialValue,
              enabled: widget.enableTextField,
              // onChanged: (value){
              //   setState(() {
              //     widget.initialValue = value;
              //   });
              //
              //   print('${widget.initialValue}    inittial value');
              // },
              onSaved: (value) {
                widget.initialValue = value!;
                // print('${provider.projectForecast}   pf inittial onsaved');
                // print('${provider.actualCost}   ac inittial onsaved');

                if(widget.label =='Project Forecast'){
                  provider.projectForecast =value;

                }
                else if(widget.label =='Actual Cost'){
                  provider.actualCost=value;
                }



              },
              style: (widget.enableTextField)
                  ? Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: colorTheme.onBackground)
                  : Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: const Color.fromRGBO(109, 109, 109, 1)),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                          width: 2,
                          color: (widget.enableTextField)
                              ? colorTheme.onSecondary
                              : colorTheme.onBackground))),
            ),
          )
        ],
      ),
    );
  }
}
