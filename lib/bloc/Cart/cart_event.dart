// import 'package:equatable/equatable.dart';

// abstract class CartEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class LoadCart extends CartEvent {}

// class AddToCart extends CartEvent {
//   final Map<String, dynamic> product;
//   AddToCart(this.product);
// }

// class RemoveFromCart extends CartEvent {
//   final Map<String, dynamic> product;
//   RemoveFromCart(this.product);
// }

// class ClearCart extends CartEvent {}
// lib/bloc/cart/cart_event.dart
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final Map<String, dynamic> product;
  AddToCart(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final int index; // we use index consistently
  RemoveFromCart(this.index);

  @override
  List<Object?> get props => [index];
}

class ClearCart extends CartEvent {}
