import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdBanner extends StatelessWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => launchUrl(Uri.parse('https://taxrefundgo.kr')),
      child: CachedNetworkImage(
        imageUrl: 'https://placehold.it/500x100?text=ad',
        height: 80,
      ),
    );
  }
}
