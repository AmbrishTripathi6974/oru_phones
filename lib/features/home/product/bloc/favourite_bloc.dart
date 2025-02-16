import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/product_model.dart';

// 🔹 Events
abstract class FavoriteEvent {}

class ToggleFavorite extends FavoriteEvent {
  final Product product;

  ToggleFavorite(this.product);
}

// 🔹 States
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {
  final Set<Product> favorites;

  FavoriteInitial(this.favorites);
}

// 🔹 Bloc Logic
class FavoritesBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final Set<Product> _favoriteProducts = {};

  FavoritesBloc() : super(FavoriteInitial({})) {
    on<ToggleFavorite>((event, emit) {
      if (_favoriteProducts.contains(event.product)) {
        _favoriteProducts.remove(event.product);
      } else {
        _favoriteProducts.add(event.product);
      }
      emit(FavoriteInitial(Set.from(_favoriteProducts)));
    });
  }
}
