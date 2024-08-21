part of 'product_list_bloc.dart';

@immutable
abstract class ProductListEvent {}

class GetAllProducts extends ProductListEvent {}

class GetCart extends ProductListEvent {}


class UpdateCartEvent extends ProductListEvent {
  final String id;
  var count;
  UpdateCartEvent(this.id,this.count);

}

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

class GetPaymentAuthTokenEvent extends ProductListEvent{
  final String email;
  final String phone;
  final String firstname;
  final String lastname;
  final String amount;
  GetPaymentAuthTokenEvent({required this.email, required this.phone, required this.firstname, required this.lastname,required this.amount});
  
}

class GetPaymengtOrderIdEvent extends ProductListEvent{
  final String email;
  final String phone;
  final String firstname;
  final String lastname;
  final String amount;
  GetPaymengtOrderIdEvent({required this.email, required this.phone, required this.firstname, required this.lastname,required this.amount});
}

class GetPaymentRequestTokenToCardEvent extends ProductListEvent{
  final String email;
  final String phone;
  final String firstname;
  final String lastname;
  final String amount;
  GetPaymentRequestTokenToCardEvent({required this.email, required this.phone, required this.firstname, required this.lastname,required this.amount});

}

class GetPaymentRequestTokenKioskvent extends ProductListEvent{
  final String email;
  final String phone;
  final String firstname;
  final String lastname;
  final String amount;

  GetPaymentRequestTokenKioskvent({required this.email, required this.phone, required this.firstname, required this.lastname,required this.amount});

}

class GetPaymentRefrenceCodeEvent extends ProductListEvent{}