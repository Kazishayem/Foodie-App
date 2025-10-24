import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/Product/product_bloc.dart';
import 'bloc/Product/product_event.dart';
import 'bloc/Cart/cart_bloc.dart';
import './bloc/Cart/cart_event.dart';
import './repositories/product_repository.dart';
import 'pages/Splash_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductBloc(ProductRepository())..add(FetchProducts()),
        ),
        BlocProvider(create: (context) => CartBloc()..add(LoadCart())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
       home: SplashScreen());
  }
}
