import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    this.title,
    required this.onToggleFavorite,
    required this.meals, 
    super.key});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealDetailsScreen(
        meal: meal,
        onToggleFavorite: onToggleFavorite,
        ),
      ),
      );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh ... nothing here',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ],
        ),
      ); 

    if (meals.isNotEmpty) {
      content = ListView.builder(
        // creates a scrollable listView and makes sure that only items that are actually visible will be displayed
        itemCount: meals.length, // with this line flutter renders the list view correctly
        itemBuilder: (ctx, index) => MealItem(meal: meals[index], onSelectMeal: (meal){
          selectMeal(context, meal);
        },) // meals[index] gives a single meal that is passed as value to the meal parameter on the MealItem class
        );
    }

    if(title == null){
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
