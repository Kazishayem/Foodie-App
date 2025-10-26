import 'package:equatable/equatable.dart';

class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class Checkoutloading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {}

class CheckoutError extends CheckoutState {
  final String message;
  const CheckoutError(this.message);

  @override
  List<Object?> get props => [message];
}
