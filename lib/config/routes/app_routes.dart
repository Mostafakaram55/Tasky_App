import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/features/home/presentation/views/scan_view.dart';
import 'package:tasky_app/features/home/presentation/views/update_task_view.dart';
import '../../core/utils/service_locator.dart';
import '../../features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import '../../features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import '../../features/authentication/presentation/views/login_view.dart';
import '../../features/authentication/presentation/views/register_view.dart';
import '../../features/home/domain/entites/task_entity.dart';
import '../../features/home/presentation/cubits/get_task_cubit/get_task_cubit.dart';
import '../../features/home/presentation/cubits/task_crud_cubit/task_curd_cubit.dart' show TaskOperationsCubit;
import '../../features/home/presentation/views/details_task_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/home/presentation/views/upload_task_view.dart';
import '../../features/onboarding/onboarding_view.dart';
import '../../features/profile/presentation/cubits/profile_cubit.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../../features/splash/splash_view.dart';
import '../../core/widgets/no_internet_connection.dart';
final ValueNotifier<bool> isConnectedNotifier = ValueNotifier(true);

abstract class AppRouter {
  static const kSignInView = '/signInView';
  static const kSignUpView = '/signUpView';
  static const kHomeView = '/homeView';
  static const kTaskDetailsView = '/taskDetailsView';
  static const kSearchView = '/searchView';
  static const kAddTaskView = '/addTaskView';
  static const kOnBoardingView = '/onBoardingView';
  static const profileView = '/profileView';
  static const detailsView = '/detailsView';
  static const updateTaskView = '/updateTaskView';
  static const noInterNet = '/noInterNetView';
  static const scanView = '/scanView';


  static void navigateTo(String routeName, {Object? extra}) {
    router.go(routeName,extra: extra); // أو router.push(routeName); حسب الحاجة
  }
  static void goBack(){
    if (AppRouter.router.canPop()) {
      AppRouter.router.pop();
    } else {
      AppRouter.router.go(AppRouter.kHomeView); // أو أي صفحة رئيسية
    }
  }

  static final router = GoRouter(
      initialLocation: '/',
      refreshListenable: isConnectedNotifier,
      redirect: (context, state) {
        final isConnected = isConnectedNotifier.value;
        final currentLocation = state.uri.toString();
        final isOnNoInternet = currentLocation == AppRouter.noInterNet;
        if (!isConnected && !isOnNoInternet) {
          return AppRouter.noInterNet;
        }
        if (isConnected && isOnNoInternet) {
          return AppRouter.kHomeView;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashView(),
        ),
        GoRoute(
          path: '/noInterNetView',
          builder: (context, state) => const NoInternetConnectionScreen(),
        ),
        GoRoute(
          path: '/scanView',
          builder: (context, state) {
            final BuildContext contextForBloc = state.extra as BuildContext;
            return BlocProvider.value(
              value: contextForBloc.read<GetTasksCubit>(),
                child: ScanView(contextForBloc: contextForBloc));
          } ,
        ),
        GoRoute(
          path: '/updateTaskView',
          builder: (context, state) {
            final taskModel = state.extra as TaskEntity;
            return BlocProvider(
              create: (context) => getIt.get<TaskOperationsCubit>(),
              child: UpdateTaskView( taskEntity: taskModel ),
            );
          },
        ),
        GoRoute(
          path: '/signInView',
          builder: (context, state) => BlocProvider(
              create: (context) => getIt<SignInCubit>(),
              child: const SignInView()),
        ),
        GoRoute(
          path: '/signUpView',
          builder: (context, state) =>  BlocProvider(
              create: (context)=>getIt<SignUPCubit>(),
              child: SignUpView()
          ),
        ),
        GoRoute(
          path: '/onBoardingView',
          builder: (context, state) =>  OnBoardingView(),
        ),
        GoRoute(
          path: '/detailsView',
           builder: (context, state) {
             final iScanFrom = state.uri.queryParameters['isCanFrom'] == 'true';
             return BlocProvider(
               create: (context) => getIt.get<TaskOperationsCubit>(),
               child: DetailsTaskView(whereFrom: iScanFrom,),
             );
           }
        ),
        GoRoute(
          path: '/addTaskView',
          builder: (context, state) =>  BlocProvider(
              create: (context)=>getIt.get<TaskOperationsCubit>(),
              child: UploadTaskView()),
        ),
        GoRoute(
          path: '/profileView',
          builder: (context, state) =>  BlocProvider(
              create: (context)=>getIt.get<ProfileCubit>(),
              child: ProfileView()),
        ),
        GoRoute(
          path: '/homeView',
          builder: (context, state) =>  MultiBlocProvider(
              providers: [
                BlocProvider(create: (context)=>getIt.get<TaskOperationsCubit>()),
                BlocProvider(create: (context)=>getIt.get<GetTasksCubit>()),
              ],
              child: HomeView()),
        ),
      ]

  );


}