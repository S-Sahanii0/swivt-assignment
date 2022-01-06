import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../router/app_router.dart' as router;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(410, 730),
      builder: () => const MaterialApp(
        title: 'Swivt Assignment',
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
