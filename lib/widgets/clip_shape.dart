import 'package:flutter/material.dart';

import 'package:aiolos_test_case/app_theme.dart';
import 'package:aiolos_test_case/utils/constants.dart';
import 'package:aiolos_test_case/widgets/custom_shape.dart';
import 'package:aiolos_test_case/widgets/responsive_widget.dart';

class ClipShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    bool _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    bool _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large ? _height / 4.5 : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [kPrimaryLightColor.withOpacity(0.5), kPrimaryColor.withOpacity(0.9)]),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large ? _height / 5 : (_medium ? _height / 4.75 : _height / 4.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [kPrimaryLightColor.withOpacity(0.5), kPrimaryColor.withOpacity(0.9)]),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Image.asset(kLoginIcon, width: _width / 3.5, height: _height / 3.5),
          margin: EdgeInsets.only(top: _large ? _height / 30 : (_medium ? _height / 25 : _height / 20)),
        ),
      ],
    );
  }
}
