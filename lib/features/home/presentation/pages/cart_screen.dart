
import 'package:eccemorce_route_project/features/home/presentation/manager/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../product_list/domain/use_cases/add_to_wish_list_use_case.dart';
import '../../../product_list/domain/use_cases/del_from_use_case.dart';
import '../../../product_list/domain/use_cases/get_carts_use_case.dart';
import '../../../product_list/domain/use_cases/product_list_use_case.dart';
import '../../../product_list/presentation/bloc/product_list_bloc.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => ProductListBloc(
          getIt<ProductListUseCase>(),
          getIt<GetCartsUseCase>(),
          getIt<AddToWishListUseCase>(),
          getIt<DelFormWishListUseCase>())
        ..add(GetCart()),
),
    BlocProvider(
      create: (context) =>getIt<HomeBloc>(),
    ),
  ],
  child: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Icon(Icons.search, color: AppColors.blueColor, size: 24.sp),
                SizedBox(width: 15.w),
                Icon(Icons.shopping_cart_outlined,
                    color: AppColors.blueColor, size: 24.sp),
                SizedBox(width: 15.w),
              ],
              leading: const BackButton(color: Colors.black),
              backgroundColor: Colors.white,
              title: Text(
                "Cart",
                style: TextStyle(fontSize: 20, color: Color(0xFF06004F)),

              ),
              centerTitle: true,
              elevation: 0,
            ),
            body: state.screenStatus == ScreenStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : state.screenStatus == ScreenStatus.successfully
                    ? Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 9,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return CartItem(
                                    cartModel: state.cartModel, index: index);
                              },
                              itemCount:
                                  state.cartModel?.data?.products?.length,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 60,
                                        decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                        width: MediaQuery.of(context).size.width / 3,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text("Total Price",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black45)),
                                             Text(
                                                "EGP ${state.cartModel?.data?.totalCartPrice}",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF06004F))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 48.h,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF06004F),
                                            borderRadius: BorderRadius.circular(30)),
                                        width: 270.w,
                                        child: const Center(
                                            child: Text("Check Out      →",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20))),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
          );
        },
      ),
);
  }
}

