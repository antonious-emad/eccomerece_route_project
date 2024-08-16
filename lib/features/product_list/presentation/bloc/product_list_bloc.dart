import 'package:bloc/bloc.dart';
import 'package:eccemorce_route_project/features/home/data/models/WishListModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../config.dart';
import '../../../../core/error/failures.dart';
import '../../../home/data/models/CartModel.dart';
import '../../../home/domain/use_cases/get_all_wish_list_items_use_case.dart';
import '../../data/models/ProductModel.dart';
import '../../domain/use_cases/add_to_wish_list_use_case.dart';
import '../../domain/use_cases/del_from_use_case.dart';
import '../../domain/use_cases/get_carts_use_case.dart';
import '../../domain/use_cases/product_list_use_case.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

@injectable
class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  static ProductListBloc get(context) => BlocProvider.of(context);
  ProductListUseCase productListUseCase;
  GetCartsUseCase getCartsUseCase;
  AddToWishListUseCase addToWishListUseCase;
  DelFormWishListUseCase delFormWishListUseCase;
  static List<String>? iDs = [];
  ProductListBloc(this.productListUseCase, this.getCartsUseCase,
      this.addToWishListUseCase, this.delFormWishListUseCase)
      : super(ProductListInitial()) {
    on<ProductListEvent>((event, emit) async {
      emit(state.copyWith(screenStatus: ScreenStatus.loading));
      if (event is GetAllProducts) {
        var result = await productListUseCase.call();
        result.fold((l) {
          emit(
              state.copyWith(screenStatus: ScreenStatus.failures, failures: l));
        }, (r) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.successfully, productModel: r));
        });
      } else if (event is GetCart) {
        var result = await getCartsUseCase.call();
        result.fold((l) {
          emit(
              state.copyWith(screenStatus: ScreenStatus.failures, failures: l));
        }, (r) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.successfully, cartModel: r));
        });
      } else if (event is ChangeFavIcon) {
        emit(state.copyWith(
            screenStatus: ScreenStatus.successfully, isFav: (event.isFave)));
      } else if (event is AddToWishList) {
        addToWishListUseCase.call(event.productId);
        iDs?.add(event.productId);
        emit(state.copyWith(screenStatus: ScreenStatus.successfully, iDs: iDs));
      } else if (event is DelFromWishList) {
        delFormWishListUseCase.call(event.productId);
        iDs?.remove(event.productId);
      } else if (event is GetWish) {
        var result = await getIt<GetWishListItemsUseCase>().call();
        result.fold((l) {}, (r) {
          for (int i = 0; i < r.data!.length; i++) {
            iDs?.add(r.data![i].id!);
          }
        });
        emit(state.copyWith(screenStatus: ScreenStatus.successfully, iDs: iDs));
      }
    });
  }
}
