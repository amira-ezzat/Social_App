import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_chats/layout/cubit_layout/cubit.dart';
import 'package:social_chats/layout/cubit_layout/states.dart';
import 'package:social_chats/model/chats_model.dart';
import 'package:social_chats/shared/styles/icons/icons.dart';
import '../../model/user_model.dart';

class ChatsDetailsScreen extends StatelessWidget {

  SocialUserModel? userModel;
var messageController=TextEditingController();
  ChatsDetailsScreen({this.userModel});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getMessage(receiveId: '${userModel!.uId}');
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor('#000000'),
              elevation: 0, // Set elevation to 0 to remove the shadow
              iconTheme: IconThemeData(
                color: Colors.white, // Change the color of the back arrow
                size: 24.0, // Change the size of the back arrow
              ),
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0, 
                    backgroundImage: NetworkImage('${userModel!.image}'),
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    children: [
                      Text(
                        '${userModel!.name}',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 4.0,),
                      Text(
                        'online',
                        style: TextStyle(color: Colors.white,
                        fontSize:11.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(IconBroken.Camera,
                        size: 20.0,
                      ),
                      SizedBox(width: 20.0,),
                      Icon(IconBroken.Call,
                        size: 20.0,
                      ),
                      SizedBox(width: 20.0,),
                      Icon(IconBroken.Search,
                        size: 20.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            body: Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: Image.network(
                      'https://img.freepik.com/free-photo/black-smooth-textured-paper-background_53876-160608.jpg?size=626&ext=jpg&uid=R122362298&ga=GA1.1.1083969217.1697145493&semt=ais',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Container(

          padding: EdgeInsets.symmetric(
          vertical:5.0 ,
          horizontal: 10.0
          ),
          decoration:BoxDecoration(
          color:HexColor('#EE4540'),
          borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          topStart:  Radius.circular(10.0),
          ),
          ),
          child: Text(
          'Hi Amira',
          style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white
          ),
          ),
          ),
          ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Container(

                            padding: EdgeInsets.symmetric(
                                vertical:5.0 ,
                                horizontal: 10.0
                            ),
                            decoration:BoxDecoration(
                              color:HexColor('#5C5A5C'),
                              borderRadius: BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(10.0),
                                topEnd: Radius.circular(10.0),
                                topStart:  Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              'Hi Sara',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                        //2message
                        SizedBox(
                          height: 20.0,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Container(

                            padding: EdgeInsets.symmetric(
                                vertical:5.0 ,
                                horizontal: 10.0
                            ),
                            decoration:BoxDecoration(
                              color:HexColor('#EE4540'),
                              borderRadius: BorderRadiusDirectional.only(
                                bottomStart: Radius.circular(10.0),
                                topEnd: Radius.circular(10.0),
                                topStart:  Radius.circular(10.0),
                              ),
                            )
                            child: Text(
                              'How are you?',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Container(

                            padding: EdgeInsets.symmetric(
                                vertical:5.0 ,
                                horizontal: 10.0
                            ),
                            decoration:BoxDecoration(
                              color:HexColor('#5C5A5C'),
                              borderRadius: BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(10.0),
                                topEnd: Radius.circular(10.0),
                                topStart:  Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              'Fin Thanks.',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                        //3sms

                        Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  controller: messageController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here..',
                                    hintStyle: TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    suffixIcon: Icon(
                                      IconBroken.Voice,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),



                            SizedBox(width: 10.0,),
                            Container(

                              child: CircleAvatar(
                                radius: 24.0, // Adjust the radius to make it circular
                                backgroundColor:  HexColor('#EE4540'),
                                child: MaterialButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                      receiveId: '${userModel!.uId}',
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text,
                                    );
                                  },
                                  minWidth: 1.0,
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 19.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          );
        },
      );
    });
  }


  // Widget buildMessage()=> Align(
  //   alignment: AlignmentDirectional.centerStart,
  //   child: Container(
  //
  //     padding: EdgeInsets.symmetric(
  //         vertical:5.0 ,
  //         horizontal: 10.0
  //     ),
  //     decoration:BoxDecoration(
  //       color:HexColor('#5C5A5C'),
  //       borderRadius: BorderRadiusDirectional.only(
  //         bottomEnd: Radius.circular(10.0),
  //         topEnd: Radius.circular(10.0),
  //         topStart:  Radius.circular(10.0),
  //       ),
  //     ),
  //     child: Text(
  //      'Hello Amira,I am very Happy',
  //       style: TextStyle(
  //           fontSize: 16.0,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white
  //       ),
  //     ),
  //   ),
  // );
  // Widget buildMyMessage()=> Align(
  //   alignment: AlignmentDirectional.centerEnd,
  //   child: Container(
  //
  //     padding: EdgeInsets.symmetric(
  //         vertical:5.0 ,
  //         horizontal: 10.0
  //     ),
  //     decoration:BoxDecoration(
  //       color:HexColor('#EE4540'),
  //       borderRadius: BorderRadiusDirectional.only(
  //         bottomStart: Radius.circular(10.0),
  //         topEnd: Radius.circular(10.0),
  //         topStart:  Radius.circular(10.0),
  //       ),
  //     ),
  //     child: Text(
  //       'Hello Sara',
  //       style: TextStyle(
  //           fontSize: 16.0,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white
  //       ),
  //     ),
  //   ),
  // );

}
