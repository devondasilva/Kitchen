import 'package:flutter/material.dart';//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home.dart';
import 'login.dart';


void main() {
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

