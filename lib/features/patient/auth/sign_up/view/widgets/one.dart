import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Height Input Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Height Input Field'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: HeightInputField(
          onChanged: (double value, String unit) {
            // This callback is triggered only when the input is valid.
            // In a real application, you would typically update a data model
            // or perform further actions with the validated height here.
            debugPrint('Height: $value $unit');
          },
        ),
      ),
    );
  }
}

class HeightInputField extends StatefulWidget {
  // Define the callback type explicitly for clarity and type safety.
  final void Function(double value, String unit)? onChanged;

  const HeightInputField({super.key, this.onChanged});

  @override
  State<HeightInputField> createState() => _HeightInputFieldState();
}

class _HeightInputFieldState extends State<HeightInputField> {
  final TextEditingController _controller = TextEditingController();
  String _selectedUnit = 'ft'; // Default unit
  String? _errorMessage; // Stores the current validation error message

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Validates the current text in the input field and updates the error message.
  /// If the input is valid, it also triggers the `onChanged` callback.
  void _onValueChanged() {
    final String text = _controller.text;
    double? parsedValue;
    String? newErrorMessage; // Temporary variable for the determined error message

    if (text.isEmpty) {
      newErrorMessage = 'Height cannot be empty.';
    } else {
      parsedValue = double.tryParse(text);
      if (parsedValue == null) {
        newErrorMessage = 'Invalid number format.';
      } else if (parsedValue <= 0) {
        // Height should generally be a positive value.
        newErrorMessage = 'Height must be positive.';
      }
    }

    // Update the state with the new error message. This will trigger a UI rebuild.
    setState(() {
      _errorMessage = newErrorMessage;
    });

    // Only call the external `onChanged` callback if there is no error message
    // and the parsed value is available.
    if (newErrorMessage == null && parsedValue != null && widget.onChanged != null) {
      widget.onChanged!(parsedValue, _selectedUnit);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine the border color based on whether there's an error.
    final Color borderColor = _errorMessage != null ? Colors.red : Colors.grey.shade400;

    return Column(
      mainAxisSize: MainAxisSize.min, // Use minimum space in the column
      crossAxisAlignment: CrossAxisAlignment.start, // Align content and error message to the start
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor), // Dynamic border color based on validation
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  // Configure keyboard for number input with decimals and disallow negative sign.
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false, // Ensures a numeric keypad without a negative sign option.
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Hide the default TextField border
                    hintText: 'Enter height',
                  ),
                  onChanged: (_) => _onValueChanged(), // Trigger validation on text change
                ),
              ),
              const SizedBox(width: 12),
              DropdownButton<String>(
                value: _selectedUnit,
                underline: const SizedBox(), // Hide the default underline
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedUnit = newValue;
                    });
                    _onValueChanged(); // Re-validate the current text with the new unit
                  }
                },
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(value: 'ft', child: Text('ft')),
                  DropdownMenuItem<String>(value: 'in', child: Text('in')),
                ],
              ),
            ],
          ),
        ),
        // Display the error message only if it exists.
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8.0),
            child: Text(
              _errorMessage!, // Use the non-nullable version as we check for null above
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}