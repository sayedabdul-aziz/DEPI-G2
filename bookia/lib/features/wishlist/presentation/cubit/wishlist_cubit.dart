import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  List<Product> products = [];

  getWishlist() async {
    emit(WishlistLoadingState());

    var res = await WishlistRepo.getWishlist();
    if (res != null) {
      products = res.data?.data ?? [];
      emit(WishlistSuccessState());
    } else {
      emit(WishlistErrorState());
    }
  }
}
