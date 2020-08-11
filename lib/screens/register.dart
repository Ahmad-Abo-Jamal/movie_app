import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switch_theme/Theme/bloc/theme_bloc.dart';
import 'package:switch_theme/blocs/auth_bloc/auth_bloc_bloc.dart';
import 'package:switch_theme/blocs/register/bloc/register_bloc.dart';

import 'package:switch_theme/core/auth/authentification.dart';
import 'package:switch_theme/shared/theme_switcher.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  RegisterScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        MySwitch(bloc: BlocProvider.of<ThemeBloc>(context))
      ], title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(AuthLoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 300.0,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Center(
                      child: Text("Nice To Meet You !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                              fontSize: 40.0)),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Theme.of(context).backgroundColor,
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            color: Theme.of(context).backgroundColor)),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock,
                            color: Theme.of(context).backgroundColor),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Theme.of(context).backgroundColor)),
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  RegisterButton(
                    onPressed: isRegisterButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      RegisterEmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      RegisterPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      RegisterSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: _onPressed,
      child: Text('Register',
          style: TextStyle(color: Theme.of(context).backgroundColor)),
    );
  }
}
