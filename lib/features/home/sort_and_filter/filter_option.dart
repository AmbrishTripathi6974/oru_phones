// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../bloc/sort_and_filter_cubit.dart';

// class FilterOptions extends StatelessWidget {
//   const FilterOptions({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Text("Filter By", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           ListTile(
//             title: const Text("Filter 1"),
//             onTap: () {
//               context.read<SortFilterCubit>().updateFilter(FilterOption.filter1);
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             title: const Text("Filter 2"),
//             onTap: () {
//               context.read<SortFilterCubit>().updateFilter(FilterOption.filter2);
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
