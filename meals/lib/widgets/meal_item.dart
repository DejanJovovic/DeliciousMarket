import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

// outputing meal item data in that list of meals
class MealItem extends StatelessWidget {
  const MealItem({required this.meal, super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        // gives this card a rounded courners
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip
          .hardEdge, //ensures that any content that would go out of the shape above would be cut off, clips the widget
      elevation: 2, // gives 3d effect
      child: InkWell(
        // using InkWell here also because meals should also be tappable
        onTap: () {},
        child: Stack(
          // widget that can be used to position multiple widgets above each other, for example set an image for a background and have some text on top of it
          children: [
            FadeInImage(
              // utility widget that displays an image that's being faded in, when its loading its not poping in but fading in
              placeholder: MemoryImage(// knows how to load images from memory
                  kTransparentImage // contains memory image that is loaded as a placeholder
                  ),
              image: NetworkImage(// image fetched from the internet
                  meal.imageUrl),
              fit: BoxFit
                  .cover, // makes sure that the image is never distored, instead is cut off and zoomed on a bit if it wouldnt fit into the box otherwise
              height: 200,
              width: double
                  .infinity, // tell the image to use as much space as it needs horizontally
            ),
            // widget that displays a name of the meals as well as the meta information of the meal
            Positioned(
              // here we define how this child widget should be positioned on top of the above widget FadeInImage
              // starts at left border of the image with left: 0, and ends at the right border with right: 0 of the image with this configuration
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54, // transparent black color,
                padding: const EdgeInsets.symmetric(
                  horizontal: 44,
                  vertical: 6,
                ),
                // adding text here
                child: Column(
                  children: [
                    // with maxLines we restric the text to have 2 max lines
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true, // text is wrapped in a good way
                      // elipisis - adds ... if the text is too long
                      overflow: TextOverflow
                          .ellipsis, // controls how the text will be cut off if it need to be cut off if its too long
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                        height: 12), // to add some spacing between rows
                    Row(
                      children: [],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
