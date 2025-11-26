import 'package:flutter/material.dart';
import '../services/meal_api.dart';
import '../models/recipe_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;

  const MealDetailScreen({required this.mealId});

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  RecipeDetail? meal;

  @override
  void initState() {
    super.initState();
    loadMeal();
  }

  void loadMeal() async {
    meal = await MealApi.getRecipeDetail(widget.mealId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (meal == null) return Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(title: Text(meal!.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(meal!.picture),

            Padding(
              padding: EdgeInsets.all(12),
              child: Text(meal!.instructions),
            ),

            Text("Ingredients", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            ...meal!.ingredients.entries.map((e) =>
                ListTile(
                  title: Text("${e.key} - ${e.value}"),
                )
            ),

            if (meal!.youtubeLink != null)
              TextButton(
                child: Text("Watch on YouTube"),
                onPressed: () => launchUrl(Uri.parse(meal!.youtubeLink!)),
              )
          ],
        ),
      ),
    );
  }
}
