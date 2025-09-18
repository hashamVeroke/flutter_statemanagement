import 'package:bloc_example/modules/splash/splash_view.dart';
import 'package:go_router/go_router.dart';
import '../../modules/auth/views/onboarding_view.dart';
import '../../modules/auth/views/passcode_view.dart';
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
        path: '/passcode',
        builder: (context, state) {
          final phoneNumber = state.uri.queryParameters['phoneNumber'] ?? '';
          final country = state.uri.queryParameters['country'] ?? '';
          final countryCode = state.uri.queryParameters['countryCode'] ?? '';
          final isNewUser = state.uri.queryParameters['isNewUser'] == 'true';

          return PassCode(
            phoneNumber: phoneNumber,
            country: country,
            countryCode: countryCode,
            isNewUser: isNewUser,
          );
        },
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
