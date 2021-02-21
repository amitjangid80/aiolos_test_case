import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:aiolos_test_case/app_theme.dart';
import 'package:aiolos_test_case/routes/routes.dart';
import 'package:aiolos_test_case/blocs/auth_bloc.dart';
import 'package:aiolos_test_case/utils/constants.dart';
import 'package:aiolos_test_case/widgets/clip_shape.dart';
import 'package:aiolos_test_case/widgets/raised_icon_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Animation<double> _usernameOffsetAnimation, _passwordOffsetAnimation;
  AnimationController _userNameAnimationController, _passwordAnimationController;

  @override
  void initState() {
    super.initState();

    _userNameAnimationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _passwordAnimationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    // setting up animation method
    _setupAnimation();
  }

  _setupAnimation() {
    _usernameOffsetAnimation =
        Tween(begin: 0.0, end: 15.0).chain(CurveTween(curve: Curves.elasticIn)).animate(_userNameAnimationController)
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                _userNameAnimationController.reverse();
              }
            },
          );

    _passwordOffsetAnimation =
        Tween(begin: 0.0, end: 15.0).chain(CurveTween(curve: Curves.elasticIn)).animate(_passwordAnimationController)
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                _passwordAnimationController.reverse();
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc _authBloc = Provider.of<AuthBloc>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipShape(),
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: Text(kWelcome, style: Theme.of(context).textTheme.headline1.copyWith(color: kPrimaryColor)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 15),
                child: Text(kLoginToYourAccount, style: Theme.of(context).textTheme.headline4),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _usernameOffsetAnimation,
                      builder: (context, child) => Container(
                        padding: EdgeInsets.only(
                          left: _usernameOffsetAnimation.value + 15.0,
                          right: 15.0 - _usernameOffsetAnimation.value,
                        ),
                        child: TextFormField(
                          autofocus: false,
                          autocorrect: false,
                          cursorColor: kPrimaryColor,
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (username) => _authBloc.userId = username,
                          decoration: InputDecoration(labelText: kUserId, prefixIcon: Icon(Icons.person_outline)),
                          validator: (username) {
                            if (username.length < 3) {
                              _userNameAnimationController.forward(from: 0.0);

                              return kEnterValidUserId;
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedBuilder(
                      animation: _passwordOffsetAnimation,
                      builder: (context, child) => Container(
                        padding: EdgeInsets.only(
                          left: _passwordOffsetAnimation.value + 15.0,
                          right: 15.0 - _passwordOffsetAnimation.value,
                        ),
                        child: TextFormField(
                          autofocus: false,
                          autocorrect: false,
                          cursorColor: kPrimaryColor,
                          obscureText: _authBloc.isPasswordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (password) => _authBloc.password = password,
                          validator: (password) {
                            if (password.length < 6) {
                              _passwordAnimationController.forward(from: 0.0);

                              return kEnterValidPassword;
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: kPassword,
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: InkWell(
                              onTap: () => _authBloc.isPasswordVisible = !_authBloc.isPasswordVisible,
                              child: Icon(
                                _authBloc.isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedIconButton(
                text: kSubmit,
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    // calling authenticate user method
                    if (await _authBloc.authenticateUser(context)) {
                      Navigator.pushNamed(context, dashboardRoute);

                      // this is the navigation to be used when login is perform.
                      // using above line for testing
                      // Navigator.pushNamedAndRemoveUntil(context, dashboardRoute, (route) => false);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
