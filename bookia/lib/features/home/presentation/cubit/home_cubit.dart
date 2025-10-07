import 'package:bookia/features/home/data/models/best_seller_response/best_seller_response.dart';
import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/home/data/models/slider_response/slider.dart';
import 'package:bookia/features/home/data/models/slider_response/slider_response.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  List<Product> products = [];
  List<SliderModel> sliders = [];

  getInitData() async {
    emit(HomeLoadingState());

    try {
      var results = await Future.wait([
        HomeRepo.getSliders(),
        HomeRepo.getBestSeller(),
      ]);
      // [res1, res2]
      var sliderRes = results[0] as SliderResponse?;
      var bestSellerRes = results[1] as BestSellerResponse?;

      if (sliderRes != null || bestSellerRes != null) {
        sliders = sliderRes?.data?.sliders ?? [];
        products = bestSellerRes?.data?.products ?? [];
        emit(HomeSuccessState());
      } else {
        emit(HomeErrorState());
      }
    } on Exception catch (_) {
      emit(HomeErrorState());
    }
  }
}
