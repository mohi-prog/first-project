import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginScreen.dart';
import 'google_auth_service.dart';
import 'changeColor.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 255, 252),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 205, 51, 51),
        leading: BackButton(),
        flexibleSpace: Stack(
          children: [
            Positioned(
              top: 35,
              right: 25,
              child: Text(
                'Sign In',
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
      body: const SignInn(),
    );
  }
}

class SignInn extends StatefulWidget {
  const SignInn({super.key});

  @override
  State<SignInn> createState() => _SignInnState();
}

class _SignInnState extends State<SignInn> {
  bool isChecked = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  final TextEditingController UsernameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController ConfirmPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void HandleSignIn() async {
    if (EmailController.text.isEmpty ||
        PasswordController.text.isEmpty ||
        ConfirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    if (PasswordController.text != ConfirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    try {
      // Firebase Registrierung
      await _auth.createUserWithEmailAndPassword(
        email: EmailController.text.trim(),
        password: PasswordController.text.trim(),
      );

      // Erfolgreiche Registrierung → Weiterleitung zum Login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'email-already-in-use':
          message = 'Email already in use';
          break;
        case 'invalid-email':
          message = 'Invalid email';
          break;
        case 'weak-password':
          message = 'Password is too weak';
          break;
        default:
          message = 'Sign up failed';
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
          top: -17,
          left: 90,
          width: 200,
          height: 200,
          child: Image.asset('assets/images/Logo.png', fit: BoxFit.cover),
        ),
        Positioned(
          top: 150,
          left: 113,
          child: Text(
            'Hey this is LNCT!',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Jersey',
              color: Colors.red,
            ),
          ),
        ),
        // Username TextField
        Positioned(
          top: 235,
          left: 30,
          width: 320,
          height: 200,
          child: TextField(
            controller: UsernameController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.red, width: 3),
              ),
              hintText: 'Username',
              hintStyle: TextStyle(color: Colors.red),
              icon: Icon(Icons.person, color: Colors.red),
            ),
          ),
        ),
        // Email
        Positioned(
          top: 310,
          left: 30,
          width: 320,
          height: 200,
          child: TextField(
            controller: EmailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.red, width: 3),
              ),
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.red),
              icon: Icon(Icons.email, color: Colors.red),
            ),
          ),
        ),
        // Password
        Positioned(
          top: 385,
          left: 30,
          width: 320,
          height: 200,
          child: TextField(
            controller: PasswordController,
            obscureText: obscurePassword,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.red, width: 3),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.red),
              icon: Icon(Icons.lock, color: Colors.red),
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.red,
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
        // Confirm Password
        Positioned(
          top: 460,
          left: 30,
          width: 320,
          height: 200,
          child: TextField(
            controller: ConfirmPasswordController,
            obscureText: obscureConfirmPassword,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.red, width: 3),
              ),
              hintText: 'Confirm Password',
              hintStyle: TextStyle(color: Colors.red),
              icon: Icon(Icons.lock, color: Colors.red),

              suffixIcon: IconButton(
                icon: Icon(
                  obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    obscureConfirmPassword = !obscureConfirmPassword;
                  });
                },
              ),
            ),
          ),
        ),

        // Sign In Button
        Positioned(
          top: 535,
          left: 40,
          width: 320,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: HandleSignIn,
            child: Text(
              'Sign In',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        // Rest der UI unverändert
        Positioned(
          top: 605,
          left: 130,
          child: RichText(
            text: TextSpan(
              text: 'I agree to the ',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontFamily: 'Jersey',
              ),
              children: [
                TextSpan(
                  text: 'Terms and Conditions',
                  style: TextStyle(
                    color: Colors.red,
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
          top: 588,
          left: 85,
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
              color: Colors.red,
              fontSize: 16,
              fontFamily: 'Jersey',
            ),
          ),
        ),
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
                  MaterialPageRoute(builder: (context) => changeColor()),
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
