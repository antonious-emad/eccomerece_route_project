import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/routes/routes.dart';
import '../../../../../core/cache/shared_prefrence.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../manager/home_bloc.dart';
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(25.w.h),
          child: Center(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Your name",
                      style:
                          TextStyle(fontSize: 22.sp, color: AppColors.blueColor),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.all(10.w.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: AppColors.blueColor)),
                      child: Text(
                        state.name ?? "",
                        style:
                            TextStyle(fontSize: 22, color: AppColors.blueColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Your Email",
                      style:
                          TextStyle(fontSize: 22.sp, color: AppColors.blueColor),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.all(10.w.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: AppColors.blueColor)),
                      child: Text(
                        state.email ?? "",
                        style:
                            TextStyle(fontSize: 20, color: AppColors.blueColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueColor,
                        padding: EdgeInsets.all(15.w.h),
                        textStyle: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.changePassword);
                    },
                    child: const Text(
                      "Change Password",
                      style: TextStyle(fontSize: 30),
                    )),
                SizedBox(height: 50.h),
                InkWell(
                    onTap: () {
                      CacheData.removeData("token");
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoute.logIn, (route) => false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("log out", style: TextStyle(fontSize: 30.sp)),
                        SizedBox(width: 20.w),
                        Icon(Icons.logout, size: 30.sp),
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
