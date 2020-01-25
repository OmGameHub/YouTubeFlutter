import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import 'MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => lightTheme,
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          title: 'YouTube App',
          theme: theme,
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        );
      }
    );
  }
}

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Color(0xff7c7c7c),
    ),
  ),
  primaryColor: Colors.white,
  brightness: Brightness.light,
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    body1: TextStyle(
      fontFamily: 'Roboto-Regular',
      fontWeight: FontWeight.normal,
    )
  )
);