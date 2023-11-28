

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chats/modules/login/cubit/states.dart';


class SocialLoginCubit extends Cubit<SocialLoginState>
    implements StateStreamable<SocialLoginState>{
  SocialLoginCubit() : super(SocialLoaginInitiat());
  static  SocialLoginCubit get(context)=>BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,
  }) {
    emit( SocialLoaginLoading());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoaginSuccess(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoaginError(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVsibility()
  {
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibility());
  }

}
