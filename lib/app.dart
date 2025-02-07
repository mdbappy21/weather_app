import 'package:flutter/material.dart';
import 'package:weather_app/ui.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Application',
      theme:_lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: ThemeMode.light,
      home: const HomeScreen(),
    );
  }

  ThemeData _lightTheme(){
    return ThemeData(
      brightness: Brightness.light,
      inputDecorationTheme:const InputDecorationTheme(
        enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
        focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
          fixedSize: const Size.fromWidth(double.maxFinite),
          padding: const EdgeInsets.symmetric(vertical:15)
        )
      ),

      // textTheme: TextTheme(
      //   bodyText2: TextStyle(
      //       color: Colors.white), // Apply color to subtitle text globally
      // ),
    );
  }
  ThemeData _darkTheme(){
    return ThemeData(
      brightness: Brightness.dark,
      inputDecorationTheme:const InputDecorationTheme(
        enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
        focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.black,
              fixedSize: const Size.fromWidth(double.maxFinite),
              padding: const EdgeInsets.symmetric(vertical:15)
          )
      ),
    );
  }
}