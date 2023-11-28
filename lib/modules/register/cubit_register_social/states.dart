

abstract class SocialRegisterState{}


class SocialRegisterInitiat extends SocialRegisterState{}

class SocialRegisterLoading extends SocialRegisterState{}
class SocialRegisterSuccess extends SocialRegisterState{
}

class SocialRegisterError extends SocialRegisterState{
  late final String error;
  SocialRegisterError(this.error);
}

class SocialCreateSuccess extends SocialRegisterState{
  final String? uId;

  SocialCreateSuccess(this.uId);

}

class SociaCreateError extends SocialRegisterState{
  late final String error;
  SociaCreateError(this.error);
}

class SocialRegisterChangePasswordVisibility extends SocialRegisterState{}

