import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(MdiIcons.themeLightDark),
        onPressed: () {
          widget._bloc.switchTheme();
        });
  }
}
