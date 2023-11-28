import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chats/modules/register/cubit_register_social/states.dart';

import '../../../model/user_model.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(SocialRegisterInitiat());
  static SocialRegisterCubit get(context)=>BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {

    emit(SocialRegisterLoading());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      createUser(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid
      );

    }).catchError((error){
      print('Registration Error: $error');
      emit(SocialRegisterError(error.toString()));
    });

  }

  void createUser({
    required String? name,
    required String? email,
    required String? phone,
    required String? uId,
  })
  {
    SocialUserModel model=SocialUserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
       bio: 'writ your bio...',
        image:'https://img.freepik.com/premium-photo/3d-illustration-teenage-girl-wearing-boxing-gloves_856795-15031.jpg?size=626&ext=jpg&uid=R122362298&ga=GA1.1.1083969217.1697145493&semt=sph',
        cover: 'https://img.freepik.com/free-photo/beautiful-view-beach-with-times-during-sunset_181624-35954.jpg?size=626&ext=jpg&uid=R122362298&ga=GA1.1.1083969217.1697145493&semt=sph',
        isEmailVerified:false,
    );
FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .set(model.toMap())
    .then((value){
      emit(SocialCreateSuccess(model.uId));
})
    .catchError((error){
      emit(SociaCreateError(error.toString()));
});
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVsibility()
  {
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibility());
  }

}
