import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdBanner extends StatelessWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse('https://taxrefundgo.kr')),
      child: SizedBox(
        height: 80,
        child: Image.network('https://placehold.it/500x100?text=ad'),
      ),
    );
  }
}
