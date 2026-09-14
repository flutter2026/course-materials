import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color themeColor = Colors.black;

  void changeTheme(Color color) {
    setState(() {
      themeColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: themeColor),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Color Changer'),
          centerTitle: true,
          backgroundColor: themeColor,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => changeTheme(Colors.red),
                child: const Text('Red'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => changeTheme(Colors.green),
                child: const Text('Green'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => changeTheme(Colors.blue),
                child: const Text('Blue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
