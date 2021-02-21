import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:aiolos_test_case/app_theme.dart';
import 'package:aiolos_test_case/routes/routes.dart';
import 'package:aiolos_test_case/blocs/auth_bloc.dart';
import 'package:aiolos_test_case/utils/constants.dart';
import 'package:aiolos_test_case/routes/custom_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthBloc(),
      child: MaterialApp(
        title: kAppName,
        theme: themeData(),
        initialRoute: homeRoute,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: CustomRouter.generateRoute,
      ),
    );
  }
}

handleException({
  @required exception,
  @required stackTrace,
  @required String exceptionClass,
  @required String exceptionMsg,
}) {
  debugPrint('\n');
  debugPrint("========================================START OF EXCEPTION========================================");
  debugPrint("==================================================================================================");
  debugPrint('\n');
  debugPrint('$exceptionClass - $exceptionMsg: \n${exception.toString()}\n$stackTrace');
  debugPrint('\n');
  debugPrint("==================================================================================================");
  debugPrint("=========================================END OF EXCEPTION=========================================");
  debugPrint('\n');
}
