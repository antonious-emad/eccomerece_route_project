import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/WishListModel.dart';
import '../manager/home_bloc.dart';


class WishListItem extends StatelessWidget {
  final WishListModel? wishListModel;
  final int index;

  const WishListItem(
      {required this.wishListModel, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(
          context,
          AppRoute.productDetailsFromWishList,
          arguments: wishListModel?.data?[index],
        );
      },
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          width: 398.w,
          height: 113.h,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: AppColors.blueColor),
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 120.w,
                height: 113.h,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  image:  DecorationImage(
                    image:NetworkImage(  wishListModel?.data?[index].imageCover ?? ""),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0, color: AppColors.blueColor),
                      borderRadius: BorderRadius.circular(15.r)
                  ),
                ),
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(15.r),
                  child: CachedNetworkImage(
                    height: 113.h,
                    width: 120.w,
                    fit: BoxFit.cover,
                    imageUrl: wishListModel?.data?[index].imageCover ?? "",
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 165.w,
                        child: Text(
                          maxLines: 1,
                          wishListModel?.data?[index].title ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              color: AppColors.blueColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                          ),
                        ),
                      ),
                      SizedBox(width: 43.w,),
                      Container(
                          padding: EdgeInsets.all(7.w.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: Colors.white30),
                          child: Icon(Icons.favorite,
                              size: 29, color: AppColors.blueColor)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 140.w,
                        child: Text(
                            "EGP ${wishListModel?.data?[index].price.toString()}",
                            style:GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: AppColors.blueColor)   ),
                      ),
                      InkWell(
                        onTap: () {
                          getIt<HomeBloc>()
                              .add(AddToCartEvent(wishListModel?.data?[index].id?? ""));

                        },
                        child: Container(
                          width: 110.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                              color: const Color(0xFF06004F),
                              borderRadius: BorderRadius.circular(30)),
                          child: const Center(
                              child: Text("Add To Cart",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
