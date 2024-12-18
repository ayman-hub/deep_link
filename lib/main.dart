import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => FirstPage(),
        '/profile': (context) => ProfilePage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      _initDeepLink();
    });
  }

  Future<void> _initDeepLink() async {
    // Handle initial link when app is launched
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _handleDeepLink(initialLink);
      }
    } catch (e) {
      print("Error handling deep link: $e");
    }

    // Listen for deep link changes
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri.toString());
      }
    });
  }

  void _handleDeepLink(String link) {
    print("Deep Link Received: $link");
    // Navigate to a specific page based on the link
    Future.delayed(const Duration(seconds: 1), () {
      if (link.contains('/profile')) {
        Navigator.pushNamed(context, '/profile');
      } else if (link.contains('/home')) {
        Navigator.pushNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Page")),
      body: Center(child: Text("Welcome to First!")),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(child: Text("Welcome to Home!")),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Page")),
      body: Center(child: Text("Welcome to Profile!")),
    );
  }
}
