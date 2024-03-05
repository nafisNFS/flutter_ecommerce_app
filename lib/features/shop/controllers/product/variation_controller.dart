import 'dart:core';
import 'package:get/get.dart';
import 'package:t_store/features/shop/controllers/product/images_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/models/product_variation_model.dart';

class VariationController extends GetxController{
  static VariationController get instance => Get.find();

  ///Variables
  RxMap selectedAttributes ={}.obs;
  RxString variationStockStatus =''.obs;
  Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;

  ///select attribute and variation
  void onAttributeSelected(ProductModel product,attributeName,attributeValue){
    //when attribute is selected we will first add that attribute to the selected attribute
    final selectedAttributes = Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName]=attributeValue;
    this.selectedAttributes[attributeName]=attributeValue;

    final selectedVariation =product.productVariations!.firstWhere(
            (variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes),
            orElse: () => ProductVariationModel.empty(),
    );

    ///show the selected variation image as a main image
    if(selectedVariation.image.isNotEmpty){
      ImagesController.instance.selectedProductImage.value =selectedVariation.image;
    }

    //assign selected variation
    this.selectedVariation.value=selectedVariation;

    //update selected product variation status
    getProductVariationStockStatus();
  }

  //check if selected variation matches any variation attributes
  bool _isSameAttributeValues(Map<String, dynamic>) variationAttributes, Map<String,dynamic> selectedAttributes){
    //if selectedAttributes contains 3 attributes and current variation contains 2 then return
    if(variationAttributes.length != selectedAttributes .length) return false;

    //if any of the attributes is different then return e.g. [Green,Large] x [Green,Small]
    for(final key in variationAttributes.keys){
      //attributes[key]=value which could be [Green,Small,Cotton] etc.
      if(variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  ///check attribute availability /stocl in variation
  Set<String?> getAttributesAvailabilityInVariation(List<ProductVariationModel> variations, String attributeName) {
  //pass the variations to check which attributes are available and stock is not 0
  final availableVariationAttributeValues=variations
      .where((variation) =>
           //check empty/out of stock selectedAttributes
           variation.attributeValues[attributeName]!=null && variation.attributeValues[attributeName]!.isNotEmpty && variation.stock>0)
           //fetch all non-empty attributes of variations
           .map((variation) =>variation.attributeValues[attributeName])
           .toSet();

     return  availableVariationAttributeValues;
  }

  String getVariationPrice(){
     return (selectedVariation.value.salePrice>0 ? selectedVariation.value.salePrice : selectedVariation.value.price).toString();
  }

  ///check product variation stock status
  void getProductVariationStockStatus(){
    variationStockStatus.value=selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  ///Reset selected attributes when switching products
  void resetSelectedAttributes(){
    selectedAttributes.clear();
    variationStockStatus.value='';
    selectedVariation.value=ProductVariationModel.empty();
  }
}