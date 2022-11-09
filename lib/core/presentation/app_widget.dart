import 'package:ddd_riverpod/core/shared/providers.dart';
import 'package:ddd_riverpod/features/auth/application/auth_state.dart';
import 'package:ddd_riverpod/features/auth/shared/provider.dart';
import 'package:ddd_riverpod/core/presentation/routes/app_router.gr.dart';
import 'package:ddd_riverpod/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppWidget extends ConsumerWidget {
  AppWidget({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initializationProvider, (previous, _) {});
    ref.listen<AuthState>(authNotifierProvider, (previous, state) {
      state.maybeWhen(
        orElse: () {
          print('while on loading app router');
        },
        authenticated: () {
          appRouter.pushAndPopUntil(
            const HomeRoute(),
            predicate: (route) => false,
          );
        },
        unauthenticated: () {
          appRouter.pushAndPopUntil(
            const SignInRoute(),
            predicate: (route) => false,
          );
        },
      );
    });

    return MaterialApp.router(
      title: 'DDD with RiverPod',
      theme: AppTheme.appTheme,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
