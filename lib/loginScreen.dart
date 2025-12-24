import 'package:flutter/material.dart';
import 'changeColor.dart';

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
      backgroundColor: const Color.fromARGB(255, 254, 255, 252),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 15,
          left: 90,
          width: 200,
          height: 200,
          child: Image.asset('assets/images/Logo.png', fit: BoxFit.cover),
        ),
        Positioned(
          top: 210,
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
          top: 290,
          left: 35,
          width: 320,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.blue, width: 3),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.blue, width: 3),
              ),
              hintText: 'Username',
              icon: Icon(Icons.person, color: Colors.blue),
            ),
          ),
        ),
        Positioned(
          top: 360,
          left: 35,
          width: 320,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.blue, width: 3),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.blue, width: 3),
              ),
              hintText: 'Email',
              icon: Icon(Icons.email, color: Colors.blue),
            ),
          ),
        ),
        Positioned(
          top: 430,
          left: 35,
          width: 320,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.blue, width: 3),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.blue, width: 3),
              ),
              hintText: 'Password',
              icon: Icon(Icons.lock, color: Colors.blue),
            ),
          ),
        ),
        Positioned(
          top: 490,
          left: 80,
          width: 50,
          height: 50,
          child: Transform.scale(
            scale: 0.8,
            child: Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
          ),
        ),
        Positioned(
          top: 503,
          left: 120,
          child: RichText(
            text: TextSpan(
              text: 'I agree to the ',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontFamily: 'Jersey',
              ),
              children: [
                TextSpan(
                  text: 'Terms and Conditions',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontFamily: 'Jersey',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 550,
          left: 35,
          width: 320,
          height: 60,

          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => changeColor()),
              );
            },
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Jersey',
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
