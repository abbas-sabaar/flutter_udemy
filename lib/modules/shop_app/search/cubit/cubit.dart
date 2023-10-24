import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/models/shop_app/search_model.dart';
import 'package:flutter_udemy/modules/shop_app/search/cubit/states.dart';
import 'package:flutter_udemy/shared/components/constants.dart';
import 'package:flutter_udemy/shared/network/end_points.dart';
import 'package:flutter_udemy/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialStates());
  static SearchCubit get(context) => BlocProvider.of(context);

    SearchModel? model;
  void search(text)
  {
    emit(SearchLoadingStates());

    DioHelper.postData(
      url: SEARCH,
      token: token,

      data: {
      'text':text,
    },).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorStates());

    });
  }
}