import 'package:equatable/equatable.dart';
import 'package:foodie_app/models/ProductModel.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

/// Initial State
class ProductInitial extends ProductState {}

/// Loading State
class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<Product> products;

  const ProductSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];

  
}

class ProductEmpty extends ProductState {}
