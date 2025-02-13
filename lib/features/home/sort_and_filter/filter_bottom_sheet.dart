import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/filter_cubit.dart';
import 'filter_model.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterCubit()..fetchFilters(),
      child: const FilterContent(),
    );
  }
}

class FilterContent extends StatefulWidget {
  const FilterContent({super.key});

  @override
  State<FilterContent> createState() => _FilterContentState();
}

class _FilterContentState extends State<FilterContent> {
  String selectedCategory = "Brand"; // Default selected category
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }

        if (state.filters == null) {
          return const Center(child: Text('No filters available'));
        }

        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              _buildHeader(context),
              const Divider(),
              Expanded(
                child: Row(
                  children: [
                    _buildSidebar(context, state.filters!),
                    _buildFilterOptions(context, state),
                  ],
                ),
              ),
              const Divider(),
              _buildFooter(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Filters",
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, size: 24, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, FilterModel filters) {
  final categories = {
    "Brand": filters.brand,
    "Condition": filters.conditions,
    "Storage": filters.storage,
    "RAM": filters.ram,
    "Verification": [],
    "Warranty": filters.warranty,
    "Price Range": [],
  };

  return Container(
    width: 150,
    decoration: BoxDecoration(
      border: Border(right: BorderSide(color: Colors.grey.shade300)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space out items evenly
      children: categories.keys.map((category) {
        int selectedCount = context.read<FilterCubit>().state.selectedFilters[category]?.length ?? 0;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedCategory = category;
              searchController.clear(); // Clear search input when switching categories
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16), // Increased vertical padding
            color: selectedCategory == category ? const Color(0xFFFFF8E1) : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    category,
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                if (selectedCount > 0)
                  Text(
                    "$selectedCount",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.amber),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    ),
  );
}


  Widget _buildFilterOptions(BuildContext context, FilterState state) {
    final filters = state.filters!;
    final options = _getOptionsForCategory(filters, selectedCategory);
    final selectedOptions = state.selectedFilters[selectedCategory] ?? [];

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: options.where((option) {
                  return option.toLowerCase().contains(searchController.text.toLowerCase());
                }).map((option) {
                  return CheckboxListTile(
                    title: Text(
                      option,
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    value: selectedOptions.contains(option),
                    onChanged: (isSelected) {
                      context.read<FilterCubit>().toggleFilter(selectedCategory, option);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.black,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 20, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search here",
                border: InputBorder.none,
                hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () => context.read<FilterCubit>().clearFilters(),
            child: Text(
              "Clear All",
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.amber),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, context.read<FilterCubit>().state.selectedFilters);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                "Apply",
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getOptionsForCategory(FilterModel filters, String category) {
    switch (category) {
      case "Brand":
        return filters.brand;
      case "Condition":
        return filters.conditions;
      case "Storage":
        return filters.storage;
      case "RAM":
        return filters.ram;
      case "Warranty":
        return filters.warranty;
      default:
        return [];
    }
  }
}
