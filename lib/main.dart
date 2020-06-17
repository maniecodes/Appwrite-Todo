import 'package:appwrite_project/blocs/filtered_tasks/filtered_tasks_bloc.dart';
import 'package:appwrite_project/localization/task_localization.dart';
import 'package:appwrite_project/models/task.dart';
import 'package:appwrite_project/screens/add_edit_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import './screens/screens.dart';
import './utils/utils.dart';
import './authentication/authentication.dart';
import './blocs/blocs.dart';
import './resources/repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository userRepository = UserRepository();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
          userRepository: userRepository,
        )..add(AppStarted()),
        //   child: TaskApp(userRepository: userRepository),
      ),
      BlocProvider(create: (context) {
        return TasksBloc(
          tasksRepository: const TasksRepositoryFlutter(
            fileStorage: const FileStorage(
              '__task_app__',
              getApplicationDocumentsDirectory,
            ),
          ),
        )..add(TasksLoaded());
      })
    ],
    child: TaskApp(userRepository: userRepository),
  ));

  // child: TaskApp(userRepository: userRepository),
}

class TaskApp extends StatelessWidget {
  final UserRepository _userRepository;

  TaskApp({Key key, @required UserRepository userRepository})
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
      title: FlutterBlocLocalizations().appTitle,
      theme: AppTheme.getTheme(),
      localizationsDelegates: [
        TaskLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        TaskRoutes.home: (context) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationAuthenticated) {
                //return HomeScreen();
                return MultiBlocProvider(providers: [
                  BlocProvider<DrawerBloc>(
                    create: (context) => DrawerBloc(
                        tasksBloc: BlocProvider.of<TasksBloc>(context),
                        userRepository: _userRepository),
                  ),
                  BlocProvider<FilteredTasksBloc>(
                    create: (context) => FilteredTasksBloc(
                        tasksBloc: BlocProvider.of<TasksBloc>(context)),
                  )
                ], child: HomeScreen());
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
        },
        TaskRoutes.addTask: (context) {
          return AddEditTaskScreen(
              key: TasksKeys.addTaskScreen,
              onSave: (title, description) {
                print('main dart');
                print(title);
                print(description);
                BlocProvider.of<TasksBloc>(context)
                    .add(TaskAdded(Task(title, description: description)));
              },
              isEditing: false);
        }
      },
    );
  }
}
