import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:mingo_2/repositories/hotdogs_repository.dart';
import 'package:mingo_2/models/ingredient.dart';


class EditIngredientPage extends StatefulWidget {
  Ingredient ingredient;

  EditIngredientPage({Key key, this.ingredient}) : super(key: key);

  @override
  _EditIngredientPageState createState() => _EditIngredientPageState();
}

class _EditIngredientPageState extends State<EditIngredientPage> {
  final _ingredient = TextEditingController();
  final _additionalPrice = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    _ingredient.text = widget.ingredient.item;
    _additionalPrice.text = widget.ingredient.additionalPrice.toString();

  }

  edit(){
    Provider.of<HotDogsRepository>(context, listen: false).editIngredient(
      ingredient: widget.ingredient,
      item: _ingredient.text,
      additionalPrice: double.parse(_additionalPrice.text),
    );

    Get.back();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Ingrediente'),
        backgroundColor: Colors.grey[800],
        actions: [IconButton(icon: Icon(Icons.check), onPressed: edit)],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                  'Por favor preencha os dados abaixo.\nNome do ingrediente e valor que pode ser cobrando quando for um adicional.'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: TextFormField(
                controller: _ingredient,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingrediente',
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe o ingrediente';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: TextFormField(
                controller: _additionalPrice,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Valor R\$ do ingrediente',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe o valor do ingrediente';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
