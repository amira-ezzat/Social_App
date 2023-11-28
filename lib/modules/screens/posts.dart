import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../layout/cubit_layout/cubit.dart';
import '../../layout/cubit_layout/states.dart';
import '../../shared/compononse/components.dart';
import '../../shared/styles/icons/icons.dart';

class PostsScreen extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: defualtAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              TextButton(
                onPressed: () {
                  var now = DateTime.now();
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                      text: textController.text,
                      dateTime: now.toString(),
                    );
                  }
                },
                child: Text(
                  'POST',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#67A3D9')
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is SocialCreatePostLoading)
                    LinearProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF67A3D9)),
                    ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 27.0,
                        backgroundImage: NetworkImage(
                          'https://i.pinimg.com/236x/4f/0b/ce/4f0bcef5b7a8be1d3a44daded5733ffe.jpg',
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Text(
                          'Amira Ezzat',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'what is on your mind.... ',
                        border: InputBorder.none
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  if (SocialCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 220.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                              image: FileImage(
                                SocialCubit.get(context).postImage!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: CircleAvatar(
                            backgroundColor: HexColor('#67A3D9'),
                            radius: 20.0,
                            child: Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Add Photo',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: HexColor('#67A3D9'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text('#Tag'
                            ,style: TextStyle(
                                color: HexColor('#67A3D9')
                            ),),
                        ),
                      ),
                    ],
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
