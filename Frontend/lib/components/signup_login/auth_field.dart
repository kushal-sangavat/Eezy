import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  const AuthField({super.key,
    required this.hintText,
    required this.controller, 
    this.obscureText = false,
    this.validator,
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 3, 33, 85),
            width: 2,
          ),
        ),
        hintText: hintText,
        helperText: hintText == 'Email' ? 'Use your @jklu.edu.in email' : null,
        helperStyle: const TextStyle(color: Colors.blue),
      ),
      validator: validator ?? (value) {
        if (value!.isEmpty) {
          return 'Please enter your $hintText';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
    );
  }
}