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

  void changeRed() {
    setState(() {
      themeColor = Colors.red;
    });
  }

  void changeGreen() {
    setState(() {
      themeColor = Colors.green;
    });
  }

  void changeBlue() {
    setState(() {
      themeColor = Colors.blue;
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
            mainAxisAlignment: .center,
            children: [
              ElevatedButton(
                onPressed: changeRed,
                child: const Text('Red'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: changeGreen,
                child: const Text('Green'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: changeBlue,
                child: const Text('Blue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
