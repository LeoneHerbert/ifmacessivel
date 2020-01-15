import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;
  final int minLinhas;
  final int maxLinhas;
  final TextEditingController controller;
  final String valorInicial;

  CustomTextField({
    this.icon,
    this.hint,
    this.obscure = false,
    this.stream,
    this.onChanged,
    this.minLinhas = 1,
    this.maxLinhas = 1,
    this.controller,
    this.valorInicial,
  }) {
    if (valorInicial != null) {
      onChanged(valorInicial);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextFormField(
          initialValue: valorInicial != null ? valorInicial : null,
          controller: controller,
          minLines: minLinhas,
          maxLines: maxLinhas,
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
