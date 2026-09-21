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
  final controller = TextEditingController();
  String someText = '';

  update() {
    setState(() {
      someText = controller.text;
    });
  }

  clear() {
    setState(() {
      someText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: .center,
          children: [
            TextField(
              textAlign: .center,
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
            Row(
              mainAxisAlignment: .center,
              children: [
                ElevatedButton(onPressed: update, child: Text('Update')),
                ElevatedButton(onPressed: clear, child: Text('Clear')),
              ],
            ),
            Text(someText),
          ],
        ),
      ),
    );
  }
}
