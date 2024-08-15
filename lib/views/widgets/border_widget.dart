import 'package:flutter/material.dart';

class BorderWidget extends StatelessWidget {
  const BorderWidget({
    super.key,
    required this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    if (text == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1),
      ),
      child: Text(
        text!,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }
}
