import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/models/social_app/social_user_model.dart';
import 'package:flutter_udemy/modules/social_app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialStates());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);

      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );

    }).catchError((error) {
      emit(SocialRegisterErrorStates(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write bio ...',
      cover: 'https://as2.ftcdn.net/v2/jpg/05/28/46/97/1000_F_528469706_vkm3p63MhGHuO19RWMCyWgdHkVF4ncr5.jpg',
      image: 'https://as2.ftcdn.net/v2/jpg/05/28/46/97/1000_F_528469706_vkm3p63MhGHuO19RWMCyWgdHkVF4ncr5.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(
          model.toMap(),
        )
        .then((value)
    {
      emit(SocialCreateUserSuccessStates());
      emit(SocialRegisterSuccessStates());
    }
    ).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changPasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangPasswordVisibilityStates());
  }
}
