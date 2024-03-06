
import 'package:flutter/cupertino.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';

import '../../../features/shop/screens/home/widgets/home_appbar.dart';

class TBrandsShimmer extends StatelessWidget{
  const TBrandsShimmer({super.key,this.itemCount=4});
  final int itemCount;
  @override
  Widget build(BuildContext context){
    return TGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_,__)=> const TShimmerEffect(width:300,height: 80,),
    );
  }
}