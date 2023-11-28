import 'package:bloc/bloc.dart';
// Make sure to import the necessary extension package for StateStreamable


abstract class  SocialLoginState{}

class  SocialLoaginInitiat extends  SocialLoginState{}

class  SocialLoaginLoading extends  SocialLoginState{}

class  SocialLoaginSuccess extends  SocialLoginState{
  final String uId;

  SocialLoaginSuccess(this.uId);
}

class SocialLoaginError extends  SocialLoginState{
  late final String error;
  SocialLoaginError(this.error);
}
class  SocialChangePasswordVisibility extends  SocialLoginState{}

