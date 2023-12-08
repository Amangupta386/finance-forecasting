// To parse this JSON data, do
//
//     final expenseCategoryAndSubCategory = expenseCategoryAndSubCategoryFromJson(jsonString);

import 'dart:convert';

List<ExpenseCategoryAndSubCategory> expenseCategoryAndSubCategoryFromJson(String str) => List<ExpenseCategoryAndSubCategory>.from(json.decode(str).map((x) => ExpenseCategoryAndSubCategory.fromJson(x)));

String expenseCategoryAndSubCategoryToJson(List<ExpenseCategoryAndSubCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseCategoryAndSubCategory {
  int? id;
  String? name;
  int? parentId;
  String? createdAt;
  String? createdById;
  String? updatedAt;
  String? updatedById;
  List<SubCategory>? children;

  ExpenseCategoryAndSubCategory({
     this.id,
     this.name,
     this.parentId,
     this.createdAt,
     this.createdById,
     this.updatedAt,
     this.updatedById,
     this.children,
  });

  factory ExpenseCategoryAndSubCategory.fromJson(Map<String, dynamic> json) => ExpenseCategoryAndSubCategory(
    id: json["id"],
    name: json["name"],
    parentId: json["parentId"],
    createdAt: json["createdAt"],
    createdById: json["createdById"],
    updatedAt: json["updatedAt"],
    updatedById: json["updatedById"],
    children: List<SubCategory>.from(json["children"].map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parentId": parentId,
    "createdAt": createdAt,
    "createdById": createdById,
    "updatedAt": updatedAt,
    "updatedById": updatedById,
    "children": List<dynamic>.from(children!.map((x) => x.toJson())),
  };
}

class SubCategory {
  String name;
  int? parentId;

  SubCategory({
    required this.name,
    this.parentId,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    name: json["name"],
    parentId: json["parentId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "parentId": parentId,
  };
}