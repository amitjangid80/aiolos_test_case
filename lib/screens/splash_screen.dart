import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:package_info/package_info.dart';
import 'package:aiolos_test_case/app_theme.dart';
import 'package:aiolos_test_case/routes/routes.dart';
import 'package:aiolos_test_case/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      // calling get app version method
      _getAppVersion();
    }

    // calling navigate to next screen method
    _navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Center(child: Icon(Icons.local_grocery_store_outlined, size: 100, color: kPrimaryColor))),
            if (!kIsWeb) ...[
              Text(
                '$kVersion: $_appVersion',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 15),
            ],
          ],
        ),
      ),
    );
  }

  /// 2021 February 21 - Sunday
  /// get app version method
  ///
  /// this method will get the current version of the app
  _getAppVersion() async {
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();

    if (mounted) {
      setState(() => _appVersion = _packageInfo.version);
    }
  }

  /// 2021 February 21 - Sunday
  /// check if logged in method
  ///
  /// this method will navigate the user to the route passed
  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);
  }
}
