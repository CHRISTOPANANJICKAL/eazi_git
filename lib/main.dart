import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/MainScreen/main_screen.dart';
import 'Screens/Provider/search_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => SearchProvider())],child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(appBar:AppBar(
       title: Text("Eazi Git"),
      ),
          body: MainScreen()),
      theme:  ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.windows: CupertinoPageTransitionsBuilder(),TargetPlatform.android: CupertinoPageTransitionsBuilder()}),
      ),
    );
  }
}
