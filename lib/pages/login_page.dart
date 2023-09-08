import 'package:flutter/material.dart';
import 'package:evaluation/pages/user_information_page.dart';
import 'dart:math';
import 'package:evaluation/repository/user_repository.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({required this.userRepository});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userPassword = '';

  @override
  Widget build(BuildContext context) {
    var random = Random();
    int userId = random.nextInt(100000);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Image.asset(
                      'assets/login.webp',
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      onSaved: (value) => userName = value ?? '',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) => userPassword = value ?? '',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        _formKey.currentState?.save();

                        // Naviguer vers la page user_information avec les informations de l'utilisateur
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserInformationPage(
                              userId: userId,
                              userName: userName,
                              userPassword: userPassword,
                              userRepository: widget.userRepository,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
