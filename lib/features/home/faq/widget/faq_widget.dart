import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../bloc/faq_cubit.dart';
import '../model/faq_model.dart';

class FaqWidget extends StatelessWidget {
  const FaqWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (context) => FaqCubit()..fetchFaqs(),
        child: BlocBuilder<FaqCubit, List<Faq>>(
          builder: (context, faqs) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  for (int i = 0; i < faqs.length; i++) ...[
                    FaqItem(faq: faqs[i], index: i),
                    const SizedBox(height: 10), // Added space between items
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final Faq faq;
  final int index;

  const FaqItem({super.key, required this.faq, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => context.read<FaqCubit>().toggleFaq(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE8E8E8))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    faq.question,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400), // Delayed icon transition
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: faq.isExpanded
                      ? const Icon(Icons.close, key: ValueKey("close"))
                      : const Icon(Icons.add, key: ValueKey("add")),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500), // Smooth expansion
          curve: Curves.easeInOut,
          padding: faq.isExpanded ? const EdgeInsets.all(12) : EdgeInsets.zero,
          margin: faq.isExpanded ? const EdgeInsets.symmetric(vertical: 5) : EdgeInsets.zero,
          height: faq.isExpanded ? null : 0,
          child: faq.isExpanded
              ? Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE8E8E8)),
                  ),
                  child: Text(
                    faq.answer,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
