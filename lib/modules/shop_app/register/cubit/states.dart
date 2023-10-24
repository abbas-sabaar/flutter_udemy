import 'package:flutter_udemy/models/shop_app/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialStates extends ShopRegisterStates {}

class ShopRegisterLoadingStates extends ShopRegisterStates {}

class ShopRegisterSuccessStates extends ShopRegisterStates {
  final ShopLoginModel loginModel;
  ShopRegisterSuccessStates(this.loginModel);
}

class ShopRegisterErrorStates extends ShopRegisterStates {}

class ShopRegisterChangPasswordVisibilityStates extends ShopRegisterStates {}
