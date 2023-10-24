import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/layout/news_app/cubit/states.dart';
import 'package:flutter_udemy/modules/news_app/business/business_screen.dart';
import 'package:flutter_udemy/modules/news_app/science/science_screen.dart';
import 'package:flutter_udemy/modules/news_app/sports/sports_screen.dart';
import 'package:flutter_udemy/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();

    emit(NewsBottomNavStates());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'dbc06a8a43044e2397982881f5388160',
      },
    ).then((value) {
      // print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorStates(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingStates());

    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'dbc06a8a43044e2397982881f5388160',
        },
      ).then((value) {
        // print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorStates(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessStates());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingStates());

    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'dbc06a8a43044e2397982881f5388160',
        },
      ).then((value) {
        // print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorStates(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessStates());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingStates());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': 'dbc06a8a43044e2397982881f5388160',
      },
    ).then((value) {
      // print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorStates(error.toString()));
    });
  }
}
