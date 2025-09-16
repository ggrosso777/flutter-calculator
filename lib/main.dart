import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ian\'s Calculator',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          final exp = Expression.parse(
            _expression.replaceAll('×', '*').replaceAll('÷', '/')
          );
          final evaluator = const ExpressionEvaluator();
          final evalResult = evaluator.eval(exp, {});
          _result = '= $evalResult';
        } catch (e) {
          _result = '= Error';
        }
      } else if (value == 'x²') {
        _expression += '^2';
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String label, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[200],
            foregroundColor: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: () => _onPressed(label),
          child: Text(label, style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> labels, {Color? color}) {
    return Row(
      children: labels.map((label) => _buildButton(label, color: color)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ian\'s Calculator')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(
              '$_expression $_result',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(),
          Expanded(
            child: Column(
              children: [
                _buildButtonRow(['x²', '%'], color: Colors.blue[100]),
                _buildButtonRow(['7', '8', '9', '÷']),
                _buildButtonRow(['4', '5', '6', '×']),
                _buildButtonRow(['1', '2', '3', '-']),
                _buildButtonRow(['0', '.', '=', '+']),
                _buildButtonRow(['C'], color: Colors.redAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }
}