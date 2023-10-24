import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/layout/shop_app/shop_layout.dart';import 'package:flutter_udemy/modules/shop_app/register/cubit/cubit.dart';
import 'package:flutter_udemy/modules/shop_app/register/cubit/states.dart';
import 'package:flutter_udemy/shared/components/components.dart';
import 'package:flutter_udemy/shared/components/constants.dart';
import 'package:flutter_udemy/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,states){
          if (states is ShopRegisterSuccessStates) {
            if (states.loginModel.status!) {
              print(states.loginModel.message);
              print(states.loginModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: states.loginModel.data!.token,
              ).then((value) {
                token = states.loginModel.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(states.loginModel.message);
              showToast(
                text: states.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context,states){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'pleas enter your name';
                              }
                            },
                            label: 'User Name',
                            prefix: Icons.person,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          child: defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'pleas enter your email';
                              }
                            },
                            label: 'Email',
                            prefix: Icons.email,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          child: defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            onSubmit: (value) {

                              // if (formKey.currentState!.validate()) {
                              //   ShopRegisterCubit.get(context).userLogin(
                              //     email: emailController.text,
                              //     password: passwordController.text,
                              //   );
                              // }
                            },
                            isPassword: ShopRegisterCubit.get(context).isPassword,
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changPasswordVisibility();
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Password is too short';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.vpn_key,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          child: defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'pleas enter your phone number';
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        ConditionalBuilder(
                          condition: states is! ShopRegisterLoadingStates,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
