import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryCard extends StatelessWidget{
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({
    required this.category,
    required this.onTap
});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        leading: Image.network(category.picture, width: 60),
        title: Text(category.name),
        subtitle: Text(
          category.description,
          maxLines: 2,
        ),
        onTap: onTap,
      ),
    );
  }
}