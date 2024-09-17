import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // External package for expression evaluation

void main() {
  runApp(const SimpleCalculator());
}

class SimpleCalculator extends StatelessWidget {
  const SimpleCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mason\'s Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '';
  String _expression = '';
  String _result = '';

  // Function to handle square
  void _square() {
    setState(() {
      try {
        final Expression expression = Expression.parse(_expression);
        final evaluator = const ExpressionEvaluator();
        final evalResult = evaluator.eval(expression, {});
        _result = (evalResult * evalResult).toString();
        _display = '$_expression² = $_result';
      } catch (e) {
        _display = 'Error';
      }
    });
  }

  // Function to handle modulo
  void _modulo() {
    setState(() {
      try {
        final Expression expression = Expression.parse(_expression);
        final evaluator = const ExpressionEvaluator();
        final evalResult = evaluator.eval(expression, {});
        _result = (evalResult % 1).toString();
        _display = '$_expression % 1 = $_result';
      } catch (e) {
        _display = 'Error';
      }
    });
  }

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '';
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          final Expression expression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          final evalResult = evaluator.eval(expression, {});
          _result = evalResult.toString();
          _display = '$_expression = $_result';
        } catch (e) {
          _display = 'Error';
        }
      } else if (value == 'x²') {
        _square();
      } else if (value == '%') {
        _modulo();
      } else {
        _expression += value;
        _display += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mason\'s Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              color: Colors.black12,
              child: Text(
                _display,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                _buildButtonRow(['7', '8', '9', '/', 'x²']),
                _buildButtonRow(['4', '5', '6', '*', '%']),
                _buildButtonRow(['1', '2', '3', '-']),
                _buildButtonRow(['C', '0', '=', '+']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((button) {
          return Expanded(
            child: ElevatedButton(
              onPressed: () => _onPressed(button),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.grey[850],
                textStyle: const TextStyle(fontSize: 24),
              ),
              child: Text(button),
            ),
          );
        }).toList(),
      ),
    );
  }
}
