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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                // 🔹 Black Section
                Container(
                  color: Colors.black87,
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.04,
                    horizontal: screenWidth * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        "Download App",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.05),

                      // QR Code Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/qr_code/android.png",
                                width: screenWidth * 0.35,
                                height: screenWidth * 0.35,
                              ), // Android QR
                              SizedBox(height: screenHeight * 0.01),
                              Image.asset(
                                "assets/images/platform_logo/playStore.png",
                                width: screenWidth * 0.08,
                                height: screenWidth * 0.08,
                              ), // Android Logo
                            ],
                          ),
                          SizedBox(width: screenWidth * 0.08),
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/qr_code/ios.png",
                                width: screenWidth * 0.35,
                                height: screenWidth * 0.35,
                              ), // iOS QR
                              SizedBox(height: screenHeight * 0.01),
                              Image.asset(
                                "assets/images/platform_logo/ios.png",
                                width: screenWidth * 0.08,
                                height: screenWidth * 0.08,
                              ), // iOS Logo
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.22), // Extra space for Invite Card
                    ],
                  ),
                ),

                // 🔹 White Section (Below Black)
                Container(
                  height: screenHeight * 0.12, // White background
                ),
              ],
            ),

            // 🔹 Invite Card (Overlaying both sections)
            Positioned(
              top: screenHeight * 0.45, // Responsive position
              left: (screenWidth - screenWidth * 0.85) / 2, // Center horizontally
              child: Container(
                width: screenWidth * 0.85,
                height: screenHeight * 0.32,
                padding: EdgeInsets.all(screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
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
                        fontSize: screenWidth * 0.035,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Buttons
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => _copyToClipboard(
                              context, "https://play.google.com/store"),
                          child: Image.asset(
                            "assets/images/platform/playStore_button.png",
                            width: screenWidth * 0.45,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        GestureDetector(
                          onTap: () => _copyToClipboard(
                              context, "https://www.apple.com/app-store/"),
                          child: Image.asset(
                            "assets/images/platform/appStore_button.png",
                            width: screenWidth * 0.45,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // 🔹 Padding after widget
        SizedBox(height: screenHeight * 0.05),
      ],
    );
  }
}
