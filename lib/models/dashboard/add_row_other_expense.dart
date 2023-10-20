import 'dart:convert';

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

AddRowOtherExpenseModel addRowOtherExpenseModelFromJson(String str) => AddRowOtherExpenseModel.fromJson(json.decode(str));

String addRowOtherExpenseModelToJson(AddRowOtherExpenseModel data) => json.encode(data.toJson());

class AddRowOtherExpenseModel {
  String label;
  List<AddRowMonthValue> monthValues;

  AddRowOtherExpenseModel({
    required this.label,
    required this.monthValues,
  });

  factory AddRowOtherExpenseModel.fromJson(Map<String, dynamic> json) => AddRowOtherExpenseModel(
    label: json["label"],
    monthValues: List<AddRowMonthValue>.from(json["monthValues"].map((x) => AddRowMonthValue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "monthValues": List<dynamic>.from(monthValues.map((x) => x.toJson())),
  };
}

class AddRowMonthValue {
  String label;
  int value;

  AddRowMonthValue({
    required this.label,
    required this.value,
  });

  factory AddRowMonthValue.fromJson(Map<String, dynamic> json) => AddRowMonthValue(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}
