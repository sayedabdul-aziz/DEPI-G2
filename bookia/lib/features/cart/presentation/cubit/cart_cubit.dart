import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/features/cart/data/models/place_order_params.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final governorateController = TextEditingController();

  int selectedGovId = -1;

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

  checkout() async {
    emit(CheckoutLoadingState());
    var res = await CartRepo.checkout();
    if (res) {
      emit(CheckoutSuccessState());
    } else {
      emit(CheckoutErrorState());
    }
  }

  placeOrder() async {
    emit(CheckoutLoadingState());

    var params = PlaceOrderParams(
      name: nameController.text,
      phone: phoneController.text,
      address: addressController.text,
      email: emailController.text,
      governorateId: selectedGovId,
    );

    var res = await CartRepo.placeOrder(params);

    if (res) {
      emit(CheckoutSuccessState());
    } else {
      emit(CheckoutErrorState());
    }
  }

  preFillUserData() {
    var user = SharedPref.getUserData();

    nameController.text = user?.name ?? '';
    phoneController.text = user?.phone ?? '';
    addressController.text = user?.address ?? '';
    emailController.text = user?.email ?? '';
  }
}
