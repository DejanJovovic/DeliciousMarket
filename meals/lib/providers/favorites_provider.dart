import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

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
