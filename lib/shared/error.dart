import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ErrorUi extends StatelessWidget {
  final String message;
  const ErrorUi({
    Key key,
    this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(Icons.error_outline,
              color: Theme.of(context).indicatorColor, size: 100.0),
          Text(this.message ?? "Error",
              style: TextStyle(
                  color: Theme.of(context).backgroundColor, fontSize: 20.0))
        ],
      ),
    );
  }
}
