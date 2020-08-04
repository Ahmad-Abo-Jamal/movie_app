import 'package:flutter/material.dart';
import 'package:switch_theme/Theme/bloc/theme_bloc.dart';

class MySwitch extends StatefulWidget {
  MySwitch({
    Key key,
    @required ThemeBloc bloc,
  })  : _bloc = bloc,
        super(key: key);

  final ThemeBloc _bloc;

  @override
  _MySwitchState createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool _switch = false;
  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
        activeColor: Colors.white,
        value: _switch,
        onChanged: (_) {
          setState(() {
            _switch = !_switch;
          });
          widget._bloc.switchTheme();
        });
  }
}
