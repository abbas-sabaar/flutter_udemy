import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/layout/news_app/cubit/cubit.dart';
import 'package:flutter_udemy/layout/news_app/cubit/states.dart';
import 'package:flutter_udemy/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'search must not not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  style: TextStyle(
                    color: Colors.pink[300],
                  ),
                  prefix: Icons.search,
                  background: Colors.pink[300],
                ),
              ),
              Expanded(
                child: articleBuilder(
                  list,
                  isSearch: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
