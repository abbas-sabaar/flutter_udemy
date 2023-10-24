import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/models/shop_app/login_model.dart';
import 'package:flutter_udemy/modules/shop_app/register/cubit/states.dart';
import 'package:flutter_udemy/shared/network/end_points.dart';
import 'package:flutter_udemy/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialStates());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingStates());
    DioHelper.postData(
        url: REGISTER,
        data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      // print(loginModel!.status);
      // print(loginModel!.data!.token);
      // print(loginModel!.message);
      emit(ShopRegisterSuccessStates(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorStates());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changPasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopRegisterChangPasswordVisibilityStates());
  }
}
