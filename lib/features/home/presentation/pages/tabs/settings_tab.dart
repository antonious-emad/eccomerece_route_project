import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/routes/routes.dart';
import '../../../../../core/cache/shared_prefrence.dart';
import '../../manager/home_bloc.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
       return Padding(
         padding: const EdgeInsets.all(12.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(children: [
               Image.asset(
                 "assets/images/user.png",
                 width: 50,
                 height: 50,
                 fit: BoxFit.fill,
               ),
               const SizedBox(
                 width: 20,
               ),
               Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     'Welcome,${state.name ?? ""}',
                     style:  GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Color.fromRGBO(6, 0, 79, 1)),
                   ),
                   const SizedBox(
                     height: 8,
                   ),
                   Text(
                     state.email ?? "",
                     style:  GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color: Color.fromRGBO(6, 0, 79, 0.6)),
                   ),
                 ],
               ),
             ],),
             Text("Your full name",style:GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Color.fromRGBO(6, 0, 79, 1)),),
             TextFormField(
               style: TextStyle(color: Theme.of(context).colorScheme.errorContainer),
               decoration: InputDecoration(
                 suffixIcon: Icon(Icons.edit_rounded),
                 hintText: state.name,
                 hintStyle:GoogleFonts.poppins(fontSize:14 ,fontWeight:FontWeight.w500 ,color:Color.fromRGBO(6, 0, 79,1) ),
                 enabledBorder: OutlineInputBorder(
                   borderRadius:  BorderRadius.circular(20),
                     borderSide: BorderSide(color:Color.fromRGBO(0,65,130,0.3))
                 ),
                 focusedBorder: OutlineInputBorder(
                     borderRadius:  BorderRadius.circular(20),
                     borderSide: BorderSide(color:Color.fromRGBO(0,65,130,0.3))
                 ),
                 errorStyle: TextStyle(color: Colors.red,),
               ),),
             Text("Your E-mail",style:GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Color.fromRGBO(6, 0, 79, 1)),),
             TextFormField(
               style: TextStyle(color: Theme.of(context).colorScheme.errorContainer),
               decoration: InputDecoration(
                 suffixIcon: Icon(Icons.edit_rounded),
                 hintText: state.email,
                 hintStyle:GoogleFonts.poppins(fontSize:14 ,fontWeight:FontWeight.w500 ,color:Color.fromRGBO(6, 0, 79,1) ),
                 enabledBorder: OutlineInputBorder(
                     borderRadius:  BorderRadius.circular(20),
                     borderSide: BorderSide(color:Color.fromRGBO(0,65,130,0.3))
                 ),
                 focusedBorder: OutlineInputBorder(
                     borderRadius:  BorderRadius.circular(20),
                     borderSide: BorderSide(color:Color.fromRGBO(0,65,130,0.3))
                 ),
                 errorStyle: TextStyle(color: Colors.red,),
               ),),
             Text("Your Password",style:GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Color.fromRGBO(6, 0, 79, 1)),),
             TextFormField(
               style: TextStyle(color: Theme.of(context).colorScheme.errorContainer),
               decoration: InputDecoration(
                 suffixIcon: IconButton(
                    onPressed: () {
                      CacheData.removeData("token");
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRoute.logIn, (route) => false);
                    },
                    icon:Icon(Icons.edit_rounded)),
                 hintText: '**********************',
                 hintStyle:GoogleFonts.poppins(fontSize:14 ,fontWeight:FontWeight.w500 ,color:Color.fromRGBO(6, 0, 79,1) ),
                 enabledBorder: OutlineInputBorder(
                     borderRadius:  BorderRadius.circular(20),
                     borderSide: BorderSide(color:Color.fromRGBO(0,65,130,0.3))
                 ),
                 focusedBorder: OutlineInputBorder(
                     borderRadius:  BorderRadius.circular(20),
                     borderSide: BorderSide(color:Color.fromRGBO(0,65,130,0.3))
                 ),
                 errorStyle: TextStyle(color: Colors.red,),
               ),),
             Text("Your mobile number",style:GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Color.fromRGBO(6, 0, 79, 1)),),
             TextFormField(
               style: TextStyle(color: Theme.of(context).colorScheme.errorContainer),
               decoration: InputDecoration(
                 suffixIcon: Icon(Icons.edit_rounded),
                 hintText: "01220156988",
                 hintStyle:GoogleFonts.poppins(fontSize:14 ,fontWeight:FontWeight.w500 ,color:Color.fromRGBO(6, 0, 79,1) ),
                 enabledBorder: OutlineInputBorder(
                     borderRadius:  BorderRadius.circular(20),
                     borderSide: BorderSide(color:Color.fromRGBO(0,65,130,0.3))
                 ),
                 focusedBorder: OutlineInputBorder(
                     borderRadius:  BorderRadius.circular(20),
                     borderSide: BorderSide(color:Color.fromRGBO(0,65,130,0.3))
                 ),
                 errorStyle: TextStyle(color: Colors.red,),
               ),),
             Text("Your Address",style:GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Color.fromRGBO(6, 0, 79, 1)),),
             TextFormField(
               style: TextStyle(color: Theme.of(context).colorScheme.errorContainer),
               decoration: InputDecoration(
                 suffixIcon: Icon(Icons.edit_rounded),
                 hintText: "6th October, street 11.....",
                 hintStyle:GoogleFonts.poppins(fontSize:14 ,fontWeight:FontWeight.w500 ,color:Color.fromRGBO(6, 0, 79,1) ),
                 enabledBorder: OutlineInputBorder(
                     borderRadius:  BorderRadius.circular(20),
                     borderSide: BorderSide(color:Color.fromRGBO(0,65,130,0.3))
                 ),
                 focusedBorder: OutlineInputBorder(
                     borderRadius:  BorderRadius.circular(20),
                     borderSide: BorderSide(color:Color.fromRGBO(0,65,130,0.3))
                 ),
                 errorStyle: TextStyle(color: Colors.red,),
               ),),
             // InkWell(
             //   onTap:  () {
             //     Navigator.pushNamed(context, AppRoute.changePassword);
             //   },
             //   child: Container(
             //     margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
             //     child: Row(
             //       crossAxisAlignment: CrossAxisAlignment.center,
             //       children: [
             //         Icon(
             //           Icons.lock,
             //           size: 30,
             //           color: Colors.blueGrey,
             //         ),
             //         const SizedBox(
             //           width: 10,
             //         ),
             //         Text(
             //           "change Password ",
             //           style: const TextStyle(fontSize: 18),
             //         ),
             //         const Spacer(),
             //       ],
             //     ),
             //   ),
             // ),
             // InkWell(
             //   onTap: () {
             //     CacheData.removeData("token");
             //     Navigator.pushNamedAndRemoveUntil(
             //         context, AppRoute.logIn, (route) => false);
             //   },
             //   child: Container(
             //     margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
             //     child: Row(
             //       crossAxisAlignment: CrossAxisAlignment.center,
             //       children: [
             //         Icon(
             //           Icons.logout,
             //           size: 30,
             //           color: Colors.blueGrey,
             //         ),
             //         const SizedBox(
             //           width: 10,
             //         ),
             //         Text(
             //           "Log out",
             //           style: const TextStyle(fontSize: 18),
             //         ),
             //         const Spacer(),
             //       ],
             //     ),
             //   ),
             // ),

           ],
         ),
       );

      },
    );
  }
}
