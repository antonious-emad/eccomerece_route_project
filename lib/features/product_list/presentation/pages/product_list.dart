import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config.dart';
import '../bloc/product_list_bloc.dart';
import '../widgets/product_item.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        bool fav = false;
        return state.screenStatus == ScreenStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : state.screenStatus == ScreenStatus.successfully
                ? Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          itemCount: state.productModel?.data?.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: (192 / 237),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.h,
                                  crossAxisSpacing: 16.w),
                          itemBuilder: (context, index) {
                            fav = ProductListBloc.iDs?.contains(
                                    state.productModel?.data?[index].id) ??
                                false;

                            return BlocProvider(
                              create: (context) => getIt<ProductListBloc>(),
                              child: ProductItem(
                                  productModel: state.productModel,
                                  index: index,
                                  fav: fav),
                            );
                          },
                        ),
                      )
                    ],
                  )
                : const SizedBox();
      },
    );
  }
}
