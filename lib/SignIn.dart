import 'package:flutter/material.dart';

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
              top: 50,
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
      body: SignInn(),
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
        Positioned(
          top: 235,
          left: 30,
          width: 320,
          height: 200,
          child: TextField(
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
        Positioned(
          top: 310,
          left: 30,
          width: 320,
          height: 200,

          child: TextField(
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
        Positioned(
          top: 385,
          left: 30,
          width: 320,
          height: 200,

          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.red, width: 3),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.red),
              icon: Icon(Icons.lock, color: Colors.red),
            ),
          ),
        ),
        Positioned(
          top: 460,
          left: 30,
          width: 320,
          height: 200,

          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.red, width: 3),
              ),
              hintText: 'Confirm Password',
              hintStyle: TextStyle(color: Colors.red),
              icon: Icon(Icons.lock, color: Colors.red),
            ),
          ),
        ),
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
            onPressed: () {},
            child: Text(
              'Sign In',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
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
            onTap: () {},

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
