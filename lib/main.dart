import 'package:flutter/material.dart';
import 'package:cart_app/providers/product_providers.dart';
import 'routes/app_route_configuration.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductProvider())],
      child: const CartApp(),
    ),
  );
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
