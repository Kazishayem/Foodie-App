import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import 'package:foodie_app/services/cartService.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) {
    final items = List<Map<String, dynamic>>.from(CartService.cartItems);
    final total = _calculateTotal(items);
    emit(CartSuccess(items, total));
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    CartService.addCart(event.product);
    final items = List<Map<String, dynamic>>.from(CartService.cartItems);
    final total = _calculateTotal(items);
    emit(CartSuccess(items, total));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    CartService.removeCart(event.index); // service expects index
    final items = List<Map<String, dynamic>>.from(CartService.cartItems);
    final total = _calculateTotal(items);
    emit(CartSuccess(items, total));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    CartService.clearCart();
    emit(CartSuccess([], 0));
  }

  double _calculateTotal(List<Map<String, dynamic>> items) {
    return items.fold(0.0, (sum, item) {
      final price = (item['price'] ?? 0);
      if (price is int) return sum + price.toDouble();
      if (price is double) return sum + price;
      // if string price, try parse
      if (price is String) {
        final p = double.tryParse(price) ?? 0.0;
        return sum + p;
      }
      return sum;
    });
  }
}
