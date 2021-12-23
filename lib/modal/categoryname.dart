class CategoryDemo {
  String? id;
  String? catName;

  CategoryDemo({this.id, this.catName});

  CategoryDemo.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.catName = json["cat_name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["cat_name"] = this.catName;
    return data;
  }
}
