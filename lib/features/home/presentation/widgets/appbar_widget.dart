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
          // 🔹 Menu & Logo
          Row(
            children: [
              IconButton(
                icon: Image.asset("assets/menu.png", height: 36, width: 36),
                onPressed: () {
                  context.read<SidebarBloc>().add(ToggleSidebar());
                },
              ),
              Image.asset("assets/logo.png", height: 30),
            ],
          ),

          // 🔹 Location & Login
          Row(
            children: [
              Text(
                "India",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              const SizedBox(width: 6),
              const Image(image: AssetImage('assets/location.png')),
              const SizedBox(width: 20),

              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthenticatedState) {
                    return const SizedBox.shrink(); // 🔹 Do not hide AppBar
                  } else {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF6C018),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
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
