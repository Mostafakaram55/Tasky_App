import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/bloc_observer.dart';
import 'package:tasky_app/config/local/cache_helper.dart';
import 'package:tasky_app/core/utils/app_constants.dart' show AppConstants;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tasky_app/tasky_app.dart';
import 'config/routes/app_routes.dart';
import 'core/utils/service_locator.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await CacheHelper.inti();
  setUp();
  AppConstants.accessToken=CacheHelper.getData(key: 'access_token')??'';
  AppConstants.refreshToken=CacheHelper.getData(key: 'refresh_token')??'';
  Bloc.observer=MyBlocObserver();
  runApp(
     const Tasky()
  );
}

class Tasky extends StatefulWidget {
  const Tasky({super.key});
  @override
  State<Tasky> createState() => _TaskyState();
}

class _TaskyState extends State<Tasky> {
  StreamSubscription?_subscription;
  @override
  void initState() {
    super.initState();
    _subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      checkIsConnectedOrNo(status);
    });
  }
  void checkIsConnectedOrNo(InternetConnectionStatus  status ){
    switch (status) {
      case InternetConnectionStatus.connected:
        setState(() =>isConnectedNotifier.value = true);
        break;
      case InternetConnectionStatus.disconnected:
        setState(() =>isConnectedNotifier.value = false);
        break;
    }
  }
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TaskApp();
  }
}
