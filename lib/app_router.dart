import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notion_clone/features/auth/screens/login_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: <GoRoute>[
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
  ],
);
