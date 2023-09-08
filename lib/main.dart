import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'package:evaluation/repository/user_repository.dart';
import 'package:evaluation/data_base/data_base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Nécessaire pour l'initialisation asynchrone

  final DatabaseHelper dbHelper = DatabaseHelper();
  final UserRepository userRepository = UserRepository(dbHelper);

  await dbHelper.conn;
  await userRepository.createTable();

  runApp(MyApp( userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginPage(userRepository: userRepository),
    );
  }
}