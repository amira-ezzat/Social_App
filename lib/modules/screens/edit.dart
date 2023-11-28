import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_chats/layout/cubit_layout/cubit.dart';
import 'package:social_chats/layout/cubit_layout/states.dart';

import '../../shared/compononse/components.dart';
import '../../shared/styles/icons/icons.dart';

class EditScreen extends StatelessWidget {

var nameController= TextEditingController();
var bioController= TextEditingController();
var phoneController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state) {
        var userModel =SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio !;
        phoneController.text = userModel.phone!;
        return  Scaffold(
          appBar: defualtAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text
                  );
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#67A3D9')),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoading)
                    LinearProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF67A3D9)),
                    ),
                  if (state is SocialUserUpdateLoading)
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(

                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 160.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        4.0
                                    ),
                                    topRight: Radius.circular(
                                        4.0
                                    ),
                                  ),
                                  image: DecorationImage(
                                    image:coverImage ==null? NetworkImage(
                                      '${userModel!.cover}',
                                    ):FileImage(coverImage) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: HexColor('#67A3D9'),
                                  radius: 20.0,
                                  child: Icon(IconBroken.Camera,
                                      color: Colors.white),
                                ),
                              ),

                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage:profileImage ==null? NetworkImage(
                                  '${userModel!.image}',
                                ):FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                backgroundColor: HexColor('#67A3D9'),
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    SocialCubit.get(context)
                                        .uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  child: Text(
                                    'Upload Profile',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: HexColor('#67A3D9'),
                                    ),
                                  ),
                                ),
                                if (state is SocialUserUpdateLoading)
                                  SizedBox(height: 10.0,),
                                if (state is SocialUserUpdateLoading)
                                  LinearProgressIndicator(
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(Color(0xFF67A3D9)),
                                  ),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 10.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    SocialCubit.get(context)
                                        .uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  child: Text(
                                    'Upload Cover',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: HexColor('#67A3D9'),
                                    ),
                                  ),
                                ),
                                if (state is SocialUserUpdateLoading)
                                  SizedBox(height: 10.0,),
                                if (state is SocialUserUpdateLoading)
                                  LinearProgressIndicator(
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(Color(0xFF67A3D9)),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    SizedBox(
                      height: 15.0,
                    ),
                  TextFormField(
                    controller: nameController,
                      keyboardType:TextInputType.name,
                      validator:(value){
                      if(value!.isEmpty){
                        return 'please enter your name';
                      }
                      return null;
                      },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(IconBroken.Profile),

                    ),
                    onFieldSubmitted: (value){},
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: bioController,
                    keyboardType:TextInputType.text,
                    validator:(value){
                      if(value!.isEmpty){
                        return 'please enter your bio';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(IconBroken.Info_Circle),

                    ),
                    onFieldSubmitted: (value){},
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType:TextInputType.phone,
                    validator:(value){
                      if(value!.isEmpty){
                        return 'please enter your phone';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(IconBroken.Call),

                    ),
                    onFieldSubmitted: (value){},
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
