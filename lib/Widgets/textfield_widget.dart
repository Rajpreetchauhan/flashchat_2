import 'package:flutter/material.dart';

class Userdatatextfield extends StatelessWidget {
  final String hinttext;
   Userdatatextfield({super.key, required this.hinttext, this.validator, this.controller});
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
      child: SizedBox(
        height: 45,
        child: TextFormField(
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.white)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.red)),
              hintText: hinttext,
              hintStyle: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
