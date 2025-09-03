import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notion_clone/features/auth/screens/authenticating_screen.dart';
import 'package:notion_clone/features/auth/screens/email_auth_screen.dart';
import 'package:notion_clone/features/auth/screens/login_screen.dart';
import 'package:notion_clone/features/notion/screens/home_screen.dart';

class GoRouterRefreshStrem extends ChangeNotifier {
  GoRouterRefreshStrem(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((dynamic data) {
      print('>>>> [Auth State Listener] 상태 변경 감지. 이벤트 : ${data.event}');
      notifyListeners();
    });
  }
  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

GoRouter createRouter() {
  return GoRouter(
    refreshListenable: GoRouterRefreshStrem(supabase.auth.onAuthStateChange),
    initialLocation: '/login',
    routes: <GoRoute>[
      GoRoute(
        path: '/login',
        name: '/lgoin',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/email-auth/:email',
        pageBuilder: (context, state) {
          final child = EmailAuthScreen(email: state.pathParameters['email']!);
          return CustomTransitionPage(
            child: child,
            transitionsBuilder:
                (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child,
                ) => SlideTransition(
                  position: animation.drive(
                    Tween(
                      begin: const Offset(1.25, 0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeIn)),
                  ),
                  child: child,
                ),
          );
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/authenticating',
        builder: (context, state) => const AuthenticatingScreen(),
      ),
    ],
    redirect: (context, state) {
      final bool loggedIn = supabase.auth.currentUser != null;
      final String location = state.uri.toString();
      print('>>>>> [Redirect Logic] 실행. 현재 경로 : $location, 로그인 상태 : $loggedIn');

      if (location.contains('//login-callback')) {
        return '/authenticating';
      }
      final isAuthRoute =
          location.startsWith('/login') ||
          location.startsWith('/email-auth') ||
          location.startsWith('/authenticating');

      if (!loggedIn && !isAuthRoute) {
        return '/login';
      }

      if (loggedIn && !isAuthRoute) {
        return '/home';
      }

      if (loggedIn &&
          (location.startsWith('/login') ||
              location.startsWith('/email-auth') ||
              location.startsWith('/authenticating'))) {
        return '/home';
      }
      return null;
    },
  );
}
