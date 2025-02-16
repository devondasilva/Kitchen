import 'package:KitchenApp/preHome.dart';
import 'package:KitchenApp/registration.dart';
import 'package:flutter/material.dart';//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home.dart';


void main() {
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: preHome(),
    );
  }
}

