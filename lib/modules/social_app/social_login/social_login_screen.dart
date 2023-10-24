import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/layout/social_app/social_layout.dart';
import 'package:flutter_udemy/modules/social_app/social_login/cubit/cubit.dart';
import 'package:flutter_udemy/modules/social_app/social_login/cubit/states.dart';
import 'package:flutter_udemy/modules/social_app/social_register/social_register_screen.dart';
import 'package:flutter_udemy/shared/components/components.dart';
import 'package:flutter_udemy/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, states) {
          if (states is SocialLoginErrorStates) {
            showToast(
              text: states.error,
              state: ToastStates.ERROR,
            );
          }
          if(states is SocialLoginSuccessStates)
          {
            CacheHelper.saveData(
              key: 'uId',
              value: states.uId,
            ).then((value)
            {

              navigateAndFinish(context, SocialLayout());
            });          }
        },
        builder: (context, states) {
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
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'login now to communicate with friends',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Email Address';
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
                            suffix: SocialLoginCubit.get(context).suffix,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                // SocialLoginCubit.get(context).userLogin(
                                //   email: emailController.text,
                                //   password: passwordController.text,
                                // );
                              }
                            },
                            isPassword:
                                SocialLoginCubit.get(context).isPassword,
                            suffixPressed: () {
                              SocialLoginCubit.get(context)
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
                        SizedBox(height: 30.0),
                        ConditionalBuilder(
                          condition: states is! SocialLoginLoadingStates,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account? '),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },
                              text: 'Register',
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
