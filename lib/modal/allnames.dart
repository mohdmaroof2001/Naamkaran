class NamesDemo {
  String? id;
  String? categoryId;
  String? name;
  String? meaning;
  String? gender;

  NamesDemo({this.id, this.categoryId, this.name, this.meaning, this.gender});

  NamesDemo.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.categoryId = json["category_id"];
    this.name = json["name"];
    this.meaning = json["meaning"];
    this.gender = json["gender"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["category_id"] = this.categoryId;
    data["name"] = this.name;
    data["meaning"] = this.meaning;
    data["gender"] = this.gender;
    return data;
  }
}
