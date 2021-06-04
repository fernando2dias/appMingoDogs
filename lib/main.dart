import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mingo_2/controllers/theme_controller.dart';
import 'package:mingo_2/pages/home_page.dart';
import 'package:mingo_2/repositories/hotdogs_repository.dart';
import 'package:mingo_2/widgets/checkauth.dart';
import 'package:provider/provider.dart';

import 'package:mingo_2/config.dart';

void main() async {

  await initConfigurations();

  runApp(
    ChangeNotifierProvider(
      create: (context) => HotDogsRepository(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeController.to.loadThemeMode();

    return GetMaterialApp(
      title: 'MingoDogs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.grey,
        accentColor: Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black45,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurpleAccent[100],
          ),
        ),
      ),
      home: CheckAuth(),
    );
  }
}
