part of 'home_bloc.dart';

enum HomeScreenStatus {
  init,
  loading,
  categorySuccess,
  categoryFailure,
  brandsSuccess,
  brandsFailure,
  changeNavBar,
  passwordChangLoading,
  passwordChangSuccess,
  passwordChangFailure,
  wishListSuccess,
  wishListFailure,
  saveUserDataSuccess,
  updateProductQuantityToCartstate,
}

class HomeState {
  final HomeScreenStatus? screenStatus;
  final CategoryEntity? categoryEntity;
  final CategoryEntity? brandsEntity;
  final WishListModel? wishListModel;
  final CartModel? cartModel;
  final ChangePasswordMessageModel? changePasswordMessageModel;
  final Failures? failures;
  final int? index;
  final String? name;
  final String? email;

  HomeState(
      {this.screenStatus,
        this.cartModel,
      this.categoryEntity,
      this.brandsEntity,
      this.failures,
      this.index,
      this.wishListModel,
      this.name,
      this.email,
      this.changePasswordMessageModel});
  HomeState copyWith({
    HomeScreenStatus? screenStatus,
    CategoryEntity? categoryEntity,
    CategoryEntity? brandsEntity,
    Failures? failures,
    int? index,
    WishListModel? wishListModel,
    String? name,
    String? email,
    ChangePasswordMessageModel? changePasswordMessageModel,
  }) {
    return HomeState(
        screenStatus: screenStatus ?? this.screenStatus,
        categoryEntity: categoryEntity ?? this.categoryEntity,
        failures: failures ?? this.failures,
        brandsEntity: brandsEntity ?? this.brandsEntity,
        index: index ?? 0,
        wishListModel: wishListModel ?? this.wishListModel,
        name: name ?? this.name,
        email: email ?? this.email);
  }
}

class HomeInitial extends HomeState {
  HomeInitial({required super.index})
      : super(
          screenStatus: HomeScreenStatus.init,
        );
}
