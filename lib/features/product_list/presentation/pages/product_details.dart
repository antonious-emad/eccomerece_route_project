import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../home/presentation/manager/home_bloc.dart';
import '../../data/models/ProductModel.dart';
import '../bloc/product_list_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {

  ProductDetailsScreen({super.key});
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}
List<Color> clrs = [
  const Color(0xFF2F2929),
  const Color(0xFFBC3018),
  const Color(0xFF0973DD),
  const Color(0xFF02B935),
  const Color(0xFFFF645A)
];
List<String> size = ["38", "39", "40", "41", "42"];
bool fav=false;
class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool descTextShowFlag = false;
  bool isSelected = false;
  int? selectedSizeIndex;
  int? selectedColorIndex;
  int count=1;

  @override
  Widget build(BuildContext context) {
    var product = ModalRoute.of(context)!.settings.arguments as Data?;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          Icon(Icons.search, color: AppColors.blueColor, size: 24.sp),
          SizedBox(width: 15.w),
          Icon(Icons.shopping_cart_outlined,
              color: AppColors.blueColor, size: 24.sp),
          SizedBox(width: 15.w,),
        ],
        title: Text(
          "Product Details",
          style: TextStyle(fontSize: 20, color: Color(0xFF06004F)),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          Stack(
                  children: [
                    Center(
                      child: ImageSlideshow(
                          width:398.w ,
                          height: 398.h,
                          indicatorColor: AppColors.blueColor,
                          indicatorBackgroundColor: Colors.black.withOpacity(0.3),
                          autoPlayInterval: 3000,
                          indicatorRadius: 5.r,
                          isLoop: true,
                          children: [
                            Card(
                              color: Colors.white.withOpacity(0.5),
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAlias,
                              elevation: 0,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                  borderSide: BorderSide(width: 2.w,color: Colors.blueGrey)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(15.r),topRight: Radius.circular(15.r) ),
                                child: CachedNetworkImage(
                                    imageUrl:product?.images?[0]??"",
                                    errorWidget: (context, url, error) => const Icon(Icons.error_outline),
                                    fit: BoxFit.cover,
                                    width:MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                            product?.images?[1]!=null?Card(
                              color: Colors.white.withOpacity(0.5),
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAlias,
                              elevation: 0,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                  borderSide: BorderSide(width: 2.w,color: Colors.blueGrey)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(15.r),topRight: Radius.circular(15.r) ),
                                child: CachedNetworkImage(
                                  imageUrl:product?.images?[1]??"",
                                  errorWidget: (context, url, error) => const Icon(Icons.error_outline),
                                  fit: BoxFit.cover,
                                  width:MediaQuery.of(context).size.width,
                                ),
                              ),
                            ) :Card(
                              color: Colors.white.withOpacity(0.5),
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAlias,
                              elevation: 0,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                  borderSide: BorderSide(width: 2.w,color: Colors.blueGrey)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(15.r),topRight: Radius.circular(15.r) ),
                                child: CachedNetworkImage(
                                  imageUrl:product?.images?[0]??"",
                                  errorWidget: (context, url, error) => const Icon(Icons.error_outline),
                                  fit: BoxFit.cover,
                                  width:MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                            product?.images?[2]!=null?    Card(
                              color: Colors.white.withOpacity(0.5),
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAlias,
                              elevation: 0,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                  borderSide: BorderSide(width: 2.w,color: Colors.blueGrey)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(15.r),topRight: Radius.circular(15.r) ),
                                child: CachedNetworkImage(
                                  imageUrl:product?.images?[2]??"",
                                  errorWidget: (context, url, error) => const Icon(Icons.error_outline),
                                  fit: BoxFit.cover,
                                  width:MediaQuery.of(context).size.width,
                                ),
                              ),
                            )  :Card(
                              color: Colors.white.withOpacity(0.5),
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAlias,
                              elevation: 0,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                  borderSide: BorderSide(width: 2.w,color: Colors.blueGrey)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(15.r),topRight: Radius.circular(15.r) ),
                                child: CachedNetworkImage(
                                  imageUrl:product?.images?[0]??"",
                                  errorWidget: (context, url, error) => const Icon(Icons.error_outline),
                                  fit: BoxFit.cover,
                                  width:MediaQuery.of(context).size.width,
                                ),
                              ),
                            ) ,
                          ]
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 7.w),
                      child: Container(
                        padding: EdgeInsets.only(left:357.w,top: 22.h),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: InkWell(
                          onTap: () {
                            // HomeBloc.getIds!.contains(product?.id)
                            //     ? HomeBloc.getIds?.remove(product?.id)
                            //     : print("error");
                            fav
                                ? ProductListBloc.get(context)
                                .add(DelFromWishList(product!.id!))
                                : ProductListBloc.get(context).add(
                                AddToWishList(product?.id ?? ""));
                            ProductListBloc.get(context)
                                .add(ChangeFavIcon((!(fav))));
                            fav = !fav;
                            // state.isFav = fav;
                          },
                          child: Icon(
                             fav ? Icons.favorite : Icons.favorite_outline,
                            // state.isFav ?? fav ? Icons.favorite : Icons.favorite_outline,
                            color: AppColors.blueColor,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
            SingleChildScrollView(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(18.w.h),
                        child: Row(children: [
                          Expanded(
                            child: Text(
                              maxLines: 3,
                                product?.title??" ",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF06004F))),
                          ),
                          Text("EGP ${product?.price.toString() ?? ""}",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Color(0xFF06004F),fontSize: 18.sp))
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.5))),
                            child: Center(
                              child: Text(
                                "${product?.sold ??0} Sold",
                                style: const TextStyle(color: Color(0xFF06004F)),
                              ),
                            ),
                          ),

                          SizedBox(width: 10.w),
                          Icon(Icons.star, color:Colors.amberAccent),
                          Text(product?.ratingsAverage.toString() ?? "",
                              style: TextStyle(fontSize: 14.sp)),
                          const SizedBox(width: 2),
                          Text("(${product?.ratingsQuantity.toString() ?? ""} reviewers) ",
                              style: TextStyle(fontSize: 14.sp)),
                          SizedBox(width: 20.w),
                          Container(
                            width: 110,
                            height: 40,
                            decoration: BoxDecoration(
                                color: const Color(0xFF06004F),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(

                                 icon: Icon(CupertinoIcons.minus_circle),
                                  color: Colors.white,
                                  onPressed: () {
                                   setState(() {
                                     count--;
                                     if(count<=0){count=1;}
                                   });
                                  },
                                ),
                                Text(
                                  '${count}'.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      count++;
                                    });
                                  },
                                 icon:Icon (Icons.add_circle_outline),
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),

                        ]),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                        child: Text("Description",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF06004F))),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.only(left: 15.w, right: 30.w),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              descTextShowFlag = !descTextShowFlag;
                            });
                          },
                          child: Text(
                            maxLines: descTextShowFlag == true ? 6 : 2,
                            product?.description?.replaceAll("\n", " ") ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.all(18.w.h),
                        child: Text("Size",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blueColor)),
                      ),

                      SizedBox(
                          height: 50,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: size.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSizeIndex=index;

                                    });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: selectedSizeIndex == index
                                            ? const Color(0xFF06004F)
                                            : Colors.white),
                                    child: Center(
                                        child: Text(
                                          size[index],
                                          style: TextStyle(
                                              color:selectedSizeIndex==index
                                                  ? Colors.white
                                                  : Colors.black),
                                        )),
                                  ),
                                );
                              })),



                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: const Text("Color",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF06004F))),
                      ),





                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 16.w ),
                        child: SizedBox(
                            height: 50,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: clrs.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedColorIndex = index;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(25),
                                                color: clrs[index]
                                            ),
                                          ),
                                         if( selectedColorIndex==index)Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                      )
                    ],
                                  ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                height: 60,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Total Price",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45)),
                    Text(
                        "EGP ${(product!.price! * count).toString() ??0}",
                        // "EGP 3,500",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF06004F))),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                for(int i=0;i<count;++i){
                getIt<HomeBloc>()
                    .add(AddToCartEvent(product?.id ?? ""));
              }
                },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: const Color(0xFF06004F),
                    borderRadius: BorderRadius.circular(30)),
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.shopping_cart_outlined,
                        color: Colors.white, size: 30.sp),
                    Text("Add To Cart",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );

  }
}
