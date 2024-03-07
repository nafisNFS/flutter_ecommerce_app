import 'dart:convert';

import 'package:get/get.dart';
import 'package:t_store/common/widgets/loader/loaders.dart';
import 'package:t_store/data/repositories.authentication/product/product_repository.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/local_storage/storage_utility.dart';

class FavouritesController extends GetxController{
  static FavouritesController get instance =>Get.find();

  //variables
  final favourites =<String, bool>{}.obs;

  @override
  void onInit(){
    super.onInit();
    initFavourites();
  }

  //method to initialize favourites by reading from storage
  Future<void> initFavourites() async {
    final json =TLocalStorage.instance().readData('favourites');
    if(json != null) {
      final storedFavourites =jsonDecode(json) as Map<String ,dynamic>;
      favourites.assignAll(storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId)  {
    return favourites[productId] ?? false;
  }

  void toggleFavouriteProduct (String productId) {
    if(!favourites.containsKey(productId)){
      favourites[productId] =true;
      saveFavouritesToStorage();
      TLoaders.customToast(message: 'Product has been added to wishlist.');
    } else {
      TLocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      saveFavouritesToStorage();
      favourites.refresh();
      TLoaders.customToast(message: 'Product has been removed from the wishlist');
    }
  }

  void saveFavouritesToStorage(){
    final encodedFavourites =json.encode(favourites);
    TLocalStorage.instance().saveData('favourites' , encodedFavourites);
  }

  Future<List<ProductModel>> favouriteProducts() async {
    return await ProductRepository.instance.getFavouriteProducts(favourites.keys.toList());
  }

}