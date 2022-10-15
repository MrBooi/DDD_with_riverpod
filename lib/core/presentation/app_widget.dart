import 'package:ddd_riverpod/features/auth/application/auth_state.dart';
import 'package:ddd_riverpod/features/auth/shared/provider.dart';
import 'package:ddd_riverpod/core/presentation/routes/app_router.gr.dart';
import 'package:ddd_riverpod/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initializationProvider = FutureProvider<void>(
  ((ref) async {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.checkAndUpdateUserAuthStatus();
  }),
);

class AppWidget extends ConsumerWidget {
  AppWidget({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initializationProvider, (previous, next) {});

    ref.listen<AuthState>(authNotifierProvider, (previous, state) {
      state.maybeWhen(
        orElse: () {},
        authenticated: () {},
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
