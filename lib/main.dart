import 'package:flutter/material.dart';
import 'pages/Splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: SplashScreen(),
      // home: ProductShow(
      //   product: {
      //     'name': 'Cheeseburger',
      //     'subtitle': "Wendy's Burger",
      //     'rating': 4.8,
      //     'image': 'assets/images/burger3.png',
      //   },
      // ),
    );
  }
}
