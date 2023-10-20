import 'dart:convert';

List<ResourceCostModel> resourceCostModelFromJson(String str) => List<ResourceCostModel>.from(json.decode(str).map((x) => ResourceCostModel.fromJson(x)));

String resourceCostModelToJson(List<ResourceCostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResourceCostModel {
  String label;
  List<MonthValue> monthValues;

  ResourceCostModel({
    required this.label,
    required this.monthValues,
  });

  factory ResourceCostModel.fromJson(Map<String, dynamic> json) => ResourceCostModel(
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
  dynamic value;

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
