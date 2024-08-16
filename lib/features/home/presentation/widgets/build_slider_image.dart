import 'package:eccemorce_route_project/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BuildImage extends StatelessWidget {
  const BuildImage({super.key, required this.image, required this.index});
  final String image;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10.w),
          width: MediaQuery.of(context).size.width,
          height: 200.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: AssetImage(
                    image,
                  ),
                  fit: BoxFit.fill)),
        ),
        Positioned(
          left: 176.w,
          width: 9,
          height: 2,
          bottom: 8.h,
          child: AnimatedSmoothIndicator(
              duration: const Duration(milliseconds: 100),
              activeIndex: index,
              count: 3,
              effect:SlideEffect(activeDotColor:AppColors.blueColor ,dotColor: Colors.white.withOpacity(0.5),radius: 5,dotWidth: 10,dotHeight:10  ) ),
        )
      ],
    );
  }
}
