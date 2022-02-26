import 'package:flutter/material.dart';
import 'package:joovlin/Screen/home_page.dart';
import 'package:joovlin/Styles/color.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Helvetica',
          appBarTheme: AppBarTheme(
            color: primaryColor,
          ),
          primaryColor: primaryColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: primaryColor,
          ),
          checkboxTheme: CheckboxThemeData(
            checkColor: MaterialStateProperty.resolveWith(
              (states) {
                return white;
              },
            ),
          )),
      home: const HomePage(),
    );
  }
}
