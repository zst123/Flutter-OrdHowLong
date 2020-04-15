import 'package:flutter/material.dart';
import 'package:ordhowlong/main.dart';

class ScreenAbout extends StatelessWidget {
  static const String TITLE = 'About';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyApp.primaryColor,
      child: Center(
        child: Text("Created by:\nManzel Seet",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 30.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900, height: 1.2
            ),
        ),
      ),
    );
  }
}

