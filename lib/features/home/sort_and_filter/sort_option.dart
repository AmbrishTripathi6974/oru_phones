import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones/features/home/sort_and_filter/sort_option_extension.dart';
import '../bloc/sort_and_filter_cubit.dart';

class SortOptions extends StatelessWidget {
  const SortOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortFilterCubit, Map<String, dynamic>>(
      builder: (context, state) {
        final selectedSort = state['sort'];

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context),
              const Divider(), // 📌 Divider after "Sort" header
              const SizedBox(height: 10),
              _buildSortOptions(context, selectedSort),
              const SizedBox(height: 15),
              const Divider(), // 📌 Divider before "Apply" button
              _buildFooter(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Sort",
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOptions(BuildContext context, SortOption selectedSort) {
    return Column(
      children: SortOption.values.where((e) => e != SortOption.none).map((option) {
        return Column(
          children: [
            ListTile(
              title: Text(option.toLabel(), style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
              tileColor: selectedSort == option ? Colors.amber[50] : Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              trailing: Radio<SortOption>( // ✅ Moved Radio button to the right
                value: option,
                groupValue: selectedSort,
                onChanged: (value) {
                  if (value != null) context.read<SortFilterCubit>().updateSort(value);
                },
                activeColor: Colors.amber,
              ),
              onTap: () => context.read<SortFilterCubit>().updateSort(option),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => context.read<SortFilterCubit>().updateSort(SortOption.none),
            child: Text("Clear", style: GoogleFonts.poppins(fontSize: 16, color: Colors.orange)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
            ),
            child: Text("Apply", style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xFF484848), fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
