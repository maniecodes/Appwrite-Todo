import 'package:appwrite_project/screens/view_task_screen.dart';
import 'package:appwrite_project/widgets/screen_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './screens/screens.dart';
import './utils/utils.dart';
import './authentication/authentication.dart';
import './blocs/blocs.dart';
import './resources/repository.dart';
import './models/models.dart';
import './localization/task_localization.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository userRepository = UserRepository();
  final TasksRepositoryFlutter taskRepository = TasksRepositoryFlutter(
      // fileStorage: const FileStorage(
      //   '__task_app__',
      //   getApplicationDocumentsDirectory,
      // ),
      );
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
          tasksRepository: taskRepository,
        )..add(TasksLoaded());
      })
    ],
    child: TaskApp(
      userRepository: userRepository,
      taskRepository: taskRepository,
    ),
  ));

  // child: TaskApp(userRepository: userRepository),
}

class TaskApp extends StatelessWidget {
  final UserRepository _userRepository;
  final TasksRepositoryFlutter _tasksRepository;
  final ScreenArguments arguments;

  TaskApp(
      {Key key,
      @required UserRepository userRepository,
      @required taskRepository,
      this.arguments})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _tasksRepository = taskRepository,
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
                return MultiBlocProvider(providers: [
                  BlocProvider<DrawerBloc>(
                    create: (context) => DrawerBloc(
                        tasksBloc: BlocProvider.of<TasksBloc>(context),
                        userRepository: _userRepository,
                        tasksRepository: _tasksRepository),
                  ),
                  BlocProvider<FilteredTasksBloc>(
                    create: (context) => FilteredTasksBloc(
                      tasksBloc: BlocProvider.of<TasksBloc>(context),
                      tasksRepository: _tasksRepository,
                      userRepository: _userRepository,
                    ),
                  )
                ], child: HomeScreen());
              }
              if (state is AuthenticationUnauthenticated) {
                return WelcomeScreen(userRepository: _userRepository);
              }
              if (state is AuthenticationLoading) {
                return SplashScreen();
              }
              return WelcomeScreen(userRepository: _userRepository);
            },
          );
        },
        TaskRoutes.addTask: (context) {
          return AddEditTaskScreen(
              key: TasksKeys.addTaskScreen,
              onSave: (title, description, dueDateTime) async {
                BlocProvider.of<TasksBloc>(context).add(
                  TaskAdded(Task(title,
                      description: description,
                      dueDateTime: dueDateTime,
                      uid: await _userRepository.currentUser())),
                );
              },
              isEditing: false);
        },
        TaskRoutes.viewTasks: (context) {
          //print(ModalRoute.of(context).settings.arguments.toString());
          return MultiBlocProvider(
            providers: [
              BlocProvider<DrawerBloc>(
                create: (context) => DrawerBloc(
                    tasksBloc: BlocProvider.of<TasksBloc>(context),
                    userRepository: _userRepository,
                    tasksRepository: _tasksRepository),
              ),
              BlocProvider<FilteredTasksBloc>(
                create: (context) => FilteredTasksBloc(
                  tasksBloc: BlocProvider.of<TasksBloc>(context),
                  tasksRepository: _tasksRepository,
                  userRepository: _userRepository,
                ),
              )
            ],
            child: ViewTaskScreen(
                // arguments: ModalRoute.of(context).settings.arguments,
                ),
          );
        }
      },
    );
  }
}
