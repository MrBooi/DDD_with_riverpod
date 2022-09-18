import 'package:ddd_riverpod/core/presentation/routes/app_router.gr.dart';
import 'package:ddd_riverpod/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DDD with RiverPod',
      theme: AppTheme.appTheme,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
