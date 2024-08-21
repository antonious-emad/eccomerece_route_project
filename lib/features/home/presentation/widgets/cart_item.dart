import 'package:cached_network_image/cached_network_image.dart';
import 'package:eccemorce_route_project/config/routes/routes.dart';
import 'package:eccemorce_route_project/features/product_list/presentation/bloc/product_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/CartModel.dart';
import '../manager/home_bloc.dart';

class CartItem extends StatelessWidget {
  final int index;
  final CartModel? cartModel;

  CartItem({this.cartModel, required this.index, super.key});
  void _incrementCount(BuildContext context) async{
    final product = cartModel?.data?.products?[index];
    if (product != null) {
      context.read<ProductListBloc>().add(UpdateCartEvent(product.product?.id ?? "", product.count! + 1));
      await Future.delayed(Duration(milliseconds: 500));
      context.read<ProductListBloc>().add(GetCart());
    }
  }
  List<Color> clrs = [
    const Color(0xFF2F2929),
    const Color(0xFFBC3018),
    const Color(0xFF0973DD),
    const Color(0xFF02B935),
    const Color(0xFFFF645A)
  ];

  void _decrementCount(BuildContext context)async {
    final product = cartModel?.data?.products?[index];
    if (product != null && product.count! > 1) {
      context.read<ProductListBloc>().add(UpdateCartEvent(product.product?.id ?? "", product.count! - 1));
      await Future.delayed(Duration(milliseconds: 500));
      context.read<ProductListBloc>().add(GetCart());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 398.w,
        height: 113.h,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: AppColors.blueColor),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 120.w,
              height: 113.h,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      cartModel?.data?.products![index].product?.imageCover ??
                          ""),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0, color: AppColors.blueColor),
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  width: 120.w,
                  fit: BoxFit.cover,
                  imageUrl:
                      cartModel?.data?.products![index].product?.imageCover ??
                          "",
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 170.w,
                      child: Text(
                        cartModel?.data?.products?[index].product?.title ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            color: AppColors.blueColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      width: 60.w,
                    ),
                    Icon(Icons.delete, size: 29, color: AppColors.blueColor),
                  ],
                ),
                Row(
                  children: [
                    Text(
                        "EGP ${cartModel?.data?.products?[index].price.toString()}",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blueColor)),
                    SizedBox(
                      width: 60.w,
                    ),
                    Container(
                      width: 116,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xFF06004F),
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: Colors.blue.withOpacity(0.5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              _decrementCount(context);
                            },
                            icon: Icon(CupertinoIcons.minus_circle),
                            color: Colors.white,
                          ),
                          Text(
                            "${cartModel?.data?.products?[index].count.toString()}",
                            style: TextStyle(color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () {
                              _incrementCount(context);
                            },
                            icon: Icon(Icons.add_circle_outline),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}