import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var checkboxValues = [false, false, false, false, false];
  var pizza = 'plain';

  changeBox(which, newValue) {
    checkboxValues[which] = newValue;
    if (which == 3) {
      clearRegulars();
      checkboxValues[4] = false;
    } else if (which == 4) {
      clearRegulars();
      checkboxValues[3] = false;
    } else {
      checkboxValues[3] = false;
      checkboxValues[4] = false;
    }

    if (!checkboxValues[0] &&
        !checkboxValues[1] &&
        !checkboxValues[2] &&
        !checkboxValues[3] &&
        !checkboxValues[4]) {
      pizza = 'plain';
    } else if (checkboxValues[0] && !checkboxValues[1] && !checkboxValues[2]) {
      pizza = 'peper';
    } else if (!checkboxValues[0] && checkboxValues[1] && !checkboxValues[2]) {
      pizza = 'green';
    } else if (!checkboxValues[0] && !checkboxValues[1] && checkboxValues[2]) {
      pizza = 'olive';
    } else if (checkboxValues[0] && checkboxValues[1] && !checkboxValues[2]) {
      pizza = 'peper_green';
    } else if (checkboxValues[0] && !checkboxValues[1] && checkboxValues[2]) {
      pizza = 'peper_olive';
    } else if (!checkboxValues[0] && checkboxValues[1] && checkboxValues[2]) {
      pizza = 'green_olive';
    } else if (checkboxValues[0] && checkboxValues[1] && checkboxValues[2]) {
      pizza = 'works';
    } else if (checkboxValues[3]) {
      pizza = 'bowling_balls';
    } else if (checkboxValues[4]) {
      pizza = 'kittens';
    }
    setState(() {});
  }

  clearRegulars() {
    checkboxValues[0] = false;
    checkboxValues[1] = false;
    checkboxValues[2] = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(title: Text('Choose your toppings')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues[0],
                      onChanged: (newValue) => changeBox(0, newValue),
                    ),
                    Text("Pepperoni"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues[1],
                      onChanged: (newValue) => changeBox(1, newValue),
                    ),
                    Text("Green peppers"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues[2],
                      onChanged: (newValue) => changeBox(2, newValue),
                    ),
                    Text("Black olives"),
                  ],
                ),
                Text(
                  'Specialty Pizzas',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues[3],
                      onChanged: (newValue) => changeBox(3, newValue),
                    ),
                    Text("Bowling balls"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues[4],
                      onChanged: (newValue) => changeBox(4, newValue),
                    ),
                    Text("Kittens"),
                  ],
                ),
                Image.asset('assets/$pizza.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
