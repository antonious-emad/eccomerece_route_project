import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes/routes.dart';
import '../../../../../core/cache/shared_prefrence.dart';
import '../../manager/home_bloc.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
       return Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/images/user.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  state.name ?? "",
                  style: const TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  state.email ?? "",
                  style: const TextStyle(fontSize: 25),
                ),

                const SizedBox(
                  height: 55,
                ),
                InkWell(
                  onTap:  () {
                    Navigator.pushNamed(context, AppRoute.changePassword);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          size: 30,
                          color: Colors.blueGrey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "change Password ",
                          style: const TextStyle(fontSize: 18),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    CacheData.removeData("token");
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoute.logIn, (route) => false);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          size: 30,
                          color: Colors.blueGrey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Log out",
                          style: const TextStyle(fontSize: 18),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          );

      },
    );
  }
}
