// import 'package:equatable/equatable.dart';

// class CartState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class CartInitial extends CartState {}

// class CartLoading extends CartState {}

// class CartSuccess extends CartState {
//   final List<Map<String, dynamic>> items;
//   final double totalAmount;

//   CartSuccess(this.items, this.totalAmount);

//   @override
//   List<Object?> get props => [items, totalAmount];
// }

// class CartError extends CartState {
//   final String message;
//   CartError(this.message);

//   @override
//   List<Object?> get props => [message];
// }
// lib/bloc/cart/cart_state.dart
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<Map<String, dynamic>> items;
  final double totalAmount;

  CartSuccess(this.items, this.totalAmount);

  @override
  List<Object?> get props => [items, totalAmount];
}

class CartError extends CartState {
  final String message;
  CartError(this.message);

  @override
  List<Object?> get props => [message];
}
