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
      content: Text(message),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("cofirm")),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("return"))
      ],
    );
  }
}
