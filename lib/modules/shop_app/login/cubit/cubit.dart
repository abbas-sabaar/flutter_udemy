import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/models/shop_app/login_model.dart';
import 'package:flutter_udemy/modules/shop_app/login/cubit/states.dart';

import 'package:flutter_udemy/shared/network/end_points.dart';
import 'package:flutter_udemy/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
        url: LOGIN,
        data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      // print(loginModel!.status);
      // print(loginModel!.data!.token);
      // print(loginModel!.message);
      emit(ShopLoginSuccessStates(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorStates());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changPasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangPasswordVisibilityStates());
  }
}
