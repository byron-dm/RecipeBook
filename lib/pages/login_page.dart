import 'package:flutter/material.dart';
import 'package:recipe_book/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
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
      appBar: AppBar(centerTitle: true, title: Text('Login')),
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
    return const Text(
      'Recipe Book',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
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
                  decoration: const InputDecoration(hintText: "Username"),
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? "Enter a username"
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
                  decoration: const InputDecoration(hintText: "Password"),
                  validator: (value) {
                    return value == null || value.length < 5
                        ? "Enter a valid password"
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
                print("Saved.");
                if (await AuthService().login(username!, password!)) {
                  if(!mounted) return;
                  Navigator.pushReplacementNamed(context, "/home");
                } else {
                  if(!mounted) return;

                  StatusAlert.show(context,
                      duration: const Duration(seconds: 2),
                      title: "Login failed",
                      subtitle: "Please try again",
                      configuration: const IconConfiguration(icon: Icons.error),
                      maxWidth: 260);
                }
              }
            },
            child: const Text("Login")));
  }
}
