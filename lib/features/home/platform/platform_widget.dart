import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadInviteWidget extends StatelessWidget {
  const DownloadInviteWidget({super.key});

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Copied: $text")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Allows Invite Card to overflow
      children: [
        Column(
          children: [
            // 🔹 Black Section
            Container(
              color: Colors.black87,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "Download App",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // QR Code Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset("assets/images/qr_code/android.png",
                              width: 160, height: 160), // Android QR
                          const SizedBox(height: 10),
                          Image.asset("assets/images/platform_logo/playStore.png",
                              width: 30, height: 32), // Android Logo
                        ],
                      ),
                      const SizedBox(width: 40),
                      Column(
                        children: [
                          Image.asset("assets/images/qr_code/ios.png",
                              width: 160, height: 160), // iOS QR
                          const SizedBox(height: 10),
                          Image.asset("assets/images/platform_logo/ios.png",
                              width: 30, height: 32), // iOS Logo
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 180), // Extra space for Invite Card overlay
                ],
              ),
            ),

            // 🔹 White Section (Below Black)
            Container(
              height: 100, // White section background
              // color: Colors.white,
            ),
          ],
        ),

        // 🔹 Invite Card (Overlaying both sections)
        Positioned(
          top: 340, // Adjusted based on given top: 81.47px
          left: 44, // From provided left position
          child: Container(
            width: 320, // Fixed width
            height: 258, // Fixed height
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40), // Rounded edges
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                // Invite Text
                Text(
                  "Invite a friend to ORUphones application.\nTap to copy the respective download link to the clipboard",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Buttons
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => _copyToClipboard(
                          context, "https://play.google.com/store"),
                      child: Image.asset(
                          "assets/images/platform/playStore_button.png",
                          width: 170),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _copyToClipboard(
                          context, "https://www.apple.com/app-store/"),
                      child: Image.asset(
                          "assets/images/platform/appStore_button.png",
                          width: 170),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
