import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/layout/news_app/cubit/cubit.dart';
import 'package:flutter_udemy/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_udemy/layout/social_app/cubit/cubit.dart';
import 'package:flutter_udemy/layout/social_app/social_layout.dart';
import 'package:flutter_udemy/modules/social_app/social_login/social_login_screen.dart';
import 'package:flutter_udemy/shared/bloc_observer.dart';
import 'package:flutter_udemy/shared/components/constants.dart';
import 'package:flutter_udemy/shared/cubit/cubit.dart';
import 'package:flutter_udemy/shared/cubit/states.dart';
import 'package:flutter_udemy/shared/network/local/cache_helper.dart';
import 'package:flutter_udemy/shared/network/remote/dio_helper.dart';
import 'package:flutter_udemy/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  Widget? widget;
  //
  bool? isDark = CacheHelper.getData(key: 'isDark') ?? false;
  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  // token = CacheHelper.getData(key: 'token');
    uId = CacheHelper.getData(key: 'uId');
  // print(token);
  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget = ShopLayout();
  //   } else {
  //     widget = ShopLoginScreen();
  //   }
  // } else {
  //   widget = OnBoardingScreen();
  // }
  if(uId != null )
  {
  widget = SocialLayout();
  }else {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  bool? isDark;
  Widget? startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
