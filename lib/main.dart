
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chats/modules/login/loginScreen.dart';
import 'package:social_chats/shared/bloc_observer.dart';
import 'package:social_chats/shared/compononse/components.dart';
import 'package:social_chats/shared/compononse/constants.dart';
import 'package:social_chats/shared/cubit/cubit.dart';
import 'package:social_chats/shared/cubit/states.dart';
import 'package:social_chats/shared/network/local/cache_helper.dart';
import 'package:social_chats/shared/network/remote/dio_helpeer.dart';
import 'package:social_chats/shared/styles/colors/themes.dart';
import 'firebase_options.dart';
import 'layout/cubit_layout/cubit.dart';
import 'layout/layout.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  await Firebase.initializeApp();
  print(message.data.toString());

  showToast(text: 'on background message', state:ToastState.SUCCESS);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  var token =FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    showToast(text:'on message',state:ToastState.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp .listen((event) {
    print('on message opened app');
    print(event.data.toString());
    showToast(text:'on message opened app',state:ToastState.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();

  Widget widget;

   uId= CacheHelper.getData(key: 'uId');
  if(uId!=null) {
    widget=SocialLayoutScreen();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(

    startWidget:widget
  ));
}


class MyApp extends StatelessWidget {

final Widget startWidget;

  const MyApp({super.key,required this.startWidget});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (BuildContext context) =>SocialCubit()..getUserData()..getPost(),

      child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home:startWidget,
          ),
    );
  }
}
