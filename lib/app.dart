import 'package:farmassist/app_theme.dart';
import 'package:farmassist/bloc/authentication/authentication.dart';
import 'package:farmassist/data/authentication/authentication_repository.dart';
import 'package:farmassist/data/farm/resources/repository.dart';
import 'package:farmassist/ui/devices/cubit/devices_provider.dart';
import 'package:farmassist/ui/devices/repository/devices_repository.dart';
import 'package:farmassist/ui/farm/news/bloc/nBloc.dart';
import 'package:farmassist/ui/farm/news/bloc/nEvent.dart';
import 'package:farmassist/ui/farm/news_details/bloc/dBloc.dart';
import 'package:farmassist/ui/home_page.dart';
import 'package:farmassist/ui/login/login_page.dart';
import 'package:farmassist/ui/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'data/farm/view_model/cityEntryViewModel.dart';
import 'data/farm/view_model/weather_app_forecast_viewmodel.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final AuthenticationRepository _authenticationRepository = AuthenticationRepository(
    firebaseAuth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
    devicesRepository: DevicesRepository(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(authenticationRepository: _authenticationRepository)),
        BlocProvider<NewsBloc>(
            create: (_) => NewsBloc(repository: Repository())..add(Fetch(category: 'Science'))),
        BlocProvider<DetailBloc>(
          create: (_) => DetailBloc(),
        ),
        ChangeNotifierProvider<ForecastViewModel>(create: (_) => ForecastViewModel()),
        ChangeNotifierProvider<CityEntryViewModel>(create: (_) => CityEntryViewModel()),
        ChangeNotifierProvider<DevicesProvider>(create: (_) => DevicesProvider()),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>.value(
            value: _authenticationRepository,
          ),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmassist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppTheme.nearlyGreen,
        appBarTheme: AppTheme.appBarTheme,
        scaffoldBackgroundColor: AppTheme.background,
        textTheme: AppTheme.textTheme,
        inputDecorationTheme: AppTheme.inputDecorationTheme,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppTheme.nearlyGreen),
      ),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
