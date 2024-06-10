import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';


//Riverpod is a package that is all about simplifing cross widget states
final mealsProvider = Provider((ref){
  return dummyMeals;
});