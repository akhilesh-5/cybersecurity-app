import 'package:flutter/material.dart';
// import 'package:cyyyyyyyyyyyyyyyyy';

void main() {
  runApp(CyberSecurityApp());
}

class CyberSecurityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cybersecurity App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      // Define named routes for navigation.
      routes: {
        '/learning': (context) => LearningPage(),
        '/encryption': (context) => EncryptionPage(),
        '/toolkit': (context) => ToolkitPage(),
        '/roadmap': (context) => RoadmapPage(),
      },
    );
  }
}

// Home page with a Drawer to navigate between sections.
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cybersecurity App')),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Navigation',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Learning'),
              onTap: () {
                Navigator.pushNamed(context, '/learning');
              },
            ),
            ListTile(
              title: Text('Encryption & Decryption'),
              onTap: () {
                Navigator.pushNamed(context, '/encryption');
              },
            ),
            ListTile(
              title: Text('Cryptography Toolkit'),
              onTap: () {
                Navigator.pushNamed(context, '/toolkit');
              },
            ),
            ListTile(
              title: Text('Roadmap to Cybersecurity'),
              onTap: () {
                Navigator.pushNamed(context, '/roadmap');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to the Cybersecurity Learning App!\nSelect an option from the drawer.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// 1. Cybersecurity Learning Page (place for interactive lessons and quizzes)
class LearningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cybersecurity Learning')),
      body: Center(
        child: Text(
          'This section contains tutorials, quizzes, and interactive simulations on cryptography concepts.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// 2. Encryption & Decryption Tool Page
class EncryptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Encryption & Decryption Tool')),
      body: Center(
        child: Text(
          'Here, users can encrypt and decrypt files/messages using cryptographic algorithms like AES or RSA.\n\n(You can integrate packages such as "encrypt" to implement these features.)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// 3. Cryptography Toolkit Page with a Miller-Rabin Primality Test example.
class ToolkitPage extends StatefulWidget {
  @override
  _ToolkitPageState createState() => _ToolkitPageState();
}

class _ToolkitPageState extends State<ToolkitPage> {
  final TextEditingController _numberController = TextEditingController();
  String _result = '';

  // Simple implementation of the Miller-Rabin Primality Test.
  bool isPrime(int n, {int k = 5}) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0) return false;

    // Express n-1 as 2^r * d.
    int r = 0;
    int d = n - 1;
    while (d % 2 == 0) {
      d ~/= 2;
      r += 1;
    }

    // Witness loop – note: for a production-level tool, you’d use a more robust randomness source.
    for (int i = 0; i < k; i++) {
      int a =
          2 +
          (i % (n - 4)); // For demo purposes; in real cases, use random values.
      int x = modPow(a, d, n);
      if (x == 1 || x == n - 1) continue;
      bool continueOuter = false;
      for (int j = 0; j < r - 1; j++) {
        x = modPow(x, 2, n);
        if (x == n - 1) {
          continueOuter = true;
          break;
        }
      }
      if (!continueOuter) return false;
    }
    return true;
  }

  // Helper for modular exponentiation.
  int modPow(int base, int exponent, int mod) {
    int result = 1;
    base = base % mod;
    while (exponent > 0) {
      if (exponent % 2 == 1) result = (result * base) % mod;
      exponent = exponent >> 1;
      base = (base * base) % mod;
    }
    return result;
  }

  void _checkPrime() {
    int? num = int.tryParse(_numberController.text);
    if (num == null) {
      setState(() {
        _result = 'Please enter a valid number';
      });
      return;
    }
    bool prime = isPrime(num);
    setState(() {
      _result = '$num is ${prime ? "a prime number" : "not a prime number"}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cryptography Toolkit')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(
              'Miller-Rabin Primality Test',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _numberController,
              decoration: InputDecoration(labelText: 'Enter a number'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _checkPrime, child: Text('Check Prime')),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. Roadmap to Cybersecurity Page
class RoadmapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Roadmap to Cybersecurity')),
      body: Center(
        child: Text(
          'This section provides a structured learning path with articles, videos, and hands-on exercises to guide you in cybersecurity.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
