import 'package:flutter/material.dart';

import 'ingredient.dart';

class HotDog{
  int id;
  String name;
  String thumb;
  String description;
  double price;
  Color color;
  List<Ingredient> ingredients = [];

  HotDog({this.id, this.thumb, this.name, this.description, this.price, this.color, this.ingredients});

}