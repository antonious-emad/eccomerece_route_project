import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/utils/images.dart';
import '../widgets/background.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({super.key});

  Future<void> _navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    if (!context.mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRoute.logIn);
  }

  @override
  Widget build(BuildContext context) {
    _navigateToHome(context);

    return BackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Image.asset(
            AppImages.splach,
            height: 165.h,
            width: 396.w,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
