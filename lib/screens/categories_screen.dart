import 'package:flutter/material.dart';
import '../services/meal_api.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import 'meals_by_category.dart';
import 'favorites_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> categories = [];
  String search = "";

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() async {
    categories = await MealApi.getCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filtered = categories
        .where((c) =>
        c.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen())
              );
            },
          ),
        ]
        ,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search category...",
                  prefixIcon: Icon(Icons.search)
              ),
              onChanged: (value) => setState(() => search = value),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: filtered[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MealsByCategoryScreen(
                          category: filtered[index].name,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
