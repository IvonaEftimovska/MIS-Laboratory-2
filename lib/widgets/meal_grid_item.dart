import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/favorites_service.dart';

class MealGridItem extends StatefulWidget {
  final Meal meal;
  final VoidCallback onTap;

  const MealGridItem({
    required this.meal,
    required this.onTap,
  });

  @override
  _MealGridItemState createState() => _MealGridItemState();
}

class _MealGridItemState extends State<MealGridItem> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    loadFavorite();
  }

  void loadFavorite() async {
    isFavorite = await FavoritesService.isFavorite(widget.meal.id);
    setState(() {});
  }

  void toggleFavorite() async {
    if (isFavorite) {
      await FavoritesService.removeFavorite(widget.meal.id);
    } else {
      await FavoritesService.addFavorite(widget.meal.id);
    }
    setState(() => isFavorite = !isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: widget.onTap,
              child: Image.network(
                widget.meal.picture,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Meal name
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.meal.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: toggleFavorite,
              ),
            ],
          )
        ],
      ),
    );
  }
}
