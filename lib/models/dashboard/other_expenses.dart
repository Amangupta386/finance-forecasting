// To parse this JSON data, do
//
//     final otherExpenseModel = otherExpenseModelFromJson(jsonString);

import 'dart:convert';

List<OtherExpenseModel> otherExpenseModelFromJson(String str) => List<OtherExpenseModel>.from(json.decode(str).map((x) => OtherExpenseModel.fromJson(x)));

String otherExpenseModelToJson(List<OtherExpenseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OtherExpenseModel {
  String label;
  List<MonthValue> monthValues;

  OtherExpenseModel({
    required this.label,
    required this.monthValues,
  });

  factory OtherExpenseModel.fromJson(Map<String, dynamic> json) => OtherExpenseModel(
    label: json["label"],
    monthValues: List<MonthValue>.from(json["monthValues"].map((x) => MonthValue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "monthValues": List<dynamic>.from(monthValues.map((x) => x.toJson())),
  };
}

class MonthValue {
  String label;
  int value;

  MonthValue({
    required this.label,
    required this.value,
  });

  factory MonthValue.fromJson(Map<String, dynamic> json) => MonthValue(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}


// List<DashboardAndProjectDropdown> projectDropdownFromJson(String str) => List<DashboardAndProjectDropdown>.from(json.decode(str).map((x) => DashboardAndProjectDropdown.fromJson(x)));
//
// String projectDropdownToJson(List<DashboardAndProjectDropdown> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class DashboardAndProjectDropdown {
//   String label;
//   int value;
//
//   DashboardAndProjectDropdown({
//     required this.label,
//     required this.value,
//   });
//
//   factory DashboardAndProjectDropdown.fromJson(Map<String, dynamic> json) => DashboardAndProjectDropdown(
//     label: json["label"],
//     value: json["value"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "label": label,
//     "value": value,
//   };
// }
