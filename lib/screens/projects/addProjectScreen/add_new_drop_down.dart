import 'package:ddofinance/models/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/providers/projects/add_new_projects_provider.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';


class AddNewFormDropdownFields extends StatefulWidget {
  final String label;
  final List<DropDownModel> items;
  const AddNewFormDropdownFields({Key? key, required this.label, required this.items})
      : super(key: key);

  @override
  State<AddNewFormDropdownFields> createState() => _FormDropdownFieldState();
}

class _FormDropdownFieldState extends State<AddNewFormDropdownFields> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AddProjectProvider>(context);
    MediaQueryData mQ = MediaQuery.of(context);
    ThemeData theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(children: [
          SizedBox(
            width: mQ.size.width / 8,
            child: RichText(
              text: TextSpan(
                text: widget.label,
                style:
                    textTheme.bodyMedium!.copyWith(color: colorTheme.onPrimary),
                children: <TextSpan>[
                  TextSpan(
                    text: ' *',
                    style: textTheme.bodyMedium!.copyWith(
                        fontSize: Insets.s20,
                        color: colorTheme.onTertiaryContainer),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: mQ.size.width / 25,
          ),
          SizedBox(
            height: 48,
            width: 300,
            child: DropdownButtonFormField(
              isExpanded: true,
              hint: Text(
               Labels.pleaseSelect,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                        width: 2,
                      ))),
              icon: const Icon(MaterialIcons.keyboardArrowDown),
              items: widget.items.map(
                (DropDownModel value) {
                  return DropdownMenuItem<String>(
                    value: value.name,
                    onTap: () {
                      provider.FK_FinancialYear_ID = value.id.toString();
                    },
                    child: Text(
                      value.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) {
              },
              onSaved: (val) {},
            ),
          )
        ]));
  }
}
