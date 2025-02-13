
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../faq/model/faq_model.dart';

class FaqCubit extends Cubit<List<Faq>> {
  FaqCubit() : super([]);

  // Fetch FAQs from API
  Future<void> fetchFaqs() async {
    try {
      final response = await Dio().get('http://40.90.224.241:5000/faq');
      final List<dynamic> data = response.data['FAQs'];
      final faqs = data.map((json) => Faq.fromJson(json)).toList();
      emit(faqs);
    } catch (e) {
      print("Error fetching FAQs: $e");
    }
  }

  // Toggle FAQ expansion with delay
  void toggleFaq(int index) async {
    final faqs = List<Faq>.from(state);

    // Add a delay before expanding/collapsing
    await Future.delayed(const Duration(milliseconds: 200));

    faqs[index].isExpanded = !faqs[index].isExpanded;
    emit(List.from(faqs)); // Emit new state to update UI
  }
}
