import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mingo_2/controllers/theme_controller.dart';
import 'package:mingo_2/models/hotdog.dart';
import 'package:mingo_2/pages/hotdog_page.dart';
import 'package:mingo_2/repositories/hotdogs_repository.dart';
import 'package:mingo_2/services/auth_service.dart';
import 'package:mingo_2/widgets/thumbAnimation.dart';
import 'package:provider/provider.dart';
import '../pages/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = ThemeController.to;

  /*
  @override
  void initState() {
    super.initState();
    controller = HomeController();
  }
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardápio'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Obx(() => controller.isDark.value
                      ? Icon(Icons.brightness_7)
                      : Icon(Icons.brightness_2)),
                  title: Obx(() =>
                      controller.isDark.value ? Text('Light') : Text('Dark')),
                  onTap: () => controller.changeTheme(),
                ),
              ),
              PopupMenuItem(
                  child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sair'),
                onTap: () {
                  Navigator.pop(context);
                  AuthService.to.logout();
                },
              )),
            ],
          ),
        ],
        centerTitle: true,
      ),
      body: Consumer<HotDogsRepository>(
        builder: (context, repository, child) {
          return ListView.separated(
            itemCount: repository.hotDogs.length,
            itemBuilder: (BuildContext context, int i) {
              final List<HotDog> menu = repository.hotDogs;
              print('------${menu[i].thumb}');
              //
              return ListTile(
                leading: ThumbAnimation(
                  thumbImage: menu[i].thumb,
                  width: 80,
                ),
                title: Text(menu[i].name),
                trailing: Text('R\$ ${menu[i].price.toStringAsFixed(2)}'),
                onTap: () {
                  Get.to(
                    () => HotDogPage(
                      key: Key(menu[i].name),
                      hotDog: menu[i],
                    ),
                  );
                },
              );
            },
            separatorBuilder: (_, __) => Divider(),
            padding: EdgeInsets.all(16),
          );
        },
      ),
    );
  }
}
