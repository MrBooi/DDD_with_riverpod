import 'package:auto_route/auto_route.dart';
import 'package:ddd_riverpod/features/auth/presentation/sign_in_page.dart';
import 'package:ddd_riverpod/features/splash/presentation/splash_page.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: SignInPage)
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
