import 'package:equatable/equatable.dart';

class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class StartCheckout extends CheckoutEvent {
  final double totalAmount;

  const StartCheckout(this.totalAmount);

  @override
  List<Object?> get props => [totalAmount];
}

class ConfirmPayment extends CheckoutEvent {}
