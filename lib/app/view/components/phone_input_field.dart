import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class PhoneInputField extends StatelessWidget {
  const PhoneInputField({Key? key, this.controller}) : super(key: key);

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 48,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5FF).withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          inputFormatters: [MaskedInputFormatter('(###) ###-####')],
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '(123) 123-1234',
          ),
        ),
      ),
    );
  }
}
