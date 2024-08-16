import 'package:injectable/injectable.dart';

import '../repositories/add_to_wish_repo.dart';

@injectable
class AddToWishListUseCase {
  AddToWishListRepo addToWishListRepo;
  AddToWishListUseCase(this.addToWishListRepo);

  Future<void> call(String productId) async {
    addToWishListRepo.addToWishList(productId);
  }
}
