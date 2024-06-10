import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/providers/meals_provider.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      // if the ids are not equal, i know that the meal i am taking a look at is not the meal i am toggling to favorite status for
      // this is how to remove a meal
      state = state
          .where((m) => m.id != m.id)
          .toList(); // filters a list and get a new list
      return false;
    } else {
      state = [
        ...state,
        meal
      ]; // ... spread operator-- is used to pull out all the elements that are stored in that list and add them as individual elements in that new list
      return true;
    }
  }
}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {// optimized for data that can change
  return FavoriteMealsNotifier();
});


// a new provider

// a provider that returns a list of filtered meals
final filteredMealsProvider = Provider((ref) {

  // those two make sure that they are reexecuted whenever the value below changes
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList(); // to make sure a list is returned, not an iterable
});
