import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    required this.category, 
    required this.onSelectCategory,
    super.key
    });

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    // GestureDetector does the same thing, but it doesnt give visual feedback when the user clicks on the item
    // with InkWell you get that visual feedback
    return InkWell( // wraping the container with this InkWell widget to make it tappable
      onTap: onSelectCategory , // set up a function that is triggered every time is this item is tapped
      splashColor: Theme.of(context).primaryColor, // base for this effect
      borderRadius: BorderRadius.circular(16), // allows to define a radius to give items a rounded courners,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
          colors: [
            category.color.withOpacity(0.55),
            category.color.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
