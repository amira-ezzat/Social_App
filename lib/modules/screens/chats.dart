import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit_layout/cubit.dart';
import '../../layout/cubit_layout/states.dart';
import '../../model/user_model.dart';
import '../../shared/compononse/components.dart';
import 'details.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: ( context, state) {  },
      builder: ( context,  state) {
        return  ConditionalBuilder(
          condition:SocialCubit.get(context).users.length>0,
          builder: ( context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context,index)=>buildChatItem(SocialCubit.get(context).users[index],context) ,
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: ( context)=>Center(
            child: CircularProgressIndicator(),
          ),

        );
      }
        );
  }



  Widget buildChatItem(SocialUserModel? model,context)=>InkWell(
    onTap: () {
      navigateTo(
          context, ChatsDetailsScreen(
        userModel: model,
      )
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(
                '${model!.image}'
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            '${model.name}',
            style:TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    ),
  );

}