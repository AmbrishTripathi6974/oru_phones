import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones/features/auth/bloc/auth_state.dart';

import '../auth/bloc/auth_bloc.dart';
import '../auth/bloc/auth_event.dart';
import 'bloc/sidebar_bloc.dart';
import 'bloc/sidebar_event.dart';
import 'bloc/sidebar_state.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<SidebarBloc, SidebarState>(
      builder: (context, state) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: state is SidebarOpened ? 0 : -screenWidth,
          top: 0,
          bottom: 0,
          child: Container(
            width: screenWidth * 0.75,
            padding: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Header: Logo & Close Icon
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/logo.png', height: 40),
                          IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () {
                              context.read<SidebarBloc>().add(ToggleSidebar());
                            },
                          ),
                        ],
                      ),
                    ),

                    // 🔹 User Profile or Login Button
                    if (authState is AuthenticatedState)
                      _buildUserProfile(authState.userName, authState.joiningDate)
                    else
                      _buildLoginButton(context),

                    const SizedBox(height: 10),

                    // 🔹 Sell Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Sell Your Phone',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // 🔹 Logout Button (Visible when logged in)
                    if (authState is AuthenticatedState)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<AuthBloc>().add(const LogoutEvent());
                            context.read<SidebarBloc>().add(UserLogout());
                          },
                          icon: const Icon(Icons.logout, color: Colors.black),
                          label: Text(
                            "Logout",
                            style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),

                    const Spacer(),

                    // 🔹 Bottom Chips Section
                    _buildBottomChips(),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  // 🔹 Login Button Widget
  Widget _buildLoginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              'Login/SignUp',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 User Profile Widget
  Widget _buildUserProfile(String name, String joiningDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/profile.png'),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                "Joined: $joiningDate",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // 🔹 Bottom Chips Section
  Widget _buildBottomChips() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Wrap(
        spacing: 20,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: [
          _buildChip('How to Buy', 'icon1.png'),
          _buildChip('How to Sell', 'icon2.png'),
          _buildChip('FAQs', 'icon3.png'),
          _buildChip('About Us', 'icon4.png'),
          _buildChip('Privacy Policy', 'icon5.png'),
          _buildChip('Return Policy', 'icon6.png'),
        ],
      ),
    );
  }

  // 🔹 Individual Chip Widget
  Widget _buildChip(String text, String iconPath) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/side_menu_icons/$iconPath', height: 30),
              const SizedBox(height: 8),
              Text(
                text,
                style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
