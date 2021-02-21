import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:aiolos_test_case/blocs/auth_bloc.dart';
import 'package:aiolos_test_case/utils/constants.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthBloc _authBloc = Provider.of<AuthBloc>(context);

    return Scaffold(
      body: Center(
        child: RichTextWidget(
          caption: kHello,
          description: _authBloc.userId,
          captionStyle: Theme.of(context).textTheme.headline4,
          descriptionStyle: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
