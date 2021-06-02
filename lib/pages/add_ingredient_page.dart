import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mingo_2/models/hotdog.dart';
import 'package:mingo_2/models/ingredient.dart';
import 'package:mingo_2/repositories/hotdogs_repository.dart';
import 'package:provider/provider.dart';

class AddIngredientPage extends StatefulWidget {
  HotDog hotDog;

  AddIngredientPage({Key key, this.hotDog});

  @override
  _AddIngredientPageState createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  final _ingredient = TextEditingController();
  final _additionalPrice = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  save() {
    Provider.of<HotDogsRepository>(context, listen: false).addIngredient(
      hotDog: widget.hotDog,
      ingredient: Ingredient(
        item: _ingredient.text,
        additionalPrice: double.parse(_additionalPrice.text),
      ),
    );

    Get.back();
    Get.snackbar(
      'Sucesso \\o/',
      'Ingrediente cadastrado com sucesso!',
      backgroundColor: Colors.grey[900],
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Ingrediente'),
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
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    save();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Salvar',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
