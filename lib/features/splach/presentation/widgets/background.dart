import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class BackGround extends StatelessWidget {
  final Widget child;
  const BackGround({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.blueColor,
      ),
      child: child,
    );
  }
}
