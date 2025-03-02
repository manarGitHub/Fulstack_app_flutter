import 'package:flutter/material.dart';
import 'package:shop_app/widgets/grocery_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 94, 74, 128),
          surface: const Color.fromARGB(255, 114, 98, 49)
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 53, 47, 26),
        useMaterial3: true,
      ),
      home: const GroceryList()
    );
  }
}


