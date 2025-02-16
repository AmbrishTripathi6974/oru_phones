import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oru_phones/common/section_heading.dart';
import 'package:oru_phones/features/home/brand/brand_widget.dart';
import 'package:oru_phones/features/home/email/email_widget.dart';
import 'package:oru_phones/features/home/faq/widget/faq_widget.dart';
import 'package:oru_phones/features/home/platform/platform_widget.dart';
import 'package:oru_phones/features/home/presentation/widgets/banner_widget.dart';
import 'package:oru_phones/features/home/presentation/widgets/option_grid.dart';
import 'package:oru_phones/features/home/social/social_widget.dart';
import 'package:oru_phones/features/home/sort_and_filter/sort_and_filter_button.dart';

import '../../../services/dio_service.dart';
import '../../../side_menu_bar/bloc/sidebar_bloc.dart';
import '../../../side_menu_bar/bloc/sidebar_state.dart';
import '../../../side_menu_bar/side_menu_bar.dart';
import '../../product/widget/product_list.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/search_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dioService = DioService(); // ✅ Ensure DioService instance is created

    // 🔹 Log stored cookies to check if the user is still logged in
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dioService.getCookies().then((cookies) {
        log("🍪 Saved Cookies: $cookies");
      });
    });

    return Scaffold(
      backgroundColor: Colors.grey[100], // ✅ Light background
      body: Stack(
        children: [
          NestedScrollView(
            clipBehavior: Clip.none, // ✅ Improves scroll performance
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 150,
                  pinned: true,
                  floating: false,
                  backgroundColor: Colors.white, // ✅ Fixed background color (No opacity flickering)
                  elevation: 0,
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: const Column(
                      children: [
                        SafeArea(child: CustomAppBar()),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                  bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(125),
                    child: Column(
                      children: [
                        CustomSearchBar(),
                        SizedBox(height: 12),
                        CategoriesList(),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBannerWidget(),
                  const SizedBox(height: 16),
                  const SectionHeadingWidget(text: "What’s on your mind?"),
                  const SizedBox(height: 12),
                  const OptionsGrid(),
                  const SizedBox(height: 16),
                  const SectionHeadingWidget(text: "Top Brands"),
                  const SizedBox(height: 16),
                  BrandsWidget(),
                  const SizedBox(height: 18),
                  const SectionHeadingWidget(text: "Best deals", location: "in India"),
                  const SizedBox(height: 12),
                  const SortFilterButtons(),
                  const ProductList(),
                  const SectionHeadingWidget(text: "Frequent Asked Questions"),
                  const SizedBox(height: 12),
                  const FaqWidget(),
                  const SizedBox(height: 12),
                  const EmailSubscriptionWidget(),
                  const DownloadInviteWidget(),
                  const SizedBox(height: 12),
                  const SocialShareWidget(),
                ],
              ),
            ),
          ),

          // ✅ Sidebar Menu (Avoid flickering by not rebuilding it)
          BlocBuilder<SidebarBloc, SidebarState>(
            builder: (context, state) {
              return const SidebarMenu(); // ✅ Sidebar stays static
            },
          ),
        ],
      ),
    );
  }
}
