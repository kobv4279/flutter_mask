
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mask/viewmodel/store_model.dart';
import 'UI/view/main_page.dart';


void main() => runApp(ChangeNotifierProvider.value(
    value: StoreModel(),
    child: MyApp() ,
  ));


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

