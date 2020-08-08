import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:switch_theme/Theme/bloc/theme_bloc.dart';
import 'package:switch_theme/blocs/auth_bloc/auth_bloc_bloc.dart';
import 'package:switch_theme/shared/confirm_dialog.dart';
import 'package:switch_theme/shared/theme_switcher.dart';

class MyAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final bool leading;
  final TabController tabController;
  const MyAppBar({
    Key key,
    this.leading = true,
    this.tabController,
    @required this.title,
  })  : assert(title != null),
        assert(leading != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: tabController != null
          ? TabBar(
              unselectedLabelColor: Theme.of(context).backgroundColor,
              labelColor: Theme.of(context).indicatorColor,
              controller: tabController,
              tabs: [
                  Tab(
                    icon: Icon(MdiIcons.home),
                  ),
                  Tab(
                    icon: Icon(MdiIcons.movie),
                  ),
                  Tab(
                    icon: Icon(MdiIcons.television),
                  )
                ])
          : null,
      elevation: 0,
      leading: leading
          ? IconButton(
              icon: Icon(MdiIcons.logout),
              onPressed: () async {
                bool log = await showDialog<bool>(
                    context: context,
                    builder: (_) {
                      return ConfirmDialog(
                        message: "are you sure you wanna log out ? ",
                      );
                    });
                if (log) {
                  BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
                }
              },
            )
          : null,
      title: Text(this.title),
      actions: <Widget>[MySwitch(bloc: BlocProvider.of<ThemeBloc>(context))],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(
      AppBar().preferredSize.height * (tabController == null ? 1 : 2));
}
