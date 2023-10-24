import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/modules/shop_app/search/cubit/cubit.dart';
import 'package:flutter_udemy/modules/shop_app/search/cubit/states.dart';
import 'package:flutter_udemy/shared/components/components.dart';

class ShopSearchScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'enter text to search ';
                      }
                      return null;
                    },
                    onSubmit: (text) {
                      SearchCubit.get(context).search(text);
                    },
                    label: 'Search',
                    prefix: Icons.search,
                  ),
                  SizedBox(height: 10.0),
                  if (states is SearchLoadingStates) LinearProgressIndicator(),
                  if (states is SearchSuccessStates)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildListProduct(
                          SearchCubit.get(context).model!.data!.data[index],context, isOldPrice: false),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount:
                            SearchCubit.get(context).model!.data!.data.length,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
