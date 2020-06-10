import 'package:appwrite_project/authentication/authentication_event.dart';
import 'package:appwrite_project/authentication/authentication_state.dart';
import 'package:appwrite_project/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './authentication/authentication_bloc.dart';
import './screens/splash_screen.dart';
import './screens/home_screen.dart';
import './screens/welcome_screen.dart';
import './resources/user_repository.dart';
import './utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository userRepository = UserRepository();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) => AuthenticationBloc(
      userRepository: userRepository,
    )..add(AppStarted()),
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
      statusBarBrightness:
          AppTheme.isLightTheme ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          AppTheme.isLightTheme ? Colors.white : Colors.black,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness:
          AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
    ));
    return MaterialApp(
      theme: AppTheme.getTheme(),
      routes: {
        TaskRoutes.home: (context) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationAuthenticated) {
                print('login to home screen');
                return HomeScreen();
              }
              if (state is AuthenticationUnauthenticated) {
                return WelcomeScreen(userRepository: _userRepository);
              }
              if (state is AuthenticationLoading) {
                return SplashScreen();
              }
              return SplashScreen();
            },
          );
        }
      },
    );
  }
}
