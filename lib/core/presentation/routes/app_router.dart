import 'package:auto_route/auto_route.dart';
import 'package:ddd_riverpod/splash/presentation/splash_page.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: SplashPage, initial: true),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
