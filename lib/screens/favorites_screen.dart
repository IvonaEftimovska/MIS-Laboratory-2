import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../services/meal_api.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Meal> favorites = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final ids = await FavoritesService.getFavorites();
    List<Meal> meals = [];

    for (String id in ids) {
      final detail = await MealApi.getRecipeDetail(id);
      meals.add(Meal(id: detail.id, name: detail.name, picture: detail.picture));
    }

    setState(() {
      favorites = meals;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite Recipes")),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, i) {
          final meal = favorites[i];
          return ListTile(
            leading: Image.network(meal.picture, width: 60),
            title: Text(meal.name),
            onTap: () {
              // Navigate to details
            },
          );
        },
      ),
    );
  }
}
