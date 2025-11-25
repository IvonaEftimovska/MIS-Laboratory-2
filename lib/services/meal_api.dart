import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/recipe_detail.dart';

class MealApi {
  static const base = "https://www.themealdb.com/api/json/v1/1";

  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse("$base/categories.php"));

    final data = json.decode(response.body);
    return (data["categories"] as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  static Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await http.get(Uri.parse("$base/filter.php?c={category}"));

    final data = json.decode(response.body);
    return (data["meals"] as List)
        .map((json) => Meal.fromJson(json))
        .toList();
  }

  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse("$base/search.php?s={query}"));

    final data = json.decode(response.body);
    return (data["meals"] as List)
        .map((json) => Meal.fromJson(json))
        .toList();
  }

  static Future<RecipeDetail> getRecipeDetail(String id) async {
    final response = await http.get(Uri.parse("$base/lookup.php?i={id}"));

    final data = json.decode(response.body);
    return RecipeDetail.fromJson(data["meals"][0]);
  }

  static Future<RecipeDetail> getRandomMeal() async {
    final response = await http.get(Uri.parse("$base/random.php"));

    final data = json.decode(response.body);
    return RecipeDetail.fromJson(data["meals"][0]);
  }
}