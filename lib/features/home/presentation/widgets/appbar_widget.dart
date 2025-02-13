import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../auth/bloc/auth_bloc.dart';
import '../../../auth/bloc/auth_state.dart';
import '../../../side_menu_bar/bloc/sidebar_bloc.dart';
import '../../../side_menu_bar/bloc/sidebar_event.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Sidebar Toggle Button (Replaced Icon with Image)
              IconButton(
                icon: Image.asset("assets/menu.png", height: 36, width: 36), 
                onPressed: () {
                  context.read<SidebarBloc>().add(ToggleSidebar());
                },
              ),
              Image.asset("assets/logo.png", height: 30), // App logo
            ],
          ),
          Row(
            children: [
              Text("India",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: GoogleFonts.poppins().fontFamily)),
              const SizedBox(width: 6),
              const Image(image: AssetImage('assets/location.png')),
              const SizedBox(width: 20),

              // BlocBuilder to check if user is logged in
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    // If user is logged in, show profile
                    return Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage("assets/profile.png"),
                          radius: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          state.userName, // Username from Bloc
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  } else {
                    // If not logged in, show Login button
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF6C018),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Redirect to login page
                        Navigator.pushNamed(context, "/login");
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
