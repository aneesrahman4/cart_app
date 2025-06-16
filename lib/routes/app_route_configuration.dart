import 'package:cart_app/product_details.dart';
import 'package:cart_app/product_screen.dart';
import 'package:go_router/go_router.dart';
import 'app_route_constants.dart';
import 'package:cart_app/LoginScreen.dart';
import 'package:cart_app/signup.dart';
import 'package:cart_app/cart_screen.dart';

class MyRouterApp {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        name: AppRouteConstants.LoginRouteName,
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: AppRouteConstants.SignupRouteName,
        path: '/signup',
        builder: (context, state) => const Signup(),
      ),
      GoRoute(
        name: AppRouteConstants.ProductsRouteName,

        path: '/Products',
        builder: (context, state) => const Product(),
      ),

      GoRoute(
        name: AppRouteConstants.ProductDetailRouteName,
        path: '/product/:name/:price',
        builder: (context, state) {
          final name = state.pathParameters['name']!;
          final price = state.pathParameters['price']!;
          return ProductDetails(name: name, price: price);
        },
      ),
      GoRoute(
        name: AppRouteConstants.CartRouteName,
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
    ],
  );
}
