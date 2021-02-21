import 'package:flutter/material.dart';

import 'package:aiolos_test_case/app_theme.dart';

class RaisedIconButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final EdgeInsetsGeometry margin;

  RaisedIconButton({
    @required this.text,
    @required this.onPressed,
    this.margin: const EdgeInsets.only(top: 15),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text, style: Theme.of(context).textTheme.button),
              Container(
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                decoration: BoxDecoration(color: kPrimaryLightColor, borderRadius: BorderRadius.circular(20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
