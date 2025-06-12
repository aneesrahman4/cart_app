import 'package:flutter/material.dart';
import 'routes/app_route_configuration.dart';

void main() {
  runApp(const CartApp());
}

class CartApp extends StatelessWidget {
  const CartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cart App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      routerConfig: MyRouterApp.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
