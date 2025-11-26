import 'package:flutter/material.dart';
import '../services/meal_api.dart';
import '../models/meal.dart';
import '../widgets/meal_grid_item.dart';
import 'meal_details.dart';

class MealsByCategoryScreen extends StatefulWidget {
  final String category;

  const MealsByCategoryScreen({required this.category});

  @override
  _MealsByCategoryScreenState createState() => _MealsByCategoryScreenState();
}

class _MealsByCategoryScreenState extends State<MealsByCategoryScreen> {
  List<Meal> meals = [];
  String search = "";

  @override
  void initState() {
    super.initState();
    loadMeals();
  }

  void loadMeals() async {
    meals = await MealApi.getMealsByCategory(widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filtered = meals
        .where((m) =>
        m.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search meals...",
                  prefixIcon: Icon(Icons.search)),
              onChanged: (v) => setState(() => search = v),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: .8,
              children: filtered
                  .map((meal) => MealGridItem(
                meal: meal,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MealDetailScreen(mealId: meal.id),
                    ),
                  );
                },
              ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
