import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        flexibleSpace: Stack(
          children: [
            Positioned(
              top: 35,
              right: 18,
              width: 70,

              child: Text(
                'Login',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 23,
                ),
              ),
            ),
          ],
        ),
      ),
      body: LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 220,
          left: 165,
          child: Text(
            'Hello!',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Jersey',
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 300,
          left: 35,
          width: 320,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 3,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.blue, width: 3),
              ),
              iconColor: Colors.blue,
              hintText: 'Username',
              icon: Icon(Icons.person),
            ),
          ),
        ),
      ],
    );
  }
}
