import 'package:flutter/material.dart';
import 'package:evaluation/models/user.dart';
import 'package:evaluation/repository/user_repository.dart';

class UserInformationPage extends StatefulWidget {
  final int userId;
  final String userName;
  final String userPassword;
  final UserRepository userRepository;

  UserInformationPage({
    required this.userId,
    required this.userName,
    required this.userPassword,
    required this.userRepository,
  });

  @override
  _UserInformationPageState createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {
  late int userId;
  late String userName;
  late String userPassword;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    userName = widget.userName;
    userPassword = widget.userPassword;
  }

  void _onUserSaved() {
    // Vous pouvez ajouter une notification ici
    print('Utilisateur sauvegardé');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle,
                size: 50.0,
                color: Colors.purple,
              ),
              SizedBox(height: 10.0),
              Text(
                "Bonjour, $userName",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purpleAccent),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isEditing
                        ? TextField(
                      decoration: InputDecoration(labelText: 'User ID'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => userId = int.parse(value),
                      controller: TextEditingController(text: userId.toString()),
                    )
                        : Text("User ID: $userId", style: TextStyle(fontSize: 18.0)),
                    SizedBox(height: 10.0),
                    isEditing
                        ? TextField(
                      decoration: InputDecoration(labelText: 'Username'),
                      onChanged: (value) => userName = value,
                      controller: TextEditingController(text: userName),
                    )
                        : Text("Username: $userName", style: TextStyle(fontSize: 18.0)),
                    SizedBox(height: 10.0),
                    isEditing
                        ? TextField(
                      decoration: InputDecoration(labelText: 'Password'),
                      onChanged: (value) => userPassword = value,
                      controller: TextEditingController(text: userPassword),
                    )
                        : Text("Password: $userPassword", style: TextStyle(fontSize: 18.0)),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: isEditing
                    ? null
                    : () {
                  User userToSave = User(
                    userId: userId,
                    userName: userName,
                    userPassword: userPassword,
                  );
                  widget.userRepository.insertOrUpdateUser(userToSave, _onUserSaved);
                },
                child: Text("Enregistrer"),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Text(isEditing ? "Confirmer" : "Mettre à jour"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
