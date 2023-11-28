
abstract class SocialStates {}

class SocialInitiateStates extends SocialStates{}

// get user
class SocialGetUserLoadingStates extends SocialStates{}
class SocialGetUserSuccessStates extends SocialStates{}
class SocialGetUserErrorStates extends SocialStates{
  final String error;
  SocialGetUserErrorStates(this.error);
}

class SocialGetAllUserLoadingStates extends SocialStates{}
class SocialGetAllUserSuccessStates extends SocialStates{}
class SocialGetAllUserErrorStates extends SocialStates {
  final String error;
  SocialGetAllUserErrorStates(this.error);
}




class SocialChangeBottonNav extends SocialStates{}

class SocialNewPost extends SocialStates{}

class SocialProfileImagePickedSuccess extends SocialStates{}

class SocialProfileImagePickedError extends SocialStates{}
class SocialCoverImagePickedSuccess extends SocialStates{}
class SocialCoverImagePickedError extends SocialStates{}
class SocialUploadProfileImageSuccess extends SocialStates{}

class SocialUploadProfileImageError extends SocialStates{}

class SocialUploadCoverImageSuccess extends SocialStates{}

class SocialUploadCoverImageError extends SocialStates{}

class SocialUserUpdateLoading extends SocialStates{}

class SocialUserUpdateError extends SocialStates{}
class SocialUserUpdateSuccess extends SocialStates{}

// create post

class SocialCreatePostLoading extends SocialStates{}
class SocialCreatePostError extends SocialStates{}
class SocialCreatePostSuccess extends SocialStates{}

class SocialPostImagePickedSuccess extends SocialStates{}
class SocialPostImagePickedError extends SocialStates{}
class SocialRemovePostImage extends SocialStates{}

class SocialGetPostLoadingStates extends SocialStates{}
class SocialGetPostSuccessStates extends SocialStates{}
class SocialGetPostErrorStates extends SocialStates{
  final String error;
  SocialGetPostErrorStates(this.error);
}

class SocialLikePostSuccessStates extends SocialStates{}
class SocialLikePostErrorStates extends SocialStates{
  final String error;
  SocialLikePostErrorStates(this.error);
}

class SocialGetMessageSuccessStates extends SocialStates{}
class SocialGetMessageErrorStates extends SocialStates{}
class SocialSendMessageSuccessStates extends SocialStates{}
class SocialSendMessageErrorStates extends SocialStates{}