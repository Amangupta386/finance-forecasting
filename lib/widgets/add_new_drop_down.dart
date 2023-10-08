import 'package:ddofinance/theme/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';

class AddNewFormDropdownFields extends StatefulWidget {
  final String label;
  final List<String> items;
  const AddNewFormDropdownFields({Key? key, required this.label, required this.items}) : super(key: key);

  @override
  State<AddNewFormDropdownFields> createState() => _FormDropdownFieldState();
}

class _FormDropdownFieldState extends State<AddNewFormDropdownFields> {
  String? selectedValue;
  String selectedLanguage1 = 'en';

  String selectedLanguage2 = 'hi';

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<EditProjectScreenData>(context);
    MediaQueryData mQ = MediaQuery.of(context);
    ThemeData theme = Theme.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(vertical:10),
        child: Row(children: [
          SizedBox(
              width: mQ.size.width / 8,
              child: Text(
                widget.label,
                style: theme.textTheme.bodyMedium!.copyWith(color:kGrey ),
              )),
          SizedBox(
            width: mQ.size.width / 25,
          ),
          SizedBox(
            height: 48,
            width: 300,
            child: DropdownButtonFormField<String>(
              hint: Text('Please Select',style: Theme.of(context).textTheme.bodyMedium,),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                        width: 2,
                      ))),
              icon: const Icon(MaterialIcons.keyboardArrowDown),
              items: widget.items.map<DropdownMenuItem<String>>(
                    (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {

                });
              },
              onSaved: (val) {

              },
            ),
          )
        ]));
  }
}