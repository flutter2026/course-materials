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
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  void copyDown() {
    setState(() {
      _controller2.text = _controller1.text;
    });
  }

  void copyUp() {
    setState(() {
      _controller1.text = _controller2.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                textAlign: TextAlign.center,
                controller: _controller1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: copyDown,
                    child: Icon(Icons.arrow_downward),
                  ),
                  ElevatedButton(
                    onPressed: copyUp,
                    child: Icon(Icons.arrow_upward),
                  ),
                ],
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _controller2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ]
        ),
      ),
    );
  }
}
