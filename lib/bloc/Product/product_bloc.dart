import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_app/repositories/product_repository.dart'; // তোমার repository path অনুযায়ী adjust করো
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());

      try {
        final products = await repository.getProducts(); // all products fetch

        if (products.isEmpty) {
          emit(ProductEmpty());
        } else {
          emit(ProductSuccess(products));
        }
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
