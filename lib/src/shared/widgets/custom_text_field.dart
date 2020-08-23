import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;
  final int minLines;
  final int maxLines;
  final TextEditingController controller;
  final String initialValue;

  CustomTextField({
    this.icon,
    this.hint,
    this.obscure = false,
    this.stream,
    this.onChanged,
    this.minLines = 1,
    this.maxLines = 1,
    this.controller,
    this.initialValue,
  }) {
    if (initialValue != null) {
      onChanged(initialValue);
    }
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextFormField(
          initialValue: initialValue != null ? initialValue : null,
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            hintText: hint,
            errorText: snapshot.hasError ? snapshot.error : null,
          ),
          obscureText: obscure,
        );
      },
    );
  }
}
