import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mingo_2/database/db.dart';
import 'package:mingo_2/models/hotdog.dart';
import 'package:mingo_2/models/ingredient.dart';
import 'package:provider/provider.dart';

class HotDogsRepository extends ChangeNotifier {
  final List<HotDog> _hotDogs = [];

  UnmodifiableListView<HotDog> get hotDogs => UnmodifiableListView(_hotDogs);

  void addIngredient({HotDog hotDog, Ingredient ingredient}) async {
    var db = await DB.get();
    int id = await db.insert('ingredients', {
      'item': ingredient.item,
      'additionalPrice': ingredient.additionalPrice,
      'hotdog_id': hotDog.id
    });
    ingredient.id = id;
    hotDog.ingredients.add(ingredient);
    notifyListeners();
  }

  void editIngredient(
      {Ingredient ingredient, String item, double additionalPrice}) async {
    var db = await DB.get();
    await db.update(
        'ingredients', {'item': item, 'additionalPrice': additionalPrice},
        where: 'id = ?', whereArgs: [ingredient.id]);

    ingredient.item = item;
    ingredient.additionalPrice = additionalPrice;
    notifyListeners();
  }

  static setupHotDogs() {
    return [
      HotDog(
        thumb: 'https://www.revistamenu.com.br/wp-content/uploads/2020/08/appdog.jpg',
        name: 'Paulista',
        description: 'O tradicional hotdog de São Paulo',
        price: 14.90,
        color: Colors.red[900],
      ),

      HotDog(
        thumb:
        'https://static-images.ifood.com.br/image/upload/t_high/pratos/6b012040-d41b-466d-8be2-e1d04577f547/202103311217_wM2g_.jpeg',
        name: 'Pensivânia',
        description: 'O tradicional hotdog da Pensilvânia',
        price: 18.90,
        color: Colors.red[900],
      ),

      HotDog(
        thumb:
        'https://static-images.ifood.com.br/image/upload/t_high/pratos/6b012040-d41b-466d-8be2-e1d04577f547/202103311142_zkzH_.jpeg',
        name: 'Tesouro do Holandês Voador',
        description: 'O lanche preferido do Jack',
        price: 21.90,
        color: Colors.red[900],
      ),

      HotDog(
        thumb:
        'https://static-images.ifood.com.br/image/upload/t_high/pratos/6b012040-d41b-466d-8be2-e1d04577f547/202103311308_TUO5_.jpeg',
        name: 'Alemão (Vegano)',
        description: 'O lanche sem graça',
        price: 18.90,
        color: Colors.red[900],
      ),

      HotDog(
        thumb:
        'https://static-images.ifood.com.br/image/upload/t_high/pratos/6b012040-d41b-466d-8be2-e1d04577f547/202103311259_EBck_.jpeg',
        name: 'Argentina',
        description: 'O melhor hotdog dos ermanos',
        price: 17.90,
        color: Colors.red[900],
      ),

      HotDog(
        thumb:
        'https://static-images.ifood.com.br/image/upload/t_high/pratos/6b012040-d41b-466d-8be2-e1d04577f547/202103311307_wfCM_.jpeg',
        name: 'Carioca',
        description: 'Malandro que é malandro pega este aqui',
        price: 15.90,
        color: Colors.red[900],
      ),

      HotDog(
        thumb:
        'https://static-images.ifood.com.br/image/upload/t_high/pratos/6b012040-d41b-466d-8be2-e1d04577f547/202103311311_wTYG_.jpeg',
        name: 'New York (Kids)',
        description: 'Para mulecada encher o bucho',
        price: 9.90,
        color: Colors.red[900],
      ),

      HotDog(
        thumb:
        'https://static-images.ifood.com.br/image/upload/t_high/pratos/6b012040-d41b-466d-8be2-e1d04577f547/202103311257_sHrr_.jpeg',
        name: 'Ohio',
        description: 'Encheu uma laje? Recomendo este aqui!',
        price: 18.90,
        color: Colors.red[900],
      ),

      HotDog(
        thumb:
        'https://static-images.ifood.com.br/image/upload/t_high/pratos/6b012040-d41b-466d-8be2-e1d04577f547/202103311254_HvvG_.jpeg',
        name: 'Seatle',
        description: 'The Best',
        price: 19.90,
        color: Colors.red[900],
      ),

      HotDog(
        thumb:
        'https://static-images.ifood.com.br/image/upload/t_high/pratos/6b012040-d41b-466d-8be2-e1d04577f547/202103311310_aZUG_.jpeg',
        name: 'India(Vegano)',
        description: 'Sem graça tbm ahahah',
        price: 18.90,
        color: Colors.red[900],
      ),





    ];
  }

  HotDogsRepository() {
    //  _hotDogs.addAll();
    initRepository();
  }

  initRepository() async {
    var db = await DB.get();
    List hotDogs = await db.query('hotdogs');
    // Equivalente a db.rawQuery (SELECT * FROM hotdogs);

    for (var hotDog in hotDogs) {
      _hotDogs.add(HotDog(
          id: hotDog['id'],
          name: hotDog['name'],
          description: hotDog['description'],
          thumb: hotDog['thumb'],
          price: hotDog['price'],
          color: Color(int.parse(hotDog['color'])),
          ingredients: await getIngredients(hotDog['id'])));
    }
    notifyListeners();
  }

  getIngredients(hotDogId) async {
    var db = await DB.get();
    var results = await db
        .query('ingredients', where: 'hotdog_id = ?', whereArgs: [hotDogId]);
    List<Ingredient> ingredients = [];

    for (var ingredient in results) {
      ingredients.add(Ingredient(
          id: ingredient['id'],
          item: ingredient['item'],
          additionalPrice: ingredient['additionalPrice']));
    }
    return ingredients;
  }
}
