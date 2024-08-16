part of 'product_list_bloc.dart';

@immutable
abstract class ProductListEvent {}

class GetAllProducts extends ProductListEvent {}

class GetCart extends ProductListEvent {}

class ChangeFavIcon extends ProductListEvent {
  final bool isFave;
  ChangeFavIcon(this.isFave);
}



class AddToWishList extends ProductListEvent {
  final String productId;

  AddToWishList(this.productId);
}

class DelFromWishList extends ProductListEvent {
  final String productId;

  DelFromWishList(this.productId);
}

class GetWish extends ProductListEvent {}
