import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_route_configuration.dart';
import 'providers/product_providers.dart';
import 'providers/cart_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: MyRouterApp.router,
      ),
    );
  }
}
