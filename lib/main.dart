import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config.dart';
import 'config/routes/routes.dart';
import 'core/cache/shared_prefrence.dart';
import 'core/utils/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.init();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  String? token = await CacheData.getData("token");
  String start;
  if (token == null) {
    start = "/";
    // start = "homeScreen";

  } else {
    start = "homeScreen";
  }
  runApp( MyApp(start));
}

class MyApp extends StatelessWidget {
  final String start;
  const MyApp(this.start, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: start,
        onGenerateRoute: (settings) => Routes.onGenerate(settings),
      ),
    );
  }
}
