import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String message;
  const ConfirmDialog({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message ?? "Are You Sure You want to log out ? "),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Confirm")),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("Return"))
      ],
    );
  }
}
