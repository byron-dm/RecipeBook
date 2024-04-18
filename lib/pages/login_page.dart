import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipe_book/services/definitions/auth_service.dart';
import 'package:status_alert/status_alert.dart';

import 'package:recipe_book/injection_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.loginPageTitle)),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_title(), _loginForm()],
        ));
  }

  Widget _title() {
    return Text(
      AppLocalizations.of(context)!.loginPageTitle,
      style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
    );
  }

  Widget _loginForm() {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: MediaQuery.sizeOf(context).height * 0.3,
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                  initialValue: "kminchelle",
                  onSaved: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!
                          .loginPageDecorationUsername),
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? AppLocalizations.of(context)!.loginPageErrorUsername
                        : null;
                  }),
              TextFormField(
                  initialValue: "0lelplR",
                  onSaved: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!
                          .loginPageDecorationPassword),
                  validator: (value) {
                    return value == null || value.length < 5
                        ? AppLocalizations.of(context)!.loginPageErrorPassword
                        : null;
                  }),
              _loginButton()
            ],
          ),
        ));
  }

  Widget _loginButton() {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.6,
        child: ElevatedButton(
            onPressed: () async {
              if (_loginFormKey.currentState?.validate() ?? false) {
                _loginFormKey.currentState?.save();
                if (await getIt<AuthService>().login(username!, password!)) {
                  if (!mounted) return;
                  Navigator.pushReplacementNamed(context, "/home");
                } else {
                  if (!mounted) return;

                  StatusAlert.show(context,
                      duration: const Duration(seconds: 2),
                      title: AppLocalizations.of(context)!
                          .loginPageStatusAlertTitle,
                      subtitle: AppLocalizations.of(context)!
                          .loginPageStatusAlertSubtitle,
                      configuration: const IconConfiguration(icon: Icons.error),
                      maxWidth: 260);
                }
              }
            },
            child: Text(AppLocalizations.of(context)!.loginPageButtonLogin)));
  }
}
