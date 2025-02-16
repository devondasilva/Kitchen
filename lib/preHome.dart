import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class preHome extends StatelessWidget {

  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
      return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/Logo.png'),
                ),
              ),
            ],
          ),
      );
  }
}