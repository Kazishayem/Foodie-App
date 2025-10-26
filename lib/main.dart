import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_app/bloc/Checkout/checkout_bloc.dart';
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
        BlocProvider(create: (context) => CheckoutBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:foodie_app/bloc/checkout/checkout_bloc.dart';
// import 'package:foodie_app/bloc/product/product_bloc.dart';
// import 'package:foodie_app/bloc/product/product_event.dart';
// import 'package:foodie_app/bloc/cart/cart_bloc.dart';
// import 'package:foodie_app/bloc/cart/cart_event.dart';
// import 'package:foodie_app/repositories/product_repository.dart';
// import 'package:foodie_app/pages/splash_screen.dart';

// void main() {
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) =>
//               ProductBloc(ProductRepository())..add(FetchProducts()),
//         ),
//         BlocProvider(create: (context) => CartBloc()..add(LoadCart())),
//         BlocProvider(create: (context) => CheckoutBloc()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }
