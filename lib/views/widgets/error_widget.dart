import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ErrorWidget extends StatelessWidget {
  final Object e;
  const ErrorWidget({
    super.key,
    required this.e,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          '<Error>',
          style: TextStyle(fontSize: 32),
        ),
        const Gap(20),
        Text('Error: $e'),
      ]),
    );
  }
}
