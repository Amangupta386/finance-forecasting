
import 'dart:convert';
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
List<DashboardAndProjectDropdown> projectDropdownFromJson(String str) => List<DashboardAndProjectDropdown>.from(json.decode(str).map((x) => DashboardAndProjectDropdown.fromJson(x)));

String projectDropdownToJson(List<DashboardAndProjectDropdown> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DashboardAndProjectDropdown {
  String label;
  int value;

  DashboardAndProjectDropdown({
    required this.label,
    required this.value,
  });

  factory DashboardAndProjectDropdown.fromJson(Map<String, dynamic> json) => DashboardAndProjectDropdown(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}
