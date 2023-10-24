import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/layout/social_app/social_layout.dart';
import 'package:flutter_udemy/modules/social_app/social_register/cubit/cubit.dart';
import 'package:flutter_udemy/modules/social_app/social_register/cubit/states.dart';
import 'package:flutter_udemy/shared/components/components.dart';


class SocialRegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,states){
          if (states is SocialRegisterSuccessStates) {
            navigateAndFinish(context, SocialLayout());
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
                          'Register now to communicate with friends',
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
                            suffix: SocialRegisterCubit.get(context).suffix,
                            onSubmit: (value) {


                            },
                            isPassword: SocialRegisterCubit.get(context).isPassword,
                            suffixPressed: () {
                              SocialRegisterCubit.get(context)
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
                          condition: states is! SocialRegisterLoadingStates,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
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
