part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetCategoriesEvent extends HomeEvent {}

class GetBrandsEvent extends HomeEvent {}

class AddToCartEvent extends HomeEvent {
  final String id;
  AddToCartEvent(this.id);
}

class UpdateProductQuantityEvent extends HomeEvent {
  final String id;
  var count;
  UpdateProductQuantityEvent(this.id,this.count);

}

class TabChange extends HomeEvent {
  final int index;
  TabChange({required this.index});
}

class GetWishList extends HomeEvent {}

class GetUserData extends HomeEvent {}

class ChangePassword extends HomeEvent {}
