import 'package:bloc_example/core/router/app_router.dart';
import 'package:bloc_example/bloc/counter_bloc.dart';
import 'package:bloc_example/cubit/counter_cubit.dart';
import 'package:bloc_example/data/repo_implementations/auth_repo_implementation.dart';
import 'package:bloc_example/data/repositories/auth_repository.dart';
import 'package:bloc_example/modules/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final AuthRepo authRepo = AuthRepoImpl();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child:  MyApp(authRepo: authRepo),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepo authRepo;
  const MyApp({super.key, required this.authRepo});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterCubit()),
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => AuthCubit(authRepo: authRepo)),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
      ),
    );
  }
}
