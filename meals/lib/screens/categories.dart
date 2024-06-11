import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen(
      {required this.availableMeals,
      //   required this.onToggleFavorite,
      super.key});

//  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// with allows to add a mix in into a class, another class beign merged into this class
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // late -- this value will have a value as soon as its been used the first time, but not when the class is created
  late AnimationController
      _animationController; // animation controller is stored here

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync:
          this, // responsbile for making sure that this animation executes for every frame
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1, // between which value flutter animates
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    // this controller is removed from device memory when this widget is destroyed
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    // filter this dummyMeals list, returns a new itterable, that only contains items that match a certain condition
    final filteredMeals = widget.availableMeals
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
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      // SlideTransition animates a movement of a widget from one position to another
      builder: (context, child) => SlideTransition(
        position: Tween(
          // tween describes the transition between two values
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
              // configuration object
              parent: _animationController,
              curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );
  }
}
