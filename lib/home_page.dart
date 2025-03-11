import 'package:flutter/material.dart';

class MyCalculator extends StatefulWidget {
  final String title;

  const MyCalculator({super.key, required this.title});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  final TextEditingController tempController = TextEditingController();
  String selectedUnit = 'Celsius';
  Map<String, double> conversions = {
    'Celsius': 0.0,
    'Fahrenheit': 0.0,
    'Kelvin': 0.0,
    'Reamur': 0.0,
  };

  void convertTemperature() {
    double temp = double.tryParse(tempController.text) ?? 0.0;
    setState(() {
      if (selectedUnit == 'Celsius') {
        conversions['Celsius'] = temp;
        conversions['Fahrenheit'] = temp * 9 / 5 + 32;
        conversions['Kelvin'] = temp + 273.15;
        conversions['Reamur'] = (temp + 273.15) * 9 / 5;
      } else if (selectedUnit == 'Fahrenheit') {
        conversions['Celsius'] = (temp - 32) * 5 / 9;
        conversions['Fahrenheit'] = temp;
        conversions['Kelvin'] = (temp + 459.67) * 5 / 9;
        conversions['Reamur'] = temp + 459.67;
      } else if (selectedUnit == 'Kelvin') {
        conversions['Celsius'] = temp - 273.15;
        conversions['Fahrenheit'] = temp * 9 / 5 - 459.67;
        conversions['Kelvin'] = temp;
        conversions['Reamur'] = temp * 9 / 5;
      } else if (selectedUnit == 'Reamur') {
        conversions['Celsius'] = (temp - 491.67) * 5 / 9;
        conversions['Fahrenheit'] = temp - 459.67;
        conversions['Kelvin'] = temp * 5 / 9;
        conversions['Reamur'] = temp;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), backgroundColor: Colors.blue),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter temperature",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue[100],
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedUnit,
              dropdownColor: Colors.white,
              isExpanded: true,
              items: ['Celsius', 'Fahrenheit', 'Kelvin', 'Reamur']
                  .map((unit) => DropdownMenuItem(value: unit, child: Text(unit)))
                  .toList(),
              onChanged: (value) {
                setState(() => selectedUnit = value!);
                convertTemperature();
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: convertTemperature,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Convert", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: conversions.keys
                      .map((key) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text(key, style: const TextStyle(fontWeight: FontWeight.bold))),
                          ))
                      .toList(),
                ),
                TableRow(
                  children: conversions.values
                      .map((value) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text(value.toStringAsFixed(2))),
                          ))
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
