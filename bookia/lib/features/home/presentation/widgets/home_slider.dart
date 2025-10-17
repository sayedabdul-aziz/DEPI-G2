import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/data/models/slider_response/slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key, required this.sliders});

  final List<SliderModel> sliders;

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.sliders.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: widget.sliders[itemIndex].image ?? '',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              },
          options: CarouselOptions(
            height: 150,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
        Gap(15),
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: 3,
          effect: ExpandingDotsEffect(
            dotHeight: 7,
            dotWidth: 7,
            spacing: 4,
            expansionFactor: 4,
            activeDotColor: AppColors.primaryColor,
            dotColor: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}
