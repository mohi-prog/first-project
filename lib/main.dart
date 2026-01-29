import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learnconnectmyself/notes_screen.dart';
import 'package:learnconnectmyself/summarizer.dart';
import 'firebase_options.dart';
import 'test.dart';
import 'changeColor.dart';
import 'Taschenrechner.dart';
import 'loginScreen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'ai_test_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // dotenv LADEN!
  await dotenv.load(fileName: ".env"); // ← WICHTIG!

  // Firebase initialisieren
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'calc': (context) => MiniCalc(),
        'changeColor': (context) => changeColor(),
        'taschenrechner': (context) => CAlculator(),
        'Login': (context) => Login(),
      },
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          centerTitle: false,
          title: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('MyApp'),
          ),
          titleTextStyle: TextStyle(
            color: const Color.fromARGB(255, 12, 228, 88),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          actions: [buildBox()],
        ),

        body: scroll(),
      ),
    );
  }
}

class buildBox extends StatelessWidget {
  const buildBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 19, 215, 101),
      ),
      padding: EdgeInsets.only(right: 1),
      child: Icon(Icons.add, size: 24, color: Colors.black),
    );
  }
}

class ScreenBox extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  const ScreenBox({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 160,
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: const Color.fromARGB(255, 49, 234, 55),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color.fromARGB(255, 0, 0, 0), size: 36),
            SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                color: const Color.fromARGB(255, 2, 2, 2),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class scroll extends StatefulWidget {
  scroll({super.key});

  @override
  State<scroll> createState() => _scrollState();
}

class _scrollState extends State<scroll> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          spacing: 25,
          children: [
            ScreenBox(
              color: const Color.fromARGB(255, 33, 191, 243),
              icon: Icons.add,
              label: 'Add',
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScreenBox(
                    color: Colors.blue,
                    icon: Icons.home,
                    label: 'Home',
                  ),
                  ScreenBox(
                    color: Colors.blue,
                    icon: Icons.search,
                    label: 'Search',
                  ),
                  ScreenBox(
                    color: Colors.blue,
                    icon: Icons.chat,
                    label: 'Chat',
                  ),
                ],
              ),
            ),
            ScreenBox(color: Colors.blue, icon: Icons.person, label: 'Profile'),
            ScreenBox(color: Colors.blue, icon: Icons.flight, label: 'Flight'),
            ScreenBox(color: Colors.blue, icon: Icons.map, label: 'Map'),
            ScreenBox(
              color: Colors.blue,
              icon: Icons.settings,
              label: 'Settings',
            ),
            ElevatedButton(
              onPressed: () {
                print('Well Done!');
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  const Color.fromARGB(255, 57, 244, 54),
                ),
              ),
              child: Text('Submit'),
            ),
            TextFormField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Hier etwas eingeben',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  gapPadding: 3,
                ),
                fillColor: const Color.fromARGB(255, 72, 255, 43),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte geben Sie etwas ein';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MiniCalc()),
                );*/
                Navigator.pushNamed(context, 'calc');
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
              ),
              child: Text('Submit'),
            ),
            ScreenBox(
              color: Colors.blue,
              icon: Icons.color_lens,
              label: 'colorchange',
              onPressed: () {
                Navigator.pushNamed(context, 'changeColor');
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'taschenrechner');
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
              ),
              child: Text('Taschenrechner'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'Login');
              },
              child: Text('Login'),
            ),
            Positioned(
              top: 30,
              left: 150,
              width: 50,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AiTest()),
                  );
                },
                child: Icon(Icons.laptop),
              ),
            ),
            Positioned(
              top: 50,
              left: 150,
              width: 50,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Summarizer()),
                  );
                },
                child: Icon(Icons.summarize),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesScreen()),
                );
              },
              child: Icon(Icons.notes),
            ),
          ],
        ),
      ),
    );
  }
}
