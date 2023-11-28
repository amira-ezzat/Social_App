import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_chats/layout/cubit_layout/states.dart';
import 'package:social_chats/model/chats_model.dart';

import '../../model/post_model.dart';
import '../../model/user_model.dart';
import '../../model/users/users_model.dart';
import '../../modules/screens/chats.dart';
import '../../modules/screens/feeds.dart';
import '../../modules/screens/posts.dart';
import '../../modules/screens/profile.dart';
import '../../modules/screens/users.dart';
import '../../shared/compononse/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  String? profile;
  String? cover;

  SocialCubit() : super(SocialInitiateStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingStates());
    FirebaseFirestore.instance.collection('users')
        .doc(uId).get().then((value) {
      // print(value.data());
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      emit(SocialGetUserErrorStates(error.toString()));
    });
  }

  int currentIndex = 0;

  List<String> titles = [
    'Home',
    'Chats',
    'Add Post',
    'Users',
    'Profile',
  ];
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    PostsScreen(),
    UsersScreen(),
    ProfileScreen()
  ];

  void changeBottomNav(int index) {
    if(index==1)
      getAllUsers();
    if (index == 2)
      emit(SocialNewPost());
    else {
      currentIndex = index;
      emit(SocialChangeBottonNav());
    }
  }

  File? profileImage;
  final picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccess());
    } else {
      print('no image selected');
      emit(SocialProfileImagePickedError());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCoverImagePickedSuccess());
    } else {
      print('no image selected');
      emit(SocialCoverImagePickedError());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  })  {
    emit( SocialUserUpdateLoading());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          photoProfile:profile,
        );
        emit(SocialUploadProfileImageSuccess());
      }).catchError((error) {
        emit(SocialUploadProfileImageError());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageError());
    });
  }

   void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  })
   {
    emit( SocialUserUpdateLoading());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);

        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          photoCover:cover,
        );
   emit(SocialUploadCoverImageSuccess());
      }).catchError((error) {
        emit(SocialUploadCoverImageError());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageError());
    });
  }
  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? photoProfile ,
    String? photoCover,
  }) {

      SocialUserModel model = SocialUserModel(
        name: name,
        phone: phone,
        bio: bio,
        email: userModel!.email,
        image:photoProfile?? userModel!.image,
        cover: photoCover??userModel!.cover,
        uId:userModel!.uId,
        isEmailVerified: false,
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .update(model.toMap())
          .then((value) {
        getUserData();
        emit(SocialUserUpdateSuccess());
      }).catchError((error) {
        print('Error updating user: $error');
        emit(SocialUserUpdateError());
      });

  }

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialPostImagePickedSuccess());
    } else {
      print('no image selected');
      emit(SocialPostImagePickedError());
    }
  }

  void removePostImage()
  {
    postImage=null;
    emit(SocialRemovePostImage());
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit( SocialCreatePostLoading());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostError());
      });
    }).catchError((error) {
      emit(SocialCreatePostError());
    });
  }


  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoading());
       PostModel model = PostModel(
        name: userModel!.name,
        image: userModel!.image,
        uId:userModel!.uId,
        text: text,
        dateTime: dateTime,
        postImage: postImage ?? '',
      );

      FirebaseFirestore.instance
          .collection('posts')
          .add(model.toMap())
          .then((value) {
            getUserData();
        emit(SocialCreatePostSuccess());
      }).catchError((error) {
        print('Error creating post: $error');
        emit(SocialCreatePostError());
      });
  }

  List<PostModel> posts=[];
  void getPost()
  {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value){
          value.docs.forEach((element) {
            posts.add(PostModel.fromJson(element.data()));
          });
      // value.docs.forEach((element) {
      //   element.reference
      //       .collection('likes')
      //       .get().then((value){
      //     likes.add(value.docs.length);
      //     postId.add(element.id);
      //     posts.add(PostModel.fromJson(element.data()));
      //   })
      //       .catchError((error){});
      //
      // });
      emit(SocialGetPostSuccessStates());
    })
        .catchError((error){
      emit(SocialGetPostErrorStates(error.toString()));
    });
  }

  List<SocialUserModel> users=[];

  void getAllUsers() {
    users=[];
      emit(SocialGetAllUserLoadingStates());
    // if(users.isEmpty)
      FirebaseFirestore
          .instance.collection('users')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          // print("uId: ${element.data()['uId']}, userModel uId: ${userModel!.uId}");
          // if (element.data()['uId'] != userModel!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          // }
        });

        emit(SocialGetAllUserSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUserErrorStates(error.toString()));
      });
    }

    void sendMessage({
    required String receiveId,
    required String dateTime,
    required String text,
})
    {
      MessageModel model=MessageModel(
        text: text,
        sendId: userModel!.uId,
        receiveId: receiveId,
        dateTime: dateTime,
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .collection('chats')
          .doc(receiveId)
          .collection('messages')
          .add(model.toMap())
          .then((value){
            emit(SocialSendMessageSuccessStates());
      })
          .catchError((error){
            emit(SocialSendMessageErrorStates());
      });

      FirebaseFirestore.instance
          .collection('users')
          .doc(receiveId)
          .collection('chats')
          .doc(userModel!.uId)
          .collection('messages')
          .add(model.toMap())
          .then((value){
        emit(SocialSendMessageSuccessStates());
      })
          .catchError((error){
        emit(SocialSendMessageErrorStates());
      });
    }

    List<MessageModel> messages=[];

  getMessage({
    required String receiveId,
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiveId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
          messages=[];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
    });
    emit(SocialGetMessageSuccessStates());
  }
  }

