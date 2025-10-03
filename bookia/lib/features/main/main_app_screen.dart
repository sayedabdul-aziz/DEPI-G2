import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/presentation/page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  List<Widget> pages = [HomeScreen(), Container(), Container(), Container()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _navBarItem(path: AppImages.homeSvg, label: 'Home'),
          _navBarItem(path: AppImages.bookmarkSvg, label: 'Bookmark'),
          _navBarItem(path: AppImages.cartSvg, label: 'Cart'),
          _navBarItem(path: AppImages.profileSvg, label: 'Profile'),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navBarItem({
    required String path,
    required String label,
  }) {
    return BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        path,
        colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
      ),
      icon: SvgPicture.asset(path),
      label: label,
    );
  }
}
