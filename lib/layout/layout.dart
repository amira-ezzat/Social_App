
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_chats/modules/screens/posts.dart';

import '../shared/compononse/components.dart';
import '../shared/styles/icons/icons.dart';
import 'cubit_layout/cubit.dart';
import 'cubit_layout/states.dart';

class SocialLayoutScreen  extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:( context,  state){
        if(state is SocialNewPost)
        {
          navigateTo(context, PostsScreen());
        }
      } ,
      builder: (BuildContext context, SocialStates state) {
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: TextStyle(
                color: HexColor('#67A3D9'),
              ),
            ),
            actions: [
              IconButton(
                icon:Icon(
                    IconBroken.Notification
                ),
                onPressed: () {

                },
              ),
              IconButton(
                icon:Icon(IconBroken.Search),
                onPressed: () {

                },
              ),

            ],
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                icon:Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon:Icon(IconBroken.Chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon:Icon(IconBroken.Paper_Upload),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon:Icon(IconBroken.Profile),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
