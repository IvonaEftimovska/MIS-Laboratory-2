class Category {
  final String id;
  final String name;
  final String picture;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.picture,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["idCategory"],
      name: json["strCategory"],
      picture: json["strCategoryThumb"],
      description: json["strCategoryDescription"],
    );
  }
}
