import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    required this.availableMeals,
 //   required this.onToggleFavorite,
    super.key
    });

//  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;


  void _selectCategory(BuildContext context, Category category) {
    // filter this dummyMeals list, returns a new itterable, that only contains items that match a certain condition
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList(); // reach out to meal.categories and check if it contains category.id of the category that was selected here

    // with pop we remove a screen, with push we move to a new screen
    // Navigator.push(context, route); - alternative to this below
    // MaterialPageRoute gives us a 'route'
    Navigator.of(context).push(
      MaterialPageRoute(
        // navigating(moving) to a screen with push
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
//          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      // rendering a grid of items
      padding: const EdgeInsets.all(24),
      // gridDelegate - controls the layout of the grid items
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // two columns next to each other
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20, // spacing between columns
        mainAxisSpacing: 20, // spacing horizontally and vertically
      ),
      children: [
        // alternative to using availableCategories.map((category) => CategoryGridItem(category: category)).toList()
        for (final category in availableCategories)
          CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              })
      ],
    );
  }
}
