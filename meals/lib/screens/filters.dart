import 'package:flutter/material.dart';
//import 'package:meals/screens/tabs.dart';
//import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false; // initially filter is not set

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
  /*    drawer: MainDrawer(
        onSelectScreen: (identifier) {
          Navigator.of(context).pop();
          if (identifier == 'meals') {
            Navigator.of(context).pushReplacement( // does the same, it just replaces the TabsScreen with the currentScreen, and the back button doesnt work
              MaterialPageRoute(
                builder: (ctx) => const TabsScreen(),
              ),
            );
          }
        },
      ),  */ // filters screen doesnt need a drawer
      body: Column(
        children: [
          SwitchListTile(
            // a list full of switches, can be taped by the user to turn something on or off
            value: _glutenFreeFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _glutenFreeFilterSet = isChecked;
              });
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            subtitle: Text(
              // to render some extra explanation
              'Only include gluten-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            activeColor: Theme.of(context)
                .colorScheme
                .tertiary, // controls which color will be used for the switch if it is turned on
            contentPadding: const EdgeInsets.only(
              // controls how much padding will be used inside of this listTile
              left: 34,
              right: 22,
            ),
          ),
        ],
      ),
    );
  }
}
