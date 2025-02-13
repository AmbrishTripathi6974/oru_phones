import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/sort_and_filter_cubit.dart';
import 'filter_bottom_sheet.dart';  // Importing filter bottom sheet
import 'sort_option.dart';

class SortFilterButtons extends StatelessWidget {
  const SortFilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: BlocProvider(
        create: (context) => SortFilterCubit(),
        child: BlocBuilder<SortFilterCubit, Map<String, dynamic>>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildButton(
                  context,
                  Icons.swap_vert,
                  "Sort",
                  () => _showSortOptions(context),
                ),
                const SizedBox(width: 12),
                _buildFilterButton(context, state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFD7D7D7)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: const Color(0xFF121212)),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF121212),
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF121212)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context, Map<String, dynamic> state) {
    int selectedFiltersCount = _calculateSelectedFilters(state);

    return GestureDetector(
      onTap: () => _showFilterOptions(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFD7D7D7)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.tune, size: 18, color: Color(0xFF121212)),
            const SizedBox(width: 6),
            Text(
              "Filters",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF121212),
              ),
            ),
            if (selectedFiltersCount > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$selectedFiltersCount",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            const SizedBox(width: 6),
            const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF121212)),
          ],
        ),
      ),
    );
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<SortFilterCubit>(context),
          child: const SortOptions(),
        );
      },
    );
  }

  void _showFilterOptions(BuildContext context) async {
    final selectedFilters = await showModalBottomSheet<Map<String, List<String>>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );

    if (selectedFilters != null) {
      context.read<SortFilterCubit>().updateFilters(selectedFilters);
    }
  }

  int _calculateSelectedFilters(Map<String, dynamic> state) {
    int count = 0;
    state.forEach((key, value) {
      if (value is List && value.isNotEmpty) {
        count += value.length;
      }
    });
    return count;
  }
}
