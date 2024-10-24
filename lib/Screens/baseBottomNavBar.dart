import 'package:flutter/material.dart';
import 'package:frontend/Screens/Home.dart';
import 'package:frontend/Screens/allProdpage.dart';
import 'package:frontend/Screens/profile.dart';
import 'package:frontend/Screens/searchPage.dart';
import 'package:frontend/constants/appConst.dart';
import 'package:sizer/sizer.dart';

class Basebottomnavbar extends StatefulWidget {
  const Basebottomnavbar({super.key});

  @override
  State<Basebottomnavbar> createState() => _BasebottomnavbarState();
}

class _BasebottomnavbarState extends State<Basebottomnavbar> {
  int pageIndex = 0;
  final List<Widget> pages = [
    const Home(),
    const Searchpage(),
    const Allprodpage(),
    const Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: pageIndex,children: pages,),
      bottomNavigationBar: Container(
        height: 8.h,
        decoration: const BoxDecoration(
          color: AppConst.backgroundWhite,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
        ),
        child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: (){
                setState(() {
                  pageIndex = 0;
                });
              }, icon:Icon(Icons.home,color: pageIndex==0?AppConst.themeColorPurple:AppConst.greyTextfield,size: pageIndex==0?6.h:4.h,)),
              IconButton(onPressed: (){
                setState(() {
                  pageIndex = 1;
                });
              }, icon:Icon(Icons.search,color: pageIndex==1?AppConst.themeColorPurple:AppConst.greyTextfield,size: pageIndex==1?6.h:4.h)),
              IconButton(onPressed: (){
                setState(() {
                  pageIndex = 2;
                });
              }, icon:Icon(Icons.store,color: pageIndex==2?AppConst.themeColorPurple:AppConst.greyTextfield,size: pageIndex==2?6.h:4.h)),
              IconButton(onPressed: (){
                setState(() {
                  pageIndex = 3;
                });
              }, icon:Icon(Icons.person,color: pageIndex==3?AppConst.themeColorPurple:AppConst.greyTextfield,size: pageIndex==3?6.h:4.h)),
            ],
          ),
        ),
      
    );
  }
}