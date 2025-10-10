import 'package:bookia/features/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  CartResponse? cartResponse;

  getCart() async {
    emit(CartLoadingState());

    var res = await CartRepo.getCart();
    if (res != null) {
      cartResponse = res;
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  removeFromCart({required int cartItemId}) async {
    emit(CartLoadingState());

    var res = await CartRepo.removeFromCart(cartItemId: cartItemId);
    if (res != null) {
      cartResponse = res;
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  updateQuantity({required int cartItemId, required int quantity}) async {
    var res = await CartRepo.updateQuantity(
      cartItemId: cartItemId,
      quantity: quantity,
    );
    if (res != null) {
      cartResponse = res;
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }
}
