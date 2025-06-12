import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_route_constants.dart';
import 'package:cart_app/LoginScreen.dart';
import 'package:cart_app/signup.dart';

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
    ],
  );
}
