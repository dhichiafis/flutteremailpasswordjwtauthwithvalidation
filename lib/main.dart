import 'package:flutter/material.dart';
import 'package:form_validation/auth.dart';
import 'package:form_validation/login.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:form_validation/myhome.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      
      create: (_)=>Auth(),
      child: MyApp(),
      )
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<Auth>();

    final router = GoRouter(
      initialLocation: '/login',
      refreshListenable: auth,

      ///
      redirect: (context, state) {
        final loggedIn = auth.isAuthenticated;
        final loggingIn = state.matchedLocation == '/login';

        // Not logged in → force login
        //if (!loggedIn&& !loggingIn) {\
        if(!loggedIn && !loggingIn){
          return '/login';
        }

        // Logged in → prevent going back to login
        if (loggedIn && loggingIn) {
        
          return '/';
        }

        return null; // no redirect
      },

      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const Login(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const Myhome(),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Flutter Auth App',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}