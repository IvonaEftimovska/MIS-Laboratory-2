import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealGridItem extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  const MealGridItem({
    required this.meal,
    required this.onTap
});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Image.network(
                meal.picture,
                height: 120),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                  meal.name,
                  textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}