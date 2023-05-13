import 'package:flutter_application_1/calorie_tracker/all_food.dart';

import 'imports.dart';
// ignore_for_file: prefer_const_constructors

void main() {
  runApp(const FitnessApp());
}

class FitnessApp extends StatefulWidget {
  const FitnessApp({super.key});

  @override
  State<FitnessApp> createState() => _FitnessAppState();
}

class _FitnessAppState extends State<FitnessApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          systemNavigationBarColor: Constants.backgroundgrey,
          statusBarColor:
              Constants.backgroundgrey, // Only honored in Android M and above
          statusBarIconBrightness: Brightness.dark),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AllFood(),
    );
  }
}
