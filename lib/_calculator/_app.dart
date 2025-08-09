import 'package:flutter/material.dart';


class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _display = '0';
  String _firstNumber = '';
  String _operation = '';
  bool isNewNumber = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:  Text(
          'Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
              child: Divider(height: 1, color: Colors.grey)
          ),
          // Display Area
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            decoration: BoxDecoration(
              color: Color(0xffF5F9FA),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(28)
            ),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (_firstNumber.isNotEmpty && _operation.isNotEmpty)
                    Text(
                      '$_firstNumber $_operation',
                      style: TextStyle(color: Colors.grey[500], fontSize: 16),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    _display,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Buttons Area
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildButton('C', functionButtonColor, _clear)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('CE', functionButtonColor, _clearEntry)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('+/-', functionButtonColor, _toggleSign)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('%', operationButtonColor, () => _setOperation('%'),
                              textColor: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _buildButton('1', digitButtonColor, () => _addDigit('1'))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('2', digitButtonColor, () => _addDigit('2'))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('3', digitButtonColor, () => _addDigit('3'))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('×', operationButtonColor, () => _setOperation('×'),
                              textColor: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _buildButton('4', digitButtonColor, () => _addDigit('4'))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('5', digitButtonColor, () => _addDigit('5'))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('6', digitButtonColor, () => _addDigit('6'))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('-', operationButtonColor, () => _setOperation('-'),
                              textColor: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _buildButton('7', digitButtonColor, () => _addDigit('7'))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('8', digitButtonColor, () => _addDigit('8'))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('9', digitButtonColor, () => _addDigit('9'))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('+', operationButtonColor, () => _setOperation('+'),
                              textColor: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _buildButton('.', digitButtonColor, _addDecimalPoint)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('0', digitButtonColor, () => _addDigit('0'))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('00', digitButtonColor, () => _addDigit('00'))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildButton('=', operationButtonColor, _calculate,
                              textColor: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }




  Widget _buildButton(
      String label, Color backgroundColor, VoidCallback onPressed,
      {Color? textColor}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor ?? Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textColor ?? Colors.black,
        ),
      ),
    );
  }

  void _clear() {
    setState(() {
      _display = '0';
      _firstNumber = '';
      _operation = '';
      isNewNumber = true;
    });
  }

  void _clearEntry() {
    setState(() {
      _display = '0';
      isNewNumber = true;
    });
  }

  void _toggleSign() {
    setState(() {
      if (_display == '0') return;
      if (_display.startsWith('-')) {
        _display = _display.substring(1);
      } else {
        _display = '-$_display';
      }
    });
  }

  void _setOperation(String operation) {
    setState(() {
      if (_operation.isNotEmpty) {
        _calculate();
      }
      _firstNumber = _display;
      _operation = operation;
      isNewNumber = true;
    });
  }

  void _addDigit(String digit) {
    setState(() {
      if (isNewNumber) {
        _display = digit;
        isNewNumber = false;
      } else {
        if (_display == '0') {
          _display = digit;
        } else {
          _display += digit;
        }
      }
    });
  }

  void _addDecimalPoint() {
    setState(() {
      if (isNewNumber) {
        _display = '0.';
        isNewNumber = false;
      } else if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  void _calculate() {
    if (_firstNumber.isNotEmpty && _operation.isNotEmpty) {
      setState(() {
        double firstNumber = double.tryParse(_firstNumber) ?? 0;
        double secondNumber = double.tryParse(_display) ?? 0;
        double result = 0;

        switch (_operation) {
          case '+':
            result = firstNumber + secondNumber;
            break;
          case '-':
            result = firstNumber - secondNumber;
            break;
          case '×':
            result = firstNumber * secondNumber;
            break;
          case '%':
            if (secondNumber != 0) {
              result = firstNumber / secondNumber;
            } else {
              _display = 'Can\'t divide by 0';
              _firstNumber = '';
              _operation = '';
              isNewNumber = true;
              return;
            }
            break;
          default:
            return;
        }

        _display = result.toStringAsFixed(10);
        _display = _display.replaceFirst(RegExp(r'\.?0+$'), '');

        _firstNumber = '';
        _operation = '';
        isNewNumber = true;
      });
    }
  }
}



const Color bodyColor = Color(0xffF5F9FA);
const Color digitButtonColor = Colors.white;
const Color functionButtonColor = Color(0xffE0E0E0);
const Color operationButtonColor = Colors.teal;