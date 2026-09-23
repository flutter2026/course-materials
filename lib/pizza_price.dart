import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

enum PizzaTopping { PEPPERONI, OLIVES, MUSHROOMS }

class _MyAppState extends State<MyApp> {
  bool pepValue = false;
  bool oliveValue = false;
  bool mushValue = false;
  var totalPrice = 8.00;
  final myFontStyle = TextStyle(fontSize: 40);

  onChanged(value, topping) {
    setState(() {
      switch (topping) {
        case PizzaTopping.PEPPERONI:
          pepValue = value;
          if (value) {
            totalPrice += 2.00;
          } else {
            totalPrice -= 2.00;
          }
          break;
        case PizzaTopping.OLIVES:
          oliveValue = value;
          if (value) {
            totalPrice += 1.50;
          } else {
            totalPrice -= 1.50;
          }
          break;
        case PizzaTopping.MUSHROOMS:
          mushValue = value;
          if (value) {
            totalPrice += 1.00;
          } else {
            totalPrice -= 1.00;
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Pizza'), centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CheckboxListTile(
                onChanged: (value) => onChanged(value, PizzaTopping.PEPPERONI),
                title: Text('Pepperoni', style: myFontStyle),
                value: pepValue,
              ),
              CheckboxListTile(
                onChanged: (value) => onChanged(value, PizzaTopping.OLIVES),
                title: Text('Olives', style: myFontStyle),
                value: oliveValue,
              ),
              CheckboxListTile(
                onChanged: (value) => onChanged(value, PizzaTopping.MUSHROOMS),
                title: Text('Mushrooms', style: myFontStyle),
                value: mushValue,
              ),
              Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: myFontStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
