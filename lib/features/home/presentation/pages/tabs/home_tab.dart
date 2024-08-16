
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../manager/home_bloc.dart';
import '../../widgets/build_slider_image.dart';
import '../../widgets/category_item.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.screenStatus == HomeScreenStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                height: 800.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        child: CarouselSlider(
                          items: const [
                            SizedBox(
                              child: BuildImage(
                                image: 'assets/images/property1_default.png',
                                index: 0,
                              ),
                            ),
                            SizedBox(
                              child: BuildImage(
                                image: 'assets/images/group12.png',
                                index: 1,
                              ),
                            ),
                            SizedBox(
                              child: BuildImage(
                                image: 'assets/images/group13.png',
                                index: 2,
                              ),
                            )
                          ],
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2,
                            viewportFraction: 1,
                            enableInfiniteScroll: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0.h, horizontal: 8.w),
                        child: Row(
                          children: [
                            Text("Categories",
                                style: TextStyle(
                                    color: AppColors.darkBlueColor,
                                    fontSize: 22.sp)),
                            const Spacer(),
                            Text("view all",
                                style: TextStyle(
                                    color: AppColors.darkBlueColor,
                                    fontSize: 18.sp)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 2.w,
                              crossAxisSpacing: 2.w,
                              childAspectRatio: 4 / 5,
                              crossAxisCount: 2),
                          itemBuilder: (context, index) => CategoryItem(
                              index: index, categoryEntity: state.categoryEntity),
                          itemCount: state.categoryEntity?.data?.length ?? 10,
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0.h, horizontal: 8.w),
                        child: Row(
                          children: [
                            Text("Brands",
                                style: TextStyle(
                                    color: AppColors.darkBlueColor,
                                    fontSize: 22.sp)),
                            const Spacer(),
                            Text("view all",
                                style: TextStyle(
                                    color: AppColors.darkBlueColor,
                                    fontSize: 18.sp)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 2.w,
                              crossAxisSpacing: 2.w,
                              childAspectRatio: 2 / 3,
                              crossAxisCount: 2),
                          itemBuilder: (context, index) => CategoryItem(
                              index: index, categoryEntity: state.brandsEntity),
                          itemCount: state.brandsEntity?.data?.length ?? 10,
                        ),
                      ),
                    ],
                  ),
              ),
            );
      },
    );
  }
}

