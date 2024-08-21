part of 'product_list_bloc.dart';

enum ScreenStatus {
  init,
  loading,
  successfully,
  failures,
  updateCartstate,
  loadingAuthTokenPaymentState,
  successAuthTokenPaymentState,
  errorAuthTokenPaymentState,
  loadingOrderIdPaymentState,
  successOrderIdPaymentState,
  erroOrderIdPaymentState,
  
  loadingRequestTokenCardPaymentState,
  successRequestTokenCardPaymentState,
  errorRequestTokenCardPaymentState,
  
  loadingRequestTokenKioskPaymentState,
  successRequestTokenKioskPaymentState,
  errorRequestTokenKioskPaymentState,

  loadingReferenceCodePaymentState,
  successReferenceCodePaymentState,
  errorReferenceCodePaymentState,

}

class ProductListState {
  final ScreenStatus? screenStatus;
  final ProductModel? productModel;
  final CartModel? cartModel;
  final Failures? failures;
  bool? isFav;
  List<String>? iDs;

  ProductListState(
      {this.screenStatus,
      this.productModel,
      this.failures,
      this.cartModel,
      this.isFav,
      this.iDs});

  ProductListState copyWith(
      {ScreenStatus? screenStatus,
      ProductModel? productModel,
      Failures? failures,
      CartModel? cartModel,
      bool? isFav,
      List<String>? iDs}) {
    return ProductListState(
      screenStatus: screenStatus ?? this.screenStatus,
      productModel: productModel ?? this.productModel,
      failures: failures,
      cartModel: cartModel ?? this.cartModel,
      isFav: isFav,
      iDs: iDs ?? this.iDs,
    );
  }
}

class ProductListInitial extends ProductListState {
  ProductListInitial() : super(screenStatus: ScreenStatus.init);
}
