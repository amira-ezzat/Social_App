 // import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chats/shared/cubit/states.dart';

import 'package:sqflite/sqflite.dart';



import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
   AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
    void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBotton());
  }

   bool isBottomShow = false;
   IconData fabIcon = Icons.edit;
   void changeBotttomSheetState({
   required bool isShow,
   required IconData icon,
})
   {
     isBottomShow=isShow;
     fabIcon=icon;
     emit(AppChangeBotttomSheetState());
   }
   bool isDark=false;

   void changeAppMode({ bool? fromShared})
   {
     if(fromShared!=null) {
       fromShared = isDark;
       emit(AppChangeModeState());
     }
     else{
       isDark=!isDark;
       CacheHelper.putBoolean(key: 'isDark',value: isDark).then((value) {});
       emit(AppChangeModeState());
     }

   }
}
