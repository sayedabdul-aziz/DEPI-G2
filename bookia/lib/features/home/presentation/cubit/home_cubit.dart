import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  List<Product>? products;

  getBestSeller() async {
    emit(HomeLoadingState());

    var res = await HomeRepo.getBestSeller();

    if (res != null) {
      products = res.data?.products;
      emit(HomeSuccessState());

      /// to rebuild the ui
    } else {
      emit(HomeErrorState());
    }
  }
}
