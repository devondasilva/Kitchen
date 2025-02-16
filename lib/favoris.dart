import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'meal.dart';

class FavoritesPage extends StatefulWidget {
  final List<Meal> meals;
  final Set<String> favoriteMeals;

  const FavoritesPage({
    Key? key,
    required this.meals,
    required this.favoriteMeals,
  }) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    // Filtre les recettes favorites
    final favoriteMealsList = widget.meals
        .where((meal) => widget.favoriteMeals.contains(meal.idMeal))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
      ),
      body: ListView.builder(
        itemCount: favoriteMealsList.length,
        itemBuilder: (context, index) {
          final meal = favoriteMealsList[index];
          return MealCard(
            meal: meal,
            favoriteMeals: widget.favoriteMeals,
            onFavoritePressed: (mealId) {
              setState(() {
                widget.favoriteMeals.remove(mealId); // Retire la recette des favoris
              });
            },
          );
        },
      ),
    );
  }
}