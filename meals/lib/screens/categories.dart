import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context) {
    // with pop we remove a screen, with push we move to a new screen
    // Navigator.push(context, route); - alternative to this below
    // MaterialPageRoute gives us a 'route'
    Navigator.of(context).push(
      MaterialPageRoute(
        // navigating(moving) to a screen with push
        builder: (ctx) => MealsScreen(
          title: 'Some title',
          meals: [],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
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
                _selectCategory(context);
              })
        ],
      ),
    );
  }
}
