import 'package:flutter/material.dart';
import 'package:mingo_2/models/ingredient.dart';
import 'package:mingo_2/repositories/hotdogs_repository.dart';
import 'package:mingo_2/widgets/thumbAnimation.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../models/hotdog.dart';
import 'add_ingredient_page.dart';
import 'edit_ingredient_page.dart';
import 'package:mingo_2/widgets/thumbAnimation.dart';

class HotDogPage extends StatefulWidget {
  HotDog hotDog;

  HotDogPage({Key key, this.hotDog}) : super(key: key);

  @override
  _HotDogPageState createState() => _HotDogPageState();
}

class _HotDogPageState extends State<HotDogPage> {
  ingredientsPage() {
    Get.to(() => AddIngredientPage(hotDog: widget.hotDog));

  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.hotDog.color,
          title: Text(widget.hotDog.name),
          actions: [
            IconButton(icon: Icon(Icons.add), onPressed: ingredientsPage)
          ],
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.favorite),
                text: 'Descrição',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'Ingredientes',
              )
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(24),
                  child: ThumbAnimation(
                      thumbImage: widget.hotDog.thumb,
                      width: 300,
                      ),
                ),
                Text(
                  widget.hotDog.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(widget.hotDog.description),
              ],
            ),
            ingredients(),
          ],
        ),
      ),
    );
  }

  Widget ingredients() {
    
    final hotdog = Provider.of<HotDogsRepository>(context)
        .hotDogs.firstWhere((h) => h.id == widget.hotDog.id);

    final quantity = hotdog.ingredients.length;

    return quantity == 0
        ? Container(
            child: Center(
              child: Text('Nenhum ingrediente foi cadastrado ainda!'),
            ),
          )
        : ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.navigate_next),
                title: Text(hotdog.ingredients[index].item),
                trailing: Text(hotdog.ingredients[index].additionalPrice
                    .toString()),
                onTap: (){
                  Get.to(
                    EditIngredientPage(ingredient: hotdog.ingredients[index]),
                    fullscreenDialog: true,
                  );

                },
              );
            },
            separatorBuilder: (_, __) => Divider(),
            itemCount: quantity);
  }
}
