
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../shared/compononse/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../layout/layout.dart';
import '../register/registerScreen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class SocialLoginScreen extends StatelessWidget
{
  var formKey =GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginState>(
        listener: (BuildContext context, state) {
          if (state is SocialLoaginError) {
            showToast(text: state.error, state: ToastState.ERROR);
          }
          if (state is SocialLoaginSuccess) {
            CacheHelper.saveData(key: 'uId',
              value:state.uId ,
            ).then((value) {
              navigateAndFinish(
                  context, SocialLayoutScreen()
              );
            });
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
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
                          'LOGIN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: HexColor('#67A3D9'),

                          ),
                        ),
                        Image(
                          image:
                          NetworkImage('https://img.freepik.com/free-vector/tablet-login-concept-illustration_114360-7963.jpg?w=740&t=st=1697147376~exp=1697147976~hmac=f0ba359c2e63a3f6aeca318276b448f150ab0f651b50edf74c15a95d695ba132'),
                          height: 270.0,
                          width: 270.0,

                        ),

                        defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          suffix: SocialLoginCubit.get(context).suffix,
                          type: TextInputType.visiblePassword,
                          onSubmit:(value) {

                          },
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVsibility();
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                          },

                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoaginLoading,
                          builder: (BuildContext context) => Container(
                            width: double.infinity,
                            color: HexColor('#67A3D9') ,
                            child: TextButton(
                              onPressed:(){
                                if(formKey.currentState!.validate())
                                {
                                  SocialLoginCubit.get(context).userLogin(

                                    email: emailController.text,
                                    password: passwordController.text,

                                  );
                                }
                              } ,
                              child: const Text(
                                'LOGIN',
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
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don \'t have an account ?'),
                            TextButton(
                              onPressed: () {
                                navigateTo(context,SocialRegisterScreen());
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(color: HexColor('#67A3D9')),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },


      ),
    );
  }
}
