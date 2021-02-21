import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:aiolos_test_case/main.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:aiolos_test_case/utils/constants.dart';

class AuthBloc extends ChangeNotifier {
  final String _tag = 'AuthBloc';

  bool _isPasswordVisible = true;
  String _userId = '', _password = '';

  String get userId => _userId;

  String get password => _password;

  bool get isPasswordVisible => _isPasswordVisible;

  set userId(String mobileNo) {
    _userId = mobileNo;
    notifyListeners();
  }

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  set isPasswordVisible(bool isPasswordVisible) {
    _isPasswordVisible = isPasswordVisible;
    notifyListeners();
  }

  /// 2020 February 21 - Sunday
  /// authenticate user method
  ///
  ///this method calls the api for authenticating the user
  Future<bool> authenticateUser(BuildContext context) async {
    try {
      if (userId == null || userId.isEmpty) {
        showCustomDialog(context, title: kInfo, description: kEnterValidUserId);

        return false;
      }

      if (password == null || password.isEmpty) {
        showCustomDialog(context, title: kInfo, description: kEnterValidPassword);

        return false;
      }

      // calling show progress dialog method
      await showProgressDialog(context);

      await Future.delayed(const Duration(seconds: 3));

      // calling hide progress dialog method
      await hideProgressDialog();

      if ((userId == 'amit' || userId == 'aiolos') && (password == 'jangid' || password == 'solutions')) {
        return true;
      } else {
        showCustomDialog(context, title: kInfo, description: kEnterValidUsernamePassword);
      }

      return false;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: "exception while authenticating user",
      );

      return false;
    }
  }
}
