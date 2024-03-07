import 'package:get/get.dart';
import 'package:t_store/common/widgets/loader/loaders.dart';
import 'package:t_store/features/shop/controllers/product/variation_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/local_storage/storage_utility.dart';

import '../../../../utils/constants/enums.dart';
import '../../models/cart_item_model.dart';

class CartController extends GetxController{
  static CartController get instance => Get.find();
  //variables
  RxInt noOfCartItems =0.obs;
  RxDouble totalCartPrice =0.0.obs;
  RxInt productQuantityInCart =0.obs;
  RxList<CartItemModel> cartItems =<CartItemModel>[].obs;
  final variationController =VariationController.instance;

  CartController(){
    loadCartItems();
  }

  //Add items in the cart
  void addToCart(ProductModel product){
    //quantity check
    if(productQuantityInCart.value<1){
      TLoaders.customToast(message: 'Select Quantity');
      return;
    }

    //variable selected ?
    if(product.productType == ProductType.variable.toString() && variationController.selectedVariation.value.id.isEmpty){
      TLoaders.customToast(message: 'Select Variation');
      return;
    }

    //Out of stock status
    if(product.productType == ProductType.variable.toString()){
      if(variationController.selectedVariation.value.stock<1){
        TLoaders.warningSnackBar(message: 'Selected variation is out of stock', title:'Oh Snap!');
        return;
      }
    }else{
      if(product.stock<1){
        TLoaders.warningSnackBar(message: 'Selected Product is out of stock',title: 'Oh Snap!');
        return;
      }
    }

    //convert the productModel to a cartItemModel with the given quantity
    final selectedCartItem= convertToCartItem(product, productQuantityInCart.value);

    //check if already added in the cart
    int index= cartItems
    .indexWhere((cartItem) => cartItem.productId ==selectedCartItem.productId && cartItem.variationId ==selectedCartItem.variationId);

    if(index>=0){
      //this quantity is already added or updated /removed from the design
      cartItems[index].quantity=selectedCartItem.quantity;
    }else{
      cartItems.add(selectedCartItem);
    }

    updateCart();
    TLoaders.customToast(message: 'Your product has been added to the cart.');

  }

  void addOneToCart(CartItemModel item) {
    int index=cartItems.indexWhere((cartItem) => cartItem.productId ==item.productId && cartItem.variationId ==item.variationId );
    if(index>=0){
      cartItems[index].quantity+=1;
    }else{
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item){
    int index=cartItems.indexWhere((cartItem) => cartItem.productId ==item.productId && cartItem.variationId ==item.variationId );

    if(index>=0){
      if(cartItems[index].quantity>1){
        cartItems[index].quantity-=1;
      }else{
        //show dialog before completely removind
        cartItems[index].quantity ==1 ? removeFromCartDialog(index) :cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index){
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: (){
        //remove the item from the cart
        cartItems.removeAt(index);
        updateCart();
        TLoaders.customToast(message: 'Product removed from the cart.');
        Get.back();
      },
      onCancel: () => () =>Get.back(),
    );
  }

  ///initialize already added item's count in the cart
  void updateAlreadyAddedProductCount(ProductModel product){
    //if product has no variations then calculate carteEntries and display total number
    //else make default entries to 0 and show cartEntries when variation is selected
    if(product.productType ==ProductType.single.toString()){
      productQuantityInCart.value=getProductQuantityInCart(product.id);
    }else{
      final variationId=variationController.selectedVariation.value.id;
      if(variationId.isNotEmpty){
        productQuantityInCart.value=getVariationQuantityInCart(product.id, variationId);
      }else{
        productQuantityInCart.value=0;
      }
    }
  }







  ///this function converts a productmodel to a cartitemmodel
  CartItemModel convertToCartItem(ProductModel product,int quantity){
    if(product.productType ==ProductType.single.toString()){
      //reset variation in case of single product type
      variationController.resetSelectedAttributes();
    }

    final variation =variationController.selectedVariation.value;
    final isVariation =variation.id.isNotEmpty;
    final price =isVariation
        ? variation.salePrice>0.0
        ? variation.salePrice
        : variation.price
        : product.salePrice >0.0
        ? product.salePrice
        : product.price;
    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image :product.thumbnail,
      brandName: product.brand!=null ?product.brand!.name: '',
      selectedVariation: isVariation ? variation.attributeValues: null,

    );

  }

  ///update cart values
  void updateCart(){
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals(){
    double calculatedTotalPrice =0.0;
    int calculatedNoOfItems=0;

    for(var item in cartItems){
      calculatedTotalPrice +=(item.price) *item.quantity.toDouble();
      calculatedNoOfItems +=item.quantity;
    }

    totalCartPrice.value=calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems ;
  }

  void saveCartItems(){
    final cartItemStrings=cartItems.map((item) => item.toJson()).toList();
    TLocalStorage.instance().saveData('cartItems',cartItemStrings);
  }

  void loadCartItems(){
    final cartItemStrings=TLocalStorage.instance().readData<List<dynamic>> ('cartItems');
    if(cartItemStrings!=null){
      cartItems.assignAll(cartItemStrings.map((item) => CartItemModel.fromJson(item as Map<String,dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem=
        cartItems.where((item) => item.productId == productId).fold(0, (previousValue, element) => previousValue+element.quantity);
        return foundItem;
  }

  int getVariationQuantityInCart(String productId,String variationId){
    final foundItem=cartItems.firstWhere(
            (item) => item.productId == productId && item.variationId ==variationId,
      orElse: () => CartItemModel.empty(),
    );
    return foundItem.quantity;
  }

  void clearCart(){
    productQuantityInCart.value=0;
    cartItems.clear();
    updateCart();
  }



}