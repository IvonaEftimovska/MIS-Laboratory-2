class RecipeDetail {
  final String id;
  final String name;
  final String instructions;
  final String picture;
  final String? youtubeLink;
  final Map<String, String> ingredients;

  RecipeDetail({
    required this.id,
    required this.name,
    required this.instructions,
    required this.picture,
    required this.youtubeLink,
    required this.ingredients,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    Map<String, String> ingredients = {};

    for (int i = 1; i <= 20; i++) {
      String? ingredient = json["strIngredient$i"];
      String? measure = json["strMeasure$i"];

      if (ingredient == null || ingredient.isEmpty) continue;

      ingredients[ingredient] = measure ?? "";
    }

    return RecipeDetail(
      id: json["idMeal"],
      name: json["strMeal"],
      instructions: json["strInstructions"],
      picture: json["strMealThumb"],
      youtubeLink: json["strYoutube"],
      ingredients: ingredients,
    );
  }
}
