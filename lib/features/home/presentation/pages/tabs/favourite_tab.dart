
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config.dart';
import '../../manager/home_bloc.dart';
import '../../widgets/wish_list_item.dart';


class FavouritesTab extends StatelessWidget {
  const FavouritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(GetWishList()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return state.screenStatus == HomeScreenStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : state.screenStatus == HomeScreenStatus.wishListSuccess
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return WishListItem(
                            wishListModel: state.wishListModel, index: index);
                      },
                      itemCount: state.wishListModel?.data?.length,
                    )
                  : const SizedBox();
        },
      ),
);
  }
}
