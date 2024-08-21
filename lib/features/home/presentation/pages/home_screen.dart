
import 'package:eccemorce_route_project/features/home/domain/use_cases/update_product_quantity_to_ccart.dart';
import 'package:eccemorce_route_project/features/home/presentation/pages/tabs/favourite_tab.dart';
import 'package:eccemorce_route_project/features/home/presentation/pages/tabs/home_tab.dart';
import 'package:eccemorce_route_project/features/home/presentation/pages/tabs/profile_tab.dart';
import 'package:eccemorce_route_project/features/home/presentation/pages/tabs/settings_tab.dart';
import 'package:eccemorce_route_project/features/product_list/domain/use_cases/update_cart_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/images.dart';
import '../../../product_list/domain/use_cases/add_to_wish_list_use_case.dart';
import '../../../product_list/domain/use_cases/del_from_use_case.dart';
import '../../../product_list/domain/use_cases/get_carts_use_case.dart';
import '../../../product_list/domain/use_cases/product_list_use_case.dart';
import '../../../product_list/presentation/bloc/product_list_bloc.dart';
import '../../../product_list/presentation/pages/product_list.dart';
import '../../domain/use_cases/add_to_cart_use_case.dart';
import '../../domain/use_cases/change_password_use_case.dart';
import '../../domain/use_cases/get_all_wish_list_items_use_case.dart';
import '../../domain/use_cases/get_brands_use_case.dart';
import '../../domain/use_cases/get_categories_use_case.dart';
import '../manager/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  final startIndex;
  HomeScreen({this.startIndex = 0, super.key});
  final List<Widget> tabs = [
    const HomeTab(),
    const ProductListScreen(),
    const FavouritesTab(),
    //const ProfileTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HomeBloc(
                  getIt<GetCategoriesUseCase>(),
                  getIt<GetBrandsUseCase>(),
                  getIt<AddToCartUseCase>(),
                  getIt<UpdateProductQuantityToCartUseCase>(),
                  getIt<GetWishListItemsUseCase>(),
                  getIt<ChangePasswordUseCase>(),
                )
                  ..add(GetUserData())
                  ..add(GetCategoriesEvent())
                  ..add(GetBrandsEvent())
                  ..add(GetWishList())),
        BlocProvider(
          create: (context) => ProductListBloc(
              getIt<ProductListUseCase>(),
              getIt<GetCartsUseCase>(),
            getIt<UpdateCartUseCase>(),
            getIt< AddToWishListUseCase>(),
            getIt<DelFormWishListUseCase>(),
          )
            ..add(GetAllProducts())
            ..add(GetWish()),
        )
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Container(
                padding: EdgeInsets.only(left: 15.w),
                height: 26.h,
                width: 70.w,
                child: Image.asset(
                  "assets/images/blueroute.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            body:state.index!=3 ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5.h),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFF004182)),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFF004182)),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xFF06004E),
                              ),
                              hintText: 'what do you search for?',
                              hintStyle: TextStyle(
                                color: const Color(0x9906004E),
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoute.cartScreen);
                        },
                        child: Icon(
                          Icons.shopping_cart,
                          size: 30.0.sp,
                          color: AppColors.blueColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Expanded(
                  child: tabs[state.index ?? startIndex],
                )
              ],
            ):Column(
              children: [
                Expanded(
                  child: tabs[state.index ?? startIndex],
                )
              ],
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
              ),
              child: BottomNavigationBar(
                onTap: (value) {
                  HomeBloc.get(context).add(TabChange(index: value));
                },
                currentIndex: state.index ?? 0,
                selectedItemColor: AppColors.blueColor,
                type: BottomNavigationBarType.shifting,
                items: [
                  BottomNavigationBarItem(
                      icon: state.index == 0
                          ? Container(
                              padding: EdgeInsets.all(7.w.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.white),
                              child:ImageIcon(AssetImage( AppImages.home)))
                          : const ImageIcon(AssetImage( AppImages.home)) ,
                      label: "",
                      backgroundColor: AppColors.blueColor),
                  BottomNavigationBarItem(
                      icon: state.index == 1
                          ? Container(
                              padding: EdgeInsets.all(7.w.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.white),
                              child: ImageIcon(AssetImage( AppImages.category)))
                          : const ImageIcon(AssetImage( AppImages.category)),
                      label: "",
                      backgroundColor: AppColors.blueColor),
                  BottomNavigationBarItem(
                      icon: state.index == 2
                          ? Container(
                              padding: EdgeInsets.all(7.w.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.white),
                              child:ImageIcon(AssetImage( AppImages.favorite)))
                          : const ImageIcon(AssetImage( AppImages.favorite)),
                      label: "",
                      backgroundColor: AppColors.blueColor),
                  BottomNavigationBarItem(
                      icon: state.index == 3
                          ? Container(
                              padding: EdgeInsets.all(7.w.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.white),
                              child: ImageIcon(AssetImage( AppImages.profile)))
                          : const ImageIcon(AssetImage( AppImages.profile)),
                      label: "",
                      backgroundColor: AppColors.blueColor),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
