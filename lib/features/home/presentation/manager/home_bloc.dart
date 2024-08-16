import 'package:bloc/bloc.dart';
import 'package:eccemorce_route_project/features/home/data/models/CartModel.dart';
import 'package:eccemorce_route_project/features/home/domain/use_cases/update_product_quantity_to_ccart.dart';
import 'package:eccemorce_route_project/features/product_list/data/models/ProductModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/cache/shared_prefrence.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/ChangePasswordMessageModel.dart';
import '../../data/models/WishListModel.dart';
import '../../domain/entities/CategoryEntity.dart';
import '../../domain/use_cases/add_to_cart_use_case.dart';
import '../../domain/use_cases/change_password_use_case.dart';
import '../../domain/use_cases/get_all_wish_list_items_use_case.dart';
import '../../domain/use_cases/get_brands_use_case.dart';
import '../../domain/use_cases/get_categories_use_case.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GetCategoriesUseCase getCategoriesUseCase;
  GetBrandsUseCase getBrandsUseCase;
  AddToCartUseCase addToCartUseCase;
  UpdateProductQuantityToCartUseCase updateProductQuantityToCartUseCase;
  ChangePasswordUseCase changePasswordUseCase;
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  GetWishListItemsUseCase getWishListItemsUseCase;

  static HomeBloc get(context) => BlocProvider.of(context);
  static List<String>? getIds = [];

  HomeBloc(
      this.getCategoriesUseCase,
      this.getBrandsUseCase,
      this.addToCartUseCase,
      this.updateProductQuantityToCartUseCase,
      this.getWishListItemsUseCase,
      this.changePasswordUseCase)
      : super(HomeInitial(index: 0)) {
    on<HomeEvent>((event, emit) async {
      emit(state.copyWith(screenStatus: HomeScreenStatus.loading));
      if (event is GetCategoriesEvent) {
        var result = await getCategoriesUseCase.call();
        result.fold((l) {
          emit(state.copyWith(
              screenStatus: HomeScreenStatus.categoryFailure, failures: l));
        }, (r) {
          emit(state.copyWith(
              screenStatus: HomeScreenStatus.categorySuccess,
              categoryEntity: r));
        });
      } else if (event is GetBrandsEvent) {
        var result = await getBrandsUseCase.call();
        result.fold((l) {
          emit(state.copyWith(
              screenStatus: HomeScreenStatus.brandsFailure, failures: l));
        }, (r) {
          emit(state.copyWith(
              screenStatus: HomeScreenStatus.brandsSuccess, brandsEntity: r));
        });
      } else if (event is TabChange) {
        emit(state.copyWith(
            screenStatus: HomeScreenStatus.changeNavBar, index: event.index));
      } else if (event is AddToCartEvent) {
        var result = await addToCartUseCase.call(event.id);
        result.fold((l) {}, (r) {
          print("Success");
        });
      } else if (event is UpdateProductQuantityEvent) {
        var result = await updateProductQuantityToCartUseCase.call(
            event.id, event.count);
        result.fold((l) {}, (r) {
          emit(state.copyWith(
            screenStatus: HomeScreenStatus.updateProductQuantityToCartstate,
          ));
        });
      } else if (event is GetWishList) {
        var result = await getWishListItemsUseCase.call();
        result.fold((l) {
          emit(state.copyWith(
              screenStatus: HomeScreenStatus.wishListFailure, failures: l));
        }, (r) {
          for (int i = 0; i < r.data!.length; i++) {
            getIds?.add(r.data![i].id!);
            print(getIds?[i]);
          }
          emit(state.copyWith(
              screenStatus: HomeScreenStatus.wishListSuccess,
              wishListModel: r));
        });
      } else if (event is GetUserData) {
        String? userName = await CacheData.getData("userName");
        String? userEmail = await CacheData.getData("userEmail");
        emit(state.copyWith(
            screenStatus: HomeScreenStatus.saveUserDataSuccess,
            email: userEmail,
            name: userName));
      } else if (event is ChangePassword) {
        var result = await changePasswordUseCase.call(
            currentPassword.text, newPassword.text, rePassword.text);
        result.fold((l) {
          emit(state.copyWith(
              screenStatus: HomeScreenStatus.passwordChangFailure,
              failures: l));
        }, (r) {
          emit(state.copyWith(
            screenStatus: HomeScreenStatus.passwordChangSuccess,
          ));
        });
      }
    });
  }
}
