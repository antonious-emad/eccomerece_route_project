import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/CategoryEntity.dart';

class CategoryItem extends StatelessWidget {
  final CategoryEntity? categoryEntity;
  final int index;
  const CategoryItem(
      {required this.index, required this.categoryEntity, super.key});
  @override
  Widget build(BuildContext context) {
    var category = categoryEntity?.data?[index];

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: SizedBox(
            child: CachedNetworkImage(
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover,
              imageUrl: category?.image ?? "",
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error_outline),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(category?.name ?? "",
            style: TextStyle(fontSize: 16.sp, color: AppColors.darkBlueColor))
      ],
    );
  }
}
