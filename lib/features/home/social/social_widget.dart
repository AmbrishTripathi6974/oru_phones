import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialShareWidget extends StatelessWidget {
  const SocialShareWidget({super.key});

  final String message = "Invite a friend to ORUphones application.";

  void _shareOnWhatsApp() async {
    final url = Uri.parse("https://wa.me/?text=${Uri.encodeComponent(message)}");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _shareOnTelegram() async {
    final url = Uri.parse("https://t.me/share/url?url=${Uri.encodeComponent(message)}");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _shareOnTwitter() async {
    final url = Uri.parse("https://twitter.com/intent/tweet?text=${Uri.encodeComponent(message)}");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _shareOnInstagram() async {
    final url = Uri.parse("https://www.instagram.com/");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          "Or Share",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 30), // Increased space
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon("assets/images/social/instagram.png", _shareOnInstagram),
            _buildIcon("assets/images/social/telegram.png", _shareOnTelegram),
            _buildIcon("assets/images/social/twitter.png", _shareOnTwitter),
            _buildIcon("assets/images/social/whatsapp.png", _shareOnWhatsApp),
          ],
        ),
        const SizedBox(height: 60), // Added bottom spacing
      ],
    );
  }

  Widget _buildIcon(String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Image.asset(assetPath, width: 40, height: 40),
      ),
    );
  }
}
