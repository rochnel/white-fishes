class Category {
  String name;

  Category(this.name);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
