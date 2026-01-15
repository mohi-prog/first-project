import 'package:flutter/material.dart';
import 'package:learnconnectmyself/notes_screen.dart';
import 'SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'google_auth_service.dart' show GoogleAuthService;

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
                  fontSize: 35,
                  fontFamily: 'Jersey',
                ),
              ),
            ),
          ],
        ),
      ),
      body: const LoginBody(),
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
  bool obscurePassword = true;
  final UsernameController = TextEditingController();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void handleEmailLogin() async {
    if (UsernameController.text.isEmpty ||
        EmailController.text.isEmpty ||
        PasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: EmailController.text.trim(),
        password: PasswordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NotesScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'user-not-found':
          message = 'User not found';
          break;
        case 'wrong-password':
          message = 'Incorrect password';
          break;
        case 'invalid-email':
          message = 'Invalid email';
          break;
        default:
          message = 'Login failed';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

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
            controller: UsernameController,
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
            controller: EmailController,
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
            controller: PasswordController,
            obscureText: obscurePassword,
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
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: 530,
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
            onPressed: handleEmailLogin,
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
        Positioned(
          top: 602,
          left: 125,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignIn()),
              );
            },
            child: Text(
              'No account yet? Sign up',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontFamily: 'Jersey',
              ),
            ),
          ),
        ),
        // Divider und OR
        Positioned(
          top: 646,
          left: 25,
          child: Container(height: 1, width: 150, color: Colors.grey),
        ),
        Positioned(
          top: 646,
          left: 220,
          child: Container(height: 1, width: 150, color: Colors.grey),
        ),
        Positioned(
          top: 635,
          left: 190,
          child: Text(
            'or',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontFamily: 'Jersey',
            ),
          ),
        ),
        // Google Login Button
        Positioned(
          top: 660,
          left: 140,
          width: 40,
          height: 40,
          child: InkWell(
            onTap: () async {
              final user = await GoogleAuthService.handleGoogleSignIn();
              if (user != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => NotesScreen()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Google login failed')),
                );
              }
            },

            child: Image.asset('assets/images/google1.png'),
          ),
        ),
        Positioned(
          top: 660,
          left: 210,
          width: 60,
          height: 60,
          child: InkWell(
            onTap: () {},
            child: Image.asset('assets/images/facebook.png'),
          ),
        ),
      ],
    );
  }
}
