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

import '../../../auth/bloc/auth_bloc.dart';
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
    return BlocProvider(
      create: (context) => SidebarBloc(BlocProvider.of<AuthBloc>(context)),
      child: Scaffold(
        backgroundColor: Colors.grey[100], // Light background
        body: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 150,
                    pinned: true,
                    floating: false,
                    backgroundColor: Colors.transparent, // Set transparent to allow translucency
                    elevation: 0,
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8), // Translucent background
                        borderRadius: const BorderRadius.only(
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
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(125),
                      child: Container(
                        color: Colors.white.withOpacity(0.7), // Matching translucent background
                        child: const Column(
                          children: [
                            CustomSearchBar(),
                            SizedBox(height: 12),
                            CategoriesList(),
                            SizedBox(height: 8),
                          ],
                        ),
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

            // Sidebar Menu
            BlocBuilder<SidebarBloc, SidebarState>(
              builder: (context, state) {
                return const SidebarMenu(); // Sidebar positioned on top
              },
            ),
          ],
        ),
      ),
    );
  }
}
