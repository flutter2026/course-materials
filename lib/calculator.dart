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
  final op1Controller = TextEditingController();
  final op2Controller = TextEditingController();
  var currentOp = '+';
  final myFontStyle = TextStyle(fontSize: 40);

  @override
  void initState() {
    super.initState();
    op1Controller.text = '0';
    op2Controller.text = '0';
  }

  addOps() {
    return '${int.parse(op1Controller.text) + int.parse(op2Controller.text)}';
  }

  subtractOps() {
    return '${int.parse(op1Controller.text) - int.parse(op2Controller.text)}';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Calculator'), centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: myFontStyle,
                      textAlign: TextAlign.center,
                      controller: op1Controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                  Text(currentOp, style: myFontStyle),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: myFontStyle,
                      textAlign: TextAlign.center,
                      controller: op2Controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => currentOp = '+'),
                    child: Text('+', style: myFontStyle,),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => currentOp = '–'),
                    child: Text('–', style: myFontStyle,),
                  ),
                ],
              ),
              Text(currentOp == '+' ? addOps() : subtractOps(), style: myFontStyle,),
            ],
          ),
        ),
      ),
    );
  }
}
