import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  // instead of StatefulWidget, this is provided by the Riverpod package, has some added functionalities to listen to changes from our provider
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    // instead of state its ConsumerState
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  // instead of state its consumer state
  int _selectedPageIndex = 0;
//  final List<Meal> _favoriteMeals = []; -- no longer needed, because the new favoriteMeals is created to use the favoriteMealsProvider
//  Map<Filter, bool> _selectedFilters = kInitialFilters;

/*  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
*/

/*  void _toggleMealFavoriteStatus(Meal meal) {
    // this function should either add a meal or remove a meal from favorites
    final isExisting = _favoriteMeals
        .contains(meal); // check whether favoriteMeals containts this meal

    if (isExisting) {
      // if it is true
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Marked as a favorite.');
    }
  }
*/ // -- this method is also not needed anymore, because this is managaged in the provider
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // close the drawer
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        // pushReplacement(instead of push) - makes sure that the current screen will be replaced by the FilteredScreen, and then the back button would not work because there is no place to go back to
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(
//            currentFilters: _selectedFilters,
              ),
        ),
      );

/*      setState(() {
        _selectedFilters = result ??
            kInitialFilters; // ?? checks whether the value in front of it is null, if it is null the fallback defined value after the ?? will be used
      });
    }*/
      /* else {
      Navigator.of(context).pop(); 
    } */ // we dont need the else statement because its called at the start
    }
  }

  @override
  Widget build(BuildContext context) {
    // ref.read() gets the data from the provider once
    // ref.watch() sets up a listener to make sure that the build method executes again as the data changes
    // ref property is simular to 'widget' property

    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
//      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
//        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ), // this adds the navigation drawer on the home screen
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ), // this is the tab bar
    );
  }
}
