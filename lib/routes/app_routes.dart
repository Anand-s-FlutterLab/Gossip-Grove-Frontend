import 'dart:convert';
import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/screens/all_user_screen.dart';
import 'package:gossip_grove/screens/chat_screen.dart';
import 'package:gossip_grove/screens/chat_user_profile.dart';
import 'package:gossip_grove/screens/home_screen.dart';
import 'package:gossip_grove/screens/login_screen.dart';
import 'package:gossip_grove/screens/setting_screen.dart';
import 'package:gossip_grove/screens/signup_screen.dart';
import 'package:gossip_grove/screens/splash_screen.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: [
        GoRoute(
          path: 'login',
          name: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          name: 'signup',
          path: 'signup',
          builder: (BuildContext context, GoRouterState state) =>
              const SignupScreen(),
        ),
        GoRoute(
          name: 'home',
          path: 'home',
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
        ),
        GoRoute(
          name: 'chat',
          path: 'chat',
          builder: (BuildContext context, GoRouterState state) => ChatScreen(
            id1: jsonEncode(state.extra),
          ),
        ),
        GoRoute(
          name: 'allUser',
          path: 'allUser',
          builder: (BuildContext context, GoRouterState state) =>
              const AllUserScreen(),
        ),
        GoRoute(
          name: 'chat_user_profile',
          path: 'chat_user_profile',
          builder: (BuildContext context, GoRouterState state) {
            return ChatUserProfile(
              id1: jsonEncode(state.extra),
            );
          },
        ),
        GoRoute(
          path: 'setting',
          name: 'setting',
          builder: (BuildContext context, GoRouterState state) =>
              const SettingScreen(),
        )
      ],
    ),
  ],
);
