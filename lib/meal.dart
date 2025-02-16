import 'package:flutter/material.dart';


class Meal {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String strArea;
  final String strCategory;
  final String strInstructions;
  final List<String> ingredients;

  Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.strArea,
    required this.strCategory,
    required this.strInstructions,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty && measure != null && measure.isNotEmpty) {
        ingredients.add('${measure} ${ingredient}');
      }
    }
    return Meal(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      strArea: json['strArea'] ?? '',
      strCategory: json['strCategory'] ?? '',
      strInstructions: json['strInstructions'] ?? '',
      ingredients: ingredients,
    );
  }
}

class MealDetailsPage extends StatelessWidget {
  final Meal meal;

  const MealDetailsPage({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView( // Use CustomScrollView for better scrolling
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0, // Image takes up more of the app bar
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                meal.strMealThumb,
                fit: BoxFit.cover,
                errorBuilder: (context, object, stackTrace) =>
                const Icon(Icons.error),
              ),
            ),
            pinned: true, // AppBar stays visible
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  meal.strMeal,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.category, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('Catégorie: ${meal.strCategory}',
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(width: 16),
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('Région: ${meal.strArea}',
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Instructions:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(meal.strInstructions),
                const SizedBox(height: 16),
                const Text(
                  'Ingrédients:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: meal.ingredients.map((ingredient) => Text('- $ingredient')).toList(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
