import 'package:injectable/injectable.dart';

import '../repositories/del_from_repo.dart';

@injectable
class DelFormWishListUseCase {
  DelFromRepo delFromRepo;
  DelFormWishListUseCase(this.delFromRepo);

  Future<void> call(String? productId) async {
    delFromRepo.delFromWishList(productId);
  }
}
