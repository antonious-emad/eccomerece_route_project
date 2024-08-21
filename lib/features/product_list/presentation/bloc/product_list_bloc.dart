import 'package:bloc/bloc.dart';
import 'package:eccemorce_route_project/core/network/remote/dio_helper.dart';
import 'package:eccemorce_route_project/core/utils/constants.dart';
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
import '../../domain/use_cases/update_cart_use_case.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

@injectable
class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  static ProductListBloc get(context) => BlocProvider.of(context);
  ProductListUseCase productListUseCase;
  GetCartsUseCase getCartsUseCase;
  UpdateCartUseCase updateCartUseCase;
  AddToWishListUseCase addToWishListUseCase;
  DelFormWishListUseCase delFormWishListUseCase;
  static List<String>? iDs = [];

  ProductListBloc(
      this.productListUseCase,
      this.getCartsUseCase,
      this.updateCartUseCase,
      this.addToWishListUseCase,
      this.delFormWishListUseCase)
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
      } else if (event is UpdateCartEvent) {
        emit(state.copyWith(
            screenStatus: ScreenStatus.loading)); // Show loading state
        var result = await updateCartUseCase.call(event.id, event.count);
        result.fold((l) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.failures,
              failures: l)); // Handle failure
        }, (r) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.successfully, cartModel: r));
        });
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
      } else if (event is GetPaymentAuthTokenEvent) {
        emit(state.copyWith(screenStatus: ScreenStatus.loadingAuthTokenPaymentState)); // Show loading state
        try {
     await DioHelper.postData(endPoint: "auth/tokens", data: {"api_key":Constants. PAYMENT_API_KEY})
      .then((value) {
      Constants.AUTH_TOKEN = value.data["token"];
      emit(state.copyWith(screenStatus: ScreenStatus.successAuthTokenPaymentState));
      add(GetPaymengtOrderIdEvent(email: event.email, phone: event.phone, firstname: event.firstname, lastname: event.lastname, amount: event.amount));
    });
          // var result = await getAuthTokenUseCase.call(event.email, event.phone, event.firstname, event.lastname, event.amount);
          // emit(state.copyWith(screenStatus: ScreenStatus.successAuthTokenPaymentState));
          // add(GetPaymengtOrderIdEvent(email: event.email, phone: event.phone, firstname: event.firstname, lastname: event.lastname, amount: event.amount));
        } 
        catch (e) {
          emit(state.copyWith(screenStatus: ScreenStatus.errorAuthTokenPaymentState)); // Handle failure
        }
      } 
      
      
      else if (event is GetPaymengtOrderIdEvent) {
        emit(state.copyWith(screenStatus: ScreenStatus.loadingOrderIdPaymentState)); // Show loading state
        try {
           await DioHelper.postData(endPoint: "ecommerce/orders", data: {
      "auth_token":Constants.AUTH_TOKEN,
      "delivery_needed": "false",
      "amount_cents":event.amount,
      "currency": "EGP",
      "items": []
    }).then((value) {
      Constants.ORDER_ID = value.data["id"].toString();
          emit(state.copyWith(screenStatus: ScreenStatus.successOrderIdPaymentState));
          add(GetPaymentRequestTokenToCardEvent(email: event.email, phone: event.phone, firstname: event.firstname, lastname: event.lastname, amount: event.amount));
          add(GetPaymentRequestTokenKioskvent(email: event.email, phone: event.phone, firstname: event.firstname, lastname: event.lastname, amount: event.amount));
    });
          // var result = await getOrderIdUseCase.call(event.email, event.phone, event.firstname, event.lastname, event.amount);
          // emit(state.copyWith(screenStatus: ScreenStatus.successOrderIdPaymentState));
          // add(GetPaymentRequestTokenToCardEvent(email: event.email, phone: event.phone, firstname: event.firstname, lastname: event.lastname, amount: event.amount));
          // add(GetPaymentRequestTokenKioskvent(email: event.email, phone: event.phone, firstname: event.firstname, lastname: event.lastname, amount: event.amount));
        } catch (e) {
          emit(state.copyWith(screenStatus: ScreenStatus.erroOrderIdPaymentState)); // Handle failure
        }
      } 
      
      else if (event is GetPaymentRequestTokenToCardEvent) {
        emit(state.copyWith(screenStatus: ScreenStatus.loadingRequestTokenCardPaymentState)); // Show loading state
        try {
             await DioHelper.postData(endPoint: "acceptance/payment_keys", data: {
      "auth_token":Constants.AUTH_TOKEN,
      "amount_cents":event.amount,
      "expiration": 3600,
      "order_id":Constants.ORDER_ID,
      "billing_data": {
        "apartment": "NA",
        "email":event.email,
        "floor": "NA",
        "first_name":event.firstname,
        "street": "NA",
        "building": "NA",
        "phone_number":event.phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "EG",
        "last_name":event.lastname,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id":Constants.INTERGRATIONCARDID
    }).then((value) {
      Constants.REQUEST_TOKEN_CARD = value.data["token"];
          emit(state.copyWith(screenStatus: ScreenStatus.successRequestTokenCardPaymentState));
    });
          // var result = await getRequestTokenUseCase.call(event.email, event.phone, event.firstname, event.lastname, event.amount);
          // emit(state.copyWith(screenStatus: ScreenStatus.successRequestTokenCardPaymentState));
        } catch (e) {
          emit(state.copyWith(screenStatus: ScreenStatus.errorRequestTokenCardPaymentState)); // Handle failure
        }
      } else if (event is GetPaymentRequestTokenKioskvent) {
        emit(state.copyWith(screenStatus: ScreenStatus.loadingRequestTokenKioskPaymentState)); // Show loading state
       try{
       await DioHelper.postData(endPoint: "acceptance/payment_keys", data: {
      "auth_token":Constants.AUTH_TOKEN,
      "amount_cents":event.amount,
      "expiration": 3600,
      "order_id":Constants.ORDER_ID,
      "billing_data": {
        "apartment": "NA",
        "email":event.email,
        "floor": "NA",
        "first_name":event.firstname,
        "street": "NA",
        "building": "NA",
        "phone_number":event.phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "EG",
        "last_name":event.lastname,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id":Constants.INTERGRATIONKIOSKID
    }).then((value) {
      Constants.REQUEST_TOKEN_KIOSK = value.data["token"];
      emit(state.copyWith(screenStatus: ScreenStatus.successRequestTokenKioskPaymentState));
      add(GetPaymentRefrenceCodeEvent());
    });
        // var result = await getRequestTokenKiosk.call(event.email, event.phone, event.firstname, event.lastname, event.amount);
        // emit(state.copyWith(screenStatus: ScreenStatus.successRequestTokenKioskPaymentState));
      }catch(e){
         emit(state.copyWith(screenStatus: ScreenStatus.errorRequestTokenKioskPaymentState)); // Handle failure}
      }
      } else if (event is GetPaymentRefrenceCodeEvent) {
        emit(state.copyWith(screenStatus: ScreenStatus.loadingReferenceCodePaymentState)); // Show loading state
        try {
       await DioHelper.postData(endPoint: "acceptance/payments/pay", data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token":Constants.REQUEST_TOKEN_KIOSK
    }).then((value) {
      Constants.REF_CODE = value.data["id"].toString();
      emit(state.copyWith(screenStatus: ScreenStatus.successReferenceCodePaymentState));
    });
          // var result = await getRefCodeUseCase.call();
          // emit(state.copyWith(screenStatus: ScreenStatus.successReferenceCodePaymentState));
        } catch (e) {
          emit(state.copyWith(screenStatus: ScreenStatus.errorReferenceCodePaymentState)); // Handle failure
        }
      }
    });
  }
}
