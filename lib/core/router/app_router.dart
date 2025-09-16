import 'package:bloc_example/modules/splash/splash_view.dart';
import 'package:go_router/go_router.dart';
import '../../modules/auth/views/onboarding_view.dart';
import '../../modules/home/home_page.dart';
import '../../modules/home/inc_dec_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const Onboarding(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MyHomePage(title: 'Home Page'),
      ),
      GoRoute(
        path: '/details',
        builder: (context, state) => const IncDecPage(),
      ),
    ],
  );
}
