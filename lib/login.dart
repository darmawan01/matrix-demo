import 'package:demo/client.dart';
import 'package:demo/home.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameEC = TextEditingController();
  final TextEditingController _passwordEC = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final client = MatrixClient.instance.getClient();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Align(
              alignment: Alignment.center,
              child: FlutterLogo(size: 50.0),
            ),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _usernameEC,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordEC,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            try {
                              await client?.checkHomeserver(Uri.https(
                                  "ec2-3-27-93-95.ap-southeast-2.compute.amazonaws.com",
                                  ""));
                              await client?.login(
                                LoginType.mLoginPassword,
                                password: _passwordEC.text,
                                identifier: AuthenticationUserIdentifier(
                                    user: _usernameEC.text),
                              );

                              goToHome();
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                      ),
                      TextButton(
                        child: const Text('Forgot password?'),
                        onPressed: () {
                          // Navigate to password reset screen
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}
