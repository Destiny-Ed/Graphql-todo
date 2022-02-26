import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:joovlin/Provider/Mutations/add_todo_provider.dart';
import 'package:joovlin/Screen/home_page.dart';
import 'package:joovlin/Styles/color.dart';
import 'package:provider/provider.dart';

void main() async {
  await initHiveForFlutter();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddTaskProvider()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
