import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailsScreen extends StatelessWidget{

  const MealDetailsScreen({
    required this.meal,
    super.key
    });
  
  final Meal meal;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Image.network(// image.network loads spaces from web and loads it in the app
        meal.imageUrl,
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
        ), 
    );
  }
}