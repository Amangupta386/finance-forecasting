class DropDownModel {
  int id;
  String name;

  DropDownModel({
    required this.id,
    required this.name,
  });

  factory DropDownModel.fromJson(Map<String, dynamic> json) {
    return DropDownModel(
      id: int.parse('${json['id']}'),
      name: '${json['name'] ?? json['projectName']}',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}