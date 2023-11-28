import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hexcolor/hexcolor.dart';

import '../../../shared/compononse/components.dart';
import '../../../shared/compononse/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../layout/layout.dart';
import '../../shared/compononse/constants.dart';
import 'cubit_register_social/cubit.dart';
import 'cubit_register_social/states.dart';

class SocialRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterState>(
        listener: (BuildContext context, state) {
          if(state is SocialCreateSuccess)
          {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              uId = state.uId!;
              Fluttertoast.showToast(
                msg: 'Welcome',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                fontSize: 16.0,
              );
              navigateAndFinish(context, SocialLayoutScreen());
            }).catchError((error) {
              print(error.toString());
            });
          }

        },
        builder: (BuildContext context, state) {
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: HexColor('#67A3D9'),
                          ),
                        ),
                        Text(
                          'register now to communicate with friends',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your  Name';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your  Email';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Phone Number';
                            }
                            return null;
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone_android,
                        ),

                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          type: TextInputType.visiblePassword,
                          isPassword: SocialRegisterCubit.get(context).isPassword,

                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVsibility();
                          },
                          validate: (String ?value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),


                        ConditionalBuilder(
                          condition: State is! SocialRegisterLoading,
                          builder: (BuildContext context) => Container(
                            width: double.infinity,
                            color: HexColor('#67A3D9') ,

                            child: TextButton(
                              onPressed:(){
                                if(formKey.currentState!.validate())
                                {
                                  SocialRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              } ,
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),),
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF67A3D9)),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

        //     if (state.loginModel.status) {
        //       print(state.loginModel.message);
        //       print(state.loginModel.data.token);
        //       CacheHelper.saveData(key: 'token',
        //           value: state.loginModel.data.token
        //       ).then((value){
        //         token=state.loginModel.data.token;
        //
        //       });
        //
        //     }
        //     else {
        //       print(state.loginModel.message);
        //       showToast(
        //           text: state.loginModel.message, state: ToastState.ERROR);
        //
        //     }
        //   }

      ),
    );
  }
}
