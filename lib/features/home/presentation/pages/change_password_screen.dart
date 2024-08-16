
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../manager/home_bloc.dart';
import 'home_screen.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>(),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (BuildContext context, HomeState state) {
          if (state.screenStatus == HomeScreenStatus.loading) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.blueGrey)),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            );
          } else if (state.screenStatus ==
              HomeScreenStatus.passwordChangSuccess) {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("success",
                        style: TextStyle(color: Colors.green, fontSize: 18)),
                    elevation: 0,
                    content: SizedBox(
                      height: 150.h,
                      child: Column(
                        children: [
                          const Text("Password changed successfully"),
                          const Spacer(),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, AppRoute.logIn, (route) => false);
                              },
                              child: const Text("go to log in")),
                        ],
                      ),
                    ),
                  );
                });
          } else if (state.screenStatus ==
              HomeScreenStatus.passwordChangFailure) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Error", style: TextStyle(fontSize: 18)),
                elevation: 0,
                content: SizedBox(
                  height: 140.h,
                  child: Column(
                    children: [
                      Text(state.failures?.message ?? "unknown error occurred",
                          style: const TextStyle(color: Colors.red)),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("OK"))
                    ],
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    HomeScreen(startIndex: 3);
                  },
                  child: const Icon(Icons.arrow_back_outlined)),
              backgroundColor: AppColors.blueColor,
              elevation: 0,
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.blueColor,
            body: Padding(
              padding: EdgeInsets.all(30.w.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 60.h),
                    const Text("Reset your account password",
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                    SizedBox(height: 30.h),
                    const Text("Enter your current password",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    SizedBox(height: 20.h),
                    Container(
                        margin: EdgeInsets.only(top: 10.h),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.white),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter your current password";
                            }
                            return null;
                          },
                          controller: HomeBloc.get(context).currentPassword,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'enter the current password here'),
                        )),
                    SizedBox(height: 20.h),
                    const Text("Enter  new password",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    SizedBox(height: 20.h),
                    Container(
                        margin: EdgeInsets.only(top: 10.h),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.white),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            final bool passwordValid = RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(value);
                            if (!passwordValid) {
                              return "please enter a valid password";
                            }
                            return null;
                          },
                          controller: HomeBloc.get(context).newPassword,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'enter the new password here'),
                        )),
                    SizedBox(height: 20.h),
                    const Text("Re-enter  new password",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    SizedBox(height: 20.h),
                    Container(
                        margin: EdgeInsets.only(top: 10.h),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.white),
                        child: TextFormField(
                          controller: HomeBloc.get(context).rePassword,
                          validator: (value) {
                            if (value !=
                                HomeBloc.get(context).newPassword.text) {
                              return "passwords does not match";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Re-enter new password'),
                        )),
                    Container(
                      padding: EdgeInsets.all(50.h.w),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0.r),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              HomeBloc.get(context).add(ChangePassword());
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(15.h.w),
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                  fontSize: 20.sp, color: AppColors.blueColor),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    ;
  }
}
