import 'package:flutter/material.dart';

class FormInputFields extends StatelessWidget {
  final String label;
  const FormInputFields({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 8,
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.titleSmall,
                  )),
            ],
          ),
          Container(
              height: 35,
              width: 265,
              child: const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 2))),
              )),
        ],
      ),
    );
  }
}
