class Meal{
  final String id;
  final String name;
  final String picture;

  Meal({
    required this.id,
    required this.name,
    required this.picture
});

  factory Meal.fromJson(Map<String, dynamic> json){
    return Meal(
        id: json["idMeal"],
        name: json["strMealName"],
        picture: json["strMealPicture"]);
  }
}