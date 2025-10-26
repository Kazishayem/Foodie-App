import 'package:flutter_bloc/flutter_bloc.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<StartCheckout>(event, emit) async {
      emit(Checkoutloading());

      try {
        await Future.delayed(const Duration(seconds: 2));

        emit(CheckoutSuccess());
      } catch (e) {
        emit(CheckoutError("Payment failed , please try again"));
      }
    }
  }
}
