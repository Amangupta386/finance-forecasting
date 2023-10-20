// To parse this JSON data, do
//
//     final monthBreakdownModel = monthBreakdownModelFromJson(jsonString);

import 'dart:convert';

List<MonthBreakdownModel> monthBreakdownModelFromJson(String str) => List<MonthBreakdownModel>.from(json.decode(str).map((x) => MonthBreakdownModel.fromJson(x)));

String monthBreakdownModelToJson(List<MonthBreakdownModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MonthBreakdownModel {
  String label;
  List<MonthValue> monthValues;

  MonthBreakdownModel({
    required this.label,
    required this.monthValues,
  });

  factory MonthBreakdownModel.fromJson(Map<String, dynamic> json) => MonthBreakdownModel(
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
  String commentData;

  MonthValue({
    required this.label,
    required this.value,
    required this.commentData,
  });

  factory MonthValue.fromJson(Map<String, dynamic> json) => MonthValue(
    label: json["label"],
    value: json["value"],
    commentData: json["commentData"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
    "commentData": commentData,
  };
}
